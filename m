Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 05/13] thermometer: Append version to Thermometer interfaces
Date: Fri, 14 Dec 2012 11:12:59 +0200
Message-Id: <1355476387-2165-5-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1355476387-2165-1-git-send-email-luiz.dentz@gmail.com>
References: <1355476387-2165-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 doc/thermometer-api.txt            |  6 +++---
 profiles/thermometer/thermometer.c |  6 +++---
 src/bluetooth.conf                 |  2 +-
 test/test-thermometer              | 15 ++++++++++-----
 4 files changed, 17 insertions(+), 12 deletions(-)

diff --git a/doc/thermometer-api.txt b/doc/thermometer-api.txt
index cab115f..c7c8a5d 100644
--- a/doc/thermometer-api.txt
+++ b/doc/thermometer-api.txt
@@ -7,7 +7,7 @@ Health Thermometer Manager hierarchy
 ====================================
 
 Service		org.bluez
-Interface	org.bluez.ThermometerManager
+Interface	org.bluez.ThermometerManager1
 Object path	[variable prefix]/{hci0,hci1,...}
 
 Methods		RegisterWatcher(object agent)
@@ -44,7 +44,7 @@ Health Thermometer Profile hierarchy
 ====================================
 
 Service		org.bluez
-Interface	org.bluez.Thermometer
+Interface	org.bluez.Thermometer1
 Object path	[variable prefix]/{hci0,hci1,...}/dev_XX_XX_XX_XX_XX_XX
 
 
@@ -77,7 +77,7 @@ Health Thermometer Watcher hierarchy
 ====================================
 
 Service		unique name
-Interface	org.bluez.ThermometerWatcher
+Interface	org.bluez.ThermometerWatcher1
 Object path	freely definable
 
 Methods		void MeasurementReceived(dict measurement)
diff --git a/profiles/thermometer/thermometer.c b/profiles/thermometer/thermometer.c
index 537db99..15db33e 100644
--- a/profiles/thermometer/thermometer.c
+++ b/profiles/thermometer/thermometer.c
@@ -42,9 +42,9 @@
 #include "attrib/gatt.h"
 #include "thermometer.h"
 
-#define THERMOMETER_INTERFACE		"org.bluez.Thermometer"
-#define THERMOMETER_MANAGER_INTERFACE	"org.bluez.ThermometerManager"
-#define THERMOMETER_WATCHER_INTERFACE	"org.bluez.ThermometerWatcher"
+#define THERMOMETER_INTERFACE		"org.bluez.Thermometer1"
+#define THERMOMETER_MANAGER_INTERFACE	"org.bluez.ThermometerManager1"
+#define THERMOMETER_WATCHER_INTERFACE	"org.bluez.ThermometerWatcher1"
 
 /* Temperature measurement flag fields */
 #define TEMP_UNITS		0x01
diff --git a/src/bluetooth.conf b/src/bluetooth.conf
index 137e4e4..5750f49 100644
--- a/src/bluetooth.conf
+++ b/src/bluetooth.conf
@@ -15,7 +15,7 @@
     <allow send_interface="org.bluez.MediaEndpoint1"/>
     <allow send_interface="org.bluez.MediaPlayer1"/>
     <allow send_interface="org.bluez.Watcher"/>
-    <allow send_interface="org.bluez.ThermometerWatcher"/>
+    <allow send_interface="org.bluez.ThermometerWatcher1"/>
     <allow send_interface="org.bluez.AlertAgent"/>
     <allow send_interface="org.bluez.Profile1"/>
     <allow send_interface="org.bluez.HeartRateWatcher1"/>
diff --git a/test/test-thermometer b/test/test-thermometer
index fdb772f..6c143be 100755
--- a/test/test-thermometer
+++ b/test/test-thermometer
@@ -15,8 +15,13 @@ import dbus.mainloop.glib
 from optparse import OptionParser, make_option
 import bluezutils
 
+BUS_NAME = 'org.bluez'
+THERMOMETER_MANAGER_INTERFACE = 'org.bluez.ThermometerManager1'
+THERMOMETER_WATCHER_INTERFACE = 'org.bluez.ThermometerWatcher1'
+THERMOMETER_INTERFACE = 'org.bluez.Thermometer1'
+
 class Watcher(dbus.service.Object):
-	@dbus.service.method("org.bluez.ThermometerWatcher",
+	@dbus.service.method(THERMOMETER_WATCHER_INTERFACE,
 					in_signature="oa{sv}", out_signature="")
 	def MeasurementReceived(self, device, measure):
 		print("%s measurement received from %s" % (measure["Measurement"], device))
@@ -31,7 +36,7 @@ class Watcher(dbus.service.Object):
 			print("Type: ", measure["Type"])
 
 def properties_changed(interface, changed, invalidated):
-	if interface != "org.bluez.Thermometer":
+	if interface != THERMOMETER_INTERFACE:
 		return
 	for name, value in changed.iteritems():
 		print("Property %s changed:  %s" % (name, str(value)))
@@ -63,15 +68,15 @@ if __name__ == "__main__":
 								options.adapter)
 	adapter_path = adapter.object_path
 
-	thermometer_manager = dbus.Interface(bus.get_object("org.bluez",
-				adapter_path), "org.bluez.ThermometerManager")
+	thermometer_manager = dbus.Interface(bus.get_object(BUS_NAME,
+				adapter_path), THERMOMETER_MANAGER_INTERFACE)
 
 	device = bluezutils.find_device_in_objects(managed_objects,
 								options.address,
 								options.adapter)
 	device_path = device.object_path
 
-	bus.add_signal_receiver(properties_changed, bus_name="org.bluez",
+	bus.add_signal_receiver(properties_changed, bus_name=BUS_NAME,
 			path=device_path,
 			dbus_interface="org.freedesktop.DBus.Properties",
 			signal_name="PropertiesChanged")
-- 
1.7.11.7

