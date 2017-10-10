//
//  NSArray+SWExtensions.swift
//  SWJsonKit
//
//  Created by Stan Wu on 16/01/2017.
//  Copyright © 2017 Stan Wu. All rights reserved.
//

import Foundation

extension NSArray {
    var withoutNull: NSArray {
        let temp = NSMutableArray(capacity: self.count)
        
        for obj in self {
            if let dict = obj as? NSDictionary {
                temp.add(dict.withoutNull)
            } else if let ary = obj as? NSArray {
                let removed = ary.withoutNull
                if removed.count > 0 {
                    temp.add(ary)
                }
            } else if let _ = obj as? NSNull {
                
            } else {
                temp.add(obj)
            }
        }
        
        return NSArray(array: temp)
    }
    
    func dictionary(at index: Int) -> NSDictionary? {
        return self.object(at: index) as? NSDictionary
    }
}
