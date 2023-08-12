import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class updatePage extends StatefulWidget {
  var doc;

  var productName;

  var productPrice;

  var productDes;

  var name;

  var phone;

  var email;

  var drop;

  updatePage(
      {Key? key,
      required this.doc,
      required this.productName,
      required this.productPrice,
      required this.productDes,
      required this.name,
      required this.phone,
      required this.email,
      required this.drop})
      : super(key: key);

  @override
  State<updatePage> createState() => _updatePageState();
}

class _updatePageState extends State<updatePage> {
  CollectionReference productRef =
      FirebaseFirestore.instance.collection("Product");

  final formKey = GlobalKey<FormState>();

  TextEditingController productName = TextEditingController();
  TextEditingController productPrice = TextEditingController();
  TextEditingController productDes = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController email = TextEditingController();

  String dropdownvalue = 'Low';

  var items = [
    'High',
    'Medium',
    'Low',
  ];

  File? file;

  @override
  Widget build(BuildContext context) {

    productName.text = widget.productName;
    productPrice.text = widget.productPrice;
     productDes.text = widget.productDes;
     name.text = widget.name;
     phone.text = widget.phone;
     email.text = widget.email;

    return Scaffold(
      backgroundColor: Color(0xfff9dbbd),
      appBar: AppBar(
        title: Text(" P R O D U C T   D A T A   U P D A T E "),
        centerTitle: true,
        backgroundColor: Color(0xff450920),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Center(
              child: InkWell(
                onTap: () {
                  imagep();
                },
                child: CircleAvatar(
                  backgroundImage: AssetImage("assets/image/db.png"),
                  radius: 150,
                  backgroundColor: Color(0xfff9dbbd),
                ),
              ),
            ),
            Form(
              key: formKey,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: productName,
                      decoration: InputDecoration(
                        hintText: "Enter Your Product Name",
                        labelText: "Product Name",
                        labelStyle: TextStyle(color: Colors.black),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(
                              color: Colors.black,
                              style: BorderStyle.solid,
                            )),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(
                              color: Color(0xff450920),
                              style: BorderStyle.solid,
                            )),
                      ),
                      validator: (value) {
                        if (value!.isEmpty ||
                            !RegExp(r'^[a-z A-Z]+[a-z A-Z]+$')
                                .hasMatch(value)) {
                          return "Enter Correct Name";
                        } else {
                          return null;
                        }
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: productPrice,
                            decoration: InputDecoration(
                              hintText: "Enter Your Product Price",
                              labelText: 'Product Price',
                              labelStyle: TextStyle(color: Colors.black),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide: BorderSide(
                                    color: Colors.black,
                                    style: BorderStyle.solid,
                                  )),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide: BorderSide(
                                    color: Color(0xff450920),
                                    style: BorderStyle.solid,
                                  )),
                            ),
                            validator: (value) {
                              if (value!.isEmpty ||
                                  !RegExp(r'^[+]*[(]{0,1}[0-9]{1,4}[)]{0,1}')
                                      .hasMatch(value)) {
                                return "Enter Correct Product Price";
                              } else {
                                return null;
                              }
                            },
                          ),
                        ),
                        SizedBox(width: 10),
                        DropdownButton(
                            value: dropdownvalue,
                            dropdownColor: Color(0xfff9dbbd),
                            icon: const Icon(Icons.keyboard_arrow_down),
                            items: items.map((String items) {
                              return DropdownMenuItem(
                                value: items,
                                child: Text(items),
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                              setState(() {
                                dropdownvalue = newValue!;
                              });
                            }),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: productDes,
                      decoration: InputDecoration(
                        hintText: "Enter Your Description",
                        labelText: "Description",
                        labelStyle: TextStyle(color: Colors.black),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(
                              color: Colors.black,
                              style: BorderStyle.solid,
                            )),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(
                              color: Color(0xff450920),
                              style: BorderStyle.solid,
                            )),
                      ),
                      validator: (value) {
                        if (value!.isEmpty ||
                            !RegExp(r'^[a-z A-Z]+[a-z A-Z]+$')
                                .hasMatch(value)) {
                          return "Enter Product Description";
                        } else {
                          return null;
                        }
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: name,
                      decoration: InputDecoration(
                        hintText: "Enter Your Name",
                        labelText: "Name",
                        labelStyle: TextStyle(color: Colors.black),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(
                              color: Colors.black,
                              style: BorderStyle.solid,
                            )),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(
                              color: Color(0xff450920),
                              style: BorderStyle.solid,
                            )),
                      ),
                      validator: (value) {
                        if (value!.isEmpty ||
                            !RegExp(r'^[a-z A-Z]+[a-z A-Z]+$')
                                .hasMatch(value)) {
                          return "Enter Correct Name";
                        } else {
                          return null;
                        }
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: phone,
                      decoration: InputDecoration(
                        hintText: "Enter Your Phone Number",
                        labelText: 'Phone Number',
                        labelStyle: TextStyle(color: Colors.black),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(
                              color: Colors.black,
                              style: BorderStyle.solid,
                            )),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(
                              color: Color(0xff450920),
                              style: BorderStyle.solid,
                            )),
                      ),
                      validator: (value) {
                        if (value!.isEmpty ||
                            !RegExp(r'^[+]*[(]{0,1}[0-9]{1,4}[)]{0,1}[-\s\./0-9]*$')
                                .hasMatch(value)) {
                          return "Enter Correct Phone Number";
                        } else {
                          return null;
                        }
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: email,
                      decoration: InputDecoration(
                        hintText: "Enter Your Email",
                        labelText: 'Email',
                        labelStyle: TextStyle(color: Colors.black),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(
                              color: Colors.black,
                              style: BorderStyle.solid,
                            )),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(
                              color: Color(0xff450920),
                              style: BorderStyle.solid,
                            )),
                      ),
                      validator: (value) {
                        if (value!.isEmpty ||
                            !RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                                .hasMatch(value)) {
                          return "Enter Correct Email Address";
                        } else {
                          return null;
                        }
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: () async {
                        if (formKey.currentState!.validate()) {
                          if (file != null) {
                            Reference imageReference = FirebaseStorage.instance
                                .ref("Image/${file!.path.split("/").last}");
                            print(imageReference);
                            await imageReference.putFile(file!);

                            String path = await imageReference.getDownloadURL();

                            productRef.doc(widget.doc).update({
                              "image": path,
                              "productName": productName.text,
                              "productPrice": productPrice.text,
                              "drop": dropdownvalue,
                              "productDes": productDes.text,
                              "name": name.text,
                              "phone": phone.text,
                              "email": email.text,
                            });
                          } else {
                            productRef.doc(widget.doc).update({
                              "productName": productName.text,
                              "productPrice": productPrice.text,
                              "drop": dropdownvalue,
                              "productDes": productDes.text,
                              "name": name.text,
                              "phone": phone.text,
                              "email": email.text,
                            });
                          }
                        }
                        Navigator.pop(context);
                      },
                      child: Container(
                        height: 40,
                        width: 120,
                        decoration: BoxDecoration(
                            color: Color(0xff450920),
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        child: Center(
                            child: Text(
                          "Update",
                          style: TextStyle(color: Colors.white),
                        )),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 12,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  imagep() async {
    final ImagePicker picker = ImagePicker();

    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      file = File(image.path);
      print(file!.path);
    }
  }
}
