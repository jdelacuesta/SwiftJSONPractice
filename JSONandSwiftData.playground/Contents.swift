import UIKit

// Common JSON Structure:
//{
//    "name": "John",
//    "age": 30,
//    "isStudent": false,
//    "address": {
//        "street": "123 Main St",
//        "city": "New York"
//    },
//    "hobbies": ["reading", "coding", "gaming"]
//}

// 1. Model Representation: To handle JSON data in Swift, you'll usually create models (structures or classes) that correspond to the JSON format.

//Example:

struct Address: Codable {
    var street: String
    var city: String
    var zipCode: String
}

// 2. Decoding JSON into Swift Objects: Use 'Codable' to easily convert between JSON and Swift Objects.

// Example:

struct Person: Codable {
    var name: String
    var age: Int
    var isStudent: Bool
    var address: Address
    var hobbies: [String]
}

// 3. Decoding with JSONDecoder:

let jsonData = """
{
    "name": "John",
    "age": 30,
    "isStudent": false,
    "address": {
        "street": "123 Main St",
        "city": "New York"
    },
    "hobbies": ["reading", "coding", "gaming"]
}
""".data(using: .utf8)!

let decoder = JSONDecoder()
do {
    let person = try decoder.decode(Person.self, from: jsonData)  // Fixed type reference
    print(person.name)  // "John"
} catch {
    print("Error decoding JSON: \(error)")
}

// 4. Encoding Swift Objects to JSON

let address = Address(street: "123 Main St", city: "Some City", zipCode: "12345")
let person = Person(name: "John Doe", age: 30, isStudent: true, address: address, hobbies: ["Reading", "Coding"])

let encoder = JSONEncoder()
do {
    let encodedData = try encoder.encode(person)  // Encode the instance of Person
    if let jsonString = String(data: encodedData, encoding: .utf8) {
        print(jsonString)  // Print the JSON string
    }
} catch {
    print("Error encoding JSON: \(error)")  // Handle errors
}


// MARK: - SwiftData Example

// 1. Defining a Model
//      - To start, you define a model that conforms to @Model and @Attribute to represent your data. These are equivalent to Core Data entitites.

//Example:
@Model struct Person {
    @Attribute(.primaryKey) var id: UUID
    @Attribute(.required) var name: String
    @Attribute(.optional) var age: Int?
    @Attribute(.optional) var isStudent: Bool
}

// @Model is the data model, and @Attribute is used to define properties for your model.
// @primaryKey is used to define the unique identifier (like 'id' in the example).

// 2. Saving Data
//      - Once you have a model, saving an instance to the database is as easy as creating the model object and saving it.

@ModelContext var context

func savePerson() {
    let person = Person(id: UUID(), name: "John", age: 30, isStudent: false)
    try? context.save(person)
}

// 3. Fetching Data
//      - Fetching data from the database is simple and involves querying your model objects:

func fetchPersons() {
    let persons = context.fetch(Person.self)
    for person in persons {
        print(person.name)
    }
}

// 4. Encoding Swift Objects to JSON with Error Handling
//      - Just like Core Data, you'll want to handle errors when performing database operations. You can utilize Swift's 'do-catch' blocks.

//Key Differences Between Core Data and SwiftData:

//    •    Simplicity: SwiftData uses a more Swift-native approach, making it easier to use and more integrated with Swift’s features.

//    •    Data Models: SwiftData uses @Model and @Attribute as a more declarative way of setting up your data structures, while Core Data uses a managed object model that relies on .xcdatamodeld files.

//    •    Context: Instead of managing NSManagedObjectContext, SwiftData uses @ModelContext, which is simpler.
