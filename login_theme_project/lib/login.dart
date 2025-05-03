import 'package:flutter/material.dart';

void main() {
  runApp(VSCodeThemeApp());
}

class VSCodeThemeApp extends StatelessWidget {
  const VSCodeThemeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'VS Code Themed Login Profile',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF1E1E1E),
        primaryColor: const Color(0xFF007ACC),
        textTheme: const TextTheme(
          bodyMedium: TextStyle(color: Color(0xFFD4D4D4)),
          titleLarge: TextStyle(
            color: Color(0xFF6A9955),
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: const Color(0xFF252526),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Color(0xFF3C3C3C)),
            borderRadius: BorderRadius.circular(6),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Color(0xFF007ACC)),
            borderRadius: BorderRadius.circular(6),
          ),
          labelStyle: const TextStyle(color: Color(0xFF569CD6)),
        ),
        buttonTheme: ButtonThemeData(
          buttonColor: const Color(0xFF007ACC),
          textTheme: ButtonTextTheme.primary,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
        ),
      ),
      home: const LoginScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  String _username = '';
  String _password = '';
  bool _loginFailed = false;

  void _tryLogin() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      if (_username == 'umar' && _password == 'akulali098') {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (_) => ProfileScreen(username: 'John Developer'),
          ),
        );
      } else {
        setState(() {
          _loginFailed = true;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: 140,
                child: Image.network(
                  'https://images.pexels.com/photos/270360/pexels-photo-270360.jpeg?auto=compress&cs=tinysrgb&h=140',
                  fit: BoxFit.contain,
                ),
              ),
              const SizedBox(height: 20),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Username',
                        prefixIcon: Icon(
                          Icons.person,
                          color: Color(0xFF569CD6),
                        ),
                      ),
                      style: const TextStyle(color: Color(0xFFD4D4D4)),
                      onSaved: (val) => _username = val!.trim(),
                      validator: (val) {
                        if (val == null || val.trim().isEmpty) {
                          return 'Please enter username';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Password',
                        prefixIcon: Icon(Icons.lock, color: Color(0xFF569CD6)),
                      ),
                      obscureText: true,
                      style: const TextStyle(color: Color(0xFFD4D4D4)),
                      onSaved: (val) => _password = val ?? '',
                      validator: (val) {
                        if (val == null || val.isEmpty) {
                          return 'Please enter password';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    if (_loginFailed)
                      const Padding(
                        padding: EdgeInsets.only(bottom: 12.0),
                        child: Text(
                          'Login failed. Please check your username or password.',
                          style: TextStyle(color: Colors.redAccent),
                        ),
                      ),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _tryLogin,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF007ACC),
                          padding: const EdgeInsets.symmetric(vertical: 14),
                        ),
                        child: const Text('Login'),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ProfileScreen extends StatelessWidget {
  final String username;

  const ProfileScreen({super.key, required this.username});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome', style: Theme.of(context).textTheme.titleLarge),
        backgroundColor: const Color(0xFF007ACC),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Hello, $username!',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (_) => const LoginScreen()),
                );
              },
              child: const Text('Logout'),
            ),
          ],
        ),
      ),
    );
  }
}
