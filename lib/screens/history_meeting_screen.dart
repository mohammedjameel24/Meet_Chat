import "package:flutter/material.dart";
import 'package:meet_chat/services/firestore_methods.dart';

class HistoryMeetingScreen extends StatefulWidget {
  const HistoryMeetingScreen({Key? key}) : super(key: key);

  @override
  State<HistoryMeetingScreen> createState() => _HistoryMeetingScreenState();
}

class _HistoryMeetingScreenState extends State<HistoryMeetingScreen> {
  FireStoreMethods fireStoreMethods = FireStoreMethods();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: fireStoreMethods.getMeetingHistory,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator.adaptive(),
          );
        }
        return ListView.builder(
          shrinkWrap: true,
          itemCount: (snapshot.data! as dynamic).docs.length,
          itemBuilder: ((context, index) => ListTile(
                title: Padding(
                  padding: const EdgeInsets.only(top: 2),
                  child: Text(
                    "Room Name: ${(snapshot.data!).docs[index]['roomName']}",
                  ),
                ),
                subtitle: Text(
                  "Joined on ${((snapshot.data!).docs[index]['createdTime'].toDate())}",
                ),
              )),
        );
      },
    );
  }
}
