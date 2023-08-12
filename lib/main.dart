import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:productcloudfirebase/firebase_options.dart';
import 'package:productcloudfirebase/insertpage.dart';
import 'package:productcloudfirebase/updatepage.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          textSelectionTheme:
              TextSelectionThemeData(cursorColor: Color(0xff450920))),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  CollectionReference productRef =
      FirebaseFirestore.instance.collection("Product");

  List catList = ["High", "Medium", "Low"];

  String? selectCat;

// bool isTapped = false;
// void istoggleEnabled(){
//   setState(() {
//     isTapped = !isTapped;
//
//   });
// }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff9dbbd),
      appBar: AppBar(
        title: Text(" P R O D U C T   D A T A"),
        centerTitle: true,
        backgroundColor: Color(0xff450920),
      ),
      body: Column(
        children: [
          Container(
            height: 60,
            color: Color(0xfff9dbbd),
            child: ListView.builder(
              itemCount: catList.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(
                      top: 10, bottom: 10, right: 5, left: 5),
                  child: InkWell(
                    onTap: () {
                    if(selectCat == catList[index])
                      {
                        selectCat = null;
                      }
                    else
                      {
                        selectCat = catList[index];
                      }
                      setState(() {});
                    },
                    child: Container(
                      width: 120,
                      decoration: BoxDecoration(
                        color: selectCat == catList[index]
                            ? Color(0xffc77dff)
                            : Color(0xfff4978e),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Center(
                          child: Text(
                        "${catList[index]}",
                        style: TextStyle(color: Colors.white),
                      )),
                    ),
                  ),
                );
              },
            ),
          ),
          StreamBuilder(
            stream: selectCat != null
                ? productRef.where("drop", isEqualTo: selectCat).snapshots()
                : productRef.snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Column(
                  children: [
                    Center(
                        child: Text(
                            " *** *** *** *** ***  E R R O R  *** *** *** *** *** ")),
                  ],
                );
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Column(
                  children: [
                    Center(
                      child: CircularProgressIndicator(
                        color: Color(0xff450920),
                      ),
                    )
                  ],
                );
              }
              return Expanded(
                child: ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    var item = snapshot.data!.docs[index].data() as Map;
                    return Padding(
                      padding:
                          const EdgeInsets.only(top: 15, left: 10, right: 10),
                      child: Card(
                        color: Color(0xffFFC4C4),
                        child: Row(
                          children: [
                            SizedBox(
                              width: 5,
                            ),
                            Column(
                              children: [
                                CircleAvatar(
                                  backgroundImage:
                                      NetworkImage("${item["image"]}"),
                                  radius: 30,
                                ),
                              ],
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Product Name :- ${item["productName"]}",
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold)),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text("Product Category :- ${item["drop"]}"),
                                ],
                              ),
                            ),
                            Column(
                              children: [
                                Container(
                                  color: Color(0xffcdb4db),
                                  child: IconButton(
                                      onPressed: () {
                                        productRef
                                            .doc(snapshot.data!.docs[index].id);
                                      },
                                      icon: Icon(Icons.delete)),
                                ),
                                Container(
                                  color: Color(0xffa2d2ff),
                                  child: IconButton(
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => updatePage(
                                                doc:
                                                    ("${snapshot.data!.docs[index].id}"),
                                                productName:
                                                    ("${item["productName"]}"),
                                                productPrice:
                                                    ("${item["productPrice"]}"),
                                                productDes:
                                                    ("${item["productDes"]}"),
                                                name: ("${item["name"]}"),
                                                phone: ("${item["phone"]}"),
                                                email: ("${item["email"]}"),
                                                drop: ("${item["drop"]}"),
                                              ),
                                            ));
                                      },
                                      icon: Icon(
                                        Icons.edit,
                                        color: Colors.white,
                                      )),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    );
                  },
                ),
              );
            },
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xff450920),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.elliptical(10, 10),
                topRight: Radius.elliptical(10, 10),
                bottomRight: Radius.elliptical(100, 100),
                bottomLeft: Radius.elliptical(100, 100))),
        autofocus: true,
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => insertPage(),
              ));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
