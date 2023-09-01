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
            const Text("blur network image"),
            _buildBlurNetworkImage(handleNavigate),
            const SizedBox(
              height: 40,
            ),
            const Text("blur local image"),
            _buildBlurLocalImage(handleNavigate),
            const SizedBox(
              height: 40,
            ),
            const Text("pure image"),
            _buildPureImage(handleNavigate),
            const SizedBox(
              height: 40,
            ),
            const Text("backdropped"),
            _buildBackdropped(handleNavigate),
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  _buildBlurNetworkImage(VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: ImageFiltered(
        imageFilter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Image.network(
          // random
          "https://picsum.photos/200/300",
          fit: BoxFit.cover,
          width: 100,
          height: 100,
        ),
      ),
    );
  }

  _buildBlurLocalImage(VoidCallback onTap) {
    return ClipRect(
      child: GestureDetector(
        onTap: onTap,
        child: ImageFiltered(
          imageFilter: ImageFilter.blur(sigmaX: 40, sigmaY: 40),
          child: Image.asset(
            "assets/img.png",
            // not work
            height: 100,
            width: 100,
          ),
        ),
      ),
    );
  }

  _buildPureImage(VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Image.asset(
        "assets/img.png",
        height: 100,
        width: 100,
      ),
    );
  }

  _buildBackdropped(VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        children: [
          Image.asset(
            "assets/img.png",
            height: 100,
            width: 100,
          ),
          ClipRect(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: const SizedBox(
                height: 100,
                width: 100,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
