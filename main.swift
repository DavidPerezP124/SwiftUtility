//
//  main.swift
//  organizeClasses
//
//  Created by David Perez on 1/14/20.
//  Copyright © 2020 David Perez P. All rights reserved.
//

import Cocoa

func main(){
    guard let path = getPath() else {
        
        return
    }
    print(path)
    guard let elements = readElements(str: path) else {
        
        return
    }
    print(elements)
    let components = path.components(separatedBy: "/")
    writeTo(text: elements, to: components[components.count - 1])
    
    
}


func getPath() -> String? {
    print("Specify path to project")
    
    return readLine()?.trimmingCharacters(in: [" "])
}

func readElements(str:  String) -> String? {
    print(str)
    if let files = try? FileManager.default.contentsOfDirectory(atPath: str){
        for file in files {
            print(file)
        }
    }
    
    var getStrings:  String?
    
    do {
        let data = try String(contentsOfFile: str, encoding: .utf8)
        let fileStrings = data
        getStrings = fileStrings
    } catch {
        print(error.localizedDescription)
    }
    return getStrings
}



func writeTo(text: String, to fileName: String) {
    guard let path = NSSearchPathForDirectoriesInDomains(.desktopDirectory, .userDomainMask, true).first else {
        print("no path accesible")
        return
        
    }
    
    print(path)
    guard let pathToWriteTo = NSURL(fileURLWithPath: path).appendingPathComponent("/Created") else {
        print("write path not accesible")
        return
        
    }
    print(pathToWriteTo)
    
    try? FileManager.default.createDirectory(atPath: pathToWriteTo.path, withIntermediateDirectories: true)
    
    let file = pathToWriteTo.appendingPathComponent(fileName)
    print(file)
   // let joined = text.joined(separator: "\n")
    do{
        try text.write(to: file, atomically: false, encoding: String.Encoding.utf8)
    } catch{
        print(error.localizedDescription)
    }
    
}


main()

