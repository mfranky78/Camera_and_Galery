import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Future pickImage(ImageSource src) async {
    final image = await ImagePicker().pickImage(source: src);
    setState(() {
      imagePath = image?.path ?? "";
      imageList.add(File(imagePath));
    });
  }

  void removeImage(int index) {
    setState(() {
      imageList.removeAt(index);
    });
  }

  String imagePath = "";

  List<File> imageList = [];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(backgroundColor: Colors.limeAccent,
        appBar: AppBar(title: const Text('TS_Kamera')),
        body: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  height: 50,
                  width: 120,
                  color: Colors.greenAccent,
                  child: MaterialButton(
                    onPressed: () {
                      pickImage(ImageSource.gallery);
                    },
                    child: const Text('Open Gallery'),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Container(
                  height: 50,
                  width: 120,
                  color: Colors.greenAccent,
                  child: MaterialButton(
                    onPressed: () {
                      pickImage(ImageSource.camera);
                    },
                    child: const Text('Open Kamera'),
                  ),
                ),
              ],
            ),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(30),
                itemCount: imageList.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    
                      onTap: () => removeImage(index),
                      title: Image.file(imageList[index]));
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
