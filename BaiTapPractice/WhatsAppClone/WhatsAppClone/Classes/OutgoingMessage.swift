//
//  OutgoingMessage.swift
//  WhatsAppClone
//
//  Created by nghiadang1205 on 4/28/20.
//  Copyright © 2020 NghiaDang. All rights reserved.
//

import Foundation

class OutgoingMessage {
    
    let messageDictionary: NSMutableDictionary
    
    // MARK: Intializers
    
    // text message
    init(message: String, senderId: String, senderName: String, date: Date, status: String, type: String) {
        messageDictionary = NSMutableDictionary(objects: [message, senderId, senderName, dateFormatter().string(from: date), status, type], forKeys: [kMESSAGE as NSCopying, kSENDERID as NSCopying, kSENDERNAME as NSCopying, kDATE as NSCopying, kSTATUS as NSCopying, kTYPE as NSCopying])
    }
    
    // picture message
    init(message: String, pictureLink: String, senderId: String, senderName: String, date: Date, status: String, type: String) {
        messageDictionary = NSMutableDictionary(objects: [message, pictureLink, senderId, senderName, dateFormatter().string(from: date), status, type], forKeys: [kMESSAGE as NSCopying, kPICTURE as NSCopying,kSENDERID as NSCopying, kSENDERNAME as NSCopying, kDATE as NSCopying, kSTATUS as NSCopying, kTYPE as NSCopying])
    }
    
    // video message
    init(message: String, videoLink: String, thumbNail: NSData, senderId: String, senderName: String, date: Date, status: String, type: String) {
        
        let picThumb = thumbNail.base64EncodedString(options: NSData.Base64EncodingOptions(rawValue: 0))
        
        messageDictionary = NSMutableDictionary(objects: [message, videoLink, picThumb, senderId, senderName, dateFormatter().string(from: date), status, type], forKeys: [kMESSAGE as NSCopying, kVIDEO as NSCopying, kPICTURE as NSCopying, kSENDERID as NSCopying, kSENDERNAME as NSCopying, kDATE as NSCopying, kSTATUS as NSCopying, kTYPE as NSCopying])
    }
    
    // audio message
    init(message: String, audio: String, senderId: String, senderName: String, date: Date, status: String, type: String) {
        messageDictionary = NSMutableDictionary(objects: [message, audio, senderId, senderName, dateFormatter().string(from: date), status, type], forKeys: [kMESSAGE as NSCopying, kAUDIO as NSCopying,kSENDERID as NSCopying, kSENDERNAME as NSCopying, kDATE as NSCopying, kSTATUS as NSCopying, kTYPE as NSCopying])
    }
    
    // location message
    init(message: String, latitude: NSNumber, longitude: NSNumber, senderId: String, senderName: String, date: Date, status: String, type: String) {
        messageDictionary = NSMutableDictionary(objects: [message, latitude, longitude, senderId, senderName, dateFormatter().string(from: date), status, type], forKeys: [kMESSAGE as NSCopying, kLATITUDE as NSCopying, kLONGITUDE as NSCopying, kSENDERID as NSCopying, kSENDERNAME as NSCopying, kDATE as NSCopying, kSTATUS as NSCopying, kTYPE as NSCopying])
    }
    
    // MARK: Send message
    
    func sendMessage(chatRoomID: String, messageDictionary: NSMutableDictionary, memberIds: [String], membersToPush: [String]) {
        
        let messageId = UUID().uuidString
        messageDictionary[kMESSAGEID] = messageId
        
        for memberId in memberIds {
            
            reference(.Message).document(memberId).collection(chatRoomID).document(messageId).setData(messageDictionary as! [String: Any])
            
        }
        
        // update recent chat
        
        // send push notification
        
    }
    
    class func deleteMessage(withId: String, chatRoomId: String) {
        
        
        
    }
    
    class func updateMessage(withId: String, chatRoomId: String, memberIds: [String]) {
        
        let readDate = dateFormatter().string(from: Date())
        
        let values = [kSTATUS: kREAD, kREADDATE: readDate]
        
        for userId in memberIds {
            
            reference(.Message).document(userId).collection(chatRoomId).document(withId).getDocument { (snapshot, error) in
                
                guard let snapshot = snapshot else { return }
                
                if snapshot.exists {
                    
                    reference(.Message).document(userId).collection(chatRoomId).document(withId).updateData(values)
                    
                }
                
            }
            
        }
        
    }
}
