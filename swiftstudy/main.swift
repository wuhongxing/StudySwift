//
//  main.swift
//  swiftstudy
//
//  Created by 吴红星 on 2020/4/3.
//  Copyright © 2020 wuhongxing. All rights reserved.
//

import Foundation

func printMemory<T>(t1: T) {
    print(MemoryLayout.size(ofValue: t1))
    print(MemoryLayout.stride(ofValue: t1))
    print(MemoryLayout.alignment(ofValue: t1))
}

func printHeap<T>(p: T) {
    print(class_getInstanceSize(type(of: p) as! AnyClass))
    print(malloc_size(UnsafeRawPointer(bitPattern: unsafeBitCast(p, to: Int.self))))
}

func test() {
    print(MemoryLayout<Int>.size)
    print(MemoryLayout<Int>.stride)
    print(MemoryLayout<Int>.alignment)

    let age = 10
    printMemory(t1: age)
}


func test1() {
    enum Password {
        case number(Int, Int, Int, Int)
        case other
    }
    let p = Password.other
    printMemory(t1: p)
}
//test1()

func test2() {
    var num: Int! = 10
    num = nil
    print(num + 10)
}
//test2()

func test3() {
    let age: Int? = 18
    print("My age is \(age)")
}
//test3()

func test4() {
    var num1: Int? = nil
    var num2: Int?? = 10
    var num3: Int?? = nil

    print(num2 == num3) // false
    print((num2 ?? 1) ?? 2) // 2
    print((num3 ?? 1) ?? 2) // 1
}
//test4()

func test5() {
    enum TestEnum {
        case test1, test2, test3
    }
    var t = TestEnum.test1
    t = .test2
    t = .test3
    print(UnsafeMutablePointer(&t))
    printMemory(t1: t)
}
//test5()

func test6() {
    enum TestEnum {
        case test1(Int, Int, Int)
        case test2(Int, Int)
        case test3(Bool)
        case test4
    }
    var t1 = TestEnum.test1(10, 11, 12)
    var t2 = TestEnum.test3(true)
    var t3 = TestEnum.test4
    
    printMemory(t1: t1)
    
    print(UnsafeMutablePointer(&t1))
    print(UnsafeMutablePointer(&t2))
    print(UnsafeMutablePointer(&t3))
}
//test6()

func test7() {
    enum TestEnum {
        case test1(Bool)
        case test2(Int, Bool)
    }
    var t1 = TestEnum.test1(true)
    var t2 = TestEnum.test2(1, true)
    var t3 = TestEnum.test1(false)
    print(UnsafeMutablePointer(&t1))
    print(UnsafeMutablePointer(&t2))
    print(UnsafeMutablePointer(&t3))

}
//test7()

func test8() {
    enum TestEnum {
        case test1(Int, Int, Int)
        case test2(Int, Int)
        case test3(Bool)
        case test4
    }
    var t1 = TestEnum.test1(10, 11, 12)
    print(UnsafeMutablePointer(&t1))
    switch t1 {
    case .test1(let v1, let v2, let v3):
        print(v1, v2, v3)
    default:
        break
    }
}
//test8()

func test9() {
    enum Fruit: String {
        case apple = "A"
        case pear
        case banbana
        
        
        var rawValue: String {
            set {
                rawValue = newValue
            }
            get {
                return String(describing: self)
            }
        }
    }
    
    let f = Fruit.apple
    print(f.rawValue)
}

//test9()

func test10() {
    struct Point {
        var x: Int = 10
        var y: Int = 20
    }
    var p = Point()
    print(UnsafeMutablePointer(&p))
    printMemory(t1: p)
}

//test10()

func test11() {
    class Size {
        var width = 1
        var height = 2
    }
    
    struct Point {
        var x = 3
        var y = 4
    }
    
    var point = Point()
    var size = Size()
    
    print(UnsafeMutablePointer(&point))
    print(UnsafeMutablePointer(&size))
}

//test11()

func test12() {
    struct Point {
        var x = 3
        var y = 4
    }
    let p = Point()
    var p1 = p
    p1.x = 10
    p1.y = 20
}

//test12()

func test13() {
    class Size {
        var width: Int
        var height: Int
        init(width: Int, height: Int) {
            self.width = width
            self.height = height
        }
    }
    
    var s1 = Size(width: 10, height: 20)
    var s2 = s1
    s1 = Size(width: 20, height: 30)
    
}

//test13()

func test14() {
    class Point {
        var x = 11
        var test = true
        var y = 22
    }
    var p = Point()
    printHeap(p: p)
}
//test14()

func test15() {
    func exec(v1: Int, v2: Int, fn: (Int, Int) -> Int) {
        print(fn(v1, v2))
    }
    
    var fn: (Int, Int) -> Int = { i, j in
        return i + j
    }
    exec(v1: 1, v2: 3, fn: fn)
    exec(v1: 1, v2: 3) { (i, j) -> Int in
        return i + j
    }
    exec(v1: 1, v2: 2) { $0 + $1 }
    exec(v1: 1, v2: 2, fn: +)
}

//test15()

func test16() {
    var a = [1, 3, 2, 8, 7, 5]
    var b = a
    a.sort(by: <)
    b.sort { $0 < $1 }
}
//test16()

func test17() {
    typealias Fn = (Int) -> Int
    func getFn() -> Fn {
        var num = 1
        func plus(_ i: Int) -> Int {
            num += i
            return num
        }
        return plus
    }
    
    let fn = getFn()
    print(fn(1))
    print(fn(1))
    print(fn(1))
    print(fn(1))
}
//test17()

let test18_ = 10
func test18() {
    typealias Fn = (Int) -> Int
    func getFn() -> Fn {
        func plus(_ i: Int) -> Int {
            return i + test18_
        }
        return plus
    }
    let fn = getFn()
    print(fn(1))
}
//test18()

func test19() {
    class Closure {
        var num = 1
        func plus(_ i: Int) -> Int {
            num += i
            return num
        }
    }
    let c = Closure()
    print(c.plus(1))
    print(c.plus(1))
    print(c.plus(1))
    print(c.plus(1))
}
//test19()

func test20() {
    var functions: [() -> Int] = []
    for i in 1...3 {
        functions.append { i }
    }
    for f in functions {
        print(f())
    }
}
//test20()

func test21() {
    func getNum() -> Int {
        let a = 10
        let b = 11
        print("getNum")
        return a + b
    }
    
    @discardableResult
    func max(a: Int, b: Int) -> Int {
        return a > 0 ? a : b
    }
    
    @discardableResult
    func max1(a: Int, b: () -> Int) -> Int {
        return a > 0 ? a : b()
    }
    
    @discardableResult
    func max2(a: Int, b: @autoclosure () -> Int) -> Int {
        return a > 0 ? a : b()
    }
    print(max2(a: 10, b: getNum()))
}
//test21()

func test22() {
    struct Circle {
        var radius: Double
        var diameter: Double {
            set {
                radius = newValue / 2
            }
            get {
                radius * 2 // 这里的 return 可以省略
            }
        }
    }
}
//test22()

func test23() {
    struct Point {
        var x = 10
        var y = 11
        lazy var z = 12
    }
    
    var point = Point()
    printMemory(t1: point)
    point.z = 10
    printMemory(t1: point)
}
//test23()

func test24() {
    struct Circle {
        var radius: Double = 10 {
            willSet {
                print("willSet", newValue)
            }
            didSet {
                print("didSet", oldValue, radius)
            }
        }
    }
    
    var c = Circle()
    c.radius = 20
}
//test24()

func test25() {
    class Point {
        var x = 10
        var y = 11
        lazy var z = 12
    }
    
    let point = Point()
    printHeap(p: point)
    point.z = 10
    printHeap(p: point)
}
//test25()

func test26() {
    class Point {
        var x = 10
        var y = 11
        
        subscript(index: Int) -> Int {
            set {
                guard index == 0 else {
                    y = newValue
                    return
                }
                    x = newValue
            }
            get {
                if index == 0 {
                    return x
                }
                return y
            }
        }
    }
    
    let p = Point()
    print(p[0])
    print(p[1])
}

//test26()

func test27() {
    struct Point {
        var x = 10
        var y = 11
    }
    
    class PointManager {
        var point = Point()
        subscript(index: Int) -> Point {
            set { point = newValue }
            get { point }
        }
    }
    
    let p = PointManager()
    p[0].x = 20
    p[0].y = 22
}
//test27()

func test28() {
    class Animal {
        var age = 0
    }
    class Dog: Animal {
        var weight = 0
    }
    class ErHa: Dog {
        var iq = 0
    }
    
    let a = Animal()
    a.age = 10
    let b = Dog()
    b.weight = 20
    let c = ErHa()
    c.iq = 180
    printHeap(p: a)
    printHeap(p: b)
    printHeap(p: c)
}
//test28()

func test29() {
    class Animal {
        func speak() {
            print("Animal speak")
        }
        func eat() {
            print("Animal eat")
        }
        func sleep() {
            print("Animal sleep")
        }
    }
    
    class Dog: Animal {
        override func speak() {
            print("Dog speak")
        }
        override func eat() {
            print("Dog eat")
        }
        func run() {
            print("Dog run")
        }
    }
    
    var anim: Animal
    anim = Animal()
    anim.speak()
    anim.eat()
    anim.sleep()
    
    anim = Dog()
    anim.speak()
    anim.eat()
    anim.sleep()
    (anim as! Dog).run()
}
//test29()

func test30() {
    struct Animal {
        func speak() {
            print("Animal speak")
        }
        func eat() {
            print("Animal eat")
        }
        func sleep() {
            print("Animal sleep")
        }
    }
    
    var anim: Animal
    anim = Animal()
    anim.speak()
    anim.eat()
    anim.sleep()
}
//test30()

func test31() {
    class Person {
        var age: Int
        init(age: Int) {
            self.age = age
        }
        
        func test() {
            
        }
        
    }
    
    class Student: Person {
        var score: Int
        init(age: Int, score: Int) {
            self.score = score
//            'self' used in property access 'age' before 'super.init' call
//            self.age = 10
            super.init(age: age)
            self.age = 10
        }
    }
}
//test31()

protocol Drawable {
    func draw()
    var x: Int { get set }
    var y: Int { get }
    subscript(index: Int) -> Int { get }
}
func test32() {
    class Person: Drawable {
        var x: Int = 0
        
        let y: Int = 10
        
        func draw() {
            print("Person draw")
        }
        
        subscript(index: Int) -> Int {
            return index
        }
    }
}
//test32()

protocol P1 {
    
}
protocol P2 {
    
}
func test33() {
    class Person { }
    func fn0(obj: P1 & P2 & Person) { }
}
test33()

enum Season {
    case spring, summer, autumn, winter
}
extension Season: CaseIterable { }
func test34() {
    let seasons = Season.allCases
    print(seasons)
}
//test34()

class Test35 {
    var age = 10
    var name = "hello"
}

extension Test35: CustomStringConvertible {
    var description: String {
        return name + "\(age)"
    }
}
func test35() {
    let t = Test35()
    print(t)
}
//test35()

func test36() {
    class Person { }
    class Student: Person { }
    
    let p = Person()
    var perType: Person.Type = Person.self
    let stuType: Student.Type = Student.self
    perType = Student.self
    
    var anyType: AnyObject.Type = Person.self
    anyType = Student.self
    // public typealias AnyClass = AnyObject.Type
    var anyType2: AnyClass = Person.self
    anyType2 = Student.self
}
//test36()

func test37() {
    class Person {
        var age: Int = 0
    }
    
    class Student: Person {
        var no: Int = 0
    }
    
    print(class_getInstanceSize(Person.self))
    print(class_getSuperclass(Student.self)!)
    print(class_getSuperclass(Person.self)!)
}
//test37()

func test38() {
    class Person {
        required init() {
            
        }
        
        func test() -> Self {
            Self.self.init()
        }
        
        func test1() -> Self {
            Self.self.init()
        }
    }
    
    class Student: Person {
        
    }
    
    let p = Person().test().test1()
}
//test38()

func test39() {
    class Person {
        static var age = 0
        static func run() {}
    }
    
    Person.age = 10
    Person.self.age = 20
    
    func test(_ cls: AnyClass) {
        
    }
    
    test(Person.self)
}
//test39()
enum MyError: Error {
    case zero
}

func test40() {
    func divide(_ num1: Int, _ num2: Int) -> Int {
        return num1 / num2
    }
    
    func divide1(_ num1: Int, _ num2: Int) -> Int? {
        guard num2 != 0 else {
            return nil
        }
        return num1 / num2
    }
    
    func divide2(_ num1: Int, _ num2: Int) throws -> Int {
        guard num2 != 0 else {
            throw MyError.zero
        }
        return num1 / num2
    }
    
    print(divide(1, 2))
    print(divide1(1, 0))
    do {
        print("1")
        print(try divide2(1, 0))
        print("2")
    } catch MyError.zero {
        print("zero")
    } catch {
        print("other")
    }
}
//test40()

func test41() {
    func test(_ i: Int) throws -> Int {
        if i == 0 {
            throw MyError.zero
        }
        return 1
    }
    print("begin")
    print(try? test(0))
    print(try? test(1))
    print(try! test(1))
    print("end")
    
    var b: Int?
    do {
        b = try test(0)
    } catch {
        b = nil
    }
    
}
//test41()

func test42() throws {
    func open() {
        print("open file")
    }
    
    func close() {
        print("close file")
    }
    
    func test(_ i: Int) throws -> Int {
        if i == 0 {
            throw MyError.zero
        }
        return 1
    }
    
    open()
    defer {
        close()
    }
    try test(0)
    
}
//try test42()


func test43() {
    func swapValue<T: Equatable>(_ a: inout T, _ b: inout T) {
        (a, b) = (b, a)
    }
    
    var a = 10
    var b = 20
    swap(&a, &b)
    
    var c = 10.0
    var d = 20.0
    swap(&c, &d)
}
//test43()

protocol Runnable {
    associatedtype Speed
    var speed: Speed { get }
}

func test44() {
    class Person: Runnable {
        var speed: Int = 0
    }
    class Car: Runnable {
        var speed: Double = 0.0
    }
//    func get(_ type: Int) -> Runnable {
//        if type == 0 {
//            return Person()
//        }
//        return Car()
//    }
    
    func get1<T: Runnable>(_ type: Int) -> T {
        if type == 0 {
            return Person() as! T
        }
        return Car() as! T
    }
    
    func get2(_ type: Int) -> some Runnable {
        return Car()
    }
    
    let p: Person = get1(0)
    let c: Car = get1(1)
}
//test44()

func test45() {
    class Dog: Runnable {
        var speed: Int = 10
    }
    
    class Person {
        var pet: some Runnable {
            return Dog()
        }
    }
}
//test45()

func test46() {
    var str1 = "0123456789"
    var str2 = "0123456789012345"
    str1.append("01234")
    str1.append("5")
    str2.append("6")
    str2.append("7")
}
//test46()

func test47() {
    var str1 = "0123456789"
    var str2 = "0123456789"
}
//test47()

func test48() {
    var a = [1, 2, 3, 4]
    printMemory(t1: a)
    print(malloc_size(UnsafeRawPointer(bitPattern: unsafeBitCast(a, to: Int.self))))
}
//test48()

func test49() {
    var a = [Int]()
    (0...64).forEach { (i) in
        a.append(i)
    }
//    a.append(16)
    
}
//test49()

func test50() {
    var age: Int? = 20
    
    switch age {
    case let v:
        print(v)
    default:
        break
    }
    
    switch age {
    case let v?:
        print(v)
    default:
        break
    }
    
    switch age {
    case let .some(v):
        print(v)
    default:
        break
    }
}
//test50()

struct Point {
    var x = 0
    var y = 0
    
    static func + (p1: Point, p2: Point) -> Point {
        return Point(x: p1.x + p2.x, y: p1.y + p2.y)
    }
    
    static func += (p1: inout Point, p2: Point) {
        p1 = p1 + p2
    }
}
func test51() {
    var p1 = Point(x: 10, y: 10)
    var p2 = Point(x: 20, y: 20)
    var p3 = p1 + p2
    p1 += p2
    print(p3)
    print(p1)
}
//test51()

class Test52 {
    var name: String = ""
}
extension Test52: Equatable {
    static func ==(p1: Test52, p2: Test52) -> Bool {
        return p1.name == p2.name
    }
}
func test52() {
    let p1 = Test52()
    let p2 = Test52()
    print(p1 == p2)
}
//test52()

func test53() {
    enum Test: Equatable {
        case number(Int)
        case zero
    }
    
    var t1 = Test.number(10)
    var t2 = Test.number(10)
    print(t1 == t2)
}
//test53()

protocol Test54 {
    func test1()
}
extension Test54 {
    func test1() {
        print("Protocol test1")
    }
    func test2() {
        print("Protocol test2")
    }
}
func test54() {
    class Test: Test54 {
        func test1() {
            print("class test1")
        }
        func test2() {
            print("class test2")
        }
    }
    
    var t: Test54 = Test()
    t.test1()
    t.test2()
    
    var t1 = Test()
    t.test2()
}
//test54()

func test55() {
    class Person {
        deinit {
            print("deinit")
        }
    }
    weak var p = Person()
    
}
//test55()

func test56() {
    var step = 1
    func increment(_ num: inout Int) {
        num += step
    }
//    increment(&step)
    var t = step
    increment(&t)
    step = t
}
//test56()

func test57() {
    var age = 10
    var ptr = withUnsafeMutablePointer(to: &age) { $0 }
    ptr.pointee = 20
    print(age)
    
    var ptr1 = withUnsafeMutablePointer(to: &age) { UnsafeMutableRawPointer($0) }
    ptr1.storeBytes(of: "a", as: String.self)
    print(age)
}
//test57()

func test58() {
    class Person {
        var age: Int = 20
    }
    var person = Person()
//    var ptr = withUnsafePointer(to: &person) { UnsafeRawPointer($0) }
//    var ptr1 = UnsafeMutableRawPointer(bitPattern: ptr.load(as: UInt.self))
//    print(ptr, ptr1)
    var ptr = unsafeBitCast(person, to: UnsafeRawPointer.self)
    print(ptr)
}
//test58()

func test59() {
//    var ptr = malloc(16)
    var ptr = UnsafeMutableRawPointer.allocate(byteCount: 16, alignment: 1)
    ptr.storeBytes(of: 11, as: Int.self)
    ptr.storeBytes(of: 22, toByteOffset: 8, as: Int.self)
    print(ptr.load(as: Int.self))
    print(ptr.load(fromByteOffset: 8, as: Int.self))
//    free(ptr)
    ptr.deallocate()
}
//test59()

func test60() {
    class Person {
        var age: Int = 0
        var name: String = ""
        
        init(age: Int, name: String) {
            self.age = age
            self.name = name
        }
        
        deinit {
            print("deinit")
        }
    }
    
    var ptr = UnsafeMutablePointer<Person>.allocate(capacity: 1)
    defer {
        ptr.deinitialize(count: 1)
        ptr.deallocate()
    }
    ptr.initialize(to: Person(age: 10, name: "json"))
    print(ptr[0].age)
}
//test60()

func test61() {
    var ptr = UnsafeMutableRawPointer.allocate(byteCount: 16, alignment: 1)
    ptr.assumingMemoryBound(to: Int.self).pointee = 11
    (ptr + 8).assumingMemoryBound(to: Double.self).pointee = 20.0
    
    print(unsafeBitCast(ptr, to: UnsafePointer<Int>.self).pointee)
    print(unsafeBitCast(ptr + 8, to: UnsafePointer<Double>.self).pointee)
}
//test61()

func test62() {
    var age = -1
    var age1 = unsafeBitCast(age, to: UInt.self)
    print(age, age1)
}
//test62()

func test63() {
    let ages: [Int?] = [2, 3, nil, 5]
    for case nil in ages {
        print("有 nil 值")
        break
    }
}
//test63()

func test64() {
    let num: Any = 6
//    switch num {
//        case is Int:
//        print("is Int", num)
//        default:
//        break
//    }
    switch num {
    case let num as Int:
        print("is Int", num)
        default:
        break
    }
}
//test64()

func test65() {
    var a = "123456789"
    var b = a.prefix(3)
    print(type(of: a), type(of: b))
    print(b.base)
}
//test65()

func test66() {
    var a: NSString = "abc"
    var b: String = "abc"
    var c: NSMutableString = "abc"
    
    print(a as String == b)
    print((b as NSString).isEqual(to: a))
    print(c as String == b)
}
//test66()

func test67() {
    class Person {
        var age: Int = 10
        var name: Int = 20
    }
    
    let person = Person()
    
}
//test67()

class Test68 {
    
}
extension Test68 {
    private static var ageKey: Bool = false
    var age: Int {
        set {
            objc_setAssociatedObject(self, &Self.ageKey, newValue, .OBJC_ASSOCIATION_ASSIGN)
        }
        get {
            objc_getAssociatedObject(self, &Self.ageKey) as! Int
        }
    }
}
func test68() {
    
}
