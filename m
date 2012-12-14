Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 08/13] health: Append version to Health interfaces
Date: Fri, 14 Dec 2012 11:13:02 +0200
Message-Id: <1355476387-2165-8-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1355476387-2165-1-git-send-email-luiz.dentz@gmail.com>
References: <1355476387-2165-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 doc/health-api.txt          |  6 +++---
 profiles/health/hdp_types.h |  6 +++---
 test/test-health            | 25 +++++++++++++++----------
 test/test-health-sink       | 22 ++++++++++++++--------
 4 files changed, 35 insertions(+), 24 deletions(-)

diff --git a/doc/health-api.txt b/doc/health-api.txt
index 7639cd2..193fbce 100644
--- a/doc/health-api.txt
+++ b/doc/health-api.txt
@@ -9,7 +9,7 @@ HealthManager hierarchy
 =======================
 
 Service		org.bluez
-Interface	org.bluez.HealthManager
+Interface	org.bluez.HealthManager1
 Object path	/org/bluez/
 
 Methods		object CreateApplication(dict config)
@@ -54,7 +54,7 @@ HealthDevice hierarchy
 ======================
 
 Service		org.bluez
-Interface	org.bluez.HealthDevice
+Interface	org.bluez.HealthDevice1
 Object path	[variable prefix]/{hci0,hci1,...}/dev_XX_XX_XX_XX_XX_XX
 
 Methods		boolean Echo()
@@ -112,7 +112,7 @@ HealthChannel hierarchy
 =======================
 
 Service		org.bluez
-Interface	org.bluez.HealthChannel
+Interface	org.bluez.HealthChannel1
 Object path	[variable prefix]/{hci0,hci1,...}/dev_XX_XX_XX_XX_XX_XX/chanZZZ
 
 Only the process that created the data channel or the creator of the
diff --git a/profiles/health/hdp_types.h b/profiles/health/hdp_types.h
index 7e4d00f..aff16df 100644
--- a/profiles/health/hdp_types.h
+++ b/profiles/health/hdp_types.h
@@ -25,9 +25,9 @@
 
 #define MANAGER_PATH		"/org/bluez"
 
-#define HEALTH_MANAGER		"org.bluez.HealthManager"
-#define HEALTH_DEVICE		"org.bluez.HealthDevice"
-#define HEALTH_CHANNEL		"org.bluez.HealthChannel"
+#define HEALTH_MANAGER		"org.bluez.HealthManager1"
+#define HEALTH_DEVICE		"org.bluez.HealthDevice1"
+#define HEALTH_CHANNEL		"org.bluez.HealthChannel1"
 
 #define HDP_VERSION		0x0100
 
diff --git a/test/test-health b/test/test-health
index e0f95a6..666972c 100755
--- a/test/test-health
+++ b/test/test-health
@@ -9,6 +9,12 @@ import gobject
 from dbus.mainloop.glib import DBusGMainLoop
 import sys
 
+BUS_NAME = 'org.bluez'
+PATH = '/org/bluez'
+ADAPTER_INTERFACE = 'org.bluez.Adapter1'
+HEALTH_MANAGER_INTERFACE = 'org.bluez.HealthManager1'
+HEALTH_DEVICE_INTERFACE = 'org.bluez.HealthDevice1'
+
 DBusGMainLoop(set_as_default=True)
 loop = gobject.MainLoop()
 
@@ -33,8 +39,8 @@ def sig_received(*args, **kwargs):
 
 
 def enter_mainloop():
-	bus.add_signal_receiver(sig_received, bus_name="org.bluez",
-				dbus_interface = "org.bluez.HealthDevice",
+	bus.add_signal_receiver(sig_received, bus_name=BUS_NAME,
+				dbus_interface=HEALTH_DEVICE_INTERFACE,
 				path_keyword="path",
 				member_keyword="member",
 				interface_keyword="interface")
@@ -49,8 +55,8 @@ def enter_mainloop():
 	finally:
 		print("Exiting, bye")
 
-hdp_manager = dbus.Interface(bus.get_object("org.bluez", "/org/bluez"),
-						"org.bluez.HealthManager")
+hdp_manager = dbus.Interface(bus.get_object(BUS_NAME, PATH),
+						HEALTH_MANAGER_INTERFACE)
 
 role = None
 while role == None:
@@ -131,14 +137,14 @@ if not con:
 	enter_mainloop()
 	sys.exit()
 
-manager = dbus.Interface(bus.get_object("org.bluez", "/"),
+manager = dbus.Interface(bus.get_object(BUS_NAME, "/"),
 					"org.freedesktop.DBus.ObjectManager")
 
 objects = manager.GetManagedObjects()
 adapters = []
 
 for path, ifaces in objects.iteritems():
-	if ifaces.has_key("org.bluez.Adapter1"):
+	if ifaces.has_key(ADAPTER_INTERFACE):
 		adapters.append(path)
 
 i = 1
@@ -159,8 +165,7 @@ while select == None:
 	except KeyboardInterrupt:
 		sys.exit()
 
-adapter =  dbus.Interface(bus.get_object("org.bluez", select),
-						"org.bluez.Adapter1")
+adapter = dbus.Interface(bus.get_object(BUS_NAME, select), ADAPTER_INTERFACE)
 
 devices = adapter.GetProperties()["Devices"]
 
@@ -186,8 +191,8 @@ while select == None:
 	except KeyboardInterrupt:
 		sys.exit()
 
-device = dbus.Interface(bus.get_object("org.bluez", select),
-					"org.bluez.HealthDevice")
+device = dbus.Interface(bus.get_object(BUS_NAME, select),
+					HEALTH_DEVICE_INTERFACE)
 
 echo = None
 while echo == None:
diff --git a/test/test-health-sink b/test/test-health-sink
index a14f16b..32afd71 100755
--- a/test/test-health-sink
+++ b/test/test-health-sink
@@ -9,26 +9,32 @@ import gobject
 from dbus.mainloop.glib import DBusGMainLoop
 import sys
 
+BUS_NAME = 'org.bluez'
+PATH = '/org/bluez'
+ADAPTER_INTERFACE = 'org.bluez.Adapter1'
+HEALTH_MANAGER_INTERFACE = 'org.bluez.HealthManager1'
+HEALTH_DEVICE_INTERFACE = 'org.bluez.HealthDevice1'
+
 DBusGMainLoop(set_as_default=True)
 loop = gobject.MainLoop()
 
 bus = dbus.SystemBus()
 
-hdp_manager = dbus.Interface(bus.get_object("org.bluez", "/org/bluez"),
-						"org.bluez.HealthManager")
+hdp_manager = dbus.Interface(bus.get_object(BUS_NAME, PATH),
+						HEALTH_MANAGER_INTERFACE)
 app_path = hdp_manager.CreateApplication({"DataType": dbus.types.UInt16(4103),
 					"Role": "sink"})
 
 print(app_path)
 
-manager = dbus.Interface(bus.get_object("org.bluez", "/"),
+manager = dbus.Interface(bus.get_object(BUS_NAME, "/"),
 					"org.freedesktop.DBus.ObjectManager")
 
 objects = manager.GetManagedObjects()
 adapters = []
 
 for path, ifaces in objects.iteritems():
-	if ifaces.has_key("org.bluez.Adapter1"):
+	if ifaces.has_key(ADAPTER_INTERFACE):
 		adapters.append(path)
 
 i = 1
@@ -49,8 +55,8 @@ while select == None:
 	except KeyboardInterrupt:
 		sys.exit()
 
-adapter =  dbus.Interface(bus.get_object("org.bluez", select),
-						"org.bluez.Adapter1")
+adapter =  dbus.Interface(bus.get_object(BUS_NAME, select),
+						ADAPTER_INTERFACE)
 
 devices = adapter.GetProperties()["Devices"]
 
@@ -77,8 +83,8 @@ while select == None:
 		sys.exit()
 
 print("Connecting to %s" % (select))
-device = dbus.Interface(bus.get_object("org.bluez", select),
-					"org.bluez.HealthDevice")
+device = dbus.Interface(bus.get_object(BUS_NAME, select),
+						HEALTH_DEVICE_INTERFACE)
 
 chan = device.CreateChannel(app_path, "Any")
 
-- 
1.7.11.7

