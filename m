Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Arman Uguray <armansito@chromium.org>
Subject: [RFC BlueZ v1] doc/gatt-api.txt: Updates to GattManager1
Date: Tue, 27 Jan 2015 15:08:53 -0800
Message-Id: <1422400133-2222-2-git-send-email-armansito@chromium.org>
In-Reply-To: <1422400133-2222-1-git-send-email-armansito@chromium.org>
References: <1422400133-2222-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch modifies GATT D-Bus API with minor additions for server-role.
Renamed GattManager1 to GattServerManager1 for clarity, added new
fields to the "options" argument to RegisterService and introduced the
NewClientConfiguration method for server-side GattCharacteristic1
implementations.

Change-Id: I298d286380941471b387846bf33288847f1ccee5
---
 doc/gatt-api.txt | 86 +++++++++++++++++++++++++++++++++++++++-----------------
 1 file changed, 60 insertions(+), 26 deletions(-)

diff --git a/doc/gatt-api.txt b/doc/gatt-api.txt
index bfeaf6d..513d398 100644
--- a/doc/gatt-api.txt
+++ b/doc/gatt-api.txt
@@ -109,6 +109,27 @@ Methods		array{byte} ReadValue()
 
 			Possible Errors: org.bluez.Error.Failed
 
+		void NewClientConfiguration(object characteristic,
+							string device_address,
+							array{byte} value)
+
+			This method gets called when a remote device with BDADDR
+			|device_address| in the GATT client role writes to the
+			Client Characteristic Configuration descriptor of
+			the characteristic with object path |characteristic|,
+			which was exported by this profile.
+
+			The profile can use this to maintain a mapping of
+			clients that have configured the characteristic and
+			update its state based on the configuration value
+			|value|.
+
+			Local characteristics only.
+
+			Possible errors: org.bluez.NotAuthorized
+					 org.bluez.NotPaired
+					 org.bluez.NotSupported
+
 Properties	string UUID [read-only]
 
 			128-bit characteristic UUID.
@@ -205,41 +226,54 @@ Properties	string UUID [read-only]
 			which a PropertiesChanged signal will be emitted.
 
 
-Service Manager hierarchy
-=============================
-
-Service Manager allows external applications to register GATT based
-services. Services must follow the API for Service and Characteristic
-described above.
+GATT Service Manager hierarchy
+==============================
 
-Local GATT services, characteristics and characteristic descriptors are
-discovered automatically using the D-Bus Object Manager interface.
+GATT Service Manager allows external applications to implement local GATT-based
+services. An application may choose to implement one or more GATT services in
+the form of org.bluez.GattService1 object hierarchies and publish them in the
+local database in the server-role.
 
 Service		org.bluez
-Interface	org.bluez.GattManager1 [Experimental]
+Interface	org.bluez.GattServiceManager1 [Experimental]
 Object path	/org/bluez
 
-Methods		RegisterService(object service, dict options)
+Methods		void RegisterService(object service, dict options)
 
-			Registers remote application service exported under
-			interface GattService1. Characteristic objects must
-			be hierarchical to their service and must use the
-			interface GattCharacteristic1. D-Bus Object Manager
-			is used to fetch the exported objects.
+			Registers a GattService1 hierarchy.
 
-			"service" object path together with the D-Bus system
-			bus connection ID define the identification of the
-			application registering a GATT based service.
+			If an application disconnects from the bus all of its
+			registered services will be removed.
 
-			Possible errors: org.bluez.Error.InvalidArguments
-					 org.bluez.Error.AlreadyExists
+			Available options:
+
+				object ObjectManager
+
+					Specifies the object path to the node
+					that implements the
+					org.freedesktop.DBus.ObjectManager
+					interface for this application. This
+					must be the object manager that manages
+					the GattService1 objects. This is used
+					by BlueZ to monitor when services get
+					added and removed.
 
-		UnregisterService(object service)
+				bool Advertised
 
-			This unregisters the service that has been
-			previously registered. The object path parameter
-			must match the same value that has been used
-			on registration.
+					Indicates whether or not this service
+					UUID should be advertised when the local
+					host has LE advertising enabled. This
+					will be ignored, if a sufficient number
+					of UUIDs have already been set for
+					advertising.
 
 			Possible errors: org.bluez.Error.InvalidArguments
-					 org.bluez.Error.DoesNotExist
+			                 org.bluez.Error.AlreadyExists
+
+		void UnregisterProfile(object profile)
+
+			Unregister a GattService1 hierarchy that has been
+			previously registered. The object path parameter must
+			match the same value that was used on registration.
+
+			Possible errors: org.bluez.Error.DoesNotExist
-- 
2.2.0.rc0.207.ga3a616c

