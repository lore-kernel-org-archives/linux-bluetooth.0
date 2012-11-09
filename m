Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Subject: [PATCH 15/15] test: Update test-thermometer for DBus.Properties
Date: Fri, 9 Nov 2012 09:55:57 +0100
Message-ID: <1352451357-22097-16-git-send-email-andrzej.kaczmarek@tieto.com>
In-Reply-To: <1352451357-22097-1-git-send-email-andrzej.kaczmarek@tieto.com>
References: <1352451357-22097-1-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 test/test-thermometer | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/test/test-thermometer b/test/test-thermometer
index 2ca260f..d56a8b2 100755
--- a/test/test-thermometer
+++ b/test/test-thermometer
@@ -29,9 +29,9 @@ class Watcher(dbus.service.Object):
 		if "Type" in measure:
 			print("Type: ", measure["Type"])
 
-def property_changed(name, value):
-
-	print("PropertyChanged('%s', '%s')" % (name, value))
+def properties_changed(interface, changed, invalidated):
+	for name, value in changed.iteritems():
+		print("Property %s changed:  %s" % (name, str(value)))
 
 if __name__ == "__main__":
 	dbus.mainloop.glib.DBusGMainLoop(set_as_default=True)
@@ -71,9 +71,10 @@ if __name__ == "__main__":
 
 	device_path = adapter.FindDevice(options.address)
 
-	bus.add_signal_receiver(property_changed, bus_name="org.bluez",
-				dbus_interface="org.bluez.Thermometer",
-				signal_name="PropertyChanged")
+	bus.add_signal_receiver(properties_changed, bus_name="org.bluez",
+			path=device_path,
+			dbus_interface="org.freedesktop.DBus.Properties",
+			signal_name="PropertiesChanged")
 
 	path = "/test/watcher"
 	watcher = Watcher(bus, path)
-- 
1.8.0

