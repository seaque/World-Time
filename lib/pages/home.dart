import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Map data = {};

  @override
  Widget build(BuildContext context) {
    data = data.isEmpty ? ModalRoute.of(context)!.settings.arguments as Map : data;

    String bgImage = data['isDayTime'] ? 'day.jpg' : 'night.jpg';
    Color bgColor = data['isDayTime'] ? const Color.fromARGB(255, 30, 92, 121) : Colors.indigo;

    return Scaffold(
        backgroundColor: bgColor,
        body: SafeArea(
          child: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
              image: AssetImage('assets/images/$bgImage'),
              fit: BoxFit.cover,
            )),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0.0, 160.0, 0.0, 0.0),
              child: Column(
                children: <Widget>[
                  TextButton.icon(
                      onPressed: () async {
                        dynamic result = await Navigator.pushNamed(context, '/location');
                        setState(() {
                          data = {'location': result['location'],
                                  'time': result['time'],
                                  'flag': result['flag'],
                                  'isDayTime': result['isDayTime']};
                        });
                      },
                      icon: const Icon(
                        Icons.edit_location,
                        color: Colors.white,
                      ),
                      label: const Text(
                        'Edit Location',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      )),
                  const SizedBox(height: 20.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        data['location'].toUpperCase(),
                        style: const TextStyle(
                          fontSize: 38.0,
                          letterSpacing: 1.0,
                          color: Colors.white,
                          shadows: <Shadow>[
                            Shadow(
                              offset: Offset(1.0, 1.0),
                              blurRadius: 2.0,
                              color: Color.fromARGB(255, 0, 0, 0),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15.0),
                  Text(
                    data['time'],
                    style: const TextStyle(
                      fontSize: 90.0,
                      color: Colors.white,
                      shadows: <Shadow>[
                        Shadow(
                          offset: Offset(2.0, 2.0),
                          blurRadius: 2.0,
                          color: Color.fromARGB(255, 0, 0, 0),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
