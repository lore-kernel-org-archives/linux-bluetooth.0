Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [PATCH v3 12/15] test: Avoid using Adapter.FindDevice()
Date: Wed,  5 Dec 2012 13:51:39 +0100
Message-Id: <1354711902-16390-13-git-send-email-mikel.astiz.oss@gmail.com>
In-Reply-To: <1354711902-16390-1-git-send-email-mikel.astiz.oss@gmail.com>
References: <1354711902-16390-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

The method is now deprecated and thus the replacement utility library
should be used in the test scripts.
---
 test/simple-agent      | 12 +++++------
 test/test-attrib       |  7 ++-----
 test/test-cyclingspeed |  9 ++++++--
 test/test-device       | 57 +++++++++++++++++++++++++++-----------------------
 test/test-heartrate    | 13 +++++++-----
 test/test-oob          | 12 +++++++----
 test/test-proximity    |  7 ++-----
 test/test-thermometer  | 10 +++++++--
 8 files changed, 71 insertions(+), 56 deletions(-)

diff --git a/test/simple-agent b/test/simple-agent
index 13c3ce7..3c51530 100755
--- a/test/simple-agent
+++ b/test/simple-agent
@@ -149,10 +149,9 @@ if __name__ == '__main__':
 	if options.capability:
 		capability  = options.capability
 
+	adapter_pattern = None
 	if len(args) > 0:
-		adapter = bluezutils.find_adapter(args[0])
-	else:
-		adapter = bluezutils.find_adapter()
+		adapter_pattern = args[0]
 
 	path = "/test/agent"
 	agent = Agent(bus, path)
@@ -160,16 +159,15 @@ if __name__ == '__main__':
 	mainloop = GObject.MainLoop()
 
 	if len(args) > 1:
-		dev_path = adapter.FindDevice(args[1])
-		device = dbus.Interface(bus.get_object("org.bluez", dev_path),
-						"org.bluez.Device")
-
+		device = bluezutils.find_device(args[1], adapter_pattern)
+		dev_path = device.object_path
 		agent.set_exit_on_release(False)
 		device.Pair(path, capability, timeout=options.timeout,
 					reply_handler=pair_reply,
 					error_handler=pair_error)
 		device_obj = device
 	else:
+		adapter = bluezutils.find_adapter(adapter_pattern)
 		adapter.RegisterAgent(path, capability)
 		print("Agent registered")
 
diff --git a/test/test-attrib b/test/test-attrib
index f75a566..2b0b010 100755
--- a/test/test-attrib
+++ b/test/test-attrib
@@ -27,8 +27,6 @@ parser = OptionParser(option_list=option_list)
 
 (options, args) = parser.parse_args()
 
-adapter = bluezutils.find_adapter(options.dev_id)
-
 if (len(args) < 1):
 	print("Usage: %s <command>" % (sys.argv[0]))
 	print("")
@@ -39,6 +37,7 @@ if (len(args) < 1):
 	sys.exit(1)
 
 if (args[0] == "list"):
+	adapter = bluezutils.find_adapter(options.dev_id)
 	for path in adapter.GetProperties()["Devices"]:
 		device = dbus.Interface(bus.get_object("org.bluez", path),
 							"org.bluez.Device")
@@ -63,9 +62,7 @@ if (args[0] == "services"):
 	if (len(args) < 2):
 		print("Need address parameter")
 	else:
-		path = adapter.FindDevice(args[1])
-		device = dbus.Interface(bus.get_object("org.bluez", path),
-							"org.bluez.Device")
+		device = bluezutils.find_device(args[1], options.dev_id)
 		properties = device.GetProperties()
 		for path in properties["Services"]:
 			print(path)
diff --git a/test/test-cyclingspeed b/test/test-cyclingspeed
index 2bfea36..10a16aa 100755
--- a/test/test-cyclingspeed
+++ b/test/test-cyclingspeed
@@ -125,10 +125,15 @@ if __name__ == "__main__":
 		print("\tSetCumulativeWheelRevolutions <value>")
 		sys.exit(1)
 
-	adapter = bluezutils.find_adapter(options.adapter)
+	managed_objects = bluezutils.get_managed_objects()
+	adapter = bluezutils.find_adapter_in_objects(managed_objects,
+								options.adapter)
 	adapter_path = adapter.object_path
 
-	device_path = adapter.FindDevice(options.address)
+	device = bluezutils.find_device_in_objects(managed_objects,
+								options.address,
+								options.adapter)
+	device_path = device.object_path
 
 	cscmanager = dbus.Interface(bus.get_object("org.bluez", adapter_path),
 						"org.bluez.CyclingSpeedManager")
diff --git a/test/test-device b/test/test-device
index f4a40c4..d40d656 100755
--- a/test/test-device
+++ b/test/test-device
@@ -23,10 +23,6 @@ parser = OptionParser(option_list=option_list)
 
 (options, args) = parser.parse_args()
 
-adapter = bluezutils.find_adapter(options.dev_id)
-
-adapter_path = adapter.object_path
-
 if (len(args) < 1):
 	print("Usage: %s <command>" % (sys.argv[0]))
 	print("")
@@ -45,6 +41,9 @@ if (len(args) < 1):
 	sys.exit(1)
 
 if (args[0] == "list"):
+	adapter = bluezutils.find_adapter(options.dev_id)
+	adapter_path = adapter.object_path
+
 	om = dbus.Interface(bus.get_object("org.bluez", "/"),
 					"org.freedesktop.DBus.ObjectManager")
 	objects = om.GetManagedObjects()
@@ -73,6 +72,7 @@ if (args[0] == "create"):
 	if (len(args) < 2):
 		print("Need address parameter")
 	else:
+		adapter = bluezutils.find_adapter(options.dev_id)
 		adapter.CreateDevice(args[1],
 				reply_handler=create_device_reply,
 				error_handler=create_device_error)
@@ -82,8 +82,14 @@ if (args[0] == "remove"):
 	if (len(args) < 2):
 		print("Need address or object path parameter")
 	else:
+		managed_objects = bluezutils.get_managed_objects()
+		adapter = bluezutils.find_adapter_in_objects(managed_objects,
+								options.dev_id)
 		try:
-			path = adapter.FindDevice(args[1])
+			dev = bluezutils.find_device_in_objects(managed_objects,
+								args[1],
+								options.dev_id)
+			path = dev.object_path
 		except:
 			path = args[1]
 		adapter.RemoveDevice(path)
@@ -93,9 +99,7 @@ if (args[0] == "connect"):
 	if (len(args) < 2):
 		print("Need address parameter")
 	else:
-		path = adapter.FindDevice(args[1])
-		device = dbus.Interface(bus.get_object("org.bluez", path),
-							"org.bluez.Device")
+		device = bluezutils.find_device(args[1], options.dev_id)
 		if (len(args) > 2):
 			device.ConnectProfile(args[2])
 		else:
@@ -106,9 +110,7 @@ if (args[0] == "disconnect"):
 	if (len(args) < 2):
 		print("Need address parameter")
 	else:
-		path = adapter.FindDevice(args[1])
-		device = dbus.Interface(bus.get_object("org.bluez", path),
-							"org.bluez.Device")
+		device = bluezutils.find_device(args[1], options.dev_id)
 		if (len(args) > 2):
 			device.DisconnectProfile(args[2])
 		else:
@@ -119,9 +121,7 @@ if (args[0] == "discover"):
 	if (len(args) < 2):
 		print("Need address parameter")
 	else:
-		path = adapter.FindDevice(args[1])
-		device = dbus.Interface(bus.get_object("org.bluez", path),
-							"org.bluez.Device")
+		device = bluezutils.find_device(args[1], options.dev_id)
 		if (len(args) < 3):
 			pattern = ""
 		else:
@@ -139,7 +139,7 @@ if (args[0] == "class"):
 	if (len(args) < 2):
 		print("Need address parameter")
 	else:
-		path = adapter.FindDevice(args[1])
+		device = bluezutils.find_device(args[1], options.dev_id)
 		device = dbus.Interface(bus.get_object("org.bluez", path),
 					"org.freedesktop.DBus.Properties")
 		cls = device.Get("org.bluez.Device", "Class")
@@ -150,10 +150,11 @@ if (args[0] == "name"):
 	if (len(args) < 2):
 		print("Need address parameter")
 	else:
-		path = adapter.FindDevice(args[1])
-		device = dbus.Interface(bus.get_object("org.bluez", path),
+		device = bluezutils.find_device(args[1], options.dev_id)
+		path = device.object_path
+		props = dbus.Interface(bus.get_object("org.bluez", path),
 					"org.freedesktop.DBus.Properties")
-		name = device.Get("org.bluez.Device", "Name")
+		name = props.Get("org.bluez.Device", "Name")
 		print(name)
 	sys.exit(0)
 
@@ -161,8 +162,9 @@ if (args[0] == "alias"):
 	if (len(args) < 2):
 		print("Need address parameter")
 	else:
-		path = adapter.FindDevice(args[1])
-		device = dbus.Interface(bus.get_object("org.bluez", path),
+		device = bluezutils.find_device(args[1], options.dev_id)
+		path = device.object_path
+		props = dbus.Interface(bus.get_object("org.bluez", path),
 					"org.freedesktop.DBus.Properties")
 		if (len(args) < 3):
 			alias = device.Get("org.bluez.Device", "Alias")
@@ -175,8 +177,9 @@ if (args[0] == "trusted"):
 	if (len(args) < 2):
 		print("Need address parameter")
 	else:
-		path = adapter.FindDevice(args[1])
-		device = dbus.Interface(bus.get_object("org.bluez", path),
+		device = bluezutils.find_device(args[1], options.dev_id)
+		path = device.object_path
+		props = dbus.Interface(bus.get_object("org.bluez", path),
 					"org.freedesktop.DBus.Properties")
 		if (len(args) < 3):
 			trusted = device.Get("org.bluez.Device", "Trusted")
@@ -195,8 +198,9 @@ if (args[0] == "blocked"):
 	if (len(args) < 2):
 		print("Need address parameter")
 	else:
-		path = adapter.FindDevice(args[1])
-		device = dbus.Interface(bus.get_object("org.bluez", path),
+		device = bluezutils.find_device(args[1], options.dev_id)
+		path = device.object_path
+		props = dbus.Interface(bus.get_object("org.bluez", path),
 					"org.freedesktop.DBus.Properties")
 		if (len(args) < 3):
 			blocked = device.Get("org.bluez.Device", "Blocked")
@@ -215,8 +219,9 @@ if (args[0] == "services"):
 	if (len(args) < 2):
 		print("Need address parameter")
 	else:
-		path = adapter.FindDevice(args[1])
-		device = dbus.Interface(bus.get_object("org.bluez", path),
+		device = bluezutils.find_device(args[1], options.dev_id)
+		path = device.object_path
+		props = dbus.Interface(bus.get_object("org.bluez", path),
 					"org.freedesktop.DBus.Properties")
 		services = device.Get("org.bluez.Device", "Services")
 		for path in services:
diff --git a/test/test-heartrate b/test/test-heartrate
index a08e8df..47dd012 100755
--- a/test/test-heartrate
+++ b/test/test-heartrate
@@ -54,18 +54,21 @@ if __name__ == "__main__":
 		print("\tReset")
 		sys.exit(1)
 
-	adapter = bluezutils.find_adapter(options.adapter)
+	managed_objects = bluezutils.get_managed_objects()
+	adapter = bluezutils.find_adapter_in_objects(managed_objects,
+								options.adapter)
 	adapter_path = adapter.object_path
+
 	heartrateManager = dbus.Interface(bus.get_object("org.bluez",
 				adapter_path), "org.bluez.HeartRateManager")
 
 	path = "/test/watcher"
 	heartrateManager.RegisterWatcher(path)
 
-	device_path = adapter.FindDevice(options.address)
-
-	device = dbus.Interface(bus.get_object("org.bluez", device_path),
-							"org.bluez.Device")
+	device = bluezutils.find_device_in_objects(managed_objects,
+								options.address,
+								options.adapter)
+	device_path = device.object_path
 
 	heartrate = dbus.Interface(bus.get_object("org.bluez",
 					device_path), "org.bluez.HeartRate")
diff --git a/test/test-oob b/test/test-oob
index 34e042d..87c558f 100755
--- a/test/test-oob
+++ b/test/test-oob
@@ -42,14 +42,18 @@ if __name__ == '__main__':
 	print("Removing any existing bond...")
 
 	try:
-		device = adapter0.FindDevice(adapter1_address)
-		adapter0.RemoveDevice(device)
+		dev = bluezutils.find_device_in_objects(managed_objects,
+							adapter1_address,
+							adapter0_address)
+		adapter0.RemoveDevice(dev.object_path)
 	except:
 		pass
 
 	try:
-		device = adapter1.FindDevice(adapter0_address)
-		adapter1.RemoveDevice(device)
+		dev = bluezutils.find_device_in_objects(managed_objects,
+							adapter0_address,
+							adapter1_address)
+		adapter1.RemoveDevice(dev.object_path)
 	except:
 		pass
 
diff --git a/test/test-proximity b/test/test-proximity
index afde3fb..d6862de 100755
--- a/test/test-proximity
+++ b/test/test-proximity
@@ -35,10 +35,6 @@ if __name__ == "__main__":
 		]
 	parser = OptionParser(option_list=option_list)
 
-	(options, args) = parser.parse_args()
-
-	adapter = bluezutils.find_adapter(options.dev_id)
-
 	if (len(args) < 1):
 		print("Usage: %s <command>" % (sys.argv[0]))
 		print("")
@@ -46,7 +42,8 @@ if __name__ == "__main__":
 		print("  -b MAC ImmediateAlertLevel <none|mild|high>")
 		sys.exit(1)
 
-	device_path = adapter.FindDevice(options.address)
+	device = bluezutils.find_device(options.address, options.dev_id)
+	device_path = device.object_path
 
 	bus.add_signal_receiver(properties_changed, bus_name="org.bluez",
 			path=device_path,
diff --git a/test/test-thermometer b/test/test-thermometer
index 5a884a3..fdb772f 100755
--- a/test/test-thermometer
+++ b/test/test-thermometer
@@ -58,12 +58,18 @@ if __name__ == "__main__":
 		print("\tEnableIntermediateMeasurement")
 		sys.exit(1)
 
-	adapter = bluezutils.find_adapter(options.adapter)
+	managed_objects = bluezutils.get_managed_objects()
+	adapter = bluezutils.find_adapter_in_objects(managed_objects,
+								options.adapter)
 	adapter_path = adapter.object_path
+
 	thermometer_manager = dbus.Interface(bus.get_object("org.bluez",
 				adapter_path), "org.bluez.ThermometerManager")
 
-	device_path = adapter.FindDevice(options.address)
+	device = bluezutils.find_device_in_objects(managed_objects,
+								options.address,
+								options.adapter)
+	device_path = device.object_path
 
 	bus.add_signal_receiver(properties_changed, bus_name="org.bluez",
 			path=device_path,
-- 
1.7.11.7

