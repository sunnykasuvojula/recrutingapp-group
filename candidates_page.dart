import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CandidatesScreen extends StatelessWidget {
  const CandidatesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;

    Future<bool> userIsConnected(User user, String userEmail) async {
      CollectionReference connectedUsersRef =
      FirebaseFirestore.instance.collection('users').doc(user.uid).collection('connectedusers');
      print("connected users data is $connectedUsersRef");

      try {
        DocumentSnapshot doc = await connectedUsersRef.doc(userEmail).get();
        print("document data is ${doc.data()}");
        return doc.exists;
      } catch (error) {
        print("Error checking user connection: $error");
        return false;
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Candidates List'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            if (user != null)
              Column(
                children: [
                  Text(
                    'Logged in as: ${user.email}',
                    style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w900),
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            const SizedBox(height: 20),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance.collection('users').snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  List<DocumentSnapshot> users = [];
                  snapshot.data!.docs.forEach((doc) {
                    if (doc['email'] != user!.email) {
                      users.add(doc);
                    }
                  });
                  print("users in candidate list is $users.data()");
                  return ListView.builder(
                    itemCount: users.length,
                    itemBuilder: (context, index) {
                      var userData = users[index].data() as Map<String, dynamic>;
                      print("user data is in scaffold is :: $userData");
                      return FutureBuilder<bool>(
                        future: userIsConnected(user!, userData['email'] ?? ''),
                        builder: (context, snapshot) {
                          bool isUserConnected = snapshot.data ?? false;
                          return ListTile(
                            title: Text(userData['username'] ?? ''),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(userData['email'] ?? ''),
                                Text(userData['description'] ?? ''),
                              ],
                            ),
                            leading: const CircleAvatar(
                              backgroundImage: AssetImage('images/userimage.png'),
                            ),
                            trailing: ElevatedButton(
                              onPressed: isUserConnected
                                  ? null
                                  : () async {
                                try {
                                  if (isUserConnected) {
                                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                      content: Text('User is already connected!'),
                                    ));
                                  } else {
                                    await FirebaseFirestore.instance
                                        .collection('users')
                                        .doc(user.uid)
                                        .collection('connectedusers')
                                        .doc(userData['email'])
                                        .set({
                                      'email': userData['email'],
                                    });
                                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                      content: Text('Connected Successfully!!'),
                                    ));
                                  }
                                } catch (error) {
                                  print("Failed to connect to user :$error");
                                }
                              },
                              child: Text(isUserConnected ? 'Already Connected' : 'Connect'),
                            ),
                          );
                        },
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
