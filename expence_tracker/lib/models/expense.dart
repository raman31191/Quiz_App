import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

final formatter = DateFormat.yMd();
//yMd() creates a formatter object which is use to format dates

const uuid = Uuid();
// Universally Unique Identifier.
//kept above the class widget as it can be used anywhere in the file

enum Category { food, travel, leisure, work }

const categoryIcons = {
  Category.food: Icons.lunch_dining,
  Category.travel: Icons.flight_takeoff,
  Category.leisure: Icons.movie,
  Category.work: Icons.work,
}; //The enum Category { food, travel, leisure, work } defines a custom type
//Category that can take one of the four values: food, travel, leisure, or work. This is useful when you need a
// variable that can only have a specific set of values, making your code more readable and less error-prone.

class Expense {
  Expense(
      {required this.title,
      required this.amount,
      required this.date,
      required this.category})
      : id = uuid.v4();
  //The constructor of the Expense class initializes three required fields (title, amount, date) with values provided when an Expense object is created.
//The id field is automatically initialized with a unique identifier generated by the uuid.v4() function
  //We have to initialize the values for the given properties

  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final Category category;
  //final String category;
  // Wont get any error in the string even if it is a typo as string will valid of any type
  String get formattedDate {
    return formatter.format(date);
    //Getter is used to read or get the data of the class field
  }
}

class ExpenseBucket {
  const ExpenseBucket({
    required this.category,
    required this.expenses,
  });

  ExpenseBucket.forCategory(List<Expense> allExpenses,
      this.category) // crreating an altenave constructor function
      : expenses = allExpenses
            .where((expense) => expense.category == category)
            .toList();

  final Category category;
  final List<Expense> expenses;

  double get totalExpenses {
    double sum = 0;

    for (final expense in expenses) {
      sum += expense.amount;
    }

    return sum;
  }
}
