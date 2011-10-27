Return-Path: <cyrus@holtmann.org>
From: chen.ganir@gmail.com
To: linux-bluetooth@vger.kernel.org
Cc: anderson.lizardo@openbossa.org, luiz.dentz@gmail.com,
	mathewm@codeaurora.org, claudio.takahasi@openbossa.org,
	bgix@codeaurora.org, ingas@codeaurora.org,
	Chen Ganir <chen.ganir@ti.com>
Subject: [RFC Bluetooth] New Bluetooth GATT Client API
Date: Thu, 27 Oct 2011 18:10:20 +0200
Message-Id: <1319731820-10622-1-git-send-email-chen.ganir@ti.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Chen Ganir <chen.ganir@ti.com>

New proposal for GATT Client API. This updates some existing API's and removes 
unnecessary properties. This is a followup for the previous comments.
---
 doc/attribute-api.txt |   52 +++++++++++++++++++++++++++++++++++++++++++++---
 1 files changed, 48 insertions(+), 4 deletions(-)

diff --git a/doc/attribute-api.txt b/doc/attribute-api.txt
index 98d7f30..e1263c1 100644
--- a/doc/attribute-api.txt
+++ b/doc/attribute-api.txt
@@ -66,6 +66,9 @@ Methods 	dict GetProperties()
 			notify about any changed characteristics in the service.
 			This also notifies about any included characteristics.
 
+			The Indicate method will be used if possible, otherwise notification
+			will be used. If none is possible, error will be returned.
+
 		UnregisterCharacteristicsWatcher(object agent)
 
 			Unregister a watcher.
@@ -112,6 +115,18 @@ Methods		dict GetProperties()
 
 			Possible Errors: org.bluez.Error.InvalidArguments
 
+		array{byte} ReadValue()
+
+			Read the value of the characteristic.
+
+		void WriteValue(array{byte} value, String method)
+
+			Write the value of the characteristic, with specified method :
+			Request |  Write without response.
+			Command |  Write with response. Return error if failed.
+
+			Other write methods will be added in the future.
+
 Properties 	string UUID [readonly]
 
 			UUID128 of this characteristic.
@@ -142,15 +157,44 @@ Properties 	string UUID [readonly]
 			  uint16 | Description: Description of the characteristic defined
 			         | in a high layer profile.
 
-		array{byte} Value [readwrite]
-
-			Raw value of the Characteristic Value attribute.
-
 		string Representation (of the binary Value) [readonly]
 
 			Friendly representation of the Characteristic Value
 			based on the format attribute.
 
+		boolean Broadcast [readwrite]
+
+			Indicates whether this characteristic is broadcasted or not.
+			If GATT Server Characteristic Configuration descriptor
+			is not available for this characteristic, or if the characteristic
+			properties do not allow this, writing to this property is not
+			allowed.
+
+		String[] SupportedValChangeSignal [readonly]
+
+			Indicates supported methods for signaling value changed from the
+			server to the client. Valid options are :
+			Indicate | This characteristic can be indicated.
+			Notify   | This characteristic can be notified.
+
+			These capabilities will be taken from the client characteristic
+			configuration descriptor availability and from the characteristic
+			properties.
+
+		boolean Readable [readonly]
+
+			Indicates wether this characteristic value can be read.
+
+		String[] WritableMethod [readony]
+
+			Indicates which write operations are allowed on this characteristic.
+			Values can be :
+			Request    | Write request, with a server response.
+			Command    | Write command, no server response.
+			Auth       | Authenticated write (link must be encrypted).
+			Signed     | Signed write (ATT packets need to be signed).
+			Reliable   | Reliable write (server responds with the written val)
+
 
 Characteristic Watcher hierarchy
 ===============================
-- 
1.7.4.1

