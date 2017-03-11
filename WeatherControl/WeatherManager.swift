//
//  WeatherManager.swift
//  Weather
//
//  Created by Jeevanantham Kalyanasundram on 3/10/17.
//  Copyright © 2017 Jeevanantham Kalyanasundram. All rights reserved.
//

import Foundation

// The delegate method didGetWeather is called if the weather data was received.
// The delegate method didNotGetWeather method is called if weather data was not received.
// The delegate method didReceivedImageData is called when weather icon image data received.
public protocol WeatherManagerDelegate {
    func didGetWeather(weather: WeatherDetails)
    func didNotGetWeather(error: NSError)
    func didReceivedImageData(data: Data)
}


// MARK: WeatherManager

public class WeatherManager {
    
    public var delegate: WeatherManagerDelegate
    
    // MARK: -
    public init(delegate: WeatherManagerDelegate) {
        self.delegate = delegate
    }
    
    public func getWeatherInfo(weatherInfoRequestURL: String) {
            
        // This is the shared session will do.
        let session = URLSession.shared
        
        //Converting string to URL
        let url = URL(string: weatherInfoRequestURL)!
        
        let task = session.dataTask(with: url, completionHandler: { (data, response, error) in

            if let networkError = error {
                // An error occurred while trying to get data from the server.
                self.delegate.didNotGetWeather(error: networkError as NSError)
            }
            else {
                print("Success")
                // We got data from the server!
                do {

                    let weatherData = try JSONSerialization.jsonObject(
                        with: data!,
                        options: .mutableContainers) as! [String: AnyObject]
                    
                    // Initializing dictionary to Weather struct.
                    let weather = WeatherDetails(weatherData: weatherData)
                    
                    // Pass Weather struct to view controller to display the weather info.
                    self.delegate.didGetWeather(weather: weather)
                }
                catch let jsonError as NSError {
                    self.delegate.didNotGetWeather(error: jsonError)
                }
            }
            
        })
        
        task.resume()
    }
   
    
    public func getWeatherImage(iconImageRequestUrl: String) {
        
        // This is the shared session will do.
        let session = URLSession.shared
        
        //Converting string to URL
        let requestURLForIconImage = URL(string: iconImageRequestUrl)
        
        let task = session.dataTask(with: requestURLForIconImage!, completionHandler: { (data, response, error) in
            
            if let networkError = error {
                // An error occurred while trying to get data from the server.
                self.delegate.didNotGetWeather(error: networkError as NSError)
            }
            else {
                print("Success")
                // We got image data from the server!
                self.delegate.didReceivedImageData(data:data!)
            }
            
        })
        
        task.resume()
        
    }
    
}
