import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Image Picker App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<File> images = [];

  Future<void> _pickImage(ImageSource source) async {
    final pickedImage = await ImagePicker().pickImage(source: source);
    if (pickedImage != null) {
      setState(() {
        images.add(File(pickedImage.path));
      });
    }
  }

  void _removeImage(int index) {
    setState(() {
      images.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Image Picker App'),
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () => _pickImage(ImageSource.gallery),
                child: Text('Fotobibliothek öffnen'),
              ),
              ElevatedButton(
                onPressed: () => _pickImage(ImageSource.camera),
                child: Text('Kamera öffnen'),
              ),
            ],
          ),
          Expanded(
            child: ListView.builder(
              itemCount: images.length,
              itemBuilder: (ctx, index) {
                return ListTile(
                  onTap: () => _removeImage(index),
                  title: Image.file(images[index]),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}












