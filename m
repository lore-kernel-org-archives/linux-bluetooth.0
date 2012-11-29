Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [RFC v2 14/15] dbus: Rename to org.bluez.Device1
Date: Thu, 29 Nov 2012 13:47:35 +0100
Message-Id: <1354193256-30610-15-git-send-email-mikel.astiz.oss@gmail.com>
In-Reply-To: <1354193256-30610-1-git-send-email-mikel.astiz.oss@gmail.com>
References: <1354193256-30610-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

Trivially add the numbering suffix to org.bluez.Device according to
the proposal for BlueZ 5.
---
 doc/adapter-api.txt    |  2 +-
 doc/device-api.txt     |  2 +-
 profiles/cups/main.c   |  4 ++--
 src/device.h           |  2 +-
 test/list-devices      |  4 ++--
 test/monitor-bluetooth |  2 +-
 test/simple-agent      |  4 ++--
 test/test-attrib       |  2 +-
 test/test-device       | 22 +++++++++++-----------
 test/testutils.py      |  2 +-
 10 files changed, 23 insertions(+), 23 deletions(-)

diff --git a/doc/adapter-api.txt b/doc/adapter-api.txt
index 983a20d..cf8374d 100644
--- a/doc/adapter-api.txt
+++ b/doc/adapter-api.txt
@@ -107,7 +107,7 @@ Signals		DevicesFound(array{object path, dict values})
 			device discovery.
 
 			The dictionary contains the properties from the
-			org.bluez.Device interface.
+			org.bluez.Device1 interface.
 
 Properties	string Address [readonly]
 
diff --git a/doc/device-api.txt b/doc/device-api.txt
index c1f2361..36ea1d9 100644
--- a/doc/device-api.txt
+++ b/doc/device-api.txt
@@ -11,7 +11,7 @@ Device hierarchy
 ================
 
 Service		org.bluez
-Interface	org.bluez.Device
+Interface	org.bluez.Device1
 Object path	[variable prefix]/{hci0,hci1,...}/dev_XX_XX_XX_XX_XX_XX
 
 Methods		dict DiscoverServices(string pattern)
diff --git a/profiles/cups/main.c b/profiles/cups/main.c
index 977c057..ae0cc6a 100644
--- a/profiles/cups/main.c
+++ b/profiles/cups/main.c
@@ -133,7 +133,7 @@ static char *device_get_ieee1284_id(const char *adapter, const char *device)
 
 	/* Look for the service handle of the HCRP service */
 	message = dbus_message_new_method_call("org.bluez", device,
-						"org.bluez.Device",
+						"org.bluez.Device1",
 						"DiscoverServices");
 	dbus_message_iter_init_append(message, &iter);
 	dbus_message_iter_append_basic(&iter, DBUS_TYPE_STRING, &hcr_print);
@@ -309,7 +309,7 @@ static gboolean device_is_printer(const char *adapter, const char *device_path,
 	gboolean retval;
 
 	message = dbus_message_new_method_call("org.bluez", device_path,
-							"org.bluez.Device",
+							"org.bluez.Device1",
 							"GetProperties");
 
 	reply = dbus_connection_send_with_reply_and_block(conn,
diff --git a/src/device.h b/src/device.h
index 703dfcf..bc251b6 100644
--- a/src/device.h
+++ b/src/device.h
@@ -22,7 +22,7 @@
  *
  */
 
-#define DEVICE_INTERFACE	"org.bluez.Device"
+#define DEVICE_INTERFACE	"org.bluez.Device1"
 
 struct btd_device;
 
diff --git a/test/list-devices b/test/list-devices
index e8f3f24..7e56239 100755
--- a/test/list-devices
+++ b/test/list-devices
@@ -32,7 +32,7 @@ def extract_uuids(uuid_list):
 objects = manager.GetManagedObjects()
 
 all_devices = (str(path) for path, interfaces in objects.iteritems() if
-					"org.bluez.Device" in interfaces.keys())
+					"org.bluez.Device1" in interfaces.keys())
 
 for path, interfaces in objects.iteritems():
 	if "org.bluez.Adapter" not in interfaces.keys():
@@ -55,7 +55,7 @@ for path, interfaces in objects.iteritems():
 		print("    [ " + dev_path + " ]")
 
 		dev = objects[dev_path]
-		properties = dev["org.bluez.Device"]
+		properties = dev["org.bluez.Device1"]
 
 		for key in properties.keys():
 			value = properties[key]
diff --git a/test/monitor-bluetooth b/test/monitor-bluetooth
index 45cc910..cfda322 100755
--- a/test/monitor-bluetooth
+++ b/test/monitor-bluetooth
@@ -7,7 +7,7 @@ import gobject
 import dbus
 import dbus.mainloop.glib
 
-relevant_ifaces = [ "org.bluez.Adapter", "org.bluez.Device" ]
+relevant_ifaces = [ "org.bluez.Adapter", "org.bluez.Device1" ]
 
 def property_changed(interface, changed, invalidated, path):
 	iface = interface[interface.rfind(".") + 1:]
diff --git a/test/simple-agent b/test/simple-agent
index ee4c6bf..f1c0a04 100755
--- a/test/simple-agent
+++ b/test/simple-agent
@@ -24,11 +24,11 @@ def ask(prompt):
 def set_trusted(path):
 	props = dbus.Interface(bus.get_object("org.bluez", path),
 					"org.freedesktop.DBus.Properties")
-	props.Set("org.bluez.Device", "Trusted", True)
+	props.Set("org.bluez.Device1", "Trusted", True)
 
 def dev_connect(path):
 	dev = dbus.Interface(bus.get_object("org.bluez", path),
-							"org.bluez.Device")
+							"org.bluez.Device1")
 	dev.Connect()
 
 class Rejected(dbus.DBusException):
diff --git a/test/test-attrib b/test/test-attrib
index 92e7393..63b869b 100755
--- a/test/test-attrib
+++ b/test/test-attrib
@@ -40,7 +40,7 @@ if (args[0] == "list"):
 	adapter = testutils.find_adapter(options.dev_id)
 	for path in adapter.GetProperties()["Devices"]:
 		device = dbus.Interface(bus.get_object("org.bluez", path),
-							"org.bluez.Device")
+							"org.bluez.Device1")
 		devprop = device.GetProperties()
 		print("[ %s ]" % devprop["Address"])
 		for path in devprop["Services"]:
diff --git a/test/test-device b/test/test-device
index e2d1355..84d34f7 100755
--- a/test/test-device
+++ b/test/test-device
@@ -49,9 +49,9 @@ if (args[0] == "list"):
 	objects = om.GetManagedObjects()
 
 	for path, interfaces in objects.iteritems():
-		if "org.bluez.Device" not in interfaces:
+		if "org.bluez.Device1" not in interfaces:
 			continue
-		properties = interfaces["org.bluez.Device"]
+		properties = interfaces["org.bluez.Device1"]
 		if properties["Adapter"] != adapter_path:
 			continue;
 		print("%s %s" % (properties["Address"], properties["Alias"]))
@@ -142,7 +142,7 @@ if (args[0] == "class"):
 		device = testutils.find_device(args[1], options.dev_id)
 		device = dbus.Interface(bus.get_object("org.bluez", path),
 					"org.freedesktop.DBus.Properties")
-		cls = device.Get("org.bluez.Device", "Class")
+		cls = device.Get("org.bluez.Device1", "Class")
 		print("0x%06x" % cls)
 	sys.exit(0)
 
@@ -154,7 +154,7 @@ if (args[0] == "name"):
 		path = device.object_path
 		props = dbus.Interface(bus.get_object("org.bluez", path),
 					"org.freedesktop.DBus.Properties")
-		name = props.Get("org.bluez.Device", "Name")
+		name = props.Get("org.bluez.Device1", "Name")
 		print(name)
 	sys.exit(0)
 
@@ -167,10 +167,10 @@ if (args[0] == "alias"):
 		props = dbus.Interface(bus.get_object("org.bluez", path),
 					"org.freedesktop.DBus.Properties")
 		if (len(args) < 3):
-			alias = device.Get("org.bluez.Device", "Alias")
+			alias = device.Get("org.bluez.Device1", "Alias")
 			print(alias)
 		else:
-			device.Set("org.bluez.Device", "Alias", args[2])
+			device.Set("org.bluez.Device1", "Alias", args[2])
 	sys.exit(0)
 
 if (args[0] == "trusted"):
@@ -182,7 +182,7 @@ if (args[0] == "trusted"):
 		props = dbus.Interface(bus.get_object("org.bluez", path),
 					"org.freedesktop.DBus.Properties")
 		if (len(args) < 3):
-			trusted = device.Get("org.bluez.Device", "Trusted")
+			trusted = device.Get("org.bluez.Device1", "Trusted")
 			print(trusted)
 		else:
 			if (args[2] == "yes"):
@@ -191,7 +191,7 @@ if (args[0] == "trusted"):
 				value = dbus.Boolean(0)
 			else:
 				value = dbus.Boolean(args[2])
-			device.Set("org.bluez.Device", "Trusted", value)
+			device.Set("org.bluez.Device1", "Trusted", value)
 	sys.exit(0)
 
 if (args[0] == "blocked"):
@@ -203,7 +203,7 @@ if (args[0] == "blocked"):
 		props = dbus.Interface(bus.get_object("org.bluez", path),
 					"org.freedesktop.DBus.Properties")
 		if (len(args) < 3):
-			blocked = device.Get("org.bluez.Device", "Blocked")
+			blocked = device.Get("org.bluez.Device1", "Blocked")
 			print(blocked)
 		else:
 			if (args[2] == "yes"):
@@ -212,7 +212,7 @@ if (args[0] == "blocked"):
 				value = dbus.Boolean(0)
 			else:
 				value = dbus.Boolean(args[2])
-			device.Set("org.bluez.Device", "Blocked", value)
+			device.Set("org.bluez.Device1", "Blocked", value)
 	sys.exit(0)
 
 if (args[0] == "services"):
@@ -223,7 +223,7 @@ if (args[0] == "services"):
 		path = device.object_path
 		props = dbus.Interface(bus.get_object("org.bluez", path),
 					"org.freedesktop.DBus.Properties")
-		services = device.Get("org.bluez.Device", "Services")
+		services = device.Get("org.bluez.Device1", "Services")
 		for path in services:
 			print(path)
 	sys.exit(0)
diff --git a/test/testutils.py b/test/testutils.py
index 45ef381..77f2f07 100644
--- a/test/testutils.py
+++ b/test/testutils.py
@@ -2,7 +2,7 @@ import dbus
 
 SERVICE_NAME = "org.bluez"
 ADAPTER_INTERFACE = SERVICE_NAME + ".Adapter"
-DEVICE_INTERFACE = SERVICE_NAME + ".Device"
+DEVICE_INTERFACE = SERVICE_NAME + ".Device1"
 
 def get_managed_objects():
 	bus = dbus.SystemBus()
-- 
1.7.11.7

