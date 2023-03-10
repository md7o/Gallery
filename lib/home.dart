import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:photo_view/photo_view.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<File> selectedImages = [];

  final _picker = ImagePicker();

  Future getImages() async {
    final pickedFile = await _picker.pickMultiImage(
        imageQuality: 100, // To set quality of images
        maxHeight: 1000,
        maxWidth: 1000);
    List<XFile> xfilePick = pickedFile;
    if (xfilePick.isNotEmpty) {
      for (var i = 0; i < xfilePick.length; i++) {
        selectedImages.add(File(xfilePick[i].path));
      }
      setState(
        () {},
      );
    } else {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Nothing is selected')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF191E2C),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Icon(
            Icons.bar_chart_rounded,
            size: 30,
            color: Colors.green,
          ),
        ),
        actions: const <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Icon(
              Icons.search_rounded,
              size: 30,
              color: Colors.green,
            ),
          )
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: SizedBox(
              width: double.infinity, // To show images in particular area only
              child: selectedImages.isEmpty // If no images is selected
                  ? const Center(
                      child: Text('Sorry nothing selected!!'),
                    )
                  : Padding(
                      padding: const EdgeInsets.all(10),
                      child: GridView.builder(
                        physics: const BouncingScrollPhysics(),
                        itemCount: selectedImages.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          mainAxisSpacing: 3,
                          crossAxisSpacing: 3,
                        ),
                        itemBuilder: (BuildContext context, int index) {
                          return Column(
                            children: [
                              Hero(
                                tag: '${selectedImages[index]}__heroTag',
                                child: Image.file(
                                  height: double.infinity,
                                  selectedImages[index],
                                  fit: BoxFit.cover,
                                ),
                              ),
                              IconButton(
                                  icon: Icon(Icons.navigate_next),
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Home2()),
                                    );
                                  }),
                            ],
                          );
                        },
                      ),
                    ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          getImages();
        },
        backgroundColor: Colors.green,
        child: const Icon(
          Icons.add,
          size: 30,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

class Home2 extends StatefulWidget {
  const Home2({
    super.key,
  });

  @override
  State<Home2> createState() => _Home2State();
}

class _Home2State extends State<Home2> {
  List<File> selectedImages = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF191E2C),
      body: Column(
        children: [
          Expanded(
            child: SizedBox(
              width: double.infinity, // To show images in particular area only
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: GridView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: selectedImages.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 1,
                    mainAxisSpacing: 3,
                    crossAxisSpacing: 3,
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    // TO show selected file
                    return Center(
                      child: Hero(
                        tag: '__heroTag',
                        child: Image.file(
                          height: double.infinity,
                          selectedImages[index],
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
