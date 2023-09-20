import 'package:get_it/get_it.dart';

import 'event_item.dart';
import 'package:flutter/material.dart';

import 'htttp_service.dart';

class EventsDate extends StatefulWidget {
  const EventsDate({super.key});

  @override
  State<EventsDate> createState() => _EventsDateState();
}

class _EventsDateState extends State<EventsDate> {
  bool _isloading = false;
  Event? _randomEvent;

  Future<void> _getEvent() async {
    setState(() {
      _isloading = true;
    });

    final client = GetIt.I.get<HttpService>().client();
    final response = await client.get(
      'http://numbersapi.com/random/year?json',
    );
    final Event event = Event.fromJson(response.data);
    setState(() {
      _randomEvent = event;
      _isloading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _getEvent();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            _isloading
                ? const Center(child: CircularProgressIndicator(color: Colors.white,))
                : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                '${_randomEvent?.text}',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal:20),
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(minimumSize:const Size.fromHeight(60),backgroundColor: Colors.white),
                  onPressed: () {
                    _getEvent();
                  },
                  child: const Text(
                    'Random Event',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                    ),
                  )),
            ),
          ])),
      backgroundColor: Colors.black,
    );
  }
}