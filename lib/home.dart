import "package:flutter/material.dart";
import "package:google_fonts/google_fonts.dart";
import "package:intl/intl.dart";

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DateTime? selectDate;
  TimeOfDay? selectTime;
  final TextEditingController taskController = TextEditingController();

  final List<Map<String, dynamic>> tasks = [];
  void addTask() {
    if (selectDate != null &&
        selectTime != null &&
        taskController.text.isNotEmpty) {
      setState(
        () {
          tasks.add({
            'date': selectDate,
            'time': selectTime,
            'task': taskController.text,
          });
        },
      );
      taskController.clear();
    }
  }

  Future<void> slectedDate(BuildContext conext) async {
    final DateTime? pickedDate = await showDatePicker(
        context: context, firstDate: DateTime.now(), lastDate: DateTime(2101));

    if (pickedDate != null && pickedDate != slectedDate) {
      setState(() {
        selectDate = pickedDate;
      });
    }
  }

  Future<void> selectedTime(BuildContext context) async {
    final TimeOfDay? pickedTime =
        await showTimePicker(context: context, initialTime: TimeOfDay.now());
    setState(() {
      selectTime = pickedTime;
    });
  }

  @override
  Widget build(BuildContext context) {

    final height = MediaQuery.sizeOf(context).height *1;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
        title: Text(
          "Task Schedular",
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontSize: 17,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    selectDate == null
                        ? "Select a Date"
                        : "Date ${DateFormat.yMd().format(selectDate!)}",
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  ElevatedButton(
                    style: const ButtonStyle(
                      backgroundColor:
                          WidgetStatePropertyAll(Colors.deepPurple),
                    ),
                    onPressed: () {
                      slectedDate(context);
                    },
                    child: Text(
                      "Select Date",
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
               SizedBox(
                height : height *.02,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    selectTime == null
                        ? "Select a Time"
                        : "Time ${selectTime!.format(context)}",
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  ElevatedButton(
                    style: const ButtonStyle(
                      backgroundColor:
                          WidgetStatePropertyAll(Colors.deepPurple),
                    ),
                    onPressed: () {
                      selectedTime(context);
                    },
                    child: Text(
                      "Select Time",
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
               SizedBox(
                height: height *.02,
              ),
              TextFormField(
                controller: taskController,
                decoration: const InputDecoration(
                    label: Text("Enter task"), border: OutlineInputBorder()),
              ),
               SizedBox(
                height: height *.02,
              ),
              ElevatedButton(
                  style: const ButtonStyle(
                      backgroundColor:
                          WidgetStatePropertyAll(Colors.deepPurple)),
                  onPressed: () {
                    addTask();
                  },
                  child: Text(
                    "Add Task",
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  )),
               SizedBox(
                height: height *.04,
              ),
              tasks.isEmpty
                  ? Text(
                      "No Task is Added",
                      style: GoogleFonts.poppins(
                          color: const Color.fromARGB(255, 157, 22, 22),
                          fontWeight: FontWeight.w600,
                          fontSize: 20),
                    )
                  : ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: tasks.length,
                      itemBuilder: (context, index) {
                        final task = tasks[index];
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 20),
                          child: Container(
                            decoration: const BoxDecoration(
                              color: Colors.deepPurple,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(20),
                              ),
                            ),
                            
                            child: ListTile(
                              title: Text(
                                task['task'],
                                style: GoogleFonts.sacramento(
                                  color: Colors.white,
                                  fontSize: 22,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              subtitle: Text(
                                  '${DateFormat.yMEd().format(task['date'])} at ${task['time'].format(context)}',style: GoogleFonts.poppins(color: Colors.white),),
                              trailing: Icon(
                                Icons.check_circle,
                                color: Color.fromARGB(255, 251, 251, 251),
                              ),
                            ),
                          ),
                        );
                      }),
            ],
          ),
        ),
      ),
    );
  }
}
