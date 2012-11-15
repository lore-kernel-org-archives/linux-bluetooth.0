Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [RFC v1 09/16] test: Update test-manager script to ObjectManager
Date: Thu, 15 Nov 2012 16:09:12 +0100
Message-Id: <1352992159-11559-10-git-send-email-mikel.astiz.oss@gmail.com>
In-Reply-To: <1352992159-11559-1-git-send-email-mikel.astiz.oss@gmail.com>
References: <1352992159-11559-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

Make the script compatible with the new API provided by the
ObjectManager and Properties interfaces.
---
 test/test-manager | 33 +++++++++++++++++++++++----------
 1 file changed, 23 insertions(+), 10 deletions(-)

diff --git a/test/test-manager b/test/test-manager
index 2a9c1e9..e35db83 100755
--- a/test/test-manager
+++ b/test/test-manager
@@ -7,14 +7,20 @@ from gi.repository import GObject
 import dbus
 import dbus.mainloop.glib
 
-def adapter_added(path):
-	print("Adapter with path %s added" % (path))
+def property_changed(interface, changed, invalidated, path):
+	if interface != "org.bluez.Manager":
+		return
+	path = changed.get("DefaultAdapter")
+	if path != None:
+		print("Default adapter is now at path %s" % (path))
 
-def adapter_removed(path):
-	print("Adapter with path %s removed" % (path))
+def interfaces_added(path, interfaces):
+	if interfaces.get("org.bluez.Adapter") != None:
+		print("Adapter with path %s added" % (path))
 
-def default_changed(path):
-	print("Default adapter is now at path %s" % (path))
+def interfaces_removed(path, interfaces):
+	if "org.bluez.Adapter" in interfaces:
+		print("Adapter with path %s removed" % (path))
 
 if __name__ == "__main__":
 	dbus.mainloop.glib.DBusGMainLoop(set_as_default=True)
@@ -24,15 +30,22 @@ if __name__ == "__main__":
 	manager = dbus.Interface(bus.get_object('org.bluez', '/org/bluez'),
 							'org.bluez.Manager')
 
-	manager.connect_to_signal("AdapterAdded", adapter_added)
+	bus.add_signal_receiver(property_changed, bus_name="org.bluez",
+			dbus_interface="org.freedesktop.DBus.Properties",
+			signal_name="PropertiesChanged",
+			path_keyword="path")
 
-	manager.connect_to_signal("AdapterRemoved", adapter_removed)
+	bus.add_signal_receiver(interfaces_added, bus_name="org.bluez",
+			dbus_interface="org.freedesktop.DBus.ObjectManager",
+			signal_name="InterfacesAdded")
 
-	manager.connect_to_signal("DefaultAdapterChanged", default_changed)
+	bus.add_signal_receiver(interfaces_removed, bus_name="org.bluez",
+			dbus_interface="org.freedesktop.DBus.ObjectManager",
+			signal_name="InterfacesRemoved")
 
 	try:
 		path = manager.FindAdapter("default")
-		default_changed(path)
+		print("Default adapter is now at path %s" % (path))
 	except:
 		pass
 
-- 
1.7.11.7

