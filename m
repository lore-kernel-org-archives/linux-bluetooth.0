Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [PATCH v3 03/15] test: Avoid using DefaultAdapter()
Date: Wed,  5 Dec 2012 13:51:30 +0100
Message-Id: <1354711902-16390-4-git-send-email-mikel.astiz.oss@gmail.com>
In-Reply-To: <1354711902-16390-1-git-send-email-mikel.astiz.oss@gmail.com>
References: <1354711902-16390-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

Call the utility library -which uses ObjectManager API- to avoid using
Manager.FindAdapter() and Manager.DefaultAdapter().
---
 test/dbusdef.py        |  5 ++---
 test/simple-agent      | 10 +++-------
 test/simple-endpoint   |  7 +++----
 test/simple-player     |  7 +++----
 test/simple-service    |  7 +++----
 test/test-adapter      |  9 ++-------
 test/test-attrib       | 11 ++---------
 test/test-cyclingspeed | 11 ++---------
 test/test-device       | 11 +++--------
 test/test-discovery    | 11 ++---------
 test/test-heartrate    | 14 +++-----------
 test/test-manager      |  3 ++-
 test/test-nap          | 10 ++--------
 test/test-oob          | 21 +++++++++++----------
 test/test-proximity    | 12 ++----------
 test/test-service      |  8 ++------
 test/test-thermometer  | 14 +++-----------
 17 files changed, 50 insertions(+), 121 deletions(-)

diff --git a/test/dbusdef.py b/test/dbusdef.py
index 5af6153..f1cd35a 100644
--- a/test/dbusdef.py
+++ b/test/dbusdef.py
@@ -1,4 +1,5 @@
 import dbus
+import bluezutils
 
 bus = dbus.SystemBus()
 
@@ -8,9 +9,7 @@ dummy = dbus.Interface(bus.get_object('org.bluez', '/'), 'org.freedesktop.DBus.I
 #print dummy.Introspect()
 
 
-manager = dbus.Interface(bus.get_object('org.bluez', '/'), 'org.bluez.Manager')
-
 try:
-	adapter = dbus.Interface(bus.get_object('org.bluez', manager.DefaultAdapter()), 'org.bluez.Adapter')
+	adapter = bluezutils.find_adapter()
 except:
 	pass
diff --git a/test/simple-agent b/test/simple-agent
index aeddc97..13c3ce7 100755
--- a/test/simple-agent
+++ b/test/simple-agent
@@ -9,6 +9,7 @@ import dbus
 import dbus.service
 import dbus.mainloop.glib
 from optparse import OptionParser
+import bluezutils
 
 bus = None
 device_obj = None
@@ -135,8 +136,6 @@ if __name__ == '__main__':
 	dbus.mainloop.glib.DBusGMainLoop(set_as_default=True)
 
 	bus = dbus.SystemBus()
-	manager = dbus.Interface(bus.get_object("org.bluez", "/"),
-							"org.bluez.Manager")
 
 	capability = "KeyboardDisplay"
 
@@ -151,12 +150,9 @@ if __name__ == '__main__':
 		capability  = options.capability
 
 	if len(args) > 0:
-		path = manager.FindAdapter(args[0])
+		adapter = bluezutils.find_adapter(args[0])
 	else:
-		path = manager.DefaultAdapter()
-
-	adapter = dbus.Interface(bus.get_object("org.bluez", path),
-							"org.bluez.Adapter")
+		adapter = bluezutils.find_adapter()
 
 	path = "/test/agent"
 	agent = Agent(bus, path)
diff --git a/test/simple-endpoint b/test/simple-endpoint
index 79e38c7..b363943 100755
--- a/test/simple-endpoint
+++ b/test/simple-endpoint
@@ -7,6 +7,7 @@ import dbus
 import dbus.service
 import dbus.mainloop.glib
 import gobject
+import bluezutils
 
 A2DP_SOURCE_UUID = "0000110A-0000-1000-8000-00805F9B34FB"
 A2DP_SINK_UUID = "0000110B-0000-1000-8000-00805F9B34FB"
@@ -82,13 +83,11 @@ if __name__ == '__main__':
 	dbus.mainloop.glib.DBusGMainLoop(set_as_default=True)
 
 	bus = dbus.SystemBus()
-	manager = dbus.Interface(bus.get_object("org.bluez", "/"),
-						"org.bluez.Manager")
 
 	if len(sys.argv) > 1:
-		path = manager.FindAdapter(sys.argv[1])
+		path = bluezutils.find_adapter(sys.argv[1]).object_path
 	else:
-		path = manager.DefaultAdapter()
+		path = bluezutils.find_adapter().object_path
 
 	media = dbus.Interface(bus.get_object("org.bluez", path),
 						"org.bluez.Media")
diff --git a/test/simple-player b/test/simple-player
index 0037f3a..7eb7d7e 100755
--- a/test/simple-player
+++ b/test/simple-player
@@ -7,6 +7,7 @@ import dbus
 import dbus.service
 import dbus.mainloop.glib
 import gobject
+import bluezutils
 
 class Player(dbus.service.Object):
 	properties = None
@@ -141,13 +142,11 @@ if __name__ == '__main__':
 	dbus.mainloop.glib.DBusGMainLoop(set_as_default=True)
 
 	bus = dbus.SystemBus()
-	manager = dbus.Interface(bus.get_object("org.bluez", "/"),
-						"org.bluez.Manager")
 
 	if len(sys.argv) > 1:
-		path = manager.FindAdapter(sys.argv[1])
+		path = bluezutils.find_adapter(sys.argv[1]).object_path
 	else:
-		path = manager.DefaultAdapter()
+		path = bluezutils.find_adapter().object_path
 
 	media = dbus.Interface(bus.get_object("org.bluez", path),
 						"org.bluez.Media")
diff --git a/test/simple-service b/test/simple-service
index ed27d0c..02d7648 100755
--- a/test/simple-service
+++ b/test/simple-service
@@ -5,6 +5,7 @@ from __future__ import absolute_import, print_function, unicode_literals
 import sys
 import time
 import dbus
+import bluezutils
 
 xml = ' \
 <?xml version="1.0" encoding="UTF-8" ?> 	\
@@ -103,13 +104,11 @@ xml = ' \
 '
 
 bus = dbus.SystemBus()
-manager = dbus.Interface(bus.get_object("org.bluez", "/"),
-						"org.bluez.Manager")
 
 if len(sys.argv) > 1:
-	path = manager.FindAdapter(sys.argv[1])
+	path = bluezutils.find_adapter(sys.argv[1]).object_path
 else:
-	path = manager.DefaultAdapter()
+	path = bluezutils.find_adapter().object_path
 
 service = dbus.Interface(bus.get_object("org.bluez", path),
 						"org.bluez.Service")
diff --git a/test/test-adapter b/test/test-adapter
index a37dd30..dc66aa6 100755
--- a/test/test-adapter
+++ b/test/test-adapter
@@ -6,11 +6,10 @@ import sys
 import dbus
 import time
 from optparse import OptionParser, make_option
+import bluezutils
 
 bus = dbus.SystemBus()
 
-manager = dbus.Interface(bus.get_object("org.bluez", "/"), "org.bluez.Manager")
-
 option_list = [
 		make_option("-i", "--device", action="store",
 				type="string", dest="dev_id"),
@@ -19,11 +18,7 @@ parser = OptionParser(option_list=option_list)
 
 (options, args) = parser.parse_args()
 
-if options.dev_id:
-	adapter_path = manager.FindAdapter(options.dev_id)
-else:
-	adapter_path = manager.DefaultAdapter()
-
+adapter_path = bluezutils.find_adapter(options.dev_id).object_path
 adapter = dbus.Interface(bus.get_object("org.bluez", adapter_path),
 					"org.freedesktop.DBus.Properties")
 
diff --git a/test/test-attrib b/test/test-attrib
index f83859d..f75a566 100755
--- a/test/test-attrib
+++ b/test/test-attrib
@@ -13,13 +13,12 @@ import sys
 import dbus
 import dbus.mainloop.glib
 from optparse import OptionParser, make_option
+import bluezutils
 
 dbus.mainloop.glib.DBusGMainLoop(set_as_default=True)
 bus = dbus.SystemBus()
 mainloop = gobject.MainLoop()
 
-manager = dbus.Interface(bus.get_object("org.bluez", "/"), "org.bluez.Manager")
-
 option_list = [
 		make_option("-i", "--device", action="store",
 				type="string", dest="dev_id"),
@@ -28,13 +27,7 @@ parser = OptionParser(option_list=option_list)
 
 (options, args) = parser.parse_args()
 
-if options.dev_id:
-	adapter_path = manager.FindAdapter(options.dev_id)
-else:
-	adapter_path = manager.DefaultAdapter()
-
-adapter = dbus.Interface(bus.get_object("org.bluez", adapter_path),
-							"org.bluez.Adapter")
+adapter = bluezutils.find_adapter(options.dev_id)
 
 if (len(args) < 1):
 	print("Usage: %s <command>" % (sys.argv[0]))
diff --git a/test/test-cyclingspeed b/test/test-cyclingspeed
index 841456c..2bfea36 100755
--- a/test/test-cyclingspeed
+++ b/test/test-cyclingspeed
@@ -125,15 +125,8 @@ if __name__ == "__main__":
 		print("\tSetCumulativeWheelRevolutions <value>")
 		sys.exit(1)
 
-	manager = dbus.Interface(bus.get_object("org.bluez", "/"),
-					"org.bluez.Manager")
-	if options.adapter:
-		adapter_path = manager.FindAdapter(options.adapter)
-	else:
-		adapter_path = manager.DefaultAdapter()
-
-	adapter = dbus.Interface(bus.get_object("org.bluez", adapter_path),
-							"org.bluez.Adapter")
+	adapter = bluezutils.find_adapter(options.adapter)
+	adapter_path = adapter.object_path
 
 	device_path = adapter.FindDevice(options.address)
 
diff --git a/test/test-device b/test/test-device
index c26d7f6..f4a40c4 100755
--- a/test/test-device
+++ b/test/test-device
@@ -9,13 +9,12 @@ import dbus
 import dbus.mainloop.glib
 import re
 from optparse import OptionParser, make_option
+import bluezutils
 
 dbus.mainloop.glib.DBusGMainLoop(set_as_default=True)
 bus = dbus.SystemBus()
 mainloop = GObject.MainLoop()
 
-manager = dbus.Interface(bus.get_object("org.bluez", "/"), "org.bluez.Manager")
-
 option_list = [
 		make_option("-i", "--device", action="store",
 				type="string", dest="dev_id"),
@@ -24,13 +23,9 @@ parser = OptionParser(option_list=option_list)
 
 (options, args) = parser.parse_args()
 
-if options.dev_id:
-	adapter_path = manager.FindAdapter(options.dev_id)
-else:
-	adapter_path = manager.DefaultAdapter()
+adapter = bluezutils.find_adapter(options.dev_id)
 
-adapter = dbus.Interface(bus.get_object("org.bluez", adapter_path),
-							"org.bluez.Adapter")
+adapter_path = adapter.object_path
 
 if (len(args) < 1):
 	print("Usage: %s <command>" % (sys.argv[0]))
diff --git a/test/test-discovery b/test/test-discovery
index e85ab60..0f73fe4 100755
--- a/test/test-discovery
+++ b/test/test-discovery
@@ -7,6 +7,7 @@ from gi.repository import GObject
 import dbus
 import dbus.mainloop.glib
 from optparse import OptionParser, make_option
+import bluezutils
 
 compact = False
 devices = {}
@@ -88,8 +89,6 @@ if __name__ == '__main__':
 	dbus.mainloop.glib.DBusGMainLoop(set_as_default=True)
 
 	bus = dbus.SystemBus()
-	manager = dbus.Interface(bus.get_object("org.bluez", "/"),
-							"org.bluez.Manager")
 
 	option_list = [
 			make_option("-i", "--device", action="store",
@@ -101,17 +100,11 @@ if __name__ == '__main__':
 
 	(options, args) = parser.parse_args()
 
-	if options.dev_id:
-		adapter_path = manager.FindAdapter(options.dev_id)
-	else:
-		adapter_path = manager.DefaultAdapter()
+	adapter = bluezutils.find_adapter(options.dev_id)
 
 	if options.compact:
 		compact = True;
 
-	adapter = dbus.Interface(bus.get_object("org.bluez", adapter_path),
-							"org.bluez.Adapter")
-
 	bus.add_signal_receiver(devices_found,
 					dbus_interface = "org.bluez.Adapter",
 					signal_name = "DevicesFound")
diff --git a/test/test-heartrate b/test/test-heartrate
index a7d05b4..a08e8df 100755
--- a/test/test-heartrate
+++ b/test/test-heartrate
@@ -13,6 +13,7 @@ import dbus
 import dbus.service
 import dbus.mainloop.glib
 from optparse import OptionParser, make_option
+import bluezutils
 
 class Watcher(dbus.service.Object):
 	@dbus.service.method("org.bluez.HeartRateWatcher",
@@ -36,9 +37,6 @@ if __name__ == "__main__":
 
 	bus = dbus.SystemBus()
 
-	manager = dbus.Interface(bus.get_object("org.bluez", "/"),
-					"org.bluez.Manager")
-
 	option_list = [
 		make_option("-i", "--adapter", action="store",
 			type="string", dest="adapter"),
@@ -56,14 +54,8 @@ if __name__ == "__main__":
 		print("\tReset")
 		sys.exit(1)
 
-	if options.adapter:
-		adapter_path = manager.FindAdapter(options.adapter)
-	else:
-		adapter_path = manager.DefaultAdapter()
-
-	adapter = dbus.Interface(bus.get_object("org.bluez", adapter_path),
-							"org.bluez.Adapter")
-
+	adapter = bluezutils.find_adapter(options.adapter)
+	adapter_path = adapter.object_path
 	heartrateManager = dbus.Interface(bus.get_object("org.bluez",
 				adapter_path), "org.bluez.HeartRateManager")
 
diff --git a/test/test-manager b/test/test-manager
index 8a7e2f6..16d6b08 100755
--- a/test/test-manager
+++ b/test/test-manager
@@ -6,6 +6,7 @@ from gi.repository import GObject
 
 import dbus
 import dbus.mainloop.glib
+import bluezutils
 
 def adapter_added(path):
 	print("Adapter with path %s added" % (path))
@@ -31,7 +32,7 @@ if __name__ == "__main__":
 	manager.connect_to_signal("DefaultAdapterChanged", default_changed)
 
 	try:
-		path = manager.DefaultAdapter()
+		path = bluezutils.find_adapter().object_path
 		default_changed(path)
 	except:
 		pass
diff --git a/test/test-nap b/test/test-nap
index dc779ad..b3d6907 100755
--- a/test/test-nap
+++ b/test/test-nap
@@ -6,12 +6,10 @@ import sys
 import time
 import dbus
 from optparse import OptionParser, make_option
+import bluezutils
 
 bus = dbus.SystemBus()
 
-manager = dbus.Interface(bus.get_object("org.bluez", "/"),
-						"org.bluez.Manager")
-
 option_list = [
 		make_option("-i", "--device", action="store",
 				type="string", dest="dev_id"),
@@ -20,11 +18,7 @@ parser = OptionParser(option_list=option_list)
 
 (options, args) = parser.parse_args()
 
-if options.dev_id:
-	adapter_path = manager.FindAdapter(options.dev_id)
-else:
-	adapter_path = manager.DefaultAdapter()
-
+adapter_path = bluezutils.find_adapter(options.dev_id).object_path
 server = dbus.Interface(bus.get_object("org.bluez", adapter_path),
 						"org.bluez.NetworkServer")
 
diff --git a/test/test-oob b/test/test-oob
index d44215f..34e042d 100755
--- a/test/test-oob
+++ b/test/test-oob
@@ -5,6 +5,7 @@ from __future__ import absolute_import, print_function, unicode_literals
 import gobject
 
 import dbus.mainloop.glib
+import bluezutils
 
 def create_device_reply(device):
 	print("Pairing succeed!")
@@ -20,19 +21,19 @@ if __name__ == '__main__':
 	mainloop = gobject.MainLoop()
 
 	bus = dbus.SystemBus()
-	manager = dbus.Interface(bus.get_object("org.bluez", "/"),
-							"org.bluez.Manager")
 
-	adapter0_path = manager.FindAdapter("hci0")
-	adapter1_path = manager.FindAdapter("hci1")
+	managed_objects = bluezutils.get_managed_objects()
+	adapter0 = bluezutils.find_adapter_in_objects(managed_objects, "hci0")
+	adapter1 = bluezutils.find_adapter_in_objects(managed_objects, "hci1")
 
-	adapter0 = dbus.Interface(bus.get_object("org.bluez", adapter0_path),
-							"org.bluez.Adapter")
-	adapter1 = dbus.Interface(bus.get_object("org.bluez", adapter1_path),
-							"org.bluez.Adapter")
+	adapter0_path = adapter0.object_path
+	adapter1_path = adapter1.object_path
+
+	adapter0_address = managed_objects[adapter0_path][
+					bluezutils.ADAPTER_INTERFACE]["Address"]
+	adapter1_address = managed_objects[adapter1_path][
+					bluezutils.ADAPTER_INTERFACE]["Address"]
 
-	adapter0_address = adapter0.GetProperties()["Address"]
-	adapter1_address = adapter1.GetProperties()["Address"]
 	print("Adapters:")
 	print("    hci0: " + adapter0_address)
 	print("    hci1: " + adapter1_address)
diff --git a/test/test-proximity b/test/test-proximity
index 3cb98cc..afde3fb 100755
--- a/test/test-proximity
+++ b/test/test-proximity
@@ -12,6 +12,7 @@ import sys
 import dbus
 import dbus.mainloop.glib
 from optparse import OptionParser, make_option
+import bluezutils
 
 def properties_changed(interface, changed, invalidated):
 	if interface != "org.bluez.ProximityMonitor":
@@ -25,9 +26,6 @@ if __name__ == "__main__":
 
 	bus = dbus.SystemBus()
 
-	manager = dbus.Interface(bus.get_object("org.bluez", "/"),
-					"org.bluez.Manager")
-
 	option_list = [
 		make_option("-i", "--adapter", action="store",
 			type="string", dest="dev_id"),
@@ -39,13 +37,7 @@ if __name__ == "__main__":
 
 	(options, args) = parser.parse_args()
 
-	if options.dev_id:
-		adapter_path = manager.FindAdapter(options.dev_id)
-	else:
-		adapter_path = manager.DefaultAdapter()
-
-	adapter = dbus.Interface(bus.get_object("org.bluez", adapter_path),
-							"org.bluez.Adapter")
+	adapter = bluezutils.find_adapter(options.dev_id)
 
 	if (len(args) < 1):
 		print("Usage: %s <command>" % (sys.argv[0]))
diff --git a/test/test-service b/test/test-service
index 8eea9e2..09e351f 100755
--- a/test/test-service
+++ b/test/test-service
@@ -6,11 +6,10 @@ import sys
 import dbus
 import time
 from optparse import OptionParser, make_option
+import bluezutils
 
 bus = dbus.SystemBus()
 
-manager = dbus.Interface(bus.get_object("org.bluez", "/"), "org.bluez.Manager")
-
 option_list = [
 		make_option("-i", "--device", action="store",
 				type="string", dest="dev_id"),
@@ -19,10 +18,7 @@ parser = OptionParser(option_list=option_list)
 
 (options, args) = parser.parse_args()
 
-if options.dev_id:
-	adapter_path = manager.FindAdapter(options.dev_id)
-else:
-	adapter_path = manager.DefaultAdapter()
+adapter_path = bluezutils.find_adapter(options.dev_id).object_path
 
 service = dbus.Interface(bus.get_object("org.bluez", adapter_path),
 						"org.bluez.Service")
diff --git a/test/test-thermometer b/test/test-thermometer
index e14a345..5a884a3 100755
--- a/test/test-thermometer
+++ b/test/test-thermometer
@@ -13,6 +13,7 @@ import dbus
 import dbus.service
 import dbus.mainloop.glib
 from optparse import OptionParser, make_option
+import bluezutils
 
 class Watcher(dbus.service.Object):
 	@dbus.service.method("org.bluez.ThermometerWatcher",
@@ -40,9 +41,6 @@ if __name__ == "__main__":
 
 	bus = dbus.SystemBus()
 
-	manager = dbus.Interface(bus.get_object("org.bluez", "/"),
-					"org.bluez.Manager")
-
 	option_list = [
 		make_option("-i", "--adapter", action="store",
 			type="string", dest="adapter"),
@@ -60,14 +58,8 @@ if __name__ == "__main__":
 		print("\tEnableIntermediateMeasurement")
 		sys.exit(1)
 
-	if options.adapter:
-		adapter_path = manager.FindAdapter(options.adapter)
-	else:
-		adapter_path = manager.DefaultAdapter()
-
-	adapter = dbus.Interface(bus.get_object("org.bluez", adapter_path),
-							"org.bluez.Adapter")
-
+	adapter = bluezutils.find_adapter(options.adapter)
+	adapter_path = adapter.object_path
 	thermometer_manager = dbus.Interface(bus.get_object("org.bluez",
 				adapter_path), "org.bluez.ThermometerManager")
 
-- 
1.7.11.7

