import 'package:flutter/material.dart';
import 'package:plaso_connect/constants/colors.dart';
import 'package:plaso_connect/models/donormodel.dart';
import 'package:plaso_connect/services/database.dart';
import 'package:plaso_connect/widgets/formbanner.dart';
import 'package:plaso_connect/widgets/inputfield.dart';

class PlasmaDonate extends StatefulWidget {
  @override
  _PlasmaDonateState createState() => _PlasmaDonateState();
}

class _PlasmaDonateState extends State<PlasmaDonate> {
  late TextEditingController namecontroller;
  late TextEditingController phonecontroller;
  late TextEditingController agecontroller;
  late TextEditingController addresscontroller;
  late TextEditingController pincontroller;
  late TextEditingController dateOfRecoverycontroller;

  int isVaccinated = 1;
  String bloodGroup = "A+";
  String covidquestion = "Have you ever tested covid positive ?";
  int covidStatus = 1;

  bool isUploading = false;

  @override
  void initState() {
    super.initState();
    namecontroller = TextEditingController();
    phonecontroller = TextEditingController();
    agecontroller = TextEditingController();
    addresscontroller = TextEditingController();
    pincontroller = TextEditingController();
    dateOfRecoverycontroller = TextEditingController();
  }

  @override
  void dispose() {
    namecontroller.dispose();
    phonecontroller.dispose();
    agecontroller.dispose();
    addresscontroller.dispose();
    pincontroller.dispose();
    dateOfRecoverycontroller.dispose();
    super.dispose();
  }

  void donePressed() async {
    setState(() {
      isUploading = true;
    });
    var donorModel = DonorModel(
      name: namecontroller.text,
      phone: phonecontroller.text,
      age: agecontroller.text,
      address: addresscontroller.text,
      pin: pincontroller.text,
      bloodGroup: bloodGroup,
      covidStatus: covidStatus.toString(),
      dateOfRecovery: dateOfRecoverycontroller.text,
      vaccinationStatus: isVaccinated.toString(),
    );
    await DatabaseMethod().uploadDonor(donorModel);
    clearInput();
    isUploading = false;
    setState(() {});
  }

  void clearInput() {
    namecontroller.clear();
    phonecontroller.clear();
    agecontroller.clear();
    addresscontroller.clear();
    pincontroller.clear();
    dateOfRecoverycontroller.clear();
    isVaccinated = 1;
    bloodGroup = "A+";
    covidStatus = 1;
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            formBanner(
              size: size,
              svgPath: "assets/images/login.svg",
            ),
            SingleChildScrollView(
              child: Container(
                width: double.infinity,
                margin: EdgeInsets.only(
                  top: size.height * 0.35,
                  left: 20,
                  right: 20,
                ),
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: kbackgroundLight,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      blurRadius: 10.0,
                      spreadRadius: 5.0,
                      offset: Offset(0.0, 0.0),
                    )
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Donation Form",
                      style: TextStyle(
                        color: kelectronBlue,
                        fontSize: 25,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 8),
                    inputforPlasma(
                      controller: namecontroller,
                      prefixIcon: Icons.account_circle_rounded,
                      hintText: "Full Name",
                      textInputType: TextInputType.name,
                      maxLines: 1,
                    ),
                    inputforPlasma(
                      controller: phonecontroller,
                      prefixIcon: Icons.phone_rounded,
                      hintText: "Phone Number",
                      textInputType: TextInputType.phone,
                      maxLines: 1,
                    ),
                    inputforPlasma(
                      controller: agecontroller,
                      prefixIcon: Icons.add_rounded,
                      hintText: "Age",
                      textInputType: TextInputType.number,
                      maxLines: 1,
                    ),
                    inputforPlasma(
                      controller: addresscontroller,
                      prefixIcon: Icons.location_on_rounded,
                      hintText: "Full Address",
                      textInputType: TextInputType.name,
                      maxLines: 3,
                    ),
                    inputforPlasma(
                      controller: pincontroller,
                      prefixIcon: Icons.location_on_rounded,
                      hintText: "Address PIN code",
                      textInputType: TextInputType.number,
                      maxLines: 1,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: Row(
                        children: [
                          Text(
                            "Blood Group",
                            style: TextStyle(
                              color: kelectronBlue,
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15),
                              child: DropdownButton<String>(
                                isExpanded: true,
                                focusColor: Colors.white,
                                value: bloodGroup,
                                //elevation: 5,
                                style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 17.0,
                                  fontWeight: FontWeight.w500,
                                ),
                                iconEnabledColor: kelectronBlue,
                                items: <String>[
                                  'A+',
                                  'A-',
                                  'B+',
                                  'B-',
                                  'O+',
                                  'O-',
                                  'AB+',
                                  'AB-',
                                ].map<DropdownMenuItem<String>>((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(
                                      value,
                                      style: TextStyle(
                                        color: Colors.red,
                                        fontSize: 17.0,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  );
                                }).toList(),
                                hint: Text(
                                  "Please choose a langauage",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500),
                                ),
                                onChanged: (value) {
                                  setState(() {
                                    bloodGroup = value!;
                                  });
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 15, bottom: 5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            covidquestion,
                            style: TextStyle(
                              color: kelectronBlue,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Row(
                            children: [
                              Row(
                                children: [
                                  Radio(
                                    activeColor: kelectronBlue,
                                    value: 1,
                                    groupValue: covidStatus,
                                    onChanged: (val) {
                                      setState(() {
                                        covidStatus = int.parse(val.toString());
                                      });
                                    },
                                  ),
                                  Text(
                                    "Yes",
                                    style: TextStyle(
                                      color: (covidStatus == 1)
                                          ? kelectronBlue
                                          : Colors.grey[700],
                                      fontSize: 17.0,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(width: 10),
                              Row(
                                children: [
                                  Radio(
                                    activeColor: kelectronBlue,
                                    value: 0,
                                    groupValue: covidStatus,
                                    onChanged: (val) {
                                      setState(() {
                                        covidStatus = int.parse(val.toString());
                                      });
                                    },
                                  ),
                                  Text(
                                    "No",
                                    style: TextStyle(
                                      color: (covidStatus == 0)
                                          ? kelectronBlue
                                          : Colors.grey[700],
                                      fontSize: 17.0,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    (covidStatus == 1)
                        ? inputforPlasma(
                            controller: dateOfRecoverycontroller,
                            prefixIcon: Icons.date_range_rounded,
                            hintText: "Date of Recovery",
                            textInputType: TextInputType.datetime,
                            maxLines: 1,
                          )
                        : Container(height: 0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Vaccinated",
                          style: TextStyle(
                            color: kelectronBlue,
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Row(
                          children: [
                            Row(
                              children: [
                                Radio(
                                  activeColor: kelectronBlue,
                                  value: 1,
                                  groupValue: isVaccinated,
                                  onChanged: (val) {
                                    setState(() {
                                      isVaccinated = int.parse(val.toString());
                                    });
                                  },
                                ),
                                Text(
                                  "Yes",
                                  style: TextStyle(
                                    color: (isVaccinated == 1)
                                        ? kelectronBlue
                                        : Colors.grey[700],
                                    fontSize: 17.0,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(width: 10),
                            Row(
                              children: [
                                Radio(
                                  activeColor: kelectronBlue,
                                  value: 0,
                                  groupValue: isVaccinated,
                                  onChanged: (val) {
                                    setState(() {
                                      isVaccinated = int.parse(val.toString());
                                    });
                                  },
                                ),
                                Text(
                                  "No",
                                  style: TextStyle(
                                    color: (isVaccinated == 0)
                                        ? kelectronBlue
                                        : Colors.grey[700],
                                    fontSize: 17.0,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(width: 10),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    GestureDetector(
                      onTap: () {
                        donePressed();
                      },
                      child: doneBtn(),
                    ),
                    SizedBox(height: 20),
                  ],
                ),
              ),
            ),
            (isUploading)
                ? Container(
                    height: double.infinity,
                    width: double.infinity,
                    color: Colors.grey.withOpacity(0.5),
                    child: Center(
                      child: SizedBox(
                        height: size.width * 0.2,
                        width: size.width * 0.2,
                        child: CircularProgressIndicator(),
                      ),
                    ),
                  )
                : Container(height: 0, width: 0),
          ],
        ),
      ),
    );
  }

  Widget doneBtn() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 30),
      child: Material(
        elevation: 5,
        borderRadius: BorderRadius.circular(15),
        color: kelectronBlue[700],
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 12),
          child: Center(
            child: Text(
              "Done",
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget inputforPlasma({
    required TextEditingController controller,
    required IconData prefixIcon,
    required String hintText,
    required TextInputType textInputType,
    required int maxLines,
  }) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: inputField(
        controller: controller,
        prefixIcon: prefixIcon,
        hintText: hintText,
        textInputType: textInputType,
        maxLines: maxLines,
      ),
    );
  }
}
