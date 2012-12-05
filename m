Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [PATCH v3 15/15] dbus: Rename to org.bluez.Adapter1
Date: Wed,  5 Dec 2012 13:51:42 +0100
Message-Id: <1354711902-16390-16-git-send-email-mikel.astiz.oss@gmail.com>
In-Reply-To: <1354711902-16390-1-git-send-email-mikel.astiz.oss@gmail.com>
References: <1354711902-16390-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

Trivially add the numbering suffix to org.bluez.Adapter according to
the proposal for BlueZ 5.
---
 doc/adapter-api.txt    |  2 +-
 doc/oob-api.txt        |  2 +-
 profiles/cups/main.c   | 20 ++++++++++----------
 src/adapter.h          |  2 +-
 test/agent.c           |  7 ++++---
 test/bluezutils.py     |  2 +-
 test/list-devices      |  4 ++--
 test/monitor-bluetooth |  2 +-
 test/test-adapter      | 32 ++++++++++++++++----------------
 test/test-discovery    |  4 ++--
 test/test-health       |  4 ++--
 test/test-health-sink  |  4 ++--
 test/test-manager      |  4 ++--
 13 files changed, 45 insertions(+), 44 deletions(-)

diff --git a/doc/adapter-api.txt b/doc/adapter-api.txt
index cf8374d..5d2ea65 100644
--- a/doc/adapter-api.txt
+++ b/doc/adapter-api.txt
@@ -11,7 +11,7 @@ Adapter hierarchy
 =================
 
 Service		org.bluez
-Interface	org.bluez.Adapter
+Interface	org.bluez.Adapter1
 Object path	[variable prefix]/{hci0,hci1,...}
 
 Methods		void RequestSession()
diff --git a/doc/oob-api.txt b/doc/oob-api.txt
index 7f73db4..d54f612 100644
--- a/doc/oob-api.txt
+++ b/doc/oob-api.txt
@@ -28,7 +28,7 @@ Methods		dict ReadLocalData()
 					16 bytes randomizer blob.
 
 			Other data that can be transmitted via OOB mechanism
-			can be obtained from org.bluez.Adapter interface.
+			can be obtained from org.bluez.Adapter1 interface.
 
 			Note: This method will generate and return new data
 			every time it is called. Data received in previous
diff --git a/profiles/cups/main.c b/profiles/cups/main.c
index ae0cc6a..ef3a176 100644
--- a/profiles/cups/main.c
+++ b/profiles/cups/main.c
@@ -342,7 +342,7 @@ static void remote_device_found(const char *adapter, const char *bdaddr,
 	assert(adapter != NULL);
 
 	message = dbus_message_new_method_call("org.bluez", adapter,
-							"org.bluez.Adapter",
+							"org.bluez.Adapter1",
 							"FindDevice");
 	dbus_message_iter_init_append(message, &iter);
 	dbus_message_iter_append_basic(&iter, DBUS_TYPE_STRING, &bdaddr);
@@ -357,7 +357,7 @@ static void remote_device_found(const char *adapter, const char *bdaddr,
 
 	if (!reply) {
 		message = dbus_message_new_method_call("org.bluez", adapter,
-							"org.bluez.Adapter",
+							"org.bluez.Adapter1",
 							"CreateDevice");
 		dbus_message_iter_init_append(message, &iter);
 		dbus_message_iter_append_basic(&iter, DBUS_TYPE_STRING, &bdaddr);
@@ -417,7 +417,7 @@ static gboolean list_known_printers(const char *adapter)
 	DBusMessage *message, *reply;
 
 	message = dbus_message_new_method_call("org.bluez", adapter,
-						"org.bluez.Adapter",
+						"org.bluez.Adapter1",
 						"ListDevices");
 	if (message == NULL)
 		return FALSE;
@@ -467,7 +467,7 @@ static gboolean list_known_printers(const char *adapter)
 static DBusHandlerResult filter_func(DBusConnection *connection,
 					DBusMessage *message, void *user_data)
 {
-	if (dbus_message_is_signal(message, "org.bluez.Adapter",
+	if (dbus_message_is_signal(message, "org.bluez.Adapter1",
 						"DeviceFound")) {
 		const char *adapter, *bdaddr;
 		char *name;
@@ -481,7 +481,7 @@ static DBusHandlerResult filter_func(DBusConnection *connection,
 		if (parse_device_properties(&iter, &name, NULL))
 			remote_device_found(adapter, bdaddr, name);
 		g_free (name);
-	} else if (dbus_message_is_signal(message, "org.bluez.Adapter",
+	} else if (dbus_message_is_signal(message, "org.bluez.Adapter1",
 						"DeviceDisappeared")) {
 		const char *bdaddr;
 
@@ -489,7 +489,7 @@ static DBusHandlerResult filter_func(DBusConnection *connection,
 					DBUS_TYPE_STRING, &bdaddr,
 					DBUS_TYPE_INVALID);
 		remote_device_disappeared(bdaddr);
-	} else if (dbus_message_is_signal(message, "org.bluez.Adapter",
+	} else if (dbus_message_is_signal(message, "org.bluez.Adapter1",
 						"PropertyChanged")) {
 		DBusMessageIter iter, value_iter;
 		const char *name;
@@ -582,7 +582,7 @@ static gboolean list_printers(void)
 
 #define MATCH_FORMAT				\
 	"type='signal',"			\
-	"interface='org.bluez.Adapter',"	\
+	"interface='org.bluez.Adapter1',"	\
 	"sender='org.bluez',"			\
 	"path='%s'"
 
@@ -595,7 +595,7 @@ static gboolean list_printers(void)
 
 	doing_disco = TRUE;
 	message = dbus_message_new_method_call("org.bluez", adapter,
-					"org.bluez.Adapter",
+					"org.bluez.Adapter1",
 					"StartDiscovery");
 
 	if (!dbus_connection_send_with_reply(conn, message, NULL, -1)) {
@@ -649,7 +649,7 @@ static gboolean print_ieee1284(const char *bdaddr)
 	}
 
 	message = dbus_message_new_method_call("org.bluez", adapter,
-			"org.bluez.Adapter",
+			"org.bluez.Adapter1",
 			"FindDevice");
 	dbus_message_iter_init_append(message, &iter);
 	dbus_message_iter_append_basic(&iter, DBUS_TYPE_STRING, &bdaddr);
@@ -664,7 +664,7 @@ static gboolean print_ieee1284(const char *bdaddr)
 
 	if (!reply) {
 		message = dbus_message_new_method_call("org.bluez", adapter,
-				"org.bluez.Adapter",
+				"org.bluez.Adapter1",
 				"CreateDevice");
 		dbus_message_iter_init_append(message, &iter);
 		dbus_message_iter_append_basic(&iter,
diff --git a/src/adapter.h b/src/adapter.h
index e131e6d..0ec0b8f 100644
--- a/src/adapter.h
+++ b/src/adapter.h
@@ -30,7 +30,7 @@
 #include <glib.h>
 #include <stdbool.h>
 
-#define ADAPTER_INTERFACE	"org.bluez.Adapter"
+#define ADAPTER_INTERFACE	"org.bluez.Adapter1"
 
 #define MODE_OFF		0x00
 #define MODE_CONNECTABLE	0x01
diff --git a/test/agent.c b/test/agent.c
index 1713ec3..85dfb22 100644
--- a/test/agent.c
+++ b/test/agent.c
@@ -346,7 +346,7 @@ static int register_agent(DBusConnection *conn, const char *adapter_path,
 	DBusError err;
 
 	msg = dbus_message_new_method_call("org.bluez", adapter_path,
-					"org.bluez.Adapter", "RegisterAgent");
+					"org.bluez.Adapter1", "RegisterAgent");
 	if (!msg) {
 		fprintf(stderr, "Can't allocate new method call\n");
 		return -1;
@@ -385,7 +385,8 @@ static int unregister_agent(DBusConnection *conn, const char *adapter_path,
 	DBusError err;
 
 	msg = dbus_message_new_method_call("org.bluez", adapter_path,
-					"org.bluez.Adapter", "UnregisterAgent");
+							"org.bluez.Adapter1",
+							"UnregisterAgent");
 	if (!msg) {
 		fprintf(stderr, "Can't allocate new method call\n");
 		return -1;
@@ -435,7 +436,7 @@ static int create_paired_device(DBusConnection *conn, const char *adapter_path,
 	DBusPendingCall *pending;
 
 	msg = dbus_message_new_method_call("org.bluez", adapter_path,
-						"org.bluez.Adapter",
+						"org.bluez.Adapter1",
 						"CreatePairedDevice");
 	if (!msg) {
 		fprintf(stderr, "Can't allocate new method call\n");
diff --git a/test/bluezutils.py b/test/bluezutils.py
index 803805b..d0c4773 100644
--- a/test/bluezutils.py
+++ b/test/bluezutils.py
@@ -1,7 +1,7 @@
 import dbus
 
 SERVICE_NAME = "org.bluez"
-ADAPTER_INTERFACE = SERVICE_NAME + ".Adapter"
+ADAPTER_INTERFACE = SERVICE_NAME + ".Adapter1"
 DEVICE_INTERFACE = SERVICE_NAME + ".Device1"
 
 def get_managed_objects():
diff --git a/test/list-devices b/test/list-devices
index 7e56239..0aac217 100755
--- a/test/list-devices
+++ b/test/list-devices
@@ -35,12 +35,12 @@ all_devices = (str(path) for path, interfaces in objects.iteritems() if
 					"org.bluez.Device1" in interfaces.keys())
 
 for path, interfaces in objects.iteritems():
-	if "org.bluez.Adapter" not in interfaces.keys():
+	if "org.bluez.Adapter1" not in interfaces.keys():
 		continue
 
 	print("[ " + path + " ]")
 
-	properties = interfaces["org.bluez.Adapter"]
+	properties = interfaces["org.bluez.Adapter1"]
 	for key in properties.keys():
 		value = properties[key]
 		if (key == "UUIDs"):
diff --git a/test/monitor-bluetooth b/test/monitor-bluetooth
index cfda322..bc5ddaf 100755
--- a/test/monitor-bluetooth
+++ b/test/monitor-bluetooth
@@ -7,7 +7,7 @@ import gobject
 import dbus
 import dbus.mainloop.glib
 
-relevant_ifaces = [ "org.bluez.Adapter", "org.bluez.Device1" ]
+relevant_ifaces = [ "org.bluez.Adapter1", "org.bluez.Device1" ]
 
 def property_changed(interface, changed, invalidated, path):
 	iface = interface[interface.rfind(".") + 1:]
diff --git a/test/test-adapter b/test/test-adapter
index dc66aa6..95e6662 100755
--- a/test/test-adapter
+++ b/test/test-adapter
@@ -37,16 +37,16 @@ if (len(args) < 1):
 	sys.exit(1)
 
 if (args[0] == "address"):
-	addr = adapter.Get("org.bluez.Adapter", "Address")
+	addr = adapter.Get("org.bluez.Adapter1", "Address")
 	print(addr)
 	sys.exit(0)
 
 if (args[0] == "name"):
 	if (len(args) < 2):
-		name = adapter.Get("org.bluez.Adapter", "Name")
+		name = adapter.Get("org.bluez.Adapter1", "Name")
 		print(name)
 	else:
-		adapter.Set("org.bluez.Adapter", "Name", args[1])
+		adapter.Set("org.bluez.Adapter1", "Name", args[1])
 	sys.exit(0)
 
 if (args[0] == "list"):
@@ -55,12 +55,12 @@ if (args[0] == "list"):
 					"org.freedesktop.DBus.ObjectManager")
 		objects = om.GetManagedObjects()
 		for path, interfaces in objects.iteritems():
-			if "org.bluez.Adapter" not in interfaces:
+			if "org.bluez.Adapter1" not in interfaces:
 				continue
 
 			print(" [ %s ]" % (path))
 
-			props = interfaces["org.bluez.Adapter"]
+			props = interfaces["org.bluez.Adapter1"]
 
 			for (key, value) in props.items():
 				if (key == "Class"):
@@ -72,7 +72,7 @@ if (args[0] == "list"):
 
 if (args[0] == "powered"):
 	if (len(args) < 2):
-		powered = adapter.Get("org.bluez.Adapter", "Powered")
+		powered = adapter.Get("org.bluez.Adapter1", "Powered")
 		print(powered)
 	else:
 		if (args[1] == "on"):
@@ -81,12 +81,12 @@ if (args[0] == "powered"):
 			value = dbus.Boolean(0)
 		else:
 			value = dbus.Boolean(args[1])
-		adapter.Set("org.bluez.Adapter", "Powered", value)
+		adapter.Set("org.bluez.Adapter1", "Powered", value)
 	sys.exit(0)
 
 if (args[0] == "pairable"):
 	if (len(args) < 2):
-		pairable = adapter.Get("org.bluez.Adapter", "Pairable")
+		pairable = adapter.Get("org.bluez.Adapter1", "Pairable")
 		print(pairable)
 	else:
 		if (args[1] == "on"):
@@ -95,21 +95,21 @@ if (args[0] == "pairable"):
 			value = dbus.Boolean(0)
 		else:
 			value = dbus.Boolean(args[1])
-		adapter.Set("org.bluez.Adapter", "Pairable", value)
+		adapter.Set("org.bluez.Adapter1", "Pairable", value)
 	sys.exit(0)
 
 if (args[0] == "pairabletimeout"):
 	if (len(args) < 2):
-		pt = adapter.Get("org.bluez.Adapter", "PairableTimeout")
+		pt = adapter.Get("org.bluez.Adapter1", "PairableTimeout")
 		print(pt)
 	else:
 		timeout = dbus.UInt32(args[1])
-		adapter.Set("org.bluez.Adapter", "PairableTimeout", timeout)
+		adapter.Set("org.bluez.Adapter1", "PairableTimeout", timeout)
 	sys.exit(0)
 
 if (args[0] == "discoverable"):
 	if (len(args) < 2):
-		discoverable = adapter.Get("org.bluez.Adapter", "Discoverable")
+		discoverable = adapter.Get("org.bluez.Adapter1", "Discoverable")
 		print(discoverable)
 	else:
 		if (args[1] == "on"):
@@ -118,20 +118,20 @@ if (args[0] == "discoverable"):
 			value = dbus.Boolean(0)
 		else:
 			value = dbus.Boolean(args[1])
-		adapter.Set("org.bluez.Adapter", "Discoverable", value)
+		adapter.Set("org.bluez.Adapter1", "Discoverable", value)
 	sys.exit(0)
 
 if (args[0] == "discoverabletimeout"):
 	if (len(args) < 2):
-		dt = adapter.Get("org.bluez.Adapter", "DiscoverableTimeout")
+		dt = adapter.Get("org.bluez.Adapter1", "DiscoverableTimeout")
 		print(dt)
 	else:
 		to = dbus.UInt32(args[1])
-		adapter.Set("org.bluez.Adapter", "DiscoverableTimeout", to)
+		adapter.Set("org.bluez.Adapter1", "DiscoverableTimeout", to)
 	sys.exit(0)
 
 if (args[0] == "discovering"):
-	discovering = adapter.Get("org.bluez.Adapter", "Discovering")
+	discovering = adapter.Get("org.bluez.Adapter1", "Discovering")
 	print(discovering)
 	sys.exit(0)
 
diff --git a/test/test-discovery b/test/test-discovery
index 0f73fe4..0004f52 100755
--- a/test/test-discovery
+++ b/test/test-discovery
@@ -106,11 +106,11 @@ if __name__ == '__main__':
 		compact = True;
 
 	bus.add_signal_receiver(devices_found,
-					dbus_interface = "org.bluez.Adapter",
+					dbus_interface = "org.bluez.Adapter1",
 					signal_name = "DevicesFound")
 
 	bus.add_signal_receiver(property_changed,
-					dbus_interface = "org.bluez.Adapter",
+					dbus_interface = "org.bluez.Adapter1",
 					signal_name = "PropertyChanged")
 
 	adapter.StartDiscovery()
diff --git a/test/test-health b/test/test-health
index 9d2f62f..e0f95a6 100755
--- a/test/test-health
+++ b/test/test-health
@@ -138,7 +138,7 @@ objects = manager.GetManagedObjects()
 adapters = []
 
 for path, ifaces in objects.iteritems():
-	if ifaces.has_key("org.bluez.Adapter"):
+	if ifaces.has_key("org.bluez.Adapter1"):
 		adapters.append(path)
 
 i = 1
@@ -160,7 +160,7 @@ while select == None:
 		sys.exit()
 
 adapter =  dbus.Interface(bus.get_object("org.bluez", select),
-						"org.bluez.Adapter")
+						"org.bluez.Adapter1")
 
 devices = adapter.GetProperties()["Devices"]
 
diff --git a/test/test-health-sink b/test/test-health-sink
index a886d85..a14f16b 100755
--- a/test/test-health-sink
+++ b/test/test-health-sink
@@ -28,7 +28,7 @@ objects = manager.GetManagedObjects()
 adapters = []
 
 for path, ifaces in objects.iteritems():
-	if ifaces.has_key("org.bluez.Adapter"):
+	if ifaces.has_key("org.bluez.Adapter1"):
 		adapters.append(path)
 
 i = 1
@@ -50,7 +50,7 @@ while select == None:
 		sys.exit()
 
 adapter =  dbus.Interface(bus.get_object("org.bluez", select),
-						"org.bluez.Adapter")
+						"org.bluez.Adapter1")
 
 devices = adapter.GetProperties()["Devices"]
 
diff --git a/test/test-manager b/test/test-manager
index c5e8007..1e3882f 100755
--- a/test/test-manager
+++ b/test/test-manager
@@ -9,11 +9,11 @@ import dbus.mainloop.glib
 import bluezutils
 
 def interfaces_added(path, interfaces):
-	if interfaces.get("org.bluez.Adapter") != None:
+	if interfaces.get("org.bluez.Adapter1") != None:
 		print("Adapter with path %s added" % (path))
 
 def interfaces_removed(path, interfaces):
-	if "org.bluez.Adapter" in interfaces:
+	if "org.bluez.Adapter1" in interfaces:
 		print("Adapter with path %s removed" % (path))
 
 if __name__ == "__main__":
-- 
1.7.11.7

