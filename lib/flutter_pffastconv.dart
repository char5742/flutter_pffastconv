import 'dart:ffi';
import 'dart:io';

import 'package:ffi/ffi.dart';

import 'generated_bindings.dart';

class FlutterPFFASTCONV {
  final _library = PFFASTCONVLibrary(Platform.isAndroid
      ? DynamicLibrary.open('libpffastconv.so')
      : DynamicLibrary.open('libpffastconv.dylib'));

  List<double> fftconvolve(List<double> signal, List<double> fillter, {int blockLen = 0}) {
    final signalPtr = malloc<Float>(signal.length);
    final fillterPtr = malloc<Float>(fillter.length);
    final outputLength = signal.length + fillter.length - 1;
    final outputPtr = malloc<Float>(outputLength);
    for (int i = 0; i < signal.length; i++) {
      signalPtr[i] = signal[i];
    }

    for (int i = 0; i < fillter.length; i++) {
      fillterPtr[i] = fillter[i];
    }
    final blockLenPtr = malloc<Int>(1);
    blockLenPtr.value = blockLen;
    final setup = _library.pffastconv_new_setup(
        fillterPtr, fillter.length, blockLenPtr, 0);
    _library.pffastconv_apply(setup, signalPtr, signal.length, outputPtr, 1);
    final result = outputPtr.asTypedList(outputLength).toList();
    _library.pffastconv_destroy_setup(setup);
    malloc.free(signalPtr);
    malloc.free(fillterPtr);
    malloc.free(outputPtr);
    return result;
  }
}
