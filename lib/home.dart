import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

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
      // maxHeight: 1000,
      // maxWidth: 1000
    );
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
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Nothing is selected'),
        ),
      );
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
                          return InkWell(
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Home2(
                                  content: selectedImages[index],
                                ),
                              ),
                            ),
                            child: Hero(
                              tag: index,
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
  File content;

  Home2({Key? key, required this.content}) : super(key: key);

  @override
  State<Home2> createState() => _Home2State();
}

class _Home2State extends State<Home2> {
  @override
  Widget build(
    BuildContext context,
  ) {
    return Scaffold(
      backgroundColor: const Color(0x6C191E2C),
      appBar: AppBar(backgroundColor: const Color(0xFF191E2C)),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Image.file(
              widget.content,
              fit: BoxFit.cover,
            ),
          )
          // Expanded(
          //   child: ListView.builder(
          //     itemCount: 1,
          //     shrinkWrap: true,
          //     physics: const BouncingScrollPhysics(),
          //     itemBuilder: (BuildContext context, int index) {
          //       return Column(
          //         mainAxisAlignment: MainAxisAlignment.center,
          //         children: [
          //           Container(
          //             child: Image.file(
          //               widget.content,
          //               fit: BoxFit.contain,
          //             ),
          //           ),
          //         ],
          //       );
          //     },
          //   ),
          // ),
          // for (final File in index)
        ],
      ),
      bottomNavigationBar: Theme(
        data: ThemeData(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
        ),
        child: Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(50)),
            color: Color(0x00192836),
          ),
          child: BottomNavigationBar(
            iconSize: 25,
            elevation: 0,
            backgroundColor: const Color(0xFF191E2C),
            type: BottomNavigationBarType.fixed, //click effect
            fixedColor: Colors.white,
            unselectedItemColor: Colors.white,
            showUnselectedLabels: false,
            showSelectedLabels: false,
            // currentIndex: currentIndex,
            // onTap: (index) =>
            //     setState(() => currentIndex = index),
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.share),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.favorite_rounded),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.delete),
                label: '',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
