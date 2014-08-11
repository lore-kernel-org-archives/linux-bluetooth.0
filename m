Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Arman Uguray <armansito@chromium.org>
Subject: [RFC v2 1/1] doc/gatt-api: New API properties and methods for the GATT D-Bus API.
Date: Mon, 11 Aug 2014 13:37:07 -0700
Message-Id: <1407789427-7118-2-git-send-email-armansito@chromium.org>
In-Reply-To: <1407789427-7118-1-git-send-email-armansito@chromium.org>
References: <1407789427-7118-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch introduces the following new properties to the GattService1
interface:

  Device: A remote-service-only property that contains the D-Bus object
  path of the associated device.

  Primary: Reflects whether or not a services is primary or secondary.

This patch also introduces new methods to GattCharacteristic1 and
GattDescriptor1 for reading and writing the corresponding attribute
values and a new signal for being notified of received notifications and
indications.

The "Value" D-Bus property is removed from both interfaces
and replaced with asynchronous ReadValue and WriteValue functions. This
is due to the fact that DBus.Properties.Get is synchronous and without
an asynchronous way of issuing a GATT value read request, there are
cases where a single read and cache based approach becomes limiting
(e.g. when a characteristic allows reads but no notifications) and
relying on the PropertyChanged signal to retrieve the value of a read
request asynchonously as well as to signal notifications/indications
makes for a vague API.
---
 doc/gatt-api.txt | 124 +++++++++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 112 insertions(+), 12 deletions(-)

diff --git a/doc/gatt-api.txt b/doc/gatt-api.txt
index 8c7975c..f7125a2 100644
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
@@ -48,6 +67,50 @@ Service		org.bluez
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
+					 org.bluez.Error.NotAuthorized
+					 org.bluez.Error.NotPaired
+					 org.bluez.Error.NotSupported
+
+		void WriteValue(array{byte} value)
+
+			Issues a request to write the value of the
+			characteristic.
+
+			Possible Errors: org.bluez.Error.Failed
+					 org.bluez.Error.InProgress
+					 org.bluez.Error.WriteNotPermitted
+					 org.bluez.Error.InvalidValueLength
+					 org.bluez.Error.NotAuthorized
+					 org.bluez.Error.NotPaired
+					 org.bluez.Error.NotSupported
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
 Properties	string UUID [read-only]
 
 			128-bit characteristic UUID.
@@ -57,12 +120,19 @@ Properties	string UUID [read-only]
 			Object path of the GATT service the characteristc
 			belongs to.
 
-		array{byte} Value [read-write]
+		array{byte} Value [read-only, optional]
+
+			The cached value of the characteristic. This property
+			gets updated only after a successful read request and
+			when a notification or indication is received, upon
+			which a PropertiesChanged signal will be emitted.
 
-			Value read from the remote Bluetooth device or from
-			the external application implementing GATT services.
+		boolean Notifying [read-only]
 
-		array{string} Flags [read-only, optional]
+			True, if notifications or indications on this
+			characteristic are currently enabled.
+
+		array{string} Flags [read-only]
 
 			Defines how the characteristic value can be used. See
 			Core spec "Table 3.5: Characteristic Properties bit
@@ -79,6 +149,14 @@ Properties	string UUID [read-only]
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
@@ -89,6 +167,32 @@ Service		org.bluez
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
+					 org.bluez.Error.NotAuthorized
+					 org.bluez.Error.NotPaired
+					 org.bluez.Error.NotSupported
+
+		void WriteValue(array{byte} value)
+
+			Issues a request to write the value of the
+			characteristic.
+
+			Possible Errors: org.bluez.Error.Failed
+					 org.bluez.Error.InProgress
+					 org.bluez.Error.WriteNotPermitted
+					 org.bluez.Error.InvalidValueLength
+					 org.bluez.Error.NotAuthorized
+					 org.bluez.Error.NotPaired
+					 org.bluez.Error.NotSupported
+
 Properties	string UUID [read-only]
 
 			128-bit descriptor UUID.
@@ -98,16 +202,12 @@ Properties	string UUID [read-only]
 			Object path of the GATT characteristc the descriptor
 			belongs to.
 
-		array{byte} Value [read-write]
-
-			Raw characteristic descriptor value read from the
-			remote Bluetooth device or from the external
-			application implementing GATT services.
+		array{byte} Value [read-only, optional]
 
-		string Permissions [read-only]: To be defined
+			The cached value of the descriptor. This property
+			gets updated only after a successful read request, upon
+			which a PropertiesChanged signal will be emitted.
 
-			Defines read/write authentication and authorization
-			requirements.
 
 Service Manager hierarchy
 =============================
-- 
2.0.0.526.g5318336

