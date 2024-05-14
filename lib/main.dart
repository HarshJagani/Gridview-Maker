import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:image_picker/image_picker.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme:
            ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 87, 89, 202)),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Cars'),
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
  final ImagePicker imagePicker = ImagePicker();

  List<String> defualtimages = [
    'assets/images/bmw_7.jpeg',
    'assets/images/bmw_i8.jpeg',
    'assets/images/dbs_superleggera.jpeg',
    'assets/images/bentley.jpeg',
    'assets/images/mustang.jpeg',
    'assets/images/g_wagon.webp',
    'assets/images/vantage.webp',
    'assets/images/maybach.jpeg'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Cars'),
          titleTextStyle: TextStyle(
              color: Color.fromARGB(255, 237, 232, 232),
              fontSize: 28,
              fontFamily: 'Mukta'),
          centerTitle: true,
          flexibleSpace: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20))),
          ),
          backgroundColor: const Color.fromARGB(255, 87, 89, 202),
        ),
        body:
            //to set grid according to image size
            MasonryGridView.builder(
                itemCount: defualtimages.length,
                gridDelegate: SliverSimpleGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.all(4),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: defualtimages[index].startsWith('assets')
                          ? Image.asset(defualtimages[index])
                          : Image.file(File(defualtimages[index])),
                    ),
                  );
                }),
        floatingActionButton: SpeedDial(
          icon: Icons.add,
          children: [
            SpeedDialChild(
              child: Icon(Icons.browse_gallery),
              label: 'Gallery',
              onTap: () => selectedimage(true),
            ),
            SpeedDialChild(
              child: Icon(Icons.camera),
              label: 'Camara',
              onTap: () => selectedimage(false),
            )
          ],
        ));
  }

  // ignore: unused_element
  void selectedimage(bool Gallery) async {
    if (Gallery) {
      final List galleryimage = await imagePicker.pickMultiImage();

      if (galleryimage.isNotEmpty) {
        for (int i = 0; i < galleryimage.length; i++) {
          defualtimages.add(galleryimage[i].path);
          setState(() {});
        }
      }
    } else {
      final pickerimage =
          await imagePicker.pickImage(source: ImageSource.camera);

      if (pickerimage != null) {
        defualtimages.add(pickerimage.path);
        setState(() {});
      }
    }
  }
}
