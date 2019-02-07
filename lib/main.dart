import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  bool didLoadImages = false;

  @override
  Widget build(BuildContext context) {
    // Pre-cache images
    if (!didLoadImages) {
      for (var i = 1; i <= 110; i++) {
        precacheImage(AssetImage('photos/$i.jpg'), context);
      }
      didLoadImages = true;
    }

    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final int imageNumberOffset;

  MyHomePage({this.imageNumberOffset = 0});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Center(
        child: Container(
          width: 960,
          child: Column(
            children: <Widget>[
              // Back button
              imageNumberOffset == 0
                  ? Container()
                  : Container(
                      padding: EdgeInsets.only(top: 20),
                      child: FlatButton(
                        color: Colors.grey,
                        child: Text('Back'),
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                    ),
              // ListView of Rows with CardWidgets
              Expanded(
                child: ListView.builder(
                  itemCount: 5,
                  itemBuilder: (context, rowNumber) {
                    return Row(
                      children: [
                        CardWidget(
                          imageNumber:
                              (imageNumberOffset * 10) + (rowNumber * 2),
                          onTap: imageNumberOffset != 0
                              ? null
                              : () =>
                                  Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => MyHomePage(
                                        imageNumberOffset: rowNumber * 2 + 1),
                                  )),
                        ),
                        CardWidget(
                          imageNumber:
                              (imageNumberOffset * 10) + (rowNumber * 2) + 1,
                          onTap: imageNumberOffset != 0
                              ? null
                              : () =>
                                  Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => MyHomePage(
                                        imageNumberOffset: rowNumber * 2 + 2),
                                  )),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CardWidget extends StatelessWidget {
  final int imageNumber;
  final Function onTap;

  CardWidget({this.imageNumber, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 480,
        height: 240,
        child: Image.asset("photos/${imageNumber + 1}.jpg"),
      ),
    );
  }
}
