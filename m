Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Subject: [PATCH 4/4] test: Update proximity test script
Date: Fri, 9 Nov 2012 13:33:21 +0100
Message-ID: <1352464401-12702-4-git-send-email-andrzej.kaczmarek@tieto.com>
In-Reply-To: <1352464401-12702-1-git-send-email-andrzej.kaczmarek@tieto.com>
References: <1352464401-12702-1-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 test/test-proximity | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/test/test-proximity b/test/test-proximity
index b08a62a..3cb98cc 100755
--- a/test/test-proximity
+++ b/test/test-proximity
@@ -13,10 +13,12 @@ import dbus
 import dbus.mainloop.glib
 from optparse import OptionParser, make_option
 
-def property_changed(name, value):
+def properties_changed(interface, changed, invalidated):
+	if interface != "org.bluez.ProximityMonitor":
+		return
 
-	print("PropertyChanged('%s', '%s')" % (name, value))
-	mainloop.quit()
+	for name, value in changed.iteritems():
+		print("Property %s changed:  %s" % (name, str(value)))
 
 if __name__ == "__main__":
 	dbus.mainloop.glib.DBusGMainLoop(set_as_default=True)
@@ -54,15 +56,19 @@ if __name__ == "__main__":
 
 	device_path = adapter.FindDevice(options.address)
 
-	bus.add_signal_receiver(property_changed, bus_name="org.bluez",
-				dbus_interface="org.bluez.ProximityMonitor",
-				signal_name="PropertyChanged")
+	bus.add_signal_receiver(properties_changed, bus_name="org.bluez",
+			path=device_path,
+			dbus_interface="org.freedesktop.DBus.Properties",
+			signal_name="PropertiesChanged")
 
 	proximity = dbus.Interface(bus.get_object("org.bluez",
 					device_path), "org.bluez.ProximityMonitor")
 
+	device_prop = dbus.Interface(bus.get_object("org.bluez", device_path),
+					"org.freedesktop.DBus.Properties")
+
 	print("Proximity SetProperty('%s', '%s')" % (args[0], args[1]))
-	proximity.SetProperty(args[0], args[1])
+	device_prop.Set("org.bluez.ProximityMonitor", args[0], args[1])
 
 	mainloop = gobject.MainLoop()
 	mainloop.run()
-- 
1.8.0

