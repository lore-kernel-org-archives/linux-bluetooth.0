Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 04/13] cyclingspeed: Append version to CyclingSpeed interfaces
Date: Fri, 14 Dec 2012 11:12:58 +0200
Message-Id: <1355476387-2165-4-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1355476387-2165-1-git-send-email-luiz.dentz@gmail.com>
References: <1355476387-2165-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 doc/cyclingspeed-api.txt             |  6 +++---
 profiles/cyclingspeed/cyclingspeed.c |  6 +++---
 src/bluetooth.conf                   |  2 +-
 test/test-cyclingspeed               | 23 ++++++++++++++---------
 4 files changed, 21 insertions(+), 16 deletions(-)

diff --git a/doc/cyclingspeed-api.txt b/doc/cyclingspeed-api.txt
index 08e11c8..1a2dfee 100644
--- a/doc/cyclingspeed-api.txt
+++ b/doc/cyclingspeed-api.txt
@@ -7,7 +7,7 @@ Cycling Speed and Cadence Manager hierarchy
 ===========================================
 
 Service		org.bluez
-Interface	org.bluez.CyclingSpeedManager
+Interface	org.bluez.CyclingSpeedManager1
 Object path	[variable prefix]/{hci0,hci1,...}
 
 Methods		RegisterWatcher(object agent)
@@ -25,7 +25,7 @@ Cycling Speed and Cadence Profile hierarchy
 ===========================================
 
 Service		org.bluez
-Interface	org.bluez.CyclingSpeed
+Interface	org.bluez.CyclingSpeed1
 Object path	[variable prefix]/{hci0,hci1,...}/dev_XX_XX_XX_XX_XX_XX
 
 Methods		SetCumulativeWheelRevolutions(uint32 value)
@@ -68,7 +68,7 @@ Cycling Speed and Cadence Watcher hierarchy
 ===========================================
 
 Service		unique name
-Interface	org.bluez.CyclingSpeedWatcher
+Interface	org.bluez.CyclingSpeedWatcher1
 Object path	freely definable
 
 Methods		void MeasurementReceived(object device, dict measurement)
diff --git a/profiles/cyclingspeed/cyclingspeed.c b/profiles/cyclingspeed/cyclingspeed.c
index e236ff7..e0ba4d2 100644
--- a/profiles/cyclingspeed/cyclingspeed.c
+++ b/profiles/cyclingspeed/cyclingspeed.c
@@ -47,9 +47,9 @@
 
 #define ATT_TIMEOUT 30
 
-#define CYCLINGSPEED_INTERFACE		"org.bluez.CyclingSpeed"
-#define CYCLINGSPEED_MANAGER_INTERFACE	"org.bluez.CyclingSpeedManager"
-#define CYCLINGSPEED_WATCHER_INTERFACE	"org.bluez.CyclingSpeedWatcher"
+#define CYCLINGSPEED_INTERFACE		"org.bluez.CyclingSpeed1"
+#define CYCLINGSPEED_MANAGER_INTERFACE	"org.bluez.CyclingSpeedManager1"
+#define CYCLINGSPEED_WATCHER_INTERFACE	"org.bluez.CyclingSpeedWatcher1"
 
 #define WHEEL_REV_SUPPORT		0x01
 #define CRANK_REV_SUPPORT		0x02
diff --git a/src/bluetooth.conf b/src/bluetooth.conf
index 72d4248..137e4e4 100644
--- a/src/bluetooth.conf
+++ b/src/bluetooth.conf
@@ -19,7 +19,7 @@
     <allow send_interface="org.bluez.AlertAgent"/>
     <allow send_interface="org.bluez.Profile1"/>
     <allow send_interface="org.bluez.HeartRateWatcher1"/>
-    <allow send_interface="org.bluez.CyclingSpeedWatcher"/>
+    <allow send_interface="org.bluez.CyclingSpeedWatcher1"/>
   </policy>
 
   <policy at_console="true">
diff --git a/test/test-cyclingspeed b/test/test-cyclingspeed
index 10a16aa..533120a 100755
--- a/test/test-cyclingspeed
+++ b/test/test-cyclingspeed
@@ -14,6 +14,11 @@ import dbus.service
 import dbus.mainloop.glib
 from optparse import OptionParser, make_option
 
+BUS_NAME = 'org.bluez'
+CYCLINGSPEED_MANAGER_INTERFACE = 'org.bluez.CyclingSpeedManager1'
+CYCLINGSPEED_WATCHER_INTERFACE = 'org.bluez.CyclingSpeedWatcher1'
+CYCLINGSPEED_INTERFACE = 'org.bluez.CyclingSpeed1'
+
 class MeasurementQ:
 	def __init__(self, wrap_v):
 		self._now = [None, None]
@@ -50,7 +55,7 @@ class Watcher(dbus.service.Object):
 	def enable_calc(self, v):
 		self._circumference = v
 
-	@dbus.service.method("org.bluez.CyclingSpeedWatcher",
+	@dbus.service.method(CYCLINGSPEED_WATCHER_INTERFACE,
 					in_signature="oa{sv}", out_signature="")
 	def MeasurementReceived(self, device, measure):
 		print("Measurement received from %s" % device)
@@ -135,8 +140,8 @@ if __name__ == "__main__":
 								options.adapter)
 	device_path = device.object_path
 
-	cscmanager = dbus.Interface(bus.get_object("org.bluez", adapter_path),
-						"org.bluez.CyclingSpeedManager")
+	cscmanager = dbus.Interface(bus.get_object(BUS_NAME, adapter_path),
+						CYCLINGSPEED_WATCHER_INTERFACE)
 
 	watcher_path = "/test/watcher"
 	watcher = Watcher(bus, watcher_path)
@@ -144,18 +149,18 @@ if __name__ == "__main__":
 		watcher.enable_calc(options.circumference)
 	cscmanager.RegisterWatcher(watcher_path)
 
-	csc = dbus.Interface(bus.get_object("org.bluez", device_path),
-						"org.bluez.CyclingSpeed")
+	csc = dbus.Interface(bus.get_object(BUS_NAME, device_path),
+							CYCLINGSPEED_INTERFACE)
 
-	bus.add_signal_receiver(properties_changed, bus_name="org.bluez",
+	bus.add_signal_receiver(properties_changed, bus_name=BUS_NAME,
 				path=device_path,
 				dbus_interface="org.freedesktop.DBus.Properties",
 				signal_name="PropertiesChanged")
 
-	device_prop = dbus.Interface(bus.get_object("org.bluez", device_path),
+	device_prop = dbus.Interface(bus.get_object(BUS_NAME, device_path),
 					"org.freedesktop.DBus.Properties")
 
-	properties = device_prop.GetAll("org.bluez.CyclingSpeed")
+	properties = device_prop.GetAll(CYCLINGSPEED_INTERFACE)
 
 	if "Location" in properties:
 		print("Sensor location: %s" % properties["Location"])
@@ -171,7 +176,7 @@ if __name__ == "__main__":
 
 		elif args[0] == "SetLocation":
 			if properties["MultipleSensorLocationsSupported"]:
-				device_prop.Set("org.bluez.CyclingSpeed", "Location", args[1])
+				device_prop.Set(CYCLINGSPEED_INTERFACE, "Location", args[1])
 			else:
 				print("Multiple sensor locations not supported")
 
-- 
1.7.11.7

