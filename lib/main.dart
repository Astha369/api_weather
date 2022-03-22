import 'package:flutter/material.dart';
import 'package:weather_app/additional_information.dart';
import 'package:weather_app/current_weather.dart';
import 'package:weather_app/model/weather_model.dart';
import 'package:weather_app/services/weather_api.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Weather App",
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  WeatherApiClient client = WeatherApiClient();
  Weather? data;
  Future<void> getData() async{
    data =  await client.getCurrentWeather("London");
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(20, 33, 54, 1),
        elevation: 0.0,
        title: Center(
          child: Text("Weather App", style: TextStyle(
            color: Colors.white,
            fontSize: 36,
          ),
          ),
        ),
      ),
      body: FutureBuilder(
        future: getData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                currentWeather(Icons.wb_sunny_rounded, "${data!.temp}", "${data!.cityName}"),
                SizedBox(height: 50.0,),
                Text(
                  "Additional Information",
                  style: TextStyle(
                    fontSize: 28.0,
                    color: Color(0x652A0E44),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Divider(color: Colors.black,),
                SizedBox(height: 20.0),
                additionalInformation("${data!.wind}", "${data!.humidity}", "${data!.pressure}", "${data!.feels_like}"),
              ],
            );
          }else if(snapshot.connectionState == ConnectionState.waiting){
            return Center(child: CircularProgressIndicator());
          };
          return Container();
        },
      ),
    );
  }
}

