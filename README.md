# How to show the footer at the bottom with insufficient rows in Flutter DataTable (SfDataGrid)?

In this article, we will show you how to show the footer at the bottom with insufficient rows in [Flutter DataTable](https://www.syncfusion.com/flutter-widgets/flutter-datagrid).

Initialize the [SfDataGrid](https://pub.dev/documentation/syncfusion_flutter_datagrid/latest/datagrid/SfDataGrid-class.html) widget with all the required properties. To achieve this, when there is insufficient data, you can add a custom widget, such as a footer, in the build method to display at the bottom of the screen. When the rows are scrollable, you can use the [SfDataGrid.footer](https://pub.dev/documentation/syncfusion_flutter_datagrid/latest/datagrid/SfDataGrid/footer.html) property. Enable the SfDataGrid.footer by checking whether the number of rows exceeds the screen size.

```dart
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
    // Need to remove the header and the extra row height created.
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
```
You can download this example on [GitHub](https://github.com/SyncfusionExamples/How-to-show-the-footer-at-the-bottom-with-insufficient-rows-in-Flutter-DataTable).