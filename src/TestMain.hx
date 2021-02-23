import openfl.display.Sprite;
import utest.Runner;
import utest.ui.Report;

class TestMain extends Sprite {
	public function new() {
		super();

		// create a `Runner` to run your tests
		var runner = new Runner();

		// add as many test cases as you need
		runner.addCase(new tests.SampleTestCase());

		// a report prints the final results after all tests have run
		Report.create(runner);

		// don't forget to start the runner
		runner.run();
	}
}
