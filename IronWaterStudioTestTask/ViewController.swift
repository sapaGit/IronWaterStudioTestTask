//
//  ViewController.swift
//  IronWaterStudioTestTask
//
//  Created by Sergey Pavlov on 09.09.2022.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Demo of work
        compareVersions(".", "0.0")
        compareVersions("01.234.56", "2.0.0")
        compareVersions("1.0", "1")
        compareVersions("..0.1", "0.0.0.1")
        
        //Demo of unacceptable input
        compareVersions("a.1", "1.2")
        
    }
    
    private func compareVersions(_ firstVersion: String, _ secondVersion: String) {
        
        // Checking arguments for unacceptable characters
        let acceptedSet = CharacterSet(charactersIn: "1234567890.")
        
        if (firstVersion + secondVersion).rangeOfCharacter(from: acceptedSet.inverted) != nil {
            print("One of the versions contains unacceptable characters. Please use only non-negative numbers and \".\" symbol.")
            return
        }
        
        // Creating object of ComparisonResult type for print result of comparison in switch statement
        var compareResult = "".compare("")
        
        let versionDelimiter = "."
        
        // Make arrays of numbers separated by versionDelimiter
        var firstVersionComponents = firstVersion.components(separatedBy: versionDelimiter)
        var secondVersionComponents = secondVersion.components(separatedBy: versionDelimiter)
        
        
        // Replacing "" with "0" in Arrays
        for index in 0...firstVersionComponents.count-1 {
            if firstVersionComponents[index] == "" {
                firstVersionComponents[index] = "0"
            }
        }
        
        for index in 0...secondVersionComponents.count-1 {
            if secondVersionComponents[index] == "" {
                secondVersionComponents[index] = "0"
            }
        }
      
        // Checking for elements count difference in two Arrays
        let elementDiff = firstVersionComponents.count - secondVersionComponents.count
        
        if elementDiff == 0 {
            // Same count of elements, comparing them without adding elements
            compareResult = firstVersionComponents.joined(separator: versionDelimiter)
                .compare(secondVersionComponents.joined(separator: versionDelimiter), options: .numeric)
        } else {
            // Creating array with "0" elements with count of abs(elementDiff) to insert it into lower count of elements array.
            let zeros = Array(repeating: "0", count: abs(elementDiff))
           
            if elementDiff > 0 {
                secondVersionComponents.append(contentsOf: zeros)
            } else {
                firstVersionComponents.append(contentsOf: zeros)
            }
            
            // Comparing arrays with same count of elements
            compareResult = firstVersionComponents.joined(separator: versionDelimiter)
                .compare(secondVersionComponents.joined(separator: versionDelimiter), options: .numeric)
        }
        
        // Switch result of comparing and print it.
        switch compareResult {
        case .orderedAscending: print("Version 2 is newer")
        case .orderedSame: print("Same versions")
        case .orderedDescending: print("Version 1 is newer")
        }
    }
}

