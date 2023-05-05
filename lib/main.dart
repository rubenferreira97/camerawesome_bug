import 'package:camerawesome/camerawesome_plugin.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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

enum ViewType { camera, text }

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  ViewType viewType = ViewType.camera;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: switch (viewType) {
        ViewType.camera => CameraAwesomeBuilder.previewOnly(
            onImageForAnalysis: (img) async {},
            imageAnalysisConfig: AnalysisConfig(
              androidOptions: const AndroidAnalysisOptions.nv21(
                width: 1024,
              ),
              cupertinoOptions: const CupertinoAnalysisOptions.bgra8888(),
              maxFramesPerSecond: 5,
            ),
            builder: (cameraState, previewSize, previewRect) =>
                const SizedBox.shrink(),
          ),
        ViewType.text => const Center(child: Text('Hi'))
      },
      floatingActionButton: FloatingActionButton(
        onPressed: () => setState(() {
          viewType = switch (viewType) {
            ViewType.camera => ViewType.text,
            ViewType.text => ViewType.camera
          };
        }),
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
