import 'dart:convert';

import 'package:basicfetchweatherapi/weather_model.dart';
import 'package:http/http.dart' as http;
class Repo {
  getWeather(String? city) async {
    var url =
        "https://api.openweathermap.org/data/2.5/weather?q=$city&APPID=d034801530562204cb91a60df23e2087";

    final res = await http.get(Uri.parse(url));

    var resBody = res.body;
    print(resBody);
    try {
      if (res.statusCode == 200) {
        return WeatherModel.fromJson(json.decode(resBody));
      }
    } catch (e) {
      throw Exception();
    }
  }
}