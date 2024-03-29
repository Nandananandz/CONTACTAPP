// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'TagModel.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TagModelAdapter extends TypeAdapter<TagModel> {
  @override
  final int typeId = 2;

  @override
  TagModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TagModel()
      ..tagName = fields[0] as String?
      ..id = fields[1] as String?;
  }

  @override
  void write(BinaryWriter writer, TagModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.tagName)
      ..writeByte(1)
      ..write(obj.id);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TagModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
