import 'package:bloc_pattern_example/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:bloc_pattern_example/features/number_trivia/domain/repository/number_trivia_repository.dart';
import 'package:bloc_pattern_example/features/number_trivia/domain/usecases/get_concrete_number_trivia.dart';
import 'package:dartz/dartz.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';

class MockNumberTriviaRepository extends Mock
    implements NumberTriviaRepository {}

void main() {
  GetConcreteNumberTrivia? usecase;

  MockNumberTriviaRepository? mockNumberTriviaRepository;
  setUp(() {
    mockNumberTriviaRepository = MockNumberTriviaRepository();
    usecase = GetConcreteNumberTrivia(mockNumberTriviaRepository!);
  });
  final tNumber = 1;
  final tNumberTrivia = NumberTrivia(text: "test", number: tNumber);
  test('should get trivia for the number for the repository', () async {
    // arrange
    when(mockNumberTriviaRepository?.getConcreteNumberTrivia(any ?? 0))
        .thenAnswer((_) async => Right(tNumberTrivia));
    //act
    final result = await usecase!(Params(tNumber));

    //assert
    expect(result, Right(tNumberTrivia));
    verify(mockNumberTriviaRepository?.getConcreteNumberTrivia(tNumber));
    verifyNoMoreInteractions(mockNumberTriviaRepository);
  });
}
