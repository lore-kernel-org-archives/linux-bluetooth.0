Return-Path: <cyrus@holtmann.org>
From: "Counihan, Tom" <tom.counihan@intel.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Date: Mon, 14 Jun 2010 09:59:47 +0100
Subject: Proposed MAP API
Message-ID: <B09AD526409DF14F8DA79CC5429052C28F7AAA6C@irsmsx505.ger.corp.intel.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Folks,

Please find below proposed Bluetooth MAP API, based upon Message Access Profile, ver 10r00. 
Comments most welcome. 
Of note below is missing the PushMessage function - Section 5.8 of mentioned spec.
Reason being, I'm trying to get my head around what should be returned from a GetMessage call below, and conversely what should be passed to a potential PushMessage - bMessage can take on a number of different guises. 
Any guidance/opinion would be greatly appreciated in this area, or any other suggested improvements.

Warm Regards

Tom.


------------------------------------------
Message Access hierarchy
=======================

Service		org.openobex.client
Interface	org.openobex.MessageAccess
Object path	[variable prefix]/{session0,session1,...}

Methods	void SetFolder(string folder)

			Change the current folder of the remote MSE device
			
		dict GetProperties()

			Returns all properties for the interface. See the
			properties section for available properties.
		
		array{string} GetFolderListing()

			Returns a Folder-Listing containing information about
			the current folder content. The return shall not contain
			message entries.
			
		array{dict} GetMessageListing()

			Returns a dictionary containing information about
			the current folder's Message content.

			The following keys are defined:

			uint64 Handle: Unique handle for message
			string subject: summary of message
			string datetime: timestamp in format "YYYMMDDTHHMMSS"
			string senderName: name of sender
			string senderAddressing: address info of sender
			string replytoAddressing: Reply-To info of sender
			string recipientName: name of recipient 
			string recipientAddressing: address info of recipient
			string type: ("EMAIL" | "SMS_GSM" | "SMS_CDMA" | "MMS")
			string size: Size in bytes of original message
			string text: ("yes"|"no") - text vs binary content
			string receptionStatus: reception status on MSE
			string attachmentSize: size of attachment in bytes
			string priority: ("yes"|"no") - high or no priority
			string read: ("yes"|"no") has message been read on MSE
			string sent: ("yes"|"no") has message been sent 
			string protected: ("yes"|"no") is all/part DRM protected				
				
		string GetMessage(uint64 handle)
			
			Retrieves a messages, identified by unique handle from MSE.
			
		void UpdateInbox()
			
			Trigger the MSE to update its inbox.
			
		void SetReadStatus(uint64 handle, string status)
			
			Sets the messges's read status on the MSE
				handle: unique handle for the message
				status: "yes" sets message status to read
			     		  "no" sets message status to unread
						
		void SetDeletStatus(uint64 handle, string status)
			
			Sets the messges's delete status on the MSE
				handle: unique handle for the message
				status: "yes" sets message status to delete
					  "no" sets message status to non-delete
						
		void EnableNotification()
		
			Request the MSE to send message notification events
		
		void DisableNotification()
		
			Request the MSE to disable message notifications.
						
Signals		MessageEventReport(dict)

			Sent when an event on the MSE affects is message listing.
			
			The following keys are defined:
				string type: ("NewMessage" | " DeliverySuccess" |
					"SendingSuccess" | "DeliveryFailure" |
					"SendingFailure" | "MemoryFull" |
					"MemoryAvailable" | "MessageDeleted" | 						"MessageShifted")
				uint64 handle: Unique handle for message
				string folder: name of folder, including path which 							message has been populated on MSE
				string oldFolder: Facilitates moving msgs between 							folders
				string msgType: ("EMAIL" | "SMS_GSM" | "SMS_CDMA" | 							"MMS")
			
Properties	boolean NotificationEnabled [readonly]

			Reflects if MSE has been directed to send message 				Notification
--------------------------------------------------------------
Intel Shannon Limited
Registered in Ireland
Registered Office: Collinstown Industrial Park, Leixlip, County Kildare
Registered Number: 308263
Business address: Dromore House, East Park, Shannon, Co. Clare

This e-mail and any attachments may contain confidential material for the sole use of the intended recipient(s). Any review or distribution by others is strictly prohibited. If you are not the intended recipient, please contact the sender and delete all copies.


