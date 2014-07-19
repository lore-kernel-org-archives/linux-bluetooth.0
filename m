Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Arman Uguray <armansito@chromium.org>
Subject: [RFC 1/1] doc/gatt-api: New API properties and methods for the GATT D-Bus API.
Date: Fri, 18 Jul 2014 23:06:48 -0700
Message-Id: <1405750008-7652-2-git-send-email-armansito@chromium.org>
In-Reply-To: <1405750008-7652-1-git-send-email-armansito@chromium.org>
References: <1405750008-7652-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch proposes changes to the currently unimplemented GATT D-Bus API for
desktop bluetoothd. This is the first step in implementing a GATT client layer
for bluetoothd that will change the way remote attributes are accessed via
bluetoothd plugins and external applications.
---
 doc/gatt-api.txt | 118 ++++++++++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 104 insertions(+), 14 deletions(-)

diff --git a/doc/gatt-api.txt b/doc/gatt-api.txt
index 8c7975c..bec9674 100644
--- a/doc/gatt-api.txt
+++ b/doc/gatt-api.txt
@@ -32,6 +32,25 @@ Properties	string UUID [read-only]
 
 			128-bit service UUID.
 
+		boolean Primary [read-only]
+
+			Indicates whether or not this GATT service is a
+			primary service. If false, the service is secondary.
+
+		object Device [read-only, optional]
+
+			Object path of the Bluetooth device the service
+			belongs to. Only present on services from remote
+			devices.
+
+		array{object} Characteristics [read-only]
+
+			Array of object paths representing the characteristics
+			of this service. This property is set only when the
+			characteristic discovery has been completed, however the
+			characteristic objects will become available via
+			ObjectManager as soon as they get discovered.
+
 		array{object} Includes [read-only]: Not implemented
 
 			Array of object paths representing the included
@@ -48,6 +67,54 @@ Service		org.bluez
 Interface	org.bluez.GattCharacteristic1 [Experimental]
 Object path	[variable prefix]/{hci0,hci1,...}/dev_XX_XX_XX_XX_XX_XX/serviceXX/charYYYY
 
+Methods		array{byte} ReadValue()
+
+			Issues a request to read the value of the
+			characteristic and returns the value if the
+			operation was successful.
+
+			Possible Errors: org.bluez.Error.Failed
+					 org.bluez.Error.InProgress
+					 org.bluez.Error.ReadNotPermitted
+					 org.bluez.Error.Authentication
+					 org.bluez.Error.Authorization
+					 org.bluez.Error.Encryption
+
+		void WriteValue(array{byte} value)
+
+			Issues a request to write the value of the
+			characteristic.
+
+			Possible Errors: org.bluez.Error.Failed
+					 org.bluez.Error.InProgress
+					 org.bluez.Error.WriteNotPermitted
+					 org.bluez.Error.Authentication
+					 org.bluez.Error.Authorization
+					 org.bluez.Error.Encryption
+
+		void StartNotify()
+
+			Starts a notification session from this characteristic
+			if it supports value notifications or indications.
+
+			Possible Errors: org.bluez.Error.Failed
+					 org.bluez.Error.InProgress
+					 org.bluez.Error.NotSupported
+
+		void StopNotify()
+
+			This method will cancel any previous StartNotify
+			transaction. Note that notifications from a
+			characteristic are shared between sessions thus
+			calling StopNotify will release a single session.
+
+			Possible Errors: org.bluez.Error.Failed
+
+Signals		void ValueUpdated(array{bytes} value)
+
+			This signal is launched when a characteristic handle
+			value notification or indication is received.
+
 Properties	string UUID [read-only]
 
 			128-bit characteristic UUID.
@@ -57,12 +124,12 @@ Properties	string UUID [read-only]
 			Object path of the GATT service the characteristc
 			belongs to.
 
-		array{byte} Value [read-write]
+		boolean Notifying [read-only]
 
-			Value read from the remote Bluetooth device or from
-			the external application implementing GATT services.
+			True, if notifications or indications on this
+			characteristic are currently enabled.
 
-		array{string} Flags [read-only, optional]
+		array{string} Flags [read-only]
 
 			Defines how the characteristic value can be used. See
 			Core spec "Table 3.5: Characteristic Properties bit
@@ -79,6 +146,14 @@ Properties	string UUID [read-only]
 				"reliable-write"
 				"writable-auxiliaries"
 
+		array{object} Descriptors [read-only]
+
+			Array of object paths representing the descriptors
+			of this service. This property is set only when the
+			descriptor discovery has been completed, however the
+			descriptor objects will become available via
+			ObjectManager as soon as they get discovered.
+
 
 Characteristic Descriptors hierarchy
 ====================================
@@ -89,6 +164,31 @@ Service		org.bluez
 Interface	org.bluez.GattDescriptor1 [Experimental]
 Object path	[variable prefix]/{hci0,hci1,...}/dev_XX_XX_XX_XX_XX_XX/serviceXX/charYYYY/descriptorZZZ
 
+Methods		array{byte} ReadValue()
+
+			Issues a request to read the value of the
+			characteristic and returns the value if the
+			operation was successful.
+
+			Possible Errors: org.bluez.Error.Failed
+					 org.bluez.Error.InProgress
+					 org.bluez.Error.ReadNotPermitted
+					 org.bluez.Error.Authentication
+					 org.bluez.Error.Authorization
+					 org.bluez.Error.Encryption
+
+		void WriteValue(array{byte} value)
+
+			Issues a request to write the value of the
+			characteristic.
+
+			Possible Errors: org.bluez.Error.Failed
+					 org.bluez.Error.InProgress
+					 org.bluez.Error.WriteNotPermitted
+					 org.bluez.Error.Authentication
+					 org.bluez.Error.Authorization
+					 org.bluez.Error.Encryption
+
 Properties	string UUID [read-only]
 
 			128-bit descriptor UUID.
@@ -98,16 +198,6 @@ Properties	string UUID [read-only]
 			Object path of the GATT characteristc the descriptor
 			belongs to.
 
-		array{byte} Value [read-write]
-
-			Raw characteristic descriptor value read from the
-			remote Bluetooth device or from the external
-			application implementing GATT services.
-
-		string Permissions [read-only]: To be defined
-
-			Defines read/write authentication and authorization
-			requirements.
 
 Service Manager hierarchy
 =============================
-- 
2.0.0.526.g5318336

