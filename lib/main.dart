// ignore_for_file: prefer_const_constructors, unused_local_variable

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_authapp/views/login.dart';

import 'firebase_options.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized;
  runApp(MaterialApp(
    title: 'Flutter Demo',
    theme: ThemeData(
      primarySwatch: Colors.blue,
    ),
    home: const LoginView(),
  ));
}

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  late final TextEditingController _email;
  late final TextEditingController _password;

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register'),
      ),
      body: FutureBuilder(
        future: Firebase.initializeApp(
          options: DefaultFirebaseOptions.currentPlatform,
        ),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.done:
              return Column(
                children: [
                  TextField(
                    controller: _email,
                    enableSuggestions: false,
                    autocorrect: false,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      hintText: 'Enter your email here',
                    ),
                  ),
                  TextField(
                    controller: _password,
                    obscureText: true,
                    enableSuggestions: false,
                    autocorrect: false,
                    decoration: InputDecoration(
                      hintText: 'Enter your password here',
                    ),
                  ),
                  TextButton(
                    onPressed: () async {
                      final email = _email.text;
                      final password = _password.text;

                      final userCredential =
                          FirebaseAuth.instance.signInWithEmailAndPassword(
                        email: email,
                        password: password,
                      );
                    },
                    child: const Text('Register'),
                  ),
                ],
              );

            default:
              return const Text('Loading...');
          }
        },
      ),
    );
  }
}
