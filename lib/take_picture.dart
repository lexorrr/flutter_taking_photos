import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;

class TakePicture extends StatefulWidget {
  final CameraDescription camera;
  TakePicture({required this.camera});

  @override
  _TakePictureState createState() => _TakePictureState();
}

class _TakePictureState extends State<TakePicture> {
  late final CameraController _controller;
  late final Future<void> _initController;

  @override
  void initState() {
    super.initState();
    _controller = CameraController(widget.camera, ResolutionPreset.high);

    _initController = _controller.initialize();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        FutureBuilder<void>(
          future: _initController,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return Expanded(
                child: Center(
                  child: AspectRatio(
                    aspectRatio: _controller.value.aspectRatio,
                    child: CameraPreview(_controller),
                  ),
                ),
              );
            }

            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
        IconButton(
            icon: const Icon(Icons.photo_camera),
            onPressed: () => _takePhoto(context)),
      ],
    );
  }

  void _takePhoto(BuildContext context) async {
    await _initController;

    // File name nad path
    final dir = await getTemporaryDirectory();
    final name = 'mypic_${DateTime.now()}.png';

    // Store the picture at the given location
    final fullPath = path.join(dir.path, name);

    await _controller.takePicture();
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: const Text('Picture taken!'), duration: const Duration(milliseconds: 600)),
    );
  }
}
