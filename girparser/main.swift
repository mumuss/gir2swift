//
//  main.swift
//  girparser
//
//  Created by Rene Hexel on 22/03/2016.
//  Copyright © 2016 Rene Hexel. All rights reserved.
//
#if os(Linux)
    import Glibc
#else
    import Darwin
#endif

@noreturn func usage() {
    fputs("Usage: \(Process.arguments[0]) [-v] [file.gir ...]\n", stderr)
    exit(EXIT_FAILURE)
}

//
// get options
//
var verbose = false
while let (opt, param) = get_opt("v") {
    switch opt {
        case "v":
            verbose = true
        default:
            usage()
    }
}

func process_gir(file: String) {
    with_mmap(file) { (content: UnsafeBufferPointer<CChar>) in
        write(STDOUT_FILENO, content.baseAddress, content.count)
        guard let xml = XMLDocument(buffer: content) else {
            perror("Cannot parse GIR file '\(file)'")
            return
        }
        for element in xml {
            print(element.debugDescription)
        }
//        for record in xml.xpath("//record") {
//            print("\(record["name"]): \(record["c:type"])")
//        }
    }
}

for file in Process.arguments[Int(optind)..<Process.arguments.count] {
    process_gir(file)
}
