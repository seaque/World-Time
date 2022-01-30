import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime {
  late String location;
  late String time;
  late String flag;
  late String url;
  late bool isDayTime;

  WorldTime({required this.location, required this.flag, required this.url});

  Future<void> getTime() async {
    try {
      //making request
      Response response = await get(Uri.parse('http://worldtimeapi.org/api/timezone/$url'));
      Map data = jsonDecode(response.body);

      String dateTime = data['datetime'];
      int utcOffset = int.parse( data['utc_offset'].toString().substring(1, 3) );
      DateTime now = DateTime.parse(dateTime).add(Duration(hours: utcOffset));

      isDayTime = now.hour > 6 && now.hour < 18 ? true : false; //day is between 6 AM and 6 PM.
      time = DateFormat.Hm().format(now);
    } catch (_) {

    }
  }
}
