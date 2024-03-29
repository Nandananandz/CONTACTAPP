import 'dart:io';

import 'package:contactapp/Model/ProfileModel.dart';
import 'package:contactapp/Screen/AddContact/components/ContactData.dart';
import 'package:contactapp/Screen/Categories/category.dart';
import 'package:contactapp/Screen/Contacts/View/NameCard.dart';
import 'package:contactapp/Screen/Contacts/View/ShareBottomSheet.dart';
import 'package:contactapp/Screen/Contacts/View/menuItem.dart';
import 'package:contactapp/Screen/EventListScreen/View/AddEvent.dart';
import 'package:contactapp/Screen/MembersScreen/MembersScreen.dart';
import 'package:contactapp/Screen/Tags/tags.dart';
import 'package:contactapp/Service/MainController.dart';

import 'package:contactapp/utils/appBar.dart';
import 'package:excel/excel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:sizer/sizer.dart';

class ContactScreen extends StatefulWidget {
  ContactScreen({super.key});

  @override
  State<ContactScreen> createState() => _ContactScreenState();
}

bool isMenu = false;

class _ContactScreenState extends State<ContactScreen> {
  MainController ctrl = Get.put(MainController());
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (isMenu) {
          isMenu = false;
          setState(() {});
        } else {
          Get.back();
        }
        return false;
      },
      child: Scaffold(
        appBar: CAappBar(
            context: context,
            title: "Contacts",
            isAdd: true,
            isBack: true,
            actionIcon: Icons.settings,
            fn: () {
              // Get.to(() => AddEventScreen(), transition: Transition.rightToLeft);
              setState(() {
                isMenu = !isMenu;
              });
            }),
        body: GetBuilder<MainController>(builder: (_ContactScreenState) {
          return Stack(
            children: [
              Positioned(
                top: 0,
                bottom: 0,
                left: 0,
                right: 0,
                child: Column(
                  children: [
                    SizedBox(
                      height: 3.1.h,
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        "Your Adding to the Event :",
                        style: GoogleFonts.karma(
                            fontSize: 13.sp,
                            color: Color(0xffA56219),
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    SizedBox(
                      height: .8.h,
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        "${ctrl.selectedEvent!.Name}",
                        style: GoogleFonts.karma(
                            fontSize: 16.sp,
                            color: Color(0xffA56219),
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        "Year  : ${ctrl.selectedEvent!.StartDate!.year}",
                        style: GoogleFonts.karma(
                            fontSize: 12.sp,
                            color: Color(0xffA56219),
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 5.w, right: 2.w),
                      child: Row(
                        children: [
                          Container(
                            width: 10.w,
                            height: 5.0.h,
                            alignment: Alignment.center,
                            child: Text(
                              "All",
                              style: GoogleFonts.karma(
                                  fontSize: 11.sp,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600),
                            ),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: Color(0xffA56219)),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Container(
                            width: 75.w,
                            height: 5.1.h,
                            alignment: Alignment.centerLeft,
                            padding: EdgeInsets.symmetric(
                              horizontal: 1.8.w,
                            ),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: Color(0xffFFDF4EB)),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.search,
                                  color: Color(0xffA56219).withOpacity(.8),
                                  size: 5.w,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: TextField(
                                    controller: searchController,
                                    textAlign: TextAlign.start,
                                    style: GoogleFonts.karma(
                                      color: Color(0xffA56219),
                                      fontWeight: FontWeight.w600,
                                      fontSize: 12.sp,
                                    ),
                                    onChanged: (value) {
                                      setState(() {});
                                    },
                                    decoration: InputDecoration(
                                      hintText: "Search",
                                      isDense: true,
                                      isCollapsed: true,
                                      hintStyle: GoogleFonts.karma(
                                        color:
                                            Color(0xffA56219).withOpacity(.8),
                                        fontWeight: FontWeight.w500,
                                        fontSize: 12.2.sp,
                                      ),
                                      border: InputBorder.none,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    for (var data in ctrl.profileList)
                      if (data.eventId == ctrl.selectedEvent!.id)
                        if (searchController == "" ||
                            data.name!
                                .toUpperCase()
                                .toString()
                                .contains(searchController.text.toUpperCase()))
                          NameCard(
                            pmodel: data,
                          ),
                  ],
                ),
              ),
              Positioned(
                  left: 0,
                  right: 0,
                  top: 0,
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 300),
                    height: (!isMenu) ? 0 : 22.5.h,
                    width: 100.w,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                            offset: Offset(1, 1),
                            color: Colors.grey.withOpacity(.2),
                            spreadRadius: .5,
                            blurRadius: 1)
                      ],
                      color: Color(0xffFFDF4EB).withOpacity(.8),
                    ),
                    padding: EdgeInsets.only(top: 2.h),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          InkWell(
                              onTap: () {
                                setState(() {
                                  isMenu = false;
                                });
                                Get.to(() => categoryScreen(),
                                    transition: Transition.rightToLeft);
                              },
                              child: menuItem("Category", Icons.menu_outlined)),
                          InkWell(
                              onTap: () {
                                setState(() {
                                  isMenu = false;
                                });
                                Get.to(() => TagScreen(),
                                    transition: Transition.rightToLeft);
                              },
                              child: menuItem("Tags", Icons.tag)),
                          InkWell(
                              onTap: () {
                                setState(() {
                                  isMenu = false;
                                });
                                Get.to(() => MembersScreen(),
                                    transition: Transition.rightToLeft);
                              },
                              child: menuItem("Team", Icons.group)),
                        ],
                      ),
                    ),
                  )),
              Positioned(
                  bottom: 30,
                  right: 20,
                  left: 20,
                  child: Row(
                    children: [
                      InkWell(
                        onTap: () {
                          CreateExcel();
                          // showModalBottomSheet(
                          //     context: context,
                          //     isScrollControlled: true,
                          //     backgroundColor: Colors.transparent,
                          //     builder: (ctx) => ShareBottomSheet());
                        },
                        child: Container(
                          width: 28.66.w,
                          height: 4.h,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Color(0xffBF782B)),
                          child: Text(
                            "Export Contacts",
                            style: GoogleFonts.karma(
                                fontSize: 10.sp,
                                color: Colors.white,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Container(
                        width: 22.66.w,
                        height: 4.h,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Color(0xffBF782B)),
                        child: Text(
                          "Send Email",
                          style: GoogleFonts.karma(
                              fontSize: 10.sp,
                              color: Colors.white,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                      Expanded(child: Container()),
                      InkWell(
                        onTap: () {
                          print("click");
                          Get.to(() => ContactDataScreen(),
                              transition: Transition.rightToLeft);
                        },
                        child: Container(
                          width: 10.31.w,
                          height: 10.31.w,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              color: Color(0xffBF782B)),
                          child: Icon(
                            Icons.add,
                            color: Colors.white,
                          ),
                        ),
                      )
                    ],
                  ))
            ],
          );
        }),
      ),
    );
  }
}

CreateExcel() async {
  // automatically creates 1 empty sheet: Sheet1
  var excel = Excel.createExcel();
  Sheet sheetObject = excel['contactDetails'];
  Data cell = sheetObject.cell(CellIndex.indexByString('A1'));
  sheetObject.cell(CellIndex.indexByString('A1')).value =
      TextCellValue("Profile ID");
  sheetObject.cell(CellIndex.indexByString('B1')).value = TextCellValue("Name");
  sheetObject.cell(CellIndex.indexByString('D1')).value =
      TextCellValue("Company");
  sheetObject.cell(CellIndex.indexByString('E1')).value =
      TextCellValue("Mobile");
  sheetObject.cell(CellIndex.indexByString('F1')).value =
      TextCellValue("Email");
  sheetObject.cell(CellIndex.indexByString('G1')).value =
      TextCellValue("Website");
  sheetObject.cell(CellIndex.indexByString('H1')).value =
      TextCellValue("Category");
  sheetObject.cell(CellIndex.indexByString('I1')).value = TextCellValue("Team");
  sheetObject.cell(CellIndex.indexByString('J1')).value = TextCellValue("Tag");
  sheetObject.cell(CellIndex.indexByString('K1')).value = TextCellValue("Note");
  sheetObject.cell(CellIndex.indexByString('L1')).value =
      TextCellValue("Designation");

  MainController ctrl = Get.put(MainController());
  int i = 1;
  for (ProfileModel dt in ctrl.profileList) {
    i = i + 1;

    sheetObject.cell(CellIndex.indexByString('A$i')).value =
        TextCellValue(dt.profileID! ?? "");
    sheetObject.cell(CellIndex.indexByString('B$i')).value =
        TextCellValue(dt.name! ?? "");
    sheetObject.cell(CellIndex.indexByString('D$i')).value =
        TextCellValue(dt.company! ?? "");
    sheetObject.cell(CellIndex.indexByString('E$i')).value =
        TextCellValue(dt.mobile! ?? "");
    sheetObject.cell(CellIndex.indexByString('F$i')).value =
        TextCellValue(dt.email! ?? "");
    sheetObject.cell(CellIndex.indexByString('G$i')).value =
        TextCellValue(dt.website! ?? "");
    sheetObject.cell(CellIndex.indexByString('H$i')).value =
        TextCellValue(dt.category! ?? "");
    sheetObject.cell(CellIndex.indexByString('I$i')).value =
        TextCellValue(dt.meeting ?? "");
    sheetObject.cell(CellIndex.indexByString('J$i')).value =
        TextCellValue(dt.tag ?? "");
    sheetObject.cell(CellIndex.indexByString('K$i')).value =
        TextCellValue(dt.notes ?? "");
    sheetObject.cell(CellIndex.indexByString('L$i')).value =
        TextCellValue(dt.designation ?? "");
  }

  print(excel.sheets["contactDetails"]!.cell(CellIndex.indexByString("A1")));
  List<int>? fileBytes = excel.save();
  var directory = await getApplicationDocumentsDirectory();

  File file = File('${directory.path}/Contact_list.xlsx')
    ..createSync(recursive: true)
    ..writeAsBytesSync(fileBytes!);

  final result = await Share.shareXFiles(
    [XFile(file!.path)],
  );
}
