import XCTest
import SimplestSwiftKeychain

class KeychainTest: XCTestCase {

    func test_SetGet() {
        let key = "test"
        let data = "test data".data(using: .utf8)!

        do {
            try KeychainHelper.set(value: data, forKey: key)
        } catch let error {
            print(error)
            XCTAssert(false)
        }

        do {
            let recievedData = try KeychainHelper.get(key: key)

            XCTAssert(recievedData != nil)

            if let recievedData = recievedData {
                XCTAssert(recievedData == data)
            }
        } catch let error {
            print(error)
            XCTAssert(false)
        }
        
    }

    func test_SetGetDelete() {
        let key = "test2"
        let data = "test data2".data(using: .utf8)!

        do {
            try KeychainHelper.set(value: data, forKey: key)
        } catch let error {
            print(error)
            XCTAssert(false)
        }

        do {
            let recievedData = try KeychainHelper.get(key: key)

            XCTAssert(recievedData != nil)

            if let recievedData = recievedData {
                XCTAssert(recievedData == data)
            }
        } catch let error {
            print(error)
            XCTAssert(false)
        }

        do {
            try KeychainHelper.delete(key: key)
        } catch let error {
            print(error)
            XCTAssert(false)
        }

        do {
            let recievedData = try KeychainHelper.get(key: key)

            XCTAssert(recievedData == nil)
        } catch let error {
            print(error)
            XCTAssert(false)
        }
        
    }
    
}
