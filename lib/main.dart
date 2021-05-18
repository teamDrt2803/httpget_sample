import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:httpget_sample/constants.dart';
import 'package:httpget_sample/modal.dart';
import 'package:http/http.dart' as http;

///Http package will help to get the data from the api call and give us a response

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
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
  var value;

  ///
  ///[This] method will handle the api call and give us the response in CountryCodes format to be used easily within the application
  ///
  Future<CountryCodes> getData() async {
    try {
      ///
      ///[Initialise] countrycode [variable] which will [store] our final [data]
      CountryCodes countryCode;

      ///
      ///Make a [Call] to the API
      ///Make sure to add [await] to wait for the [call] to fully [complete]
      ///
      var response = await http.get(
        Uri.parse(BASEURL),
      );

      ///
      ///[Decode] the response from the call in [json] format using [inbuilt] methods [jsonDecode]
      ///
      var json = jsonDecode(response.body);

      ///
      ///Create a [map] using [json] to be used for [parsing] data and [converting] it into our [DATA] class
      ///
      var map = Map<String, dynamic>.from(json);

      ///
      /// See [modal.dart] for these methods
      ///
      countryCode = CountryCodes.fromMap(map);

      ///
      ///[return] the [final] data object [parsed] to be used by the [function] which [called] it
      ///
      return countryCode;
    } catch (e) {
      ///Catch the errors here so the application doesn't crash
      print('***** ERROR *****');
      print(e);
      print('***** ERROR END *****');
      throw e;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sample API Call'),
      ),
      body: Container(
        child: FutureBuilder(
          future: getData(),

          /// Here pass the function we created above for a better flow of the data
          builder: (context, AsyncSnapshot<CountryCodes> snapshot) {
            ///
            ///Check is our function has returned any data
            ///If yes then show the drop down button
            ///
            if (snapshot.hasData) {
              print(snapshot.data.data.length);
              return Center(
                child: DropdownButton(
                    hint: Text('Select a Value'),

                    ///Set a default value to be shown when no value is selected
                    value: value,
                    items: [
                      ...List.generate(
                        snapshot.data.data.length,
                        (index) {
                          var data = snapshot.data.data[index];
                          return DropdownMenuItem(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('+${data.mastLookupKey}  ' +
                                    data.mastLookupValue.replaceAll(
                                        ('(+' + data.mastLookupKey + ')'), '')),
                              ],
                            ),
                            value: data.mastLookupKey,
                          );
                        },
                      ),
                    ],
                    onChanged: (value) {
                      setState(() {
                        this.value = value;
                      });
                    }),
              );
            } else if (snapshot.hasError) {
              return Center(
                ///
                ///Check is [function] returned an error show [data] according to it
                ///
                child: Text('Error occured please check logs'),
              );
            } else {
              ///if there is [no] [data] and no error then [probably] the function is till [fetching] the data so show a [progressn] indicator
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }
}
