Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Arman Uguray <armansito@chromium.org>
Subject: [PATCH BlueZ v1 04/17] doc/gatt-api.txt: New ObjectManager requirements
Date: Wed, 25 Feb 2015 21:13:17 -0800
Message-Id: <1424927610-26226-5-git-send-email-armansito@chromium.org>
In-Reply-To: <1424927610-26226-1-git-send-email-armansito@chromium.org>
References: <1424927610-26226-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

After some discussion it was decided to require an ObjectManager
interface implementation on a per-service basis to reduce the
overhead of heaving to process and cache potentially many non-GATT
related objects. This patch updates the documentation to reflect this.
---
 doc/gatt-api.txt | 74 +++++++++++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 62 insertions(+), 12 deletions(-)

diff --git a/doc/gatt-api.txt b/doc/gatt-api.txt
index 67938d0..088d285 100644
--- a/doc/gatt-api.txt
+++ b/doc/gatt-api.txt
@@ -8,7 +8,9 @@ application. Remote refers to GATT services exported by the peer.
 BlueZ acts as a proxy, translating ATT operations to D-Bus method calls and
 Properties (or the opposite). Support for D-Bus Object Manager is mandatory for
 external services to allow seamless GATT declarations (Service, Characteristic
-and Descriptors) discovery.
+and Descriptors) discovery. Each GATT service tree is required to export a D-Bus
+Object Manager at its root that is solely responsible for the objects that
+belong to that service.
 
 Releasing a registered GATT service is not defined yet. Any API extension
 should avoid breaking the defined API, and if possible keep an unified GATT
@@ -229,12 +231,63 @@ Methods		void Release()
 GATT Manager hierarchy
 ======================
 
-GATT Manager allows external applications to register GATT based
-services. Services must follow the API for Service and Characteristic
-described above.
-
-Local GATT services, characteristics and characteristic descriptors are
-discovered automatically using the D-Bus Object Manager interface.
+GATT Manager allows external applications to register GATT services and
+profiles.
+
+Registering a profile allows applications to subscribe to *remote* services.
+These must implement the GattProfile1 interface defined above.
+
+Registering a service allows applications to publish a *local* GATT service,
+which then becomes available to remote devices. A GATT service is represented by
+a D-Bus object hierarchy where the root node corresponds to a service and the
+child nodes represent characteristics and descriptors that belong to that
+service. Each node must implement one of GattService1, GattCharacteristic1,
+or GattDescriptor1 interfaces described above, based on the attribute it
+represents. Each node must also implement the standard D-Bus Properties
+interface to expose their properties. These objects collectively represent a
+GATT service definition.
+
+To make service registration simple, BlueZ requires that all objects that belong
+to a GATT service be grouped under a D-Bus Object Manager that solely manages
+the objects of that service. Hence, the standard DBus.ObjectManager interface
+must be available on the root service path. An example application hierarchy
+containing two separate GATT services may look like this:
+
+-> /com/example
+  |
+  -> /com/example/service0
+  | |   - org.freedesktop.DBus.ObjectManager
+  | |   - org.freedesktop.DBus.Properties
+  | |   - org.bluez.GattService1
+  | |
+  | -> /com/example/service0/char0
+  | |     - org.freedesktop.DBus.Properties
+  | |     - org.bluez.GattCharacteristic1
+  | |
+  | -> /com/example/service0/char1
+  |   |   - org.freedesktop.DBus.Properties
+  |   |   - org.bluez.GattCharacteristic1
+  |   |
+  |   -> /com/example/service0/char1/desc0
+  |       - org.freedesktop.DBus.Properties
+  |       - org.bluez.GattDescriptor1
+  |
+  -> /com/example/service1
+    |   - org.freedesktop.DBus.ObjectManager
+    |   - org.freedesktop.DBus.Properties
+    |   - org.bluez.GattService1
+    |
+    -> /com/example/service1/char0
+        - org.freedesktop.DBus.Properties
+        - org.bluez.GattCharacteristic1
+
+When a service is registered, BlueZ will automatically obtain information about
+all objects using the service's Object Manager. Once a service has been
+registered, the objects of a service should not be removed. If BlueZ receives an
+InterfacesRemoved signal from a service's Object Manager, it will immediately
+unregister the service. Similarly, if the application disconnects from the bus,
+all of its registered services will be automatically unregistered.
+InterfacesAdded signals will be ignored.
 
 Service		org.bluez
 Interface	org.bluez.GattManager1 [Experimental]
@@ -242,11 +295,8 @@ Object path	[variable prefix]/{hci0,hci1,...}
 
 Methods		void RegisterService(object service, dict options)
 
-			Registers remote application service exported under
-			interface GattService1. Characteristic objects must
-			be hierarchical to their service and must use the
-			interface GattCharacteristic1. D-Bus Object Manager
-			is used to fetch the exported objects.
+			Registers a local GATT service hierarchy as described
+			above.
 
 			"service" object path together with the D-Bus system
 			bus connection ID define the identification of the
-- 
2.2.0.rc0.207.ga3a616c

