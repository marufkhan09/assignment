import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/current_remaining_time.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';

class AnswersPage extends StatefulWidget {
  const AnswersPage({super.key});

  @override
  State<AnswersPage> createState() => _AnswersPageState();
}

class _AnswersPageState extends State<AnswersPage> {
  bool randomBool = true;
  int count = 0;
  late var endTime;
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const SizedBox(),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Visibility(
                  visible: randomBool,
                  child: Center(
                    child: IconButton(
                        splashRadius: 100,
                        iconSize: 100,
                        icon: Container(
                          alignment: Alignment.center,
                          child: Container(
                            width: 100,
                            height: 100,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30.0),
                                image: const DecorationImage(
                                    image: NetworkImage(
                                      "https://images.unsplash.com/photo-1547721064-da6cfb341d50",
                                    ),
                                    fit: BoxFit.cover)),
                          ),
                        ),
                        onPressed: () {
                          setState(() {
                            randomBool = Random().nextBool();
                            count++;
                            //wait for the number of minutes
                            endTime = DateTime.now().millisecondsSinceEpoch +
                                1000 * 60 * count;
                          });
                        }),
                  )),
              randomBool == false
                  ? CountdownTimer(
                      onEnd: () {
                        setState(() {
                          randomBool = true;
                          count = 0;
                        });
                      },
                      endTime: endTime,
                      widgetBuilder:
                          (BuildContext context, CurrentRemainingTime? time) {
                        if (time == null) {
                          return const SizedBox.shrink();
                        }
                        return time.min != null
                            ? Text(
                                " ${time.min}:${time.sec}",
                                style: const TextStyle(
                                    color: Colors.red,
                                    fontSize: 30,
                                    fontWeight: FontWeight.w600),
                              )
                            : Text(
                                " 00:${time.sec}",
                                style: const TextStyle(
                                    color: Colors.red,
                                    fontSize: 30,
                                    fontWeight: FontWeight.w600),
                              );
                      },
                    )
                  : const SizedBox.shrink(),
            ],
          ),
          Container(
            margin: const EdgeInsets.all(50),
            height: 50,
            child: Text("$count", style: const TextStyle(fontSize: 50)),
          )
        ],
      ),
    );
  }
}
