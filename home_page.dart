import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sample_auth/candidates_page.dart';
import 'package:sample_auth/create_post.dart';
import 'package:sample_auth/login_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  bool _isLoggedIn = false;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      _isLoggedIn = true;
    }

    if (!_isLoggedIn) {
      return LoginPage();
    }

    return Scaffold(
      appBar: _selectedIndex == 0
          ? AppBar(
        title: Text('Home'),
        automaticallyImplyLeading: false, // Remove back button
      )
          : null, // No app bar on other pages
      body: _buildBody(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        backgroundColor: Colors.blue,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: 'Post',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.verified_user),
            label: 'Candidates',
          ),
        ],
      ),
    );
  }

  Widget _buildBody(int index) {
    switch (index) {
      case 0:
        return HomePageContent();
      case 1:
        return CreatePostScreen();
      case 2:
        return CandidatesScreen();
      default:
        return HomePageContent();
    }
  }
}

class HomePageContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: const [
        ListTile(
          title: Text('Web Developer'),
          subtitle: Text('2 years of experience required, knowledge of HTML, CSS, and JavaScript'),
        ),
        Divider(
          color: Colors.grey,
          height: 0,
          thickness: 1,
        ),
        SizedBox(height: 20),
        ListTile(
          title: Text('Python Developer'),
          subtitle: Text('4 years of experience required, knowledge of Python'),
        ),
        Divider(
          color: Colors.grey,
          height: 0,
          thickness: 1,
        ),
        SizedBox(height: 20),
        ListTile(
          title: Text('Wordpress Developer'),
          subtitle: Text('1 years of experience required, knowledge of Wordpress'),
        ),
        Divider(
          color: Colors.grey,
          height: 0,
          thickness: 1,
        ),
        SizedBox(height: 20),
        ListTile(
          title: Text('Prompe Engineer Developer'),
          subtitle: Text('2 years of experience required, knowledge of Training AI'),
        ),
        Divider(
          color: Colors.grey,
          height: 0,
          thickness: 1,
        ),
        SizedBox(height: 20),
        ListTile(
          title: Text('Web Developer'),
          subtitle: Text('2 years of experience required, knowledge of HTML, CSS, and JavaScript'),
        ),
        Divider(
          color: Colors.grey,
          height: 0,
          thickness: 1,
        ),
        SizedBox(height: 20),
        ListTile(
          title: Text('Web Developer'),
          subtitle: Text('2 years of experience required, knowledge of HTML, CSS, and JavaScript'),
        ),
        Divider(
          color: Colors.grey,
          height: 0,
          thickness: 1,
        ),
        SizedBox(height: 20),
        ListTile(
          title: Text('Web Developer'),
          subtitle: Text('2 years of experience required, knowledge of HTML, CSS, and JavaScript'),
        ),
        Divider(
          color: Colors.grey,
          height: 0,
          thickness: 1,
        ),
        SizedBox(height: 20),
        ListTile(
          title: Text('Web Developer'),
          subtitle: Text('2 years of experience required, knowledge of HTML, CSS, and JavaScript'),
        ),
        Divider(
          color: Colors.grey,
          height: 0,
          thickness: 1,
        ),
        SizedBox(height: 20),

      ],
    );
  }
}

