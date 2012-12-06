Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: johan.hedberg@gmail.com, Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [PATCH] test: Fix test-device using wrong interface
Date: Thu,  6 Dec 2012 14:34:43 +0100
Message-Id: <1354800883-31456-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

The property getter and setter belong to org.freedesktop.DBus.Properties
and therefore fix this code using the wrong interface since commit
67dab2d2aeec9ab895da6afd528ec0c63e657ff4.
---
 test/test-device | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/test/test-device b/test/test-device
index 655eeae..2be5394 100755
--- a/test/test-device
+++ b/test/test-device
@@ -140,9 +140,10 @@ if (args[0] == "class"):
 		print("Need address parameter")
 	else:
 		device = bluezutils.find_device(args[1], options.dev_id)
-		device = dbus.Interface(bus.get_object("org.bluez", path),
+		path = device.object_path
+		props = dbus.Interface(bus.get_object("org.bluez", path),
 					"org.freedesktop.DBus.Properties")
-		cls = device.Get("org.bluez.Device1", "Class")
+		cls = props.Get("org.bluez.Device1", "Class")
 		print("0x%06x" % cls)
 	sys.exit(0)
 
@@ -167,10 +168,10 @@ if (args[0] == "alias"):
 		props = dbus.Interface(bus.get_object("org.bluez", path),
 					"org.freedesktop.DBus.Properties")
 		if (len(args) < 3):
-			alias = device.Get("org.bluez.Device1", "Alias")
+			alias = props.Get("org.bluez.Device1", "Alias")
 			print(alias)
 		else:
-			device.Set("org.bluez.Device1", "Alias", args[2])
+			props.Set("org.bluez.Device1", "Alias", args[2])
 	sys.exit(0)
 
 if (args[0] == "trusted"):
@@ -182,7 +183,7 @@ if (args[0] == "trusted"):
 		props = dbus.Interface(bus.get_object("org.bluez", path),
 					"org.freedesktop.DBus.Properties")
 		if (len(args) < 3):
-			trusted = device.Get("org.bluez.Device1", "Trusted")
+			trusted = props.Get("org.bluez.Device1", "Trusted")
 			print(trusted)
 		else:
 			if (args[2] == "yes"):
@@ -191,7 +192,7 @@ if (args[0] == "trusted"):
 				value = dbus.Boolean(0)
 			else:
 				value = dbus.Boolean(args[2])
-			device.Set("org.bluez.Device1", "Trusted", value)
+			props.Set("org.bluez.Device1", "Trusted", value)
 	sys.exit(0)
 
 if (args[0] == "blocked"):
@@ -203,7 +204,7 @@ if (args[0] == "blocked"):
 		props = dbus.Interface(bus.get_object("org.bluez", path),
 					"org.freedesktop.DBus.Properties")
 		if (len(args) < 3):
-			blocked = device.Get("org.bluez.Device1", "Blocked")
+			blocked = props.Get("org.bluez.Device1", "Blocked")
 			print(blocked)
 		else:
 			if (args[2] == "yes"):
@@ -212,7 +213,7 @@ if (args[0] == "blocked"):
 				value = dbus.Boolean(0)
 			else:
 				value = dbus.Boolean(args[2])
-			device.Set("org.bluez.Device1", "Blocked", value)
+			props.Set("org.bluez.Device1", "Blocked", value)
 	sys.exit(0)
 
 if (args[0] == "services"):
@@ -223,7 +224,7 @@ if (args[0] == "services"):
 		path = device.object_path
 		props = dbus.Interface(bus.get_object("org.bluez", path),
 					"org.freedesktop.DBus.Properties")
-		services = device.Get("org.bluez.Device1", "Services")
+		services = props.Get("org.bluez.Device1", "Services")
 		for path in services:
 			print(path)
 	sys.exit(0)
-- 
1.7.11.7

