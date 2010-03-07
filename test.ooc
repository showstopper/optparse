import structs/[Array, ArrayList, HashMap]
import optparse/[Option, Parser]

test: func (parser: Parser, args: ArrayList<String>) {
    parser parse(args)
    "Name: %s " format(parser values get("name", String)) println()
    "Quiet: %d " format(parser values get("quiet", Bool)) println()
    "Libs: %s" format(parser values get("libs", ArrayList<String>) join(", ")) println()
    "Positional: %s" format(parser positional join(' ')) println()
    "Config:" println()
    cfg := parser values get("cfg", HashMap<String>)
    for(key in cfg keys) {
        "        '%s' => '%s'" format(key, cfg[key]) println()
    }
}

main: func (args: Array<String>) {
    parser := Parser new()
    
    quiet := ToggleOption new("quiet") .longName("quiet") .shortName("q") .help("Don't say anything.")
    name := StringOption new("name") .longName("name") .shortName("n") .help("Give me a name!") .metaVar("NAME")
    libs := ListOption new("libs") .longName("lib") .shortName("l") .help("Link with LIBRARY.") .metaVar("LIBRARY")
    cfg := ListOption new("cfg") .longName("cfg") .shortName("c") .help("Add the KEY/VALUE pair to the config.") .metaVar("KEY VALUE")

    parser addOption(quiet) .addOption(name) .addOption(libs)
    
    if(args size() < 2) {
        parser displayHelp()
    } else {
        test(parser, args toArrayList())
    }
}
