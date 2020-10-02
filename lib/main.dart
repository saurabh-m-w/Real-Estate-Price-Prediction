

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<bool> bhk=[true,false,false,false,false];
  List<bool> bathlist=[true,false,false,false,false];
  int bhkno=1;
  bool isloading=false;
  int bath=1;
  String location;
  List locationList=['Select Location'];
  String estimatedPrice='';
  String area='1000';

  Future<void> getprice(area,bhk,bath,location) async {
    setState(() {
      isloading=true;
    });
    //const url = 'http://127.0.0.1:5000/predict_home_price';
    const url = 'https://real-estates-price-prediction.herokuapp.com/predict_home_price';
    final response =await http.post(
        url,
        body:{
          'total_sqft': area.toString(),
          'bhk': bhk.toString(),
          'bath': bath.toString(),
          'location': location.toString()
        }
    );
    //print(json.decode(response.body)['estimated_price']);
    setState(() {
      isloading=false;
      estimatedPrice = json.decode(response.body)['estimated_price'].toString() + 'lakhs';
    });
  }

  @override
  void initState() {
    getlocations();
    super.initState();
  }
  getlocations() async{
    //const url = 'http://127.0.0.1:5000/get_location_names';
    const url = 'https://real-estates-price-prediction.herokuapp.com/get_location_names';
    final response2 = await http.get(url);
    setState(() {
      locationList = json.decode(response2.body)['locations'];
    });

    print(locationList[1].toString());
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("RealEstatePricePrediction"),
        ),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(image: AssetImage("background.jpg"),fit: BoxFit.cover,),
          ),

          child: Container(

            color: Colors.grey.withOpacity(0.6),
            child: Center(

                child: Container(
                  width: 280,
                  //color: Colors.grey.withOpacity(0.6),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      //scrollDirection: Axis.vertical,
                      children: [
                        SizedBox(height: 15,),
                        Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            onChanged: (val){
                                    area=val;
                            },
                            decoration: InputDecoration(
                              hintText: 'Area(Sqft)',
                              fillColor:  Colors.white,
                              filled: true,
                              enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black,width: 2.0)),
                              focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.pink,width: 2.0)),
                            ),
                          ),
                        ),
                        SizedBox(height: 15,),
                      Text('BHK',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                      Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: ToggleButtons(
                          fillColor: Colors.blue,
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                          borderWidth: 3,
                          borderColor: Colors.black26,
                          selectedBorderColor: Colors.black54,
                          selectedColor: Colors.black,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                '1',
                              ),
                            ),
                            // second toggle button
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                '2',
                              ),
                            ),
                            // third toggle button
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                '3',
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                '4',
                              ),
                            ),
                            // third toggle button
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                '5',
                              ),
                            ),
                          ],
                          onPressed: (index){
                              bhk=[false,false,false,false,false];
                              setState(() {
                                bhkno=index+1;
                                print(bhkno);
                                bhk[index]=true;
                              });
                          },
                          isSelected: bhk,
                        ),
                      ),
                        SizedBox(height: 15,),
                        Text('Bathrooms',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                        Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: ToggleButtons(
                            fillColor: Colors.blue,
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                            borderWidth: 3,
                            borderColor: Colors.black26,
                            selectedBorderColor: Colors.black54,
                            splashColor: Colors.blueAccent,
                            selectedColor: Colors.black,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  '1',
                                ),
                              ),
                              // second toggle button
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  '2',
                                ),
                              ),
                              // third toggle button
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  '3',
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  '4',
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  '5',
                                ),
                              ),
                            ],
                            onPressed: (index){
                              bathlist=[false,false,false,false,false];
                              setState(() {
                                bathlist[index]=true;
                                bath=index+1;
                              });
                            },
                            isSelected: bathlist,
                          ),
                        ),
                        SizedBox(height: 15,),
                        Text('Location',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),

                        Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: Container(
                            width: 270,
                            padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                color: Colors.white70,
                                ),
                            child: DropdownButtonHideUnderline(

                              child: DropdownButton(

                                value: location,
                                items: locationList.map(( val) {
                                  return DropdownMenuItem<String>(
                                    value: val,
                                    child:  Text(val),
                                  );
                                }).toList(),
                                onChanged: (val){
                                  setState(() {
                                    location=val;
                                  });
                                },
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 25,),
                        Container(
                          width: 250,
                          padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            color: Colors.blue,
                          ),
                          child: FlatButton(
                            color: Colors.blue,
                            onPressed: () {
                              getprice(area,bhkno,bath,location);
                            },
                            child: Text('Estimate Price'),

                          ),
                        ),
                        SizedBox(height: 15,),
                        Container(
                          height: 45,
                          width: 250,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            //color: Colors.grey,
                          ),
                          child: Center(
                            child: isloading?SpinKitSquareCircle(
                              color: Colors.white70,
                              size: 50.0,
                            ):Text(estimatedPrice,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,),
                        ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
            ),
          ),
        ),
      ),
    );
  }
}
