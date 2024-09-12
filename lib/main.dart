import 'package:basicfetchweatherapi/repo.dart';
import 'package:basicfetchweatherapi/weather_model.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  TextEditingController controller = TextEditingController();
  WeatherModel? weatherModel;

  // Function to convert Kelvin to Celsius
  double _kelvinToCelsius(double temp) {
    return temp - 273.15;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(
              title: Center(child: Text("Weather App")),
            ),
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextField(
                  controller: controller,
                ),
                ElevatedButton(
                    onPressed: () async {
                      weatherModel = await Repo().getWeather(controller.text);

                      // Convert temperatures from Kelvin to Celsius
                      if (weatherModel?.main?.temp != null) {
                        weatherModel!.main!.temp = _kelvinToCelsius(weatherModel!.main!.temp!);
                        weatherModel!.main!.tempMin = _kelvinToCelsius(weatherModel!.main!.tempMin!);
                        weatherModel!.main!.tempMax = _kelvinToCelsius(weatherModel!.main!.tempMax!);
                      }

                      print(weatherModel?.main?.temp ?? "error");
                      setState(() {});
                    },
                    child: Text("Search")),
                Text("Temp: ${weatherModel?.main?.temp?.toStringAsFixed(2)} °C"),
                Text("Min Temp: ${weatherModel?.main?.tempMin?.toStringAsFixed(2)} °C"),
                Text("Max Temp: ${weatherModel?.main?.tempMax?.toStringAsFixed(2)} °C"),
              ],
            )));
  }
}
