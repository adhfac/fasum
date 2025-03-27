import 'package:fasum/screens/home_screen.dart';
import 'package:fasum/screens/signin_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  String _errorMessage = ' ';
  bool _obscurePassword = true;

  bool isValidPassword(String password) {
    final regex = RegExp(
        r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@\$!%*?&])[A-Za-z\d@\$!%*?&]{8,}\$');
    return regex.hasMatch(password);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SIGN UP'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
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
              obscureText: _obscurePassword,
              decoration: InputDecoration(
                labelText: 'Create a password',
                border: const OutlineInputBorder(),
                suffixIcon: IconButton(
                  icon: Icon(
                    _obscurePassword ? Icons.visibility_off : Icons.visibility,
                  ),
                  onPressed: () {
                    setState(() {
                      _obscurePassword = !_obscurePassword;
                    });
                  },
                ),
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              "Password harus minimal 8 karakter, mengandung huruf besar, huruf kecil, angka, dan simbol.",
              style: TextStyle(fontSize: 8, color: Colors.red),
            ),
            const SizedBox(
              height: 16,
            ),
            ElevatedButton(
              onPressed: () async {
                if (!isValidPassword(_passwordController.text)) {
                  setState(() {
                    _errorMessage = "Password tidak memenuhi syarat!";
                  });
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text(_errorMessage)));
                  return;
                }

                try {
                  await FirebaseAuth.instance.createUserWithEmailAndPassword(
                    email: _emailController.text,
                    password: _passwordController.text,
                  );
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => const HomeScreen(),
                  ));
                } catch (e) {
                  setState(() {
                    _errorMessage = e.toString();
                  });
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text(_errorMessage)));
                }
              },
              child: const Text("Sign Up"),
            ),
            TextButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SigninScreen(),
                      ));
                },
                child: const Text(
                  "Already have an account?",
                  style: TextStyle(color: Colors.blue),
                )),
          ],
        ),
      ),
    );
  }
}
