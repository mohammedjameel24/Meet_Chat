import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:meet_chat/screens/home_screen.dart';
import 'package:meet_chat/screens/login_screen.dart';
import 'package:meet_chat/screens/join_meeting_screen.dart';
import 'package:meet_chat/services/auth_methods.dart';
import 'package:meet_chat/utils/colors.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Meet chat",
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: backgroundColor,
        primaryColor: primaryColor,
      ),
      routes: {
        '/login-route': (context) => const LoginScreen(),
        '/home-route': (context) => const HomeScreen(),
        '/join-meet-route': (context) => const VideoCallScreen(),
      },

      // StreamBuilder listen to exposed streams and return widgets and
      // capture snapshots of received stream data.
      home: StreamBuilder(
        stream: AuthMethods().authChanges,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasData) {
            return const HomeScreen();
          } else {
            return const LoginScreen();
          }
        },
      ),
    );
  }
}
