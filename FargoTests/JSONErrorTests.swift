//
//  JSONErrorTests.swift
//  Fargo
//
//  Created by Ivan Vasic on 03/11/15.
//  Copyright © 2015 Ivan Vasic. All rights reserved.
//

import XCTest
@testable import Fargo

class JSONErrorTests: XCTestCase {
    
    func testInitMissingKey() {
        // Given
        let json = JSON(object: 0)
        
        // When
        let error = JSON.Error(missingKey: JSON.KeyPath.Key.Key("key"), json: json)
        
        // Then
        XCTAssertEqual(error.debugDescription, "MissingKey `Key(\"key\")` in keyPath `/`")
    }
    
    func testInitTypeMismatch() {
        // Given
        let json = JSON(object: 0)
        
        // When
        let error = JSON.Error(typeMismatchForType: "String", json: json)
        
        // Then
        XCTAssertEqual(error.debugDescription, "TypeMismatch, expected `String` got `__NSCFNumber` for keyPath `/`")
    }
    
    func testDebugDescriptionMissingKey() {
        // Given
        let error = JSON.Error.MissingKey(key: JSON.KeyPath.Key.Key("key"), keyPath: JSON.KeyPath())
        
        // When
        let description = error.debugDescription
        
        // Then
        XCTAssertEqual(description, "MissingKey `Key(\"key\")` in keyPath `/`")
    }
    
    func testDebugDescriptionMissingKeyIndex() {
        // Given
        let error = JSON.Error.MissingKey(key: JSON.KeyPath.Key.Index(0), keyPath: JSON.KeyPath())
        
        // When
        let description = error.debugDescription
        
        // Then
        XCTAssertEqual(description, "MissingKey `Index(0)` in keyPath `/`")
    }
    
    func testDebugDescriptionTypeMismatch() {
        // Given
        let error = JSON.Error.TypeMismatch(expectedType: "Int", actualType: "String", keyPath: JSON.KeyPath())
        
        // When
        let description = error.debugDescription
        
        // Then
        XCTAssertEqual(description, "TypeMismatch, expected `Int` got `String` for keyPath `/`")
    }
    
    // MARK: - Description for JSON
    
    func testDebugDescriptionForJSONForMissingKey() {
        // Given
        let json = JSON(object: ["somekey": "somevalue"])
        let error = JSON.Error.MissingKey(key: JSON.KeyPath.Key.Key("key"), keyPath: JSON.KeyPath())
        
        // When
        let description = error.descriptionForJSON(json)
        
        // Then
        XCTAssertEqual(description, "MissingKey `Key(\"key\")` in JSON : ``. Full keyPath `/`")
    }
    
    func testDebugDescriptionForJSONForTypeMismatch() {
        // Given
        let json = JSON(object: ["key": 1])
        let error = JSON.Error.TypeMismatch(expectedType: "String", actualType: "Int", keyPath: JSON.KeyPath())
        
        // When
        let description = error.descriptionForJSON(json)
        
        // Then
        XCTAssertEqual(description, "TypeMismatch, expected `String` got `?`. Full keyPath `/`")
    }
    
    func testDebugDescriptionForJSONForTypeMismatchWithInvalidKeyPath() {
        // Given
        let json = JSON(object: ["key": 1])
        let error = JSON.Error.TypeMismatch(expectedType: "String", actualType: "Int", keyPath: JSON.KeyPath(path: [.Key("test")]))
        
        // When
        let description = error.descriptionForJSON(json)
        
        // Then
        XCTAssertEqual(description, "TypeMismatch, expected `String` got `?`. Full keyPath `/`")
    }
}
