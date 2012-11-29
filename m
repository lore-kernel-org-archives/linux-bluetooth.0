Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [RFC v2 04/15] test: Update monitor script to ObjectManager
Date: Thu, 29 Nov 2012 13:47:25 +0100
Message-Id: <1354193256-30610-5-git-send-email-mikel.astiz.oss@gmail.com>
In-Reply-To: <1354193256-30610-1-git-send-email-mikel.astiz.oss@gmail.com>
References: <1354193256-30610-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

Make the script compatible with the new API provided by the
ObjectManager and Properties interfaces.
---
 test/monitor-bluetooth | 68 +++++++++++++++++++++++---------------------------
 1 file changed, 31 insertions(+), 37 deletions(-)

diff --git a/test/monitor-bluetooth b/test/monitor-bluetooth
index 4a598e1..45cc910 100755
--- a/test/monitor-bluetooth
+++ b/test/monitor-bluetooth
@@ -7,15 +7,28 @@ import gobject
 import dbus
 import dbus.mainloop.glib
 
-def property_changed(name, value, path, interface):
-	iface = interface[interface.rfind(".") + 1:]
-	val = str(value)
-	print("{%s.PropertyChanged} [%s] %s = %s" % (iface, path, name, val))
+relevant_ifaces = [ "org.bluez.Adapter", "org.bluez.Device" ]
 
-def object_signal(value, path, interface, member):
+def property_changed(interface, changed, invalidated, path):
 	iface = interface[interface.rfind(".") + 1:]
-	val = str(value)
-	print("{%s.%s} [%s] Path = %s" % (iface, member, path, val))
+	for name, value in changed.iteritems():
+		val = str(value)
+		print("{%s.PropertyChanged} [%s] %s = %s" % (iface, path, name,
+									val))
+
+def interfaces_added(path, interfaces):
+	for iface, props in interfaces.iteritems():
+		if not(iface in relevant_ifaces):
+			continue
+		print("{Added %s} [%s]" % (iface, path))
+		for name, value in props.iteritems():
+			print("      %s = %s" % (name, value))
+
+def interfaces_removed(path, interfaces):
+	for iface in interfaces:
+		if not(iface in relevant_ifaces):
+			continue
+		print("{Removed %s} [%s]" % (iface, path))
 
 if __name__ == '__main__':
 	dbus.mainloop.glib.DBusGMainLoop(set_as_default=True)
@@ -23,36 +36,17 @@ if __name__ == '__main__':
 	bus = dbus.SystemBus()
 
 	bus.add_signal_receiver(property_changed, bus_name="org.bluez",
-					signal_name = "PropertyChanged",
-						path_keyword="path",
-						interface_keyword="interface")
-
-	bus.add_signal_receiver(object_signal, bus_name="org.bluez",
-					signal_name = "AdapterAdded",
-						path_keyword="path",
-						member_keyword="member",
-						interface_keyword="interface")
-	bus.add_signal_receiver(object_signal, bus_name="org.bluez",
-					signal_name = "AdapterRemoved",
-						path_keyword="path",
-						member_keyword="member",
-						interface_keyword="interface")
-	bus.add_signal_receiver(object_signal, bus_name="org.bluez",
-					signal_name = "DefaultAdapterChanged",
-						path_keyword="path",
-						member_keyword="member",
-						interface_keyword="interface")
-
-	bus.add_signal_receiver(object_signal, bus_name="org.bluez",
-					signal_name = "DeviceCreated",
-						path_keyword="path",
-						member_keyword="member",
-						interface_keyword="interface")
-	bus.add_signal_receiver(object_signal, bus_name="org.bluez",
-					signal_name = "DeviceRemoved",
-						path_keyword="path",
-						member_keyword="member",
-						interface_keyword="interface")
+			dbus_interface="org.freedesktop.DBus.Properties",
+			signal_name="PropertiesChanged",
+			path_keyword="path")
+
+	bus.add_signal_receiver(interfaces_added, bus_name="org.bluez",
+			dbus_interface="org.freedesktop.DBus.ObjectManager",
+			signal_name="InterfacesAdded")
+
+	bus.add_signal_receiver(interfaces_removed, bus_name="org.bluez",
+			dbus_interface="org.freedesktop.DBus.ObjectManager",
+			signal_name="InterfacesRemoved")
 
 	mainloop = gobject.MainLoop()
 	mainloop.run()
-- 
1.7.11.7

