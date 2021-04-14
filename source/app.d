import std.stdio;
import std.file;

void main(string[] args)
{
	string[] names;

	auto files = args[1 .. $];
	foreach (string file; files)
	{
		auto f = File(file, "r"); //TODO: check if file exists

		auto lines = f.byLine();
		foreach(line; lines)
		{
			//add to names [if not duplicate or empty]
			import std.algorithm.searching : canFind;
			if ((line != "") && !canFind(names, line))
			{
				names ~= line.idup;
			}
		}

		//file is automatically closed
	}

	foreach(string name; names)
	{
		writeln(name);
	}
}
