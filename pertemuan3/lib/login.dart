import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Tambahkan baris ini

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          children: <Widget>[
            const SizedBox(height: 80.0),
            Column(
              children: <Widget>[
                Image.asset('assets/diamond.png'),
                const SizedBox(height: 16.0),
                Text(
                  'SHRINE',
                  style: Theme.of(context).textTheme.headline5,
                ),
                const SizedBox(height: 8.0), // Tambahkan ruang tambahan
                Text(
                  'Ryanda Afriza - 221511029', // Tambahkan teks ini
                  style: Theme.of(context).textTheme.caption,
                ),
              ],
            ),
            const SizedBox(height: 120.0),
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: 'Email',
              ),
              keyboardType: TextInputType.emailAddress,
              inputFormatters: [
                // Menghapus spasi dan mengubah huruf besar menjadi kecil
                FilteringTextInputFormatter.deny(RegExp(r'\s|[A-Z]')),
              ],
            ),
            const SizedBox(height: 12.0),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(
                labelText: 'Password',
                suffixIcon: IconButton(
                  icon: Icon(
                    _isPasswordVisible
                        ? Icons.visibility
                        : Icons.visibility_off,
                  ),
                  onPressed: () {
                    setState(() {
                      _isPasswordVisible = !_isPasswordVisible;
                    });
                  },
                ),
              ),
              obscureText: !_isPasswordVisible,
            ),
            OverflowBar(
              alignment: MainAxisAlignment.end,
              children: <Widget>[
                TextButton(
                  child: const Text('BATAL'),
                  onPressed: () {
                    _emailController.clear();
                    _passwordController.clear();
                  },
                  style: TextButton.styleFrom(
                    // primary: Theme.of(context).colorScheme.secondary,
                    shape: const BeveledRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(7.0)),
                    ),
                  ),
                ),
                ElevatedButton(
                  child: const Text('LANJUT'),
                  onPressed: () {
                    if (_emailController.text.contains('@') &&
                        _validatePassword(_passwordController.text)) {
                      // Email is valid and password meets criteria, proceed
                      Navigator.pop(context);
                    } else {
                      // Show SnackBar with an error message
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: const Text(
                              'Email harus memakai "@" dan password harus mengandung minimal satu huruf besar, serta minimal satu angka atau simbol.'),
                        ),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    elevation: 8.0,
                    shape: const BeveledRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(7.0)),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  bool _validatePassword(String password) {
    // Validasi password: minimal satu huruf besar, minimal satu angka atau simbol
    final RegExp upperCase = RegExp(r'[A-Z]');
    final RegExp digitOrSymbol =
        RegExp(r'[\d!@#\$%\^&\*\(\)_\+{}\[\]:;<>,.\?~\\-]');

    return upperCase.hasMatch(password) && digitOrSymbol.hasMatch(password);
  }
}
