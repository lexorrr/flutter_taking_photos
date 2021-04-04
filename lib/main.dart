import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_taking_photos/take_picture.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final cameras = await availableCameras();
  final firstCamera = cameras.first;

  runApp(MyApp(
    camera: firstCamera,
  ));
}

class MyApp extends StatelessWidget {
  final CameraDescription camera;
  const MyApp({required this.camera});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(
        camera: camera,
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final CameraDescription camera;
  const MyHomePage({required this.camera});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Using camera'),
      ),
      body: TakePicture(
        camera: camera,
      ),
    );
  }
}
