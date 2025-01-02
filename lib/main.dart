import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

void main() {
  runApp(const MyApp());
}

/// The application that contains datagrid on it.
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Syncfusion DataGrid Demo',
      theme: ThemeData(useMaterial3: false),
      home: const MyHomePage(),
    );
  }
}

/// The home page of the application which hosts the datagrid.
class MyHomePage extends StatefulWidget {
  /// Creates the home page.
  const MyHomePage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Employee> employees = <Employee>[];
  late EmployeeDataSource employeeDataSource;
  bool isFooterEnabled = false;

  @override
  void initState() {
    super.initState();
    employees = getEmployeeData();
    employeeDataSource = EmployeeDataSource(
      employeeData: employees,
    );
    WidgetsBinding.instance
        .addPostFrameCallback((_) => _updateFooterVisibility());
  }

  void _updateFooterVisibility() {
    // Default row height in SfDataGrid.
    double rowHeight = 49;
    // Need to remove the header and the extra row height created during the initial loading.
    double availableHeight = MediaQuery.of(context).size.height - 200;
    double totalRowsHeight =
        (employeeDataSource.effectiveRows.length) * rowHeight;

    setState(() {
      isFooterEnabled = totalRowsHeight > availableHeight;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Syncfusion Flutter DataGrid'),
      ),
      body: Column(
        children: [
          Expanded(
            child: SfDataGrid(
              source: employeeDataSource,
              columnWidthMode: ColumnWidthMode.fill,
              footer: isFooterEnabled
                  ? Container(
                      color: Colors.grey[400],
                      child: const Center(
                        child: Text(
                          'FOOTER VIEW',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    )
                  : null,
              columns: <GridColumn>[
                GridColumn(
                    columnName: 'id',
                    label: Container(
                        padding: const EdgeInsets.all(16.0),
                        alignment: Alignment.center,
                        child: const Text(
                          'ID',
                        ))),
                GridColumn(
                    columnName: 'name',
                    label: Container(
                        padding: const EdgeInsets.all(8.0),
                        alignment: Alignment.center,
                        child: const Text('Name'))),
                GridColumn(
                    columnName: 'designation',
                    label: Container(
                        padding: const EdgeInsets.all(8.0),
                        alignment: Alignment.center,
                        child: const Text(
                          'Designation',
                          overflow: TextOverflow.ellipsis,
                        ))),
                GridColumn(
                    columnName: 'salary',
                    label: Container(
                        padding: const EdgeInsets.all(8.0),
                        alignment: Alignment.center,
                        child: const Text('Salary'))),
              ],
            ),
          ),
          if (!isFooterEnabled)
            Container(
              height: 50,
              color: Colors.grey[400],
              child: const Center(
                child: Text(
                  'FOOTER VIEW',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
        ],
      ),
    );
  }

  List<Employee> getEmployeeData() {
    return [
      Employee(10001, 'James', 'Project Lead', 20000),
      Employee(10002, 'Kathryn', 'Manager', 30000),
      Employee(10003, 'Lara', 'Developer', 15000),
      Employee(10004, 'Michael', 'Designer', 15000),
      Employee(10005, 'Martin', 'Developer', 15000),
      Employee(10006, 'Newberry', 'Tester', 14000),
      // Employee(10007, 'Blanc', 'Developer', 16000),
      // Employee(10008, 'Perry', 'Tester', 14000),
      // Employee(10009, 'Gable', 'Developer', 15500),
      // Employee(10010, 'Grimes', 'Tester', 14500),
      // Employee(10011, 'Anderson', 'HR', 18000),
      // Employee(10012, 'Smith', 'Project Manager', 35000),
      // Employee(10013, 'Taylor', 'QA Engineer', 14000),
      // Employee(10014, 'Johnson', 'System Analyst', 17000),
      // Employee(10015, 'Williams', 'Support Engineer', 13000),
      // Employee(10016, 'Brown', 'Data Scientist', 25000),
      // Employee(10017, 'Davis', 'Backend Developer', 16000),
      // Employee(10018, 'Miller', 'Frontend Developer', 16000),
      // Employee(10019, 'Wilson', 'UI/UX Designer', 15000),
      // Employee(10020, 'Moore', 'DevOps Engineer', 20000),
    ];
  }
}

/// Custom business object class which contains properties to hold the detailed
/// information about the employee which will be rendered in datagrid.
class Employee {
  /// Creates the employee class with required details.
  Employee(this.id, this.name, this.designation, this.salary);

  /// Id of an employee.
  final int id;

  /// Name of an employee.
  final String name;

  /// Designation of an employee.
  final String designation;

  /// Salary of an employee.
  final int salary;
}

/// An object to set the employee collection data source to the datagrid. This
/// is used to map the employee data to the datagrid widget.
class EmployeeDataSource extends DataGridSource {
  EmployeeDataSource({required this.employeeData}) {
    buildDataGridRows();
  }

  void buildDataGridRows() {
    _employeeData = employeeData
        .map<DataGridRow>((e) => DataGridRow(cells: [
              DataGridCell<int>(columnName: 'id', value: e.id),
              DataGridCell<String>(columnName: 'name', value: e.name),
              DataGridCell<String>(
                  columnName: 'designation', value: e.designation),
              DataGridCell<int>(columnName: 'salary', value: e.salary),
            ]))
        .toList();
  }

  List<Employee> employeeData;

  List<DataGridRow> _employeeData = [];

  @override
  List<DataGridRow> get rows => _employeeData;

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    return DataGridRowAdapter(
      cells: row.getCells().map<Widget>((e) {
        return Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(8.0),
          child: Text(e.value.toString()),
        );
      }).toList(),
    );
  }
}
