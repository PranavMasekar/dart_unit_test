import 'package:test/test.dart';
import 'package:unit_tests/counter.dart';

void main() {
  late Counter counter;

  setUp(
    () {
      counter = Counter();
    },
  );
  group(
    'Counter Class tests ',
    () {
      test(
        'Counter value at start should be 0',
        () {
          int value = counter.count;
          expect(value, 0);
        },
      );

      test(
        'Counter value after increment should be 1',
        () {
          counter.increment();
          int value = counter.count;
          expect(value, 1);
        },
      );

      test(
        'Counter value after decrement must be -1',
        () {
          counter.decrement();
          int value = counter.count;
          expect(value, -1);
        },
      );

      test(
        'Counter value after rest should be 0',
        () {
          counter.reset();
          int value = counter.count;
          expect(value, 0);
        },
      );
    },
  );
}
