import 'package:http/http.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';
import 'package:unit_tests/user_model.dart';
import 'package:unit_tests/user_repository.dart';

Client client = Client();

class MockHttpClient extends Mock implements Client {}

void main() {
  late UserRepository userRepository;
  late MockHttpClient mockHttpClient;

  setUp(() {
    mockHttpClient = MockHttpClient();
    userRepository = UserRepository(mockHttpClient);
  });

  group(
    "UserRepository - ",
    () {
      group(
        'GetUser Function - ',
        () {
          test(
            'If getUser function return status code 200 then usermodel should be returned',
            () async {
              when(
                () => mockHttpClient.get(
                  Uri.parse('https://jsonplaceholder.typicode.com/users/1'),
                ),
              ).thenAnswer(
                (invocation) async {
                  return Response(
                    ''' 
                    {
                      "id": 1,
                      "name": "Leanne Graham",
                      "username": "Bret",
                      "email": "Sincere@april.biz",
                      "website": "hildegard.org"
                    }
                    ''',
                    200,
                  );
                },
              );

              final user = await userRepository.getUser();

              expect(user, isA<User>());
            },
          );

          test(
            'If getuser Function return status code which is not 200 then exception must be throwned',
            () async {
              when(
                () => mockHttpClient.get(
                  Uri.parse('https://jsonplaceholder.typicode.com/users/1'),
                ),
              ).thenAnswer(
                (invocation) async {
                  return Response(
                    ''' ''',
                    404,
                  );
                },
              );

              final user = userRepository.getUser();

              expect(user, throwsException);
            },
          );
        },
      );
    },
  );
}
