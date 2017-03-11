//
//  WeatherDetails.swift
//  Weather
//
//  Created by Jeevanantham Kalyanasundram on 3/10/17.
//  Copyright © 2017 Jeevanantham Kalyanasundram. All rights reserved.
//

import Foundation


public struct WeatherDetails {
    
    public let city: String
    public let country: String
    
    public let weatherIconID: String
    
    let temp: Double
    public var tempCelsius: Double {
        get {
            return temp - 273.15
        }
    }
    
    public var tempFahrenheit: Double {
        get {
            return (temp - 273.15) * 1.8 + 32
        }
    }
    
    public let humidity: Int
    public let windSpeed: Double
    
    
    init(weatherData: [String: AnyObject]) {
        city = weatherData["name"] as! String
        
        let weatherDict = weatherData["weather"]![0] as! [String: AnyObject]
        weatherIconID = weatherDict["icon"] as! String
        
        let mainDict = weatherData["main"] as! [String: AnyObject]
        temp = mainDict["temp"] as! Double
        humidity = mainDict["humidity"] as! Int
        
        let windDict = weatherData["wind"] as! [String: AnyObject]
        windSpeed = windDict["speed"] as! Double
        
        let sysDict = weatherData["sys"] as! [String: AnyObject]
        country = sysDict["country"] as! String
        
    }
    
    
}
