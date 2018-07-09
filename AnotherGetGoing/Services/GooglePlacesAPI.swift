//
//  GooglePlacesAPI.swift
//  AnotherGetGoing
//
//  Created by Alla Bondarenko on 2018-06-18.
//  Copyright © 2018 Alla Bondarenko. All rights reserved.
//

import Foundation
import CoreLocation

class GooglePlacesAPI {
    
    class func textSearch(query: String,rankBy: String, distance : String , openNow : Bool,  completionHandler: @escaping(_ statusCode: Int, _ json: [String: Any]?) -> Void){
        var urlComponents = URLComponents()
        urlComponents.scheme = Constants.scheme
        urlComponents.host = Constants.host
        urlComponents.path = Constants.textPlaceSearch
        
        urlComponents.queryItems = [
            URLQueryItem(name: "query", value: query),
            URLQueryItem(name: "key", value: Constants.apiKey)
        ]
        
        if rankBy == "Distance" {
            urlComponents.queryItems?.append(URLQueryItem(name: "radius", value: distance))
            print("Distance Selected")
        }
        
        if openNow {
            print("Open Now Value : \(openNow)")
            urlComponents.queryItems?.append(URLQueryItem(name: "opennow", value: "true"))
        }
        //print("url \(urlComponents.url)")
        NetworkingLayer.getRequest(with: urlComponents) { (statusCode, data) in
            if let jsonData = data,
                let jsonObject = try? JSONSerialization.jsonObject(with: jsonData, options: .allowFragments) as? [String: Any] {
                print(jsonObject ?? "")
                completionHandler(statusCode, jsonObject)
            } else {
                print("life is not easy")
                completionHandler(statusCode, nil)
            }
        }
        
    }
    
    class func placeDetails(placeId: String, completionHandler: @escaping(_ statusCode: Int, _ json: [String: Any]?) -> Void){
        var urlComponents = URLComponents()
        urlComponents.scheme = Constants.scheme
        urlComponents.host = Constants.host
        urlComponents.path = Constants.placeDetails
        
        urlComponents.queryItems = [
            URLQueryItem(name: "place_id", value: placeId),
            URLQueryItem(name: "key", value: Constants.apiKey)
        ]
        
        NetworkingLayer.getRequest(with: urlComponents) { (statusCode, data) in
            if let jsonData = data,
                let jsonObject = try? JSONSerialization.jsonObject(with: jsonData, options: .allowFragments) as? [String: Any] {
                print(jsonObject ?? "")
                completionHandler(statusCode, jsonObject)
            } else {
                print("life is not easy")
                completionHandler(statusCode, nil)
            }
        }
        
    }
    
    class func nearbySearch(for locationCoordinate: CLLocationCoordinate2D, radius: Int = 5000, openNow : Bool?, rankBy : String?,keyword: String?, completionHandler: @escaping(_ statusCode: Int, _ json: [String: Any]?) -> Void){
        var urlComponents = URLComponents()
        urlComponents.scheme = Constants.scheme
        urlComponents.host = Constants.host
        urlComponents.path = Constants.nearbyPlaceSearch
        
        let locationParameter = "\(locationCoordinate.latitude),\(locationCoordinate.longitude)"
        
        //adding parameters to network request
        urlComponents.queryItems = [
            URLQueryItem(name: "location", value: locationParameter),
           // URLQueryItem(name: "radius", value: String(radius)),
            URLQueryItem(name: "key", value: Constants.apiKey)
        ]
        if let keyword = keyword {
            urlComponents.queryItems?.append(URLQueryItem(name: "keyword", value: keyword))
        }
        
        if rankBy == "Distance"{
            urlComponents.queryItems?.append(URLQueryItem(name: "rankby", value: rankBy))
        }
        else{
            urlComponents.queryItems?.append(URLQueryItem(name: "radius", value: String(radius)))
        }
        
        if openNow == openNow{
            urlComponents.queryItems?.append(URLQueryItem(name: "opennow", value: "true"))
        }
   //     print("url \(urlComponents.url)")
        NetworkingLayer.getRequest(with: urlComponents) { (statusCode, data) in
            if let jsonData = data,
                let jsonObject = try? JSONSerialization.jsonObject(with: jsonData, options: .allowFragments) as? [String: Any] {
                print(jsonObject ?? "")
                completionHandler(statusCode, jsonObject)
            } else {
                print("life is not easy")
                completionHandler(statusCode, nil)
            }
        }
        
    }
   
    
}
