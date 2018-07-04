//
//  PlaceOfInterest.swift
//  AnotherGetGoing
//
//  Created by Alla Bondarenko on 2018-06-18.
//  Copyright © 2018 Alla Bondarenko. All rights reserved.
//

import Foundation
import CoreLocation

class PlaceOfInterest: NSObject, NSCoding {
    
    //keys used for archiving the obj (persistent storage)
    struct PropertyKey {
        static let idKey = "id"
        static let nameKey = "name"
        static let ratingKey = "rating"
        static let latKey = "lat"
    static let lngKey = "lng"
//        static let formattedAddressKey = "formattedAddress"
    }
    
    var id: String
    var name: String
    var rating: Double?
    var location: CLLocation?
    var formattedAddress: String?
    var iconUrl: String?
    var placeId : String?
    var website : String?
    var formattedPhoneNumber : String?
    
    init?(json: [String: Any]){
        
        guard let id = json["id"] as? String else {
            return nil
        }
        guard let name = json["name"] as? String else {
            return nil
        }
        self.id = id
        self.name = name
        
        self.rating = json["rating"] as? Double
        self.formattedAddress = json["formatted_address"] as? String
        self.iconUrl = json["icon"] as? String
        self.placeId = json["place_id"] as? String
        self.formattedPhoneNumber = json["formatted_phone_number"] as? String
        self.website = json["website"] as? String
        
        if let geometry = json["geometry"] as? [String: Any] {
            if let locationCoordinate = geometry["location"] as? [String: Double
                ] {
                if locationCoordinate["lat"] != nil, locationCoordinate["lng"] != nil {
                    self.location = CLLocation(latitude: locationCoordinate["lat"]!, longitude: locationCoordinate["lng"]!)
                }
            }
        }
        
    }
    
    init(id: String, name: String){
        self.id = id
        self.name = name
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(id, forKey: PropertyKey.idKey)
        aCoder.encode(name, forKey: PropertyKey.nameKey)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        let id = aDecoder.decodeObject(forKey: PropertyKey.idKey) as! String
        let name = aDecoder.decodeObject(forKey: PropertyKey.nameKey) as! String
        self.init(id: id, name: name)
    }
    
}
