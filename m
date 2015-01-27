Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Arman Uguray <armansito@chromium.org>
Subject: [RFC BlueZ] doc/gatt-api.txt: Add GattProfile1 API
Date: Tue, 27 Jan 2015 12:26:20 -0800
Message-Id: <1422390380-26000-2-git-send-email-armansito@chromium.org>
In-Reply-To: <1422390380-26000-1-git-send-email-armansito@chromium.org>
References: <1422390380-26000-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds the definition for the GattProfile1 and
GattProfileManager1 D-Bus interfaces. This API allows applications to
publish local GATT services for the server-role and manage client-role
configurations and behavior, such as auto-connects, GATT connection
life-time, subscribing to notifications/indications, etc.

Change-Id: I26c20b6db9ad01c8dcf7ad3d2d03913117505963
---
 doc/gatt-api.txt | 158 ++++++++++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 132 insertions(+), 26 deletions(-)

diff --git a/doc/gatt-api.txt b/doc/gatt-api.txt
index bfeaf6d..8a64467 100644
--- a/doc/gatt-api.txt
+++ b/doc/gatt-api.txt
@@ -205,41 +205,147 @@ Properties	string UUID [read-only]
 			which a PropertiesChanged signal will be emitted.
 
 
-Service Manager hierarchy
-=============================
+GATT Profile Manager hierarchy
+==============================
 
-Service Manager allows external applications to register GATT based
-services. Services must follow the API for Service and Characteristic
-described above.
-
-Local GATT services, characteristics and characteristic descriptors are
-discovered automatically using the D-Bus Object Manager interface.
+GATT Profile Manager allows external applications to implement a GATT-based
+profile. An application may choose to implement one or more GATT services and
+publish them in the local database in the server role or it may be interested in
+remote GATT services in the client role.
 
 Service		org.bluez
-Interface	org.bluez.GattManager1 [Experimental]
+Interface	org.bluez.GattProfileManager1 [Experimental]
 Object path	/org/bluez
 
-Methods		RegisterService(object service, dict options)
+Methods		void RegisterProfile(object profile, dict options)
 
-			Registers remote application service exported under
-			interface GattService1. Characteristic objects must
-			be hierarchical to their service and must use the
-			interface GattCharacteristic1. D-Bus Object Manager
-			is used to fetch the exported objects.
+			Registers a profile implementation.
 
-			"service" object path together with the D-Bus system
-			bus connection ID define the identification of the
-			application registering a GATT based service.
+			If an application disconnects from the bus all of its
+			registered profiles will be removed.
 
-			Possible errors: org.bluez.Error.InvalidArguments
-					 org.bluez.Error.AlreadyExists
+			Available options:
+
+				string Role
+
+					Specifies which specific profile role
+					is implemented by the application.
+					The value of this option determines
+					which other options are mandatory.
+
+					Possible values: "client", "server"
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
+
+					Required for the "server" role. Not
+					allowed in "client" role.
+
+				array{object} Services
+
+					List of exported object paths that
+					implement the GattService1 interface
+					hierarchy. These services are
+					implemented by the application and will
+					be published in the local attribute
+					database.
+
+					Required for the "server" role. Not
+					allowed in "client" role.
+
+				array{string} UUIDs
+
+					List of remote service UUIDs that the
+					application wants to access. The
+					application will be notified for each
+					GATT service discovered on a remote
+					device that matches one of these UUIDs.
+
+					Required for the "client" role. Not
+					allowed in "server" role.
+
+				string AdvertisedUUID
+
+					The service UUID that should be
+					advertised when the local host is in
+					LE advertising mode while in the LE
+					peripheral role. This will be ignored,
+					if a sufficient number of UUIDs are
+					already set for advertising.
 
-		UnregisterService(object service)
+					Optional for the "server" role. Not
+					allowed in "client" role.
 
-			This unregisters the service that has been
-			previously registered. The object path parameter
-			must match the same value that has been used
-			on registration.
+				boolean AutoConnect
+
+					If a device is found that contains one
+					or more of the desired remote UUIDs, it
+					will be automatically connected to.
+
+					Optional for the "client" role. Not
+					allowed in "server" role.
+
+				array{string} NotifyUUIDs
+
+					List of GATT characteristic UUIDs that
+					the application is interested in
+					receiving notifications/indications
+					from. If any of these characteristics
+					are discovered in a remote device and
+					they support notifications/indications,
+					they will be immediately enabled.
+
+					Optional for the "client" role. Not
+					allowed in the "server" role.
 
 			Possible errors: org.bluez.Error.InvalidArguments
-					 org.bluez.Error.DoesNotExist
+			                 org.bluez.Error.AlreadyExists
+
+		void UnregisterProfile(object profile)
+
+			Unregister a profile that has been previously
+			registered. The object path parameter must match the
+			same value that has been used on registration. If the
+			profile is in the server role, all of its published GATT
+			services will be removed from the database.
+
+			Possible errors: org.bluez.Error.DoesNotExist
+
+
+GATT Profile hierarchy
+======================
+
+Represents a GATT-based profile implemented by an external application in either
+the server or client role. A profile can publish one or more local GATT services
+or may be interact with GATT services found on a remote device.
+
+Service		unique name
+Interface	org.bluez.GattProfile1 [Experimental]
+Object path	freely definable
+
+Methods		void NewClientConfiguration(object characteristic,
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
+			Possible errors: org.bluez.NotAuthorized
+					 org.bluez.NotPaired
+					 org.bluez.NotSupported
-- 
2.2.0.rc0.207.ga3a616c

