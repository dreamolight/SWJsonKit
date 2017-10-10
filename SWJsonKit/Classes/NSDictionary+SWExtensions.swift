//
//  NSDictionary+SWAdditions.swift
//  SWJsonKit
//
//  Created by Stan Wu on 10/4/16.
//  Copyright © 2016 Stan Wu. All rights reserved.
//
import Foundation

extension NSDictionary{
    func int(forKey key: Any) -> Int? {
        if let str = self.object(forKey: key) as? NSString {
            return str.integerValue
        }
        
        return self.object(forKey: key) as? Int
    }
    
    func double(forKey key: Any) -> Double? {
        if let str = self.object(forKey: key) as? NSString {
            return str.doubleValue
        }
        
        return self.object(forKey: key) as? Double
    }
    
    func bool(forKey key: Any) -> Bool? {
        if let str = self.object(forKey: key) as? NSString {
            return str.boolValue
        }
        
        return self.object(forKey: key) as? Bool
    }
    
    func string(forKey key: Any) -> String? {
        if let value = self.object(forKey: key) {
            if let str = value as? String {
                return str
            } else if let num = value as? Int {
                return "\(num)"
            } else {
                return "\(value)"
            }
        }
        
        return nil
    }
    
    func dictionary(forKey key: Any) -> NSDictionary? {
        return self.object(forKey: key) as? NSDictionary
    }
    
    func array(forKey key: Any) -> NSArray? {
        return self.object(forKey: key) as? NSArray
    }
    
    func intValue(_ key: Any) -> Int {
        return self.int(forKey: key) ?? 0
    }
    
    func doubleValue(_ key: Any) -> Double {
        return self.double(forKey: key) ?? 0
    }
    
    func boolValue(_ key: Any) -> Bool {
        return self.bool(forKey: key) ?? false
    }
    
    var withoutNull: NSDictionary {
        let temp = NSMutableDictionary(dictionary: self)
        
        for key in self.allKeys {
            if let ary = self.object(forKey: key) as? NSArray {
                let tempary = ary.withoutNull
                
                if tempary.count > 0 {
                    temp.setObject(tempary, forKey: key as! NSCopying)
                }
            } else if let dict = self.object(forKey: key) as? NSDictionary {
                temp.setObject(dict.withoutNull, forKey: key as! NSCopying)
            } else if let _ = self.object(forKey: key) as? NSNull {
                temp.removeObject(forKey: key)
            }
        }
        
        return NSDictionary(dictionary: temp)
    }
}
