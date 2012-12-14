Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 10/13] proximity: Append version to Proximity interfaces
Date: Fri, 14 Dec 2012 11:13:04 +0200
Message-Id: <1355476387-2165-10-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1355476387-2165-1-git-send-email-luiz.dentz@gmail.com>
References: <1355476387-2165-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 doc/proximity-api.txt         |  4 ++--
 profiles/proximity/monitor.c  |  2 +-
 profiles/proximity/reporter.h |  2 +-
 test/test-proximity           | 15 +++++++++------
 4 files changed, 13 insertions(+), 10 deletions(-)

diff --git a/doc/proximity-api.txt b/doc/proximity-api.txt
index b68a4fe..4719428 100644
--- a/doc/proximity-api.txt
+++ b/doc/proximity-api.txt
@@ -8,7 +8,7 @@ Proximity Monitor hierarchy
 ===========================
 
 Service		org.bluez
-Interface	org.bluez.ProximityMonitor
+Interface	org.bluez.ProximityMonitor1
 Object path	[variable prefix]/{hci0,hci1,...}/dev_XX_XX_XX_XX_XX_XX
 
 Properties	string SignalLevel [readonly]
@@ -40,7 +40,7 @@ Shared service used by Proximity Path Loss and Find Me. Allows per device
 alert level handling.
 
 Service		org.bluez
-Interface	org.bluez.ProximityReporter
+Interface	org.bluez.ProximityReporter1
 Object path	[variable prefix]/{hci0,hci1,...}/dev_XX_XX_XX_XX_XX_XX
 
 Properties	string ImmediateAlertLevel [readonly]
diff --git a/profiles/proximity/monitor.c b/profiles/proximity/monitor.c
index 023de72..d9ed3ff 100644
--- a/profiles/proximity/monitor.c
+++ b/profiles/proximity/monitor.c
@@ -50,7 +50,7 @@
 #include "monitor.h"
 #include "textfile.h"
 
-#define PROXIMITY_INTERFACE "org.bluez.ProximityMonitor"
+#define PROXIMITY_INTERFACE "org.bluez.ProximityMonitor1"
 
 #define ALERT_LEVEL_CHR_UUID 0x2A06
 #define POWER_LEVEL_CHR_UUID 0x2A07
diff --git a/profiles/proximity/reporter.h b/profiles/proximity/reporter.h
index 480c668..6a7066d 100644
--- a/profiles/proximity/reporter.h
+++ b/profiles/proximity/reporter.h
@@ -22,7 +22,7 @@
  *
  */
 
-#define PROXIMITY_REPORTER_INTERFACE "org.bluez.ProximityReporter"
+#define PROXIMITY_REPORTER_INTERFACE "org.bluez.ProximityReporter1"
 
 #define IMMEDIATE_ALERT_SVC_UUID	0x1802
 #define LINK_LOSS_SVC_UUID		0x1803
diff --git a/test/test-proximity b/test/test-proximity
index d6862de..0cbf315 100755
--- a/test/test-proximity
+++ b/test/test-proximity
@@ -14,8 +14,11 @@ import dbus.mainloop.glib
 from optparse import OptionParser, make_option
 import bluezutils
 
+BUS_NAME = 'org.bluez'
+PROXIMITY_MONITOR_INTERFACE = 'org.bluez.ProxymityMonitor1'
+
 def properties_changed(interface, changed, invalidated):
-	if interface != "org.bluez.ProximityMonitor":
+	if interface != PROXIMITY_MONITOR_INTERFACE:
 		return
 
 	for name, value in changed.iteritems():
@@ -45,19 +48,19 @@ if __name__ == "__main__":
 	device = bluezutils.find_device(options.address, options.dev_id)
 	device_path = device.object_path
 
-	bus.add_signal_receiver(properties_changed, bus_name="org.bluez",
+	bus.add_signal_receiver(properties_changed, bus_name=BUS_NAME,
 			path=device_path,
 			dbus_interface="org.freedesktop.DBus.Properties",
 			signal_name="PropertiesChanged")
 
-	proximity = dbus.Interface(bus.get_object("org.bluez",
-					device_path), "org.bluez.ProximityMonitor")
+	proximity = dbus.Interface(bus.get_object(BUS_NAME, device_path),
+						PROXIMITY_MONITOR_INTERFACE)
 
-	device_prop = dbus.Interface(bus.get_object("org.bluez", device_path),
+	device_prop = dbus.Interface(bus.get_object(BUS_NAME, device_path),
 					"org.freedesktop.DBus.Properties")
 
 	print("Proximity SetProperty('%s', '%s')" % (args[0], args[1]))
-	device_prop.Set("org.bluez.ProximityMonitor", args[0], args[1])
+	device_prop.Set(PROXIMITY_MONITOR_INTERFACE, args[0], args[1])
 
 	mainloop = gobject.MainLoop()
 	mainloop.run()
-- 
1.7.11.7

