Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 1/4] doc/gatt-api: Make proper use of ObjectManager
Date: Tue,  5 Jan 2016 14:54:35 -0300
Message-Id: <1452016478-17221-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

ObjectManager path shall not contain other intefaces in its root path, only
child objects shall be included with many bindings following this.

Due to this limitation and also the fact that application might actually
have a single ObjectManager path so all services can be registered at
once.
---
 doc/gatt-api.txt | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/doc/gatt-api.txt b/doc/gatt-api.txt
index d832c73..f1940ba 100644
--- a/doc/gatt-api.txt
+++ b/doc/gatt-api.txt
@@ -270,9 +270,9 @@ must be available on the root service path. An example application hierarchy
 containing two separate GATT services may look like this:
 
 -> /com/example
+  |   - org.freedesktop.DBus.ObjectManager
   |
   -> /com/example/service0
-  | |   - org.freedesktop.DBus.ObjectManager
   | |   - org.freedesktop.DBus.Properties
   | |   - org.bluez.GattService1
   | |
@@ -289,7 +289,6 @@ containing two separate GATT services may look like this:
   |       - org.bluez.GattDescriptor1
   |
   -> /com/example/service1
-    |   - org.freedesktop.DBus.ObjectManager
     |   - org.freedesktop.DBus.Properties
     |   - org.bluez.GattService1
     |
@@ -309,21 +308,21 @@ Service		org.bluez
 Interface	org.bluez.GattManager1 [Experimental]
 Object path	[variable prefix]/{hci0,hci1,...}
 
-Methods		void RegisterService(object service, dict options)
+Methods		void RegisterApplication(object application, dict options)
 
-			Registers a local GATT service hierarchy as described
+			Registers a local GATT services hierarchy as described
 			above.
 
-			"service" object path together with the D-Bus system
-			bus connection ID define the identification of the
-			application registering a GATT based service.
+			The application object path together with the D-Bus
+			system bus connection ID define the identification of
+			the application registering a GATT based service.
 
 			Possible errors: org.bluez.Error.InvalidArguments
 					 org.bluez.Error.AlreadyExists
 
-		void UnregisterService(object service)
+		void UnregisterApplication(object application)
 
-			This unregisters the service that has been
+			This unregisters the services that has been
 			previously registered. The object path parameter
 			must match the same value that has been used
 			on registration.
-- 
2.4.3

