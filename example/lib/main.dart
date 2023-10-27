import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_pffastconv/flutter_pffastconv.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: ElevatedButton(
            onPressed: () {
              final signal = [
                1.0,
                2.0,
                3.0,
                4.0,
                5.0,
                0.0,
                0.0,
                0.0,
                0.0,
                0.0,
              ];
              final fillter = [0.2, 0.2, 0.2, 0.2, 0.2];
              final res = FlutterPFFASTCONV().fftconvolve(signal, fillter);
              // output: [2.0, 3.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]
              print(res);
            },
            child: Text('Running on:'),
          ),
        ),
      ),
    );
  }
}
