Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [RFC v2 05/15] test: Update test-manager script to ObjectManager
Date: Thu, 29 Nov 2012 13:47:26 +0100
Message-Id: <1354193256-30610-6-git-send-email-mikel.astiz.oss@gmail.com>
In-Reply-To: <1354193256-30610-1-git-send-email-mikel.astiz.oss@gmail.com>
References: <1354193256-30610-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

Make the script compatible with the new API provided by the
ObjectManager interface.
---
 test/test-manager | 30 ++++++++++++++----------------
 1 file changed, 14 insertions(+), 16 deletions(-)

diff --git a/test/test-manager b/test/test-manager
index b3ecc6d..e5d23d0 100755
--- a/test/test-manager
+++ b/test/test-manager
@@ -8,34 +8,32 @@ import dbus
 import dbus.mainloop.glib
 import testutils
 
-def adapter_added(path):
-	print("Adapter with path %s added" % (path))
+def interfaces_added(path, interfaces):
+	if interfaces.get("org.bluez.Adapter") != None:
+		print("Adapter with path %s added" % (path))
 
-def adapter_removed(path):
-	print("Adapter with path %s removed" % (path))
-
-def default_changed(path):
-	print("Default adapter is now at path %s" % (path))
+def interfaces_removed(path, interfaces):
+	if "org.bluez.Adapter" in interfaces:
+		print("Adapter with path %s removed" % (path))
 
 if __name__ == "__main__":
 	dbus.mainloop.glib.DBusGMainLoop(set_as_default=True)
 
 	bus = dbus.SystemBus()
 
-	manager = dbus.Interface(bus.get_object('org.bluez', '/'),
-							'org.bluez.Manager')
-
-	manager.connect_to_signal("AdapterAdded", adapter_added)
-
-	manager.connect_to_signal("AdapterRemoved", adapter_removed)
+	bus.add_signal_receiver(interfaces_added, bus_name="org.bluez",
+			dbus_interface="org.freedesktop.DBus.ObjectManager",
+			signal_name="InterfacesAdded")
 
-	manager.connect_to_signal("DefaultAdapterChanged", default_changed)
+	bus.add_signal_receiver(interfaces_removed, bus_name="org.bluez",
+			dbus_interface="org.freedesktop.DBus.ObjectManager",
+			signal_name="InterfacesRemoved")
 
 	try:
 		path = testutils.find_adapter().object_path
-		default_changed(path)
+		print("Adapter found at path %s" % (path))
 	except:
-		pass
+		print("No adapter found")
 
 	mainloop = GObject.MainLoop()
 	mainloop.run()
-- 
1.7.11.7

