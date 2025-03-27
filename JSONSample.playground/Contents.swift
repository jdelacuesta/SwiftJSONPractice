import Foundation

// MARK: - Model Definitions

struct Address: Codable {
    var street: String
    var city: String
    var zipCode: String
}

struct Person: Codable {
    var name: String
    var age: Int
    var isStudent: Bool
    var address: Address
    var hobbies: [String]
}

// MARK: - Load JSON Data

if let url = Bundle.main.url(forResource: "sample", withExtension: "json") {
    do {
        let jsonData = try Data(contentsOf: url)
        let decoder = JSONDecoder()
        let person = try decoder.decode(Person.self, from: jsonData)
        
        // ✅ Output Decoded Data
        print("Name: \(person.name)")
        print("Age: \(person.age)")
        print("Is Student: \(person.isStudent)")
        print("Address: \(person.address.street), \(person.address.city) \(person.address.zipCode)")
        print("Hobbies: \(person.hobbies.joined(separator: ", "))")
        
    } catch let DecodingError.keyNotFound(key, context) {
        print("❌ Key '\(key)' not found: \(context.debugDescription)")
    } catch let DecodingError.valueNotFound(value, context) {
        print("❌ Value '\(value)' not found: \(context.debugDescription)")
    } catch let DecodingError.typeMismatch(type, context) {
        print("❌ Type mismatch for type '\(type)': \(context.debugDescription)")
    } catch {
        print("❌ Other error: \(error)")
    }
} else {
    print("❌ JSON file not found")
}
