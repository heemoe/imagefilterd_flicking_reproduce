import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:imagefilterd_flicking_reproduce/second_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  void handleNavigate() {
    // nav to second

    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (_, __, ___) => const SecondScreen(),
        transitionDuration: const Duration(seconds: 0),
      ),
    );
  }

  void handleNavigateAnimated() {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return const SecondScreen();
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: handleNavigate,
              child: const Text("navigate without animation"),
            ),
            ElevatedButton(
              onPressed: handleNavigateAnimated,
              child: const Text("navigate with animation"),
            ),
            const SizedBox(
              height: 40,
            ),
            _buildImageFiltered(),
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  _buildImageFiltered() {
    return ClipRect(
      child: ImageFiltered(
        imageFilter: ImageFilter.blur(sigmaX: 40, sigmaY: 40),
        child: Image.asset(
          "assets/img.png",
          // not work
          height: 100,
          width: 100,
        ),
      ),
    );
  }
}
