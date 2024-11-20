import 'package:desaaplikasi/pages/home_screen.dart';
import 'package:desaaplikasi/pages/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Supabase
  await Supabase.initialize(
    url: 'http://labulabs.net:8000', // Replace with your SUPABASE_PUBLIC_URL
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.ewogICJyb2xlIjogImFub24iLAogICJpc3MiOiAic3VwYWJhc2UiLAogICJpYXQiOiAxNzMxODYyODAwLAogICJleHAiOiAxODg5NjI5MjAwCn0.4IpwhwCVbfYXxb8JlZOLSBzCt6kQmypkvuso7N8Aicc',
  );

  // Test Supabase connection
  try {
    final response = await Supabase.instance.client
        .from('user')
        .select('*')
        .limit(1); // Remove `.execute()`

    print('Supabase connected successfully. Data: $response');
  } catch (e) {
    print('Error connecting to Supabase: $e');
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Check if a user is logged in
    final currentUser = Supabase.instance.client.auth.currentUser;
    print('Current user: $currentUser');

    // Determine the initial screen
    final initialScreen =
        currentUser != null ? const HomeScreen() : LoginScreen();

    return MaterialApp(
      title: 'Desa Aplikasi',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: initialScreen,
      routes: {
        '/login': (context) => LoginScreen(),
        '/home': (context) => const HomeScreen(),
      },
    );
  }
}
