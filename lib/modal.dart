import 'dart:convert';

import 'package:flutter/foundation.dart';

class CountryCodes {
  final String status;
  final List<Data> data;
  final String message;
  final double totalTime;
  CountryCodes({
    this.status,
    this.data,
    this.message,
    this.totalTime,
  });

  CountryCodes copyWith({
    String status,
    List<Data> data,
    String message,
    double totalTime,
  }) {
    return CountryCodes(
      status: status ?? this.status,
      data: data ?? this.data,
      message: message ?? this.message,
      totalTime: totalTime ?? this.totalTime,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'status': status,
      'data': data?.map((x) => x.toMap())?.toList(),
      'message': message,
      'totalTime': totalTime,
    };
  }

  factory CountryCodes.fromMap(Map<String, dynamic> map) {
    return CountryCodes(
      status: map['status'],
      data: List<Data>.from(map['data']?.map((x) => Data.fromMap(x))),
      message: map['message'],
      totalTime: map['totalTime']?.toDouble(),
    );
  }

  String toJson() => json.encode(toMap());

  factory CountryCodes.fromJson(String source) =>
      CountryCodes.fromMap(json.decode(source));

  @override
  String toString() {
    return 'CountryCodes(status: $status, data: $data, message: $message, totalTime: $totalTime)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CountryCodes &&
        other.status == status &&
        listEquals(other.data, data) &&
        other.message == message &&
        other.totalTime == totalTime;
  }

  @override
  int get hashCode {
    return status.hashCode ^
        data.hashCode ^
        message.hashCode ^
        totalTime.hashCode;
  }
}

class Data {
  final String mastLookupKey;
  final String mastLookupValue;
  final String mastLookupType;
  Data({
    this.mastLookupKey,
    this.mastLookupValue,
    this.mastLookupType,
  });

  Data copyWith({
    String mastLookupKey,
    String mastLookupValue,
    String mastLookupType,
  }) {
    return Data(
      mastLookupKey: mastLookupKey ?? this.mastLookupKey,
      mastLookupValue: mastLookupValue ?? this.mastLookupValue,
      mastLookupType: mastLookupType ?? this.mastLookupType,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'mastLookupKey': mastLookupKey,
      'mastLookupValue': mastLookupValue,
      'mastLookupType': mastLookupType,
    };
  }

  factory Data.fromMap(Map<String, dynamic> map) {
    return Data(
      mastLookupKey: map['mastLookupKey'],
      mastLookupValue: map['mastLookupValue'],
      mastLookupType: map['mastLookupType'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Data.fromJson(String source) => Data.fromMap(json.decode(source));

  @override
  String toString() =>
      'Data(mastLookupKey: $mastLookupKey, mastLookupValue: $mastLookupValue, mastLookupType: $mastLookupType)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Data &&
        other.mastLookupKey == mastLookupKey &&
        other.mastLookupValue == mastLookupValue &&
        other.mastLookupType == mastLookupType;
  }

  @override
  int get hashCode =>
      mastLookupKey.hashCode ^
      mastLookupValue.hashCode ^
      mastLookupType.hashCode;
}
