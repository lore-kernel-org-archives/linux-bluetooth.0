Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 03/13] heartrate: Append version to HeartRate interfaces
Date: Fri, 14 Dec 2012 11:12:57 +0200
Message-Id: <1355476387-2165-3-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1355476387-2165-1-git-send-email-luiz.dentz@gmail.com>
References: <1355476387-2165-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 doc/heartrate-api.txt          |  6 +++---
 profiles/heartrate/heartrate.c |  6 +++---
 src/bluetooth.conf             |  2 +-
 test/test-heartrate            | 19 ++++++++++++-------
 4 files changed, 19 insertions(+), 14 deletions(-)

diff --git a/doc/heartrate-api.txt b/doc/heartrate-api.txt
index d1d5191..0f202bd 100644
--- a/doc/heartrate-api.txt
+++ b/doc/heartrate-api.txt
@@ -8,7 +8,7 @@ Heart Rate Manager hierarchy
 ============================
 
 Service		org.bluez
-Interface	org.bluez.HeartRateManager
+Interface	org.bluez.HeartRateManager1
 Object path	[variable prefix]/{hci0,hci1,...}
 
 Methods		RegisterWatcher(object agent)
@@ -25,7 +25,7 @@ Heart Rate Profile hierarchy
 ============================
 
 Service		org.bluez
-Interface	org.bluez.HeartRate
+Interface	org.bluez.HeartRate1
 Object path	[variable prefix]/{hci0,hci1,...}/dev_XX_XX_XX_XX_XX_XX
 
 Methods		Reset()
@@ -47,7 +47,7 @@ Heart Rate Watcher hierarchy
 ============================
 
 Service		unique name
-Interface	org.bluez.HeartRateWatcher
+Interface	org.bluez.HeartRateWatcher1
 Object path	freely definable
 
 Methods		void MeasurementReceived(object device, dict measurement)
diff --git a/profiles/heartrate/heartrate.c b/profiles/heartrate/heartrate.c
index 155100e..f4edf09 100644
--- a/profiles/heartrate/heartrate.c
+++ b/profiles/heartrate/heartrate.c
@@ -41,9 +41,9 @@
 #include "log.h"
 #include "heartrate.h"
 
-#define HEART_RATE_INTERFACE		"org.bluez.HeartRate"
-#define HEART_RATE_MANAGER_INTERFACE	"org.bluez.HeartRateManager"
-#define HEART_RATE_WATCHER_INTERFACE	"org.bluez.HeartRateWatcher"
+#define HEART_RATE_INTERFACE		"org.bluez.HeartRate1"
+#define HEART_RATE_MANAGER_INTERFACE	"org.bluez.HeartRateManager1"
+#define HEART_RATE_WATCHER_INTERFACE	"org.bluez.HeartRateWatcher1"
 
 #define HR_VALUE_FORMAT		0x01
 #define SENSOR_CONTACT_DETECTED	0x02
diff --git a/src/bluetooth.conf b/src/bluetooth.conf
index 6111fdb..72d4248 100644
--- a/src/bluetooth.conf
+++ b/src/bluetooth.conf
@@ -18,7 +18,7 @@
     <allow send_interface="org.bluez.ThermometerWatcher"/>
     <allow send_interface="org.bluez.AlertAgent"/>
     <allow send_interface="org.bluez.Profile1"/>
-    <allow send_interface="org.bluez.HeartRateWatcher"/>
+    <allow send_interface="org.bluez.HeartRateWatcher1"/>
     <allow send_interface="org.bluez.CyclingSpeedWatcher"/>
   </policy>
 
diff --git a/test/test-heartrate b/test/test-heartrate
index 47dd012..f26b3db 100755
--- a/test/test-heartrate
+++ b/test/test-heartrate
@@ -15,8 +15,13 @@ import dbus.mainloop.glib
 from optparse import OptionParser, make_option
 import bluezutils
 
+BUS_NAME = 'org.bluez'
+HEARTRATE_MANAGER_INTERFACE = 'org.bluez.HeartRateManager1'
+HEARTRATE_WATCHER_INTERFACE = 'org.bluez.HeartRateWatcher1'
+HEARTRATE_INTERFACE = 'org.bluez.HeartRate1'
+
 class Watcher(dbus.service.Object):
-	@dbus.service.method("org.bluez.HeartRateWatcher",
+	@dbus.service.method(HEARTRATE_WATCHER_INTERFACE,
 					in_signature="oa{sv}", out_signature="")
 	def MeasurementReceived(self, device, measure):
 		print("Measurement received from %s" % device)
@@ -59,8 +64,8 @@ if __name__ == "__main__":
 								options.adapter)
 	adapter_path = adapter.object_path
 
-	heartrateManager = dbus.Interface(bus.get_object("org.bluez",
-				adapter_path), "org.bluez.HeartRateManager")
+	heartrateManager = dbus.Interface(bus.get_object(BUS_NAME,
+				adapter_path), HEARTRATE_MANAGER_INTERFACE)
 
 	path = "/test/watcher"
 	heartrateManager.RegisterWatcher(path)
@@ -70,15 +75,15 @@ if __name__ == "__main__":
 								options.adapter)
 	device_path = device.object_path
 
-	heartrate = dbus.Interface(bus.get_object("org.bluez",
-					device_path), "org.bluez.HeartRate")
+	heartrate = dbus.Interface(bus.get_object(BUS_NAME, device_path),
+							HEARTRATE_INTERFACE)
 
 	watcher = Watcher(bus, path)
 
-	dev_prop = dbus.Interface(bus.get_object("org.bluez", device_path),
+	dev_prop = dbus.Interface(bus.get_object(BUS_NAME, device_path),
 					"org.freedesktop.DBus.Properties")
 
-	properties = dev_prop.GetAll("org.bluez.HeartRate")
+	properties = dev_prop.GetAll(HEARTRATE_INTERFACE)
 
 	if "Location" in properties:
 		print("Sensor location: %s" % properties["Location"])
-- 
1.7.11.7

