//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

/**:
    Swift Enumeratios
        User the keyword enum to define an enumeration which is a new *type*
 */
enum SomeEnumeration {
    // enumeration definition
}

/**:
    Define an enumaration
 */
enum CompassPoint {
    case north
    case south
    case east
    case west
}

//: Multiple cases can appear on a single line, separated by commas:
enum Planet {
    case mercury, venus, earth, mars, jupiter, saturn, uranus, neptune
}

//: Work with enumerations

var directionToHead = CompassPoint.west

directionToHead = .east

//: Matcheing Enumeration with a switch statement

/**:
    If the case for .west is omitted, this code does not compile,
    because it does not consider the complete list of CompassPoint cases.
    Requiring exhaustiveness ensures that enumeration cases are not accidentally omitted.
 */
switch directionToHead {
    case .north :
        print("We are at the north")
    case .south:
        print("We are at the south")
    case .east:
        print("We are at the east")
    case .west:
        print("We are at the west")
}

/**:
    When it is not appropriate to provide a case for every enumeration case,
    you can provide a default case to cover any cases that are not addressed explicitly
 */

let somePlanet = Planet.earth
switch somePlanet {
case .earth:
    print("Mostly harmless")
default:
    print("Not a safe place for humans")
}

//: Associeted value
enum Barcode {
    case upc(Int, Int, Int, Int)
    case qrCode(String)
}

var productBarcode = Barcode.upc(8, 85909, 51226, 3)

productBarcode = Barcode.qrCode("ABCDEFSKDKS")

switch productBarcode {
    case .upc(let numberSystem, let manufacturer, let product, let check):
        print("UPC: \(numberSystem), \(manufacturer), \(product), \(check)")
    case .qrCode(let productCode):
        print("QR Code: \(productCode)")
}

//: Raw Value

/**:
    implicite assign rawValue
 */
enum RPlanet: Int {
    case mercury = 1, venus, earth, mars, jupiter, saturn, uranus, neptune
}

//: You access the raw value of an enumeration case with its rawValue property

let earthsOrder = RPlanet.earth.rawValue

print("earthsOrder = \(earthsOrder)")

//: init from a rawValue
let possiblyPlanet = RPlanet(rawValue: 7)

print("possiblyPlanet = \(String(describing: possiblyPlanet))")

/**:
    If you try to find a planet with a position of 11,
    the optional Planet value returned by the raw value initializer will be nil
 */
let positionToFind = 11
if let somePlanet = RPlanet(rawValue: positionToFind) {
    switch somePlanet {
    case .earth:
        print("Mostly harmless")
    default:
        print("Not a safe place for humans")
    }
} else {
    print("There isn't a planet at position \(positionToFind)")
}

//: recursive Enumerations

/**:
    You indicate that an enumeration case is recursive by writing indirect before it,
    which tells the compiler to insert the necessary layer of indirection
 */
//enum ArithmeticExpression {
//    case number(Int)
//    indirect case addition(ArithmeticExpression, ArithmeticExpression)
//    indirect case multiplication(ArithmeticExpression, ArithmeticExpression)
//}

/**:
    You can also write *indirect* before the beginning of the enumeration
    to enable indirection for all of the enumeration’s cases that have an associated value:
 */

indirect enum ArithmeticExpression {
    case number(Int)
    case addition(ArithmeticExpression, ArithmeticExpression)
    case multiplication(ArithmeticExpression, ArithmeticExpression)
}

let five = ArithmeticExpression.number(5)
let four = ArithmeticExpression.number(4)
let sum = ArithmeticExpression.addition(five, four)
let product = ArithmeticExpression.multiplication(sum, ArithmeticExpression.number(2))

func evalualte(_ expression: ArithmeticExpression) -> Int {
    switch expression {
    case let .number(value):
        return value
    case let .addition(left, right):
        return evalualte(left) + evalualte(right)
    case let .multiplication(left, right):
        return evalualte(left) * evalualte(right)
    }
}

print(evalualte(product))

/**:
    Comments
 */
func split1(email: String) -> (String, String)? {
    let components = email.components(separatedBy: "@")

    guard components.count == 2,
        let username = components.first,
        let domain = components.last,
        !username.isEmpty && !domain.isEmpty else { return nil }
    return (username, domain)
}

let splitEmail1 = split1(email: "simbaste52@gmail.com")

print("unsername = \(String(describing: splitEmail1?.0)) | domain = \(String(describing: splitEmail1?.1))")


/**:
    Symbols
 */
typealias TSplitEmail = (username: String, domain: String)?

/**:
 Or
 struct splitEmail {
    let username: String
    let domain: String
 }
 */

func split(email: String) -> TSplitEmail {
    let components = email.components(separatedBy: "@")

    guard components.count == 2,
        let username = components.first,
        let domain = components.last,
        !username.isEmpty && !domain.isEmpty else { return nil }
    return (username, domain)
}

let splitEmail = split(email: "simbaste52@gmail.com")

print("unsername = \(String(describing: splitEmail?.0)) | domain = \(String(describing: splitEmail?.1))")

/**:
    Wrapper
 */

enum SplitEmail {
    case valid(username: String, domain: String)
    case invalid
    
    init(from email: String) {
        let components = email.components(separatedBy: "@")
        
        if components.count == 2,
            let username = components.first,
            let domain = components.last,
            !username.isEmpty && !domain.isEmpty {
            self = .valid(username: username, domain: domain)
        } else {
            self = .invalid
        }
    }
}

let emailSplit = SplitEmail(from: "stephanedarcy.simomba@gmail.com")

switch emailSplit {
    case let .valid(username, domain):
        print("username = \(username), domain = \(domain)")
    case .invalid:
        print("invalid email addess")
}













