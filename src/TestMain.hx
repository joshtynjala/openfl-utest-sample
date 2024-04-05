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

		#if (html5 && playwright)
		// special case: see below for details
		setupHeadlessMode(runner);
		#else
		// a report prints the final results after all tests have run
		Report.create(runner);
		#end

		#if html5
		runner.onComplete.add(function(runner:Runner):Void {
			// by default, OpenFL fills the entire window on the html5 target
			// these lines ensure that test results are visible (and scrollable,
			// if necessary) after all tests have run
			stage.window.element.style.display = "none";
			stage.window.element.ownerDocument.body.style.overflow = "auto";
		});
		#end

		// don't forget to start the runner
		runner.run();
	}

	#if (html5 && playwright)
	/**
		Developers using continuous integration might want to run the html5
		target in a "headless" browser using playwright. To do that, add
		-Dplaywright to your command line options when building.

		@see https://playwright.dev
	**/
	private function setupHeadlessMode(runner:Runner):Void {
		new utest.ui.text.PrintReport(runner);
		var aggregator = new utest.ui.common.ResultAggregator(runner, true);
		aggregator.onComplete.add(function(result:utest.ui.common.PackageResult):Void {
			Reflect.setField(js.Lib.global, "utestResult", result);
		});
	}
	#end
}
