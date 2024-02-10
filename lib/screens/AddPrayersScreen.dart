import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:prayertime_dashboard/controllers/mosque_controllers.dart';
import 'package:prayertime_dashboard/widgets/prayers_fileds.dart';
import 'package:prayertime_dashboard/widgets/reuse_textfields.dart';

import '../controllers/prayers_controller.dart';

class AddPrayersScreen extends StatefulWidget {
  final String docId;
  final String mosqueName;
  const AddPrayersScreen(
      {super.key, required this.docId, required this.mosqueName});

  @override
  State<AddPrayersScreen> createState() => _AddPrayersScreenState();
}

class _AddPrayersScreenState extends State<AddPrayersScreen> {
  final PrayersController prayersController = Get.put(PrayersController());

  DateTime selectedDateTime = DateTime.now();

  DateTime parseDateString(String dateString) {
    List<String> parts = dateString.split(' ');

    int day = int.parse(parts[0]);
    int month = parseMonth(parts[1]);
    int year = int.parse(parts[2]);
    int hour = int.parse(parts[3].split(':')[0]);
    int minute = int.parse(parts[3].split(':')[1]);
    String period = parts[4];

    // Handle leap year
    if (!DateTime.utc(year, 2, 29).isAfter(DateTime.utc(year, 2, 28))) {
      // Not a leap year, change day to 28
      day = 28;
    }

    if (period.toUpperCase() == 'PM' && hour < 12) {
      // Convert to 24-hour format if it's PM and hour is less than 12
      hour += 12;
    }

    return DateTime(year, month, day, hour, minute);
  }

  int parseMonth(String monthString) {
    switch (monthString) {
      case 'January':
        return 1;
      case 'February':
        return 2;
      case 'March':
        return 3;
      case 'April':
        return 4;
      case 'May':
        return 5;
      case 'June':
        return 6;
      case 'July':
        return 7;
      case 'August':
        return 8;
      case 'September':
        return 9;
      case 'October':
        return 10;
      case 'November':
        return 11;
      case 'December':
        return 12;
      default:
        throw ArgumentError('Invalid month string: $monthString');
    }
  }

  Future<void> _selectDate(BuildContext context) async {

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate:selectedDateTime,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (picked != null && picked != prayersController.datetextController.text) {
      prayersController.datetextController.value = TextEditingValue(text: DateFormat("MMMM d, y").format(picked));

      selectedDateTime = picked;

      DateTime fajrPrayerTime = parseAndCopyDate(prayersController.fajrprayerTimecontroller.text);
      print(fajrPrayerTime);
      DateTime fajrJammahTime = parseAndCopyDate(prayersController.fajrjammahTimecontroller.text);
      DateTime fajrPrayerEndTime = parseAndCopyDate(prayersController.fajrprayerendTimecontroller.text);

      DateTime sunrisePrayerTime = parseAndCopyDate(prayersController.sunriseprayerTimecontroller.text);
      DateTime sunriseJammahTime = parseAndCopyDate(prayersController.sunrisejammahTimecontroller.text);
      DateTime sunrisePrayerEndTime = parseAndCopyDate(prayersController.sunriseprayerendTimecontroller.text);

      DateTime duhrPrayerTime = parseAndCopyDate(prayersController.duhrprayerTimecontroller.text);
      DateTime duhrJammahTime = parseAndCopyDate(prayersController.duhrjammahTimecontroller.text);
      DateTime duhrPrayerEndTime = parseAndCopyDate(prayersController.duhrprayerendTimecontroller.text);

      DateTime asrPrayerTime = parseAndCopyDate(prayersController.asrprayerTimecontroller.text);
      DateTime asrJammahTime = parseAndCopyDate(prayersController.asrjammahTimecontroller.text);
      DateTime asrPrayerEndTime = parseAndCopyDate(prayersController.asrprayerendTimecontroller.text);

      DateTime maghribPrayerTime = parseAndCopyDate(prayersController.maghribprayerTimecontroller.text);
      DateTime maghribJammahTime = parseAndCopyDate(prayersController.maghribjammahTimecontroller.text);
      DateTime maghribPrayerEndTime = parseAndCopyDate(prayersController.maghribprayerendTimecontroller.text);

      DateTime ishaPrayerTime = parseAndCopyDate(prayersController.ishaprayerTimecontroller.text);
      DateTime ishaJammahTime = parseAndCopyDate(prayersController.ishajammahTimecontroller.text);
      DateTime ishaPrayerEndTime = parseAndCopyDate(prayersController.ishaprayerendTimecontroller.text);



      setState(() {

        prayersController.fajrprayerTimecontroller.text = DateFormat('dd MMMM yyyy hh:mm a').format(fajrPrayerTime);
        print(   prayersController.fajrprayerTimecontroller.text);
        prayersController.fajrjammahTimecontroller.text = DateFormat('dd MMMM yyyy hh:mm a').format(fajrJammahTime);
        prayersController.fajrprayerendTimecontroller.text = DateFormat('dd MMMM yyyy hh:mm a').format(fajrPrayerEndTime);

        prayersController.sunriseprayerTimecontroller.text = DateFormat('dd MMMM yyyy hh:mm a').format(sunrisePrayerTime);
        prayersController.sunrisejammahTimecontroller.text = DateFormat('dd MMMM yyyy hh:mm a').format(sunriseJammahTime);
        prayersController.sunriseprayerendTimecontroller.text = DateFormat('dd MMMM yyyy hh:mm a').format(sunrisePrayerEndTime);

        prayersController.duhrprayerTimecontroller.text = DateFormat('dd MMMM yyyy hh:mm a').format(duhrPrayerTime);
        prayersController.duhrjammahTimecontroller.text = DateFormat('dd MMMM yyyy hh:mm a').format(duhrJammahTime);
        prayersController.duhrprayerendTimecontroller.text = DateFormat('dd MMMM yyyy hh:mm a').format(duhrPrayerEndTime);

        prayersController.asrprayerTimecontroller.text = DateFormat('dd MMMM yyyy hh:mm a').format(asrPrayerTime);
        prayersController.asrjammahTimecontroller.text = DateFormat('dd MMMM yyyy hh:mm a').format(asrJammahTime);
        prayersController.asrprayerendTimecontroller.text = DateFormat('dd MMMM yyyy hh:mm a').format(asrPrayerEndTime);

        prayersController.maghribprayerTimecontroller.text = DateFormat('dd MMMM yyyy hh:mm a').format(maghribPrayerTime);
        prayersController.maghribjammahTimecontroller.text = DateFormat('dd MMMM yyyy hh:mm a').format(maghribJammahTime);
        prayersController.maghribprayerendTimecontroller.text = DateFormat('dd MMMM yyyy hh:mm a').format(maghribPrayerEndTime);

        prayersController.ishaprayerTimecontroller.text = DateFormat('dd MMMM yyyy hh:mm a').format(ishaPrayerTime);
        prayersController.ishajammahTimecontroller.text = DateFormat('dd MMMM yyyy hh:mm a').format(ishaJammahTime);
        prayersController.ishaprayerendTimecontroller.text = DateFormat('dd MMMM yyyy hh:mm a').format(ishaPrayerEndTime);
      });
    }
  }

  DateTime parseAndCopyDate(String timeText) {
    DateTime parsedTime = parseDateString(timeText);
    return parsedTime.copyWith(
      year: selectedDateTime.year,
      month: selectedDateTime.month,
      day: selectedDateTime.day,
    );
  }

  Future<void> _selectDateTime(BuildContext context, TextEditingController controller) async {
    // Use the current selectedDateTime as the initial date and time
    TimeOfDay timeOfDay = TimeOfDay.now();
    try{
      timeOfDay = TimeOfDay.fromDateTime(parseDateString(controller.text));
    }catch(e){
      timeOfDay = TimeOfDay.now();
    }

    TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: timeOfDay,
    );
    print(pickedTime);
    if (pickedTime != null) {
      // Update only the time part of the selectedDateTime
      selectedDateTime = DateTime(
        selectedDateTime.year,
        selectedDateTime.month,
        selectedDateTime.day,
        pickedTime.hour,
        pickedTime.minute,
      );


      // Update the text field with the formatted date and time
      String formattedDateTime = DateFormat('MMM dd, yyyy HH:mm').format(selectedDateTime);
      print(formattedDateTime);
      setState(() {
        controller.text = formattedDateTime;
      });
    }
  }

  Future<void> _fetchLastEnteredData() async {
    try {
      // Replace 'yourFirestoreCollection' with the actual collection name in your Firestore
      DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
          .collection('prayerTimes')
          .doc(widget.docId)
          .get();

      if (documentSnapshot.exists) {
        List<dynamic> prayersData = documentSnapshot['prayers'];
        if (prayersData.isNotEmpty) {
          // Fetch the last entry in the prayers list
          Map<String, dynamic> lastPrayerEntry =
              prayersData.last as Map<String, dynamic>;

          // Assuming you have a 'prayers' field in your Firestore document
          List<dynamic> prayers = lastPrayerEntry['prayers'];
          if (prayers.isNotEmpty) {

            String date = lastPrayerEntry['date'] ?? '';
             selectedDateTime = DateFormat('MMMM d, y').parse(date);
             print(selectedDateTime);

            // Populate text fields with the last entered data
            prayersController.datetextController.text = lastPrayerEntry['date'] ?? '';
            prayersController.islamicdatecontroller.text = lastPrayerEntry['islamic_date'] ?? '';

            // Update the text field with the formatted date and time
            prayersController.fajrprayerTimecontroller.text =
                DateFormat('dd MMMM yyyy hh:mm a').format(
                    DateTime.fromMillisecondsSinceEpoch(
                        lastPrayerEntry['prayers'][0]["prayerTime"].seconds *
                            1000));
            prayersController.fajrjammahTimecontroller.text =
                DateFormat('dd MMMM yyyy hh:mm a').format(
                    DateTime.fromMillisecondsSinceEpoch(
                        lastPrayerEntry['prayers'][0]["jammahTime"].seconds *
                            1000));
            prayersController.fajrprayerendTimecontroller.text =
                DateFormat('dd MMMM yyyy hh:mm a').format(
                    DateTime.fromMillisecondsSinceEpoch(
                        lastPrayerEntry['prayers'][0]["prayerendTime"].seconds *
                            1000));

            prayersController.sunriseprayerTimecontroller.text =
                DateFormat('dd MMMM yyyy hh:mm a').format(
                    DateTime.fromMillisecondsSinceEpoch(
                        lastPrayerEntry['prayers'][1]["prayerTime"].seconds *
                            1000));
            prayersController.sunrisejammahTimecontroller.text =
                DateFormat('dd MMMM yyyy hh:mm a').format(
                    DateTime.fromMillisecondsSinceEpoch(
                        lastPrayerEntry['prayers'][1]["jammahTime"].seconds *
                            1000));
            prayersController.sunriseprayerendTimecontroller.text =
                DateFormat('dd MMMM yyyy hh:mm a').format(
                    DateTime.fromMillisecondsSinceEpoch(
                        lastPrayerEntry['prayers'][1]["prayerendTime"].seconds *
                            1000));

            prayersController.duhrprayerTimecontroller.text =
                DateFormat('dd MMMM yyyy hh:mm a').format(
                    DateTime.fromMillisecondsSinceEpoch(
                        lastPrayerEntry['prayers'][2]["prayerTime"].seconds *
                            1000));
            prayersController.duhrjammahTimecontroller.text =
                DateFormat('dd MMMM yyyy hh:mm a').format(
                    DateTime.fromMillisecondsSinceEpoch(
                        lastPrayerEntry['prayers'][2]["jammahTime"].seconds *
                            1000));
            prayersController.duhrprayerendTimecontroller.text =
                DateFormat('dd MMMM yyyy hh:mm a').format(
                    DateTime.fromMillisecondsSinceEpoch(
                        lastPrayerEntry['prayers'][2]["prayerendTime"].seconds *
                            1000));

            prayersController.asrprayerTimecontroller.text =
                DateFormat('dd MMMM yyyy hh:mm a').format(
                    DateTime.fromMillisecondsSinceEpoch(
                        lastPrayerEntry['prayers'][3]["prayerTime"].seconds *
                            1000));
            prayersController.asrjammahTimecontroller.text =
                DateFormat('dd MMMM yyyy hh:mm a').format(
                    DateTime.fromMillisecondsSinceEpoch(
                        lastPrayerEntry['prayers'][3]["jammahTime"].seconds *
                            1000));
            prayersController.asrprayerendTimecontroller.text =
                DateFormat('dd MMMM yyyy hh:mm a').format(
                    DateTime.fromMillisecondsSinceEpoch(
                        lastPrayerEntry['prayers'][3]["prayerendTime"].seconds *
                            1000));

            prayersController.maghribprayerTimecontroller.text =
                DateFormat('dd MMMM yyyy hh:mm a').format(
                    DateTime.fromMillisecondsSinceEpoch(
                        lastPrayerEntry['prayers'][4]["prayerTime"].seconds *
                            1000));
            prayersController.maghribjammahTimecontroller.text =
                DateFormat('dd MMMM yyyy hh:mm a').format(
                    DateTime.fromMillisecondsSinceEpoch(
                        lastPrayerEntry['prayers'][4]["jammahTime"].seconds *
                            1000));
            prayersController.maghribprayerendTimecontroller.text =
                DateFormat('dd MMMM yyyy hh:mm a').format(
                    DateTime.fromMillisecondsSinceEpoch(
                        lastPrayerEntry['prayers'][4]["prayerendTime"].seconds *
                            1000));

            prayersController.ishaprayerTimecontroller.text =
                DateFormat('dd MMMM yyyy hh:mm a').format(
                    DateTime.fromMillisecondsSinceEpoch(
                        lastPrayerEntry['prayers'][5]["prayerTime"].seconds *
                            1000));
            prayersController.ishajammahTimecontroller.text =
                DateFormat('dd MMMM yyyy hh:mm a').format(
                    DateTime.fromMillisecondsSinceEpoch(
                        lastPrayerEntry['prayers'][5]["jammahTime"].seconds *
                            1000));
            prayersController.ishaprayerendTimecontroller.text =
                DateFormat('dd MMMM yyyy hh:mm a').format(
                    DateTime.fromMillisecondsSinceEpoch(
                        lastPrayerEntry['prayers'][5]["prayerendTime"].seconds *
                            1000));

            setState(() {
              // Update the state to reflect the changes
            });
          }
        }
      }
    } catch (error) {
      print('Error fetching last entered data: $error');
      // Handle error
    }
  }

  @override
  void initState() {
    super.initState();
    // TODO: implement initState
    _fetchLastEnteredData();
  }

  final TextEditingController fajrnamecontroller = TextEditingController();
  final TextEditingController sunrisenamecontroller = TextEditingController();
  final TextEditingController duhrnamecontroller = TextEditingController();
  final TextEditingController asrnamecontroller = TextEditingController();
  final TextEditingController maghribnamecontroller = TextEditingController();
  final TextEditingController ishanamecontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    fajrnamecontroller.text = 'Fajr';
    sunrisenamecontroller.text = 'Sunrise';
    duhrnamecontroller.text = 'Duhr';
    asrnamecontroller.text = 'Asr';
    maghribnamecontroller.text = 'Maghrib';
    ishanamecontroller.text = 'Isha';

    return Scaffold(
      appBar: AppBar(
        title: Text("Add Prayers in ${widget.mosqueName}"),
        centerTitle: true,
        flexibleSpace: Container(
          height: Get.height,
          width: Get.width,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xffC5DFF1),
                Colors.white
              ], // You can customize the colors
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: Container(
        height: Get.height,
        width: Get.width,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xffC5DFF1),
              Colors.white
            ], // You can customize the colors
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              ReuseTextFields(
                text: 'Enter Date',
                hintText: "February 1, 2024",
                prefixicon: Icons.mosque,
                controller: prayersController.datetextController,
                onTap: () {
                  _selectDate(context);
                },
              ),
              ReuseTextFields(
                text: 'Enter Islamic Date',
                hintText: "Rajab 20, 1445 AH",
                prefixicon: Icons.location_city,
                controller: prayersController.islamicdatecontroller,
              ),
              SizedBox(
                height: 20.h,
              ),
              Divider(
                color: Colors.teal,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 18.0.w),
                child: Column(
                  children: [
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          PrayersField(
                            text: "Prayer Name",
                            enabled: false,
                            hintText: "Fajr",
                            prefixicon: Icons.nights_stay_outlined,
                            controller: fajrnamecontroller,
                          ),
                          SizedBox(
                            width: 20.w,
                          ),
                          PrayersField(
                            text: "Prayer Time",
                            hintText: "04:44",
                            prefixicon: Icons.web,
                            controller:
                                prayersController.fajrprayerTimecontroller,
                            onTap: () {
                              _selectDateTime(context,
                                  prayersController.fajrprayerTimecontroller);
                            },
                          ),
                          SizedBox(
                            width: 20.w,
                          ),
                          PrayersField(
                            text: "Prayer Jammah Time",
                            hintText: "05:00",
                            prefixicon: Icons.web,
                            controller:
                                prayersController.fajrjammahTimecontroller,
                            onTap: () {
                              _selectDateTime(context,
                                  prayersController.fajrjammahTimecontroller);
                            },
                          ),
                          SizedBox(width: 20.w),
                          PrayersField(
                            text: "Prayer End Time",
                            hintText: "06:50",
                            prefixicon: Icons.web,
                            controller:
                                prayersController.fajrprayerendTimecontroller,
                            onTap: () {
                              _selectDateTime(
                                  context,
                                  prayersController
                                      .fajrprayerendTimecontroller);
                            },
                          ),
                        ],
                      ),
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          PrayersField(
                            enabled: false,
                            hintText: "Sunrise",
                            prefixicon: Icons.sunny,
                            controller: sunrisenamecontroller,
                          ),
                          SizedBox(
                            width: 20.w,
                          ),
                          PrayersField(
                            hintText: "06:51",
                            prefixicon: Icons.date_range,
                            controller:
                                prayersController.sunriseprayerTimecontroller,
                            onTap: () {
                              _selectDateTime(
                                  context,
                                  prayersController
                                      .sunriseprayerTimecontroller);
                            },
                          ),
                          SizedBox(
                            width: 20.w,
                          ),
                          PrayersField(
                            hintText: "06:51",
                            prefixicon: Icons.date_range_outlined,
                            controller:
                                prayersController.sunriseprayerTimecontroller,
                            onTap: () {
                              _selectDateTime(
                                  context,
                                  prayersController
                                      .sunriseprayerTimecontroller);
                            },
                          ),
                          SizedBox(
                            width: 20.w,
                          ),
                          PrayersField(
                            hintText: "12:44",
                            prefixicon: Icons.date_range_rounded,
                            controller: prayersController
                                .sunriseprayerendTimecontroller,
                            onTap: () {
                              _selectDateTime(
                                  context,
                                  prayersController
                                      .sunriseprayerendTimecontroller);
                            },
                          ),
                        ],
                      ),
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          PrayersField(
                            enabled: false,
                            hintText: "Duhr",
                            prefixicon: Icons.wb_sunny_sharp,
                            controller: duhrnamecontroller,
                          ),
                          SizedBox(
                            width: 20.w,
                          ),
                          PrayersField(
                            hintText: "12:45",
                            prefixicon: Icons.date_range,
                            controller:
                                prayersController.duhrprayerTimecontroller,
                            onTap: () {
                              _selectDateTime(context,
                                  prayersController.duhrprayerTimecontroller);
                            },
                          ),
                          SizedBox(
                            width: 20.w,
                          ),
                          PrayersField(
                            hintText: "13:00",
                            prefixicon: Icons.date_range_outlined,
                            controller:
                                prayersController.duhrjammahTimecontroller,
                            onTap: () {
                              _selectDateTime(context,
                                  prayersController.duhrjammahTimecontroller);
                            },
                          ),
                          SizedBox(
                            width: 20.w,
                          ),
                          PrayersField(
                            hintText: "15:44",
                            prefixicon: Icons.date_range_rounded,
                            controller:
                                prayersController.duhrprayerendTimecontroller,
                            onTap: () {
                              _selectDateTime(
                                  context,
                                  prayersController
                                      .duhrprayerendTimecontroller);
                            },
                          ),
                        ],
                      ),
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          PrayersField(
                            enabled: false,
                            hintText: "Asr",
                            prefixicon: Icons.wb_sunny_sharp,
                            controller: asrnamecontroller,
                          ),
                          SizedBox(
                            width: 20.w,
                          ),
                          PrayersField(
                            hintText: "15:45",
                            prefixicon: Icons.date_range,
                            controller:
                                prayersController.asrprayerTimecontroller,
                            onTap: () {
                              _selectDateTime(context,
                                  prayersController.asrprayerTimecontroller);
                            },
                          ),
                          SizedBox(
                            width: 20.w,
                          ),
                          PrayersField(
                            hintText: "16:01",
                            prefixicon: Icons.date_range_outlined,
                            controller:
                                prayersController.asrjammahTimecontroller,
                            onTap: () {
                              _selectDateTime(context,
                                  prayersController.asrjammahTimecontroller);
                            },
                          ),
                          SizedBox(
                            width: 20.w,
                          ),
                          PrayersField(
                            hintText: "18:10",
                            prefixicon: Icons.date_range_rounded,
                            controller:
                                prayersController.asrprayerendTimecontroller,
                            onTap: () {
                              _selectDateTime(context,
                                  prayersController.asrprayerendTimecontroller);
                            },
                          ),
                        ],
                      ),
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          PrayersField(
                            enabled: false,
                            hintText: "Maghrib",
                            prefixicon: Icons.dark_mode_outlined,
                            controller: maghribnamecontroller,
                          ),
                          SizedBox(
                            width: 20.w,
                          ),
                          PrayersField(
                            hintText: "18:11",
                            prefixicon: Icons.date_range,
                            controller:
                                prayersController.maghribprayerTimecontroller,
                            onTap: () {
                              _selectDateTime(
                                  context,
                                  prayersController
                                      .maghribprayerTimecontroller);
                            },
                          ),
                          SizedBox(
                            width: 20.w,
                          ),
                          PrayersField(
                            hintText: "18:30",
                            prefixicon: Icons.date_range_outlined,
                            controller:
                                prayersController.maghribjammahTimecontroller,
                            onTap: () {
                              _selectDateTime(
                                  context,
                                  prayersController
                                      .maghribjammahTimecontroller);
                            },
                          ),
                          SizedBox(
                            width: 20.w,
                          ),
                          PrayersField(
                            hintText: "20:30",
                            prefixicon: Icons.date_range_rounded,
                            controller: prayersController
                                .maghribprayerendTimecontroller,
                            onTap: () {
                              _selectDateTime(
                                  context,
                                  prayersController
                                      .maghribprayerendTimecontroller);
                            },
                          ),
                        ],
                      ),
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          PrayersField(
                            enabled: false,
                            hintText: "Isha",
                            prefixicon: Icons.nights_stay,
                            controller: ishanamecontroller,
                          ),
                          SizedBox(
                            width: 20.w,
                          ),
                          PrayersField(
                            hintText: "20:31",
                            prefixicon: Icons.date_range,
                            controller:
                                prayersController.ishaprayerTimecontroller,
                            onTap: () {
                              _selectDateTime(context,
                                  prayersController.ishaprayerTimecontroller);
                            },
                          ),
                          SizedBox(
                            width: 20.w,
                          ),
                          PrayersField(
                            hintText: "20:50",
                            prefixicon: Icons.date_range_outlined,
                            controller:
                                prayersController.ishajammahTimecontroller,
                            onTap: () {
                              _selectDateTime(context,
                                  prayersController.ishajammahTimecontroller);
                            },
                          ),
                          SizedBox(
                            width: 20.w,
                          ),
                          PrayersField(
                            hintText: "23:59",
                            prefixicon: Icons.date_range_rounded,
                            controller:
                                prayersController.ishaprayerendTimecontroller,
                            onTap: () {
                              _selectDateTime(
                                  context,
                                  prayersController
                                      .ishaprayerendTimecontroller);
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    fixedSize: Size(100.w, 50.h),
                    backgroundColor: Colors.black54),
                onPressed: () {
                  prayersController.addprayers(
                    widget.docId,
                  );
                },
                child: FittedBox(
                  child: Text(
                    "Add Data",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
