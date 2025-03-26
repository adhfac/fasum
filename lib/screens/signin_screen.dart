import 'package:fasum/screens/home_screen.dart';
import 'package:fasum/screens/signup_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class SigninScreen extends StatefulWidget {
  const SigninScreen({super.key});

  @override
  State<SigninScreen> createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  String _errorMessage = ' ';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("SIGN IN"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 32,
              ),
              TextField(
                controller: _emailController,
                decoration: const InputDecoration(
                    labelText: 'Type your email', border: OutlineInputBorder()),
              ),
              const SizedBox(
                height: 16,
              ),
              TextField(
                controller: _passwordController,
                decoration: const InputDecoration(
                    labelText: 'Your password?', border: OutlineInputBorder()),
              ),
              const SizedBox(
                height: 16,
              ),
              ElevatedButton(
                  onPressed: () async {
                    try {
                      await FirebaseAuth.instance.signInWithEmailAndPassword(
                          email: _emailController.text,
                          password: _passwordController.text);
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => HomeScreen(),
                      ));
                    } catch (e) {
                      setState(() {
                        _errorMessage = e.toString();
                      });
                      ScaffoldMessenger.of(context)
                          .showSnackBar(SnackBar(content: Text(_errorMessage)));
                    }
                  },
                  child: const Text("Sign In")),
              TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SignupScreen(),
                        ));
                  },
                  child: const Text(
                    "Don't have an account?",
                    style: TextStyle(color: Colors.blue),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
