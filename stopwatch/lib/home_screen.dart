import 'dart:async';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  int secounds =0, minutes = 0,hours = 0;
  String digitsecounds = "00", digitMinutes = "00", digitHours = "00";

  Timer? timer;
  bool started = false;
  List laps = [];

  //creating the stop timer function

void stop(){
  timer!.cancel();
  setState(() {
    started = false;
  });
}

//creating the reset function

  void reset (){
 timer!.cancel();
 setState(() {
   secounds = 0;
   minutes = 0;
   hours = 0;

   digitsecounds = "00";
   digitMinutes = "00";
   digitHours = "00";

   started = false;

 });
}


void addLaps(){
  String lap = "$digitHours:$digitMinutes:$digitsecounds";
  setState(() {
    laps.add(lap);
  });
}

//creating the start timer function

  void start(){
  started = true;
  timer = Timer.periodic(Duration(seconds: 1), (timer){
    int localSecounds = secounds+1;
    int localMinutes = minutes;
    int localHours = hours;

    if(localSecounds > 59){
      if(localMinutes> 59){
        localHours++;
        localMinutes = 0;
      } else {
        localMinutes++;
        localSecounds = 0;
      }
    }

    setState(() {
      secounds = localSecounds;
      minutes = localMinutes;
      hours = localHours;
      digitsecounds = (secounds >= 10) ? "$secounds": "0$secounds";
      digitHours = (hours >= 10) ? "$hours": "0$hours";
      digitMinutes = (minutes >= 10) ? "$minutes": "0$minutes";
    });


  });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1C2757),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: Text("StopWatch App", style: TextStyle(
                  color: Colors.white,
                  fontSize: 28.0,
                  fontWeight: FontWeight.bold,
                ),),
              ),
              SizedBox(
                height: 20.0,
              ),
              Center(
                child: Text("$digitHours:$digitMinutes:$digitsecounds",style: TextStyle(
                  color: Colors.white,
                  fontSize: 82,
                  fontWeight: FontWeight.w600,
                ),),
              ),

              Container(
                height: 400.0,
                decoration: BoxDecoration(
                  color: Color(0xFF323F68),
                  borderRadius: BorderRadius.circular(8.0),
                ),

                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView.builder(
                    itemCount: laps.length,
                      itemBuilder: (context, index ){
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Lap n${index+1}",style: TextStyle(
                              color: Colors.white,
                            fontSize: 16.0,
                            ),
                            ),
                            Text(
                              "${laps[index]}",style: TextStyle(
                              color: Colors.white,
                              fontSize: 16.0,
                            ),
                            ),
                          ],
                        );
                      }
                  ),
                ),
              ),

              SizedBox(
                height: 20.0,
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                      child: RawMaterialButton(
                        onPressed: (){
                          (!started) ?start ():stop();
                        },
                        fillColor: Colors.blue,
                        shape: StadiumBorder(
                          side: BorderSide(color: Colors.blue),
                        ),
                        child: Text(
                          (!started) ? "Start" : "Pause" ,
                          style: TextStyle(
                          color: Colors.white,
                        ),
                        ),

                      )
                  ),
                  SizedBox(width: 8.0,),

                  IconButton(onPressed: (){
                    addLaps();
                  },
                      icon: Icon(Icons.flag,color: Colors.white,),
                  ),

                  Expanded(
                      child: RawMaterialButton(
                        onPressed: (){
                          reset();
                        },
                        fillColor: Colors.blue,
                        shape: StadiumBorder(
                          side: BorderSide(color: Colors.blue),
                        ),
                        child: Text(
                          "Reset",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),

                      )
                  ),
                ],
              )
            ],
          ),
        ),
      )
    );
  }
}
