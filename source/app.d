import std.stdio;
import std.file;

void main(string[] args)
{
	if (args.length <= 1) {
		writeln("usage: names FILE [FILE...]");
	} else {

		try {
			string[] names;

			auto files = args[1 .. $];
			foreach (string file; files) {
				import std.file : exists;
				import std.exception : enforce;
				enforce(file.exists, "error: file " ~ file ~ " does not exist");

				auto f = File(file, "r");
				auto lines = f.byLine();
				foreach(line; lines) {
					//add to names [if not duplicate or empty]
					import std.algorithm.searching : canFind;
					if ((line != "") && !canFind(names, line)) {
						names ~= line.idup;
					}
				}

				//file is automatically closed
			}

			foreach(string name; names) {
				writeln(name);
			}

		} catch(Exception e) {
			writeln(e.msg);
		}
	}
}
