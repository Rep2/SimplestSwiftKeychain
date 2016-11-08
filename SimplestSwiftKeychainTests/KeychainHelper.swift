import Foundation
import Security

public struct OSStatusError: Error {
    let status: OSStatus
}

public class KeychainHelper {

    static let accountKey = "undabot.Njupop-login-API"

    public static func set(value: Data, forKey key: String, override: Bool = true) throws {
        if override {
            try delete(key: key)
        }

        let query: [String : Any] = [
            kSecClass as String : kSecClassGenericPassword,
            kSecAttrAccount as String : accountKey + key,
            kSecValueData as String : value
        ]

        let status = SecItemAdd(query as CFDictionary, nil)

        if status != noErr {
            throw OSStatusError(status: status)
        }
    }

    public static func get(key: String) throws -> Data? {
        let query: [String : Any] = [
            kSecClass as String : kSecClassGenericPassword,
            kSecAttrAccount as String : accountKey + key,
            kSecReturnData as String : kCFBooleanTrue,
            kSecMatchLimit as String : kSecMatchLimitOne
        ]

        var result: AnyObject?

        let status = withUnsafeMutablePointer(to: &result) {
            SecItemCopyMatching(query as CFDictionary, UnsafeMutablePointer($0))
        }

        if status == noErr || status == errSecItemNotFound {
            return result as? Data
        } else {
            throw OSStatusError(status: status)
        }
    }

    public static func delete(key: String) throws {
        let query: [String : Any] = [
            kSecClass as String : kSecClassGenericPassword,
            kSecAttrAccount as String : accountKey + key
        ]

        let status = SecItemDelete(query as CFDictionary)

        if !(status == noErr || status == errSecItemNotFound) {
            throw OSStatusError(status: status)
        }
    }

}
