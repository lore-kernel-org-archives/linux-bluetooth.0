Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC v2 BlueZ 1/3] doc/gatt-api: Add options dictionary to ReadValue/WriteValue
Date: Fri, 29 Apr 2016 13:38:31 +0300
Message-Id: <1461926313-5629-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds the possibility to pass an offset to these operations, and
also in the server case to give the device object.
---
v2: Change flags to options since flags is term already used for other things,
also include secure-{read,write} to the flags to restrict access to secure
connection only.

 doc/gatt-api.txt | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/doc/gatt-api.txt b/doc/gatt-api.txt
index ad2ab16..683b1b7 100644
--- a/doc/gatt-api.txt
+++ b/doc/gatt-api.txt
@@ -61,23 +61,29 @@ Service		org.bluez
 Interface	org.bluez.GattCharacteristic1 [Experimental]
 Object path	[variable prefix]/{hci0,hci1,...}/dev_XX_XX_XX_XX_XX_XX/serviceXX/charYYYY
 
-Methods		array{byte} ReadValue()
+Methods		array{byte} ReadValue(dict options)
 
 			Issues a request to read the value of the
 			characteristic and returns the value if the
 			operation was successful.
 
+			Possible options: "offset": uint16 offset
+					  "device": Object Device (Server only)
+
 			Possible Errors: org.bluez.Error.Failed
 					 org.bluez.Error.InProgress
 					 org.bluez.Error.NotPermitted
 					 org.bluez.Error.NotAuthorized
 					 org.bluez.Error.NotSupported
 
-		void WriteValue(array{byte} value)
+		void WriteValue(array{byte} value, dict options)
 
 			Issues a request to write the value of the
 			characteristic.
 
+			Possible options: "offset": Start offset
+					  "device": Device path (Server only)
+
 			Possible Errors: org.bluez.Error.Failed
 					 org.bluez.Error.InProgress
 					 org.bluez.Error.NotPermitted
@@ -154,23 +160,29 @@ Service		org.bluez
 Interface	org.bluez.GattDescriptor1 [Experimental]
 Object path	[variable prefix]/{hci0,hci1,...}/dev_XX_XX_XX_XX_XX_XX/serviceXX/charYYYY/descriptorZZZ
 
-Methods		array{byte} ReadValue()
+Methods		array{byte} ReadValue(dict flags)
 
 			Issues a request to read the value of the
 			characteristic and returns the value if the
 			operation was successful.
 
+			Possible options: "offset": Start offset
+					  "device": Device path (Server only)
+
 			Possible Errors: org.bluez.Error.Failed
 					 org.bluez.Error.InProgress
 					 org.bluez.Error.NotPermitted
 					 org.bluez.Error.NotAuthorized
 					 org.bluez.Error.NotSupported
 
-		void WriteValue(array{byte} value)
+		void WriteValue(array{byte} value, dict flags)
 
 			Issues a request to write the value of the
 			characteristic.
 
+			Possible options: "offset": Start offset
+					  "device": Device path (Server only)
+
 			Possible Errors: org.bluez.Error.Failed
 					 org.bluez.Error.InProgress
 					 org.bluez.Error.NotPermitted
-- 
2.5.5

