import structs/[Array, ArrayList]
import optparse/[Option, Parser]

test: func (parser: Parser, args: ArrayList<String>) {
    parser parse(args)
    "Name: %s " format(parser values get("name", String)) println()
    "Quiet: %d " format(parser values get("quiet", Bool)) println()
    "Positional: %s" format(parser positional join(' ')) println()
}

main: func (args: Array<String>) {
    parser := Parser new()
    parser addOption(ToggleOption new("quiet", "quiet", "q", false))
    parser addOption(StringOption new("name", "name", "n", "Bla-Bli-Blubb"))
   
    test(parser, args toArrayList())
}
