Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [RFC v2 03/15] test: Avoid using DefaultAdapter()
Date: Thu, 29 Nov 2012 13:47:24 +0100
Message-Id: <1354193256-30610-4-git-send-email-mikel.astiz.oss@gmail.com>
In-Reply-To: <1354193256-30610-1-git-send-email-mikel.astiz.oss@gmail.com>
References: <1354193256-30610-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

Call the utility library -which uses ObjectManager API- to avoid using
Manager.FindAdapter() and Manager.DefaultAdapter().
---
 test/dbusdef.py       |  5 ++---
 test/simple-agent     | 10 +++-------
 test/simple-endpoint  |  7 +++----
 test/simple-player    |  7 +++----
 test/simple-service   |  7 +++----
 test/test-adapter     |  9 ++-------
 test/test-attrib      | 11 ++---------
 test/test-device      | 11 +++--------
 test/test-discovery   | 11 ++---------
 test/test-heartrate   | 14 +++-----------
 test/test-manager     |  3 ++-
 test/test-nap         | 10 ++--------
 test/test-oob         | 21 +++++++++++----------
 test/test-proximity   | 12 ++----------
 test/test-service     |  8 ++------
 test/test-thermometer | 14 +++-----------
 16 files changed, 48 insertions(+), 112 deletions(-)

diff --git a/test/dbusdef.py b/test/dbusdef.py
index 5af6153..74664f3 100644
--- a/test/dbusdef.py
+++ b/test/dbusdef.py
@@ -1,4 +1,5 @@
 import dbus
+import testutils
 
 bus = dbus.SystemBus()
 
@@ -8,9 +9,7 @@ dummy = dbus.Interface(bus.get_object('org.bluez', '/'), 'org.freedesktop.DBus.I
 #print dummy.Introspect()
 
 
-manager = dbus.Interface(bus.get_object('org.bluez', '/'), 'org.bluez.Manager')
-
 try:
-	adapter = dbus.Interface(bus.get_object('org.bluez', manager.DefaultAdapter()), 'org.bluez.Adapter')
+	adapter = testutils.find_adapter()
 except:
 	pass
diff --git a/test/simple-agent b/test/simple-agent
index 465857b..94996ad 100755
--- a/test/simple-agent
+++ b/test/simple-agent
@@ -9,6 +9,7 @@ import dbus
 import dbus.service
 import dbus.mainloop.glib
 from optparse import OptionParser
+import testutils
 
 bus = None
 device_obj = None
@@ -126,8 +127,6 @@ if __name__ == '__main__':
 	dbus.mainloop.glib.DBusGMainLoop(set_as_default=True)
 
 	bus = dbus.SystemBus()
-	manager = dbus.Interface(bus.get_object("org.bluez", "/"),
-							"org.bluez.Manager")
 
 	capability = "KeyboardDisplay"
 
@@ -142,12 +141,9 @@ if __name__ == '__main__':
 		capability  = options.capability
 
 	if len(args) > 0:
-		path = manager.FindAdapter(args[0])
+		adapter = testutils.find_adapter(args[0])
 	else:
-		path = manager.DefaultAdapter()
-
-	adapter = dbus.Interface(bus.get_object("org.bluez", path),
-							"org.bluez.Adapter")
+		adapter = testutils.find_adapter()
 
 	path = "/test/agent"
 	agent = Agent(bus, path)
diff --git a/test/simple-endpoint b/test/simple-endpoint
index 20c8159..25c170e 100755
--- a/test/simple-endpoint
+++ b/test/simple-endpoint
@@ -7,6 +7,7 @@ import dbus
 import dbus.service
 import dbus.mainloop.glib
 import gobject
+import testutils
 
 A2DP_SOURCE_UUID = "0000110A-0000-1000-8000-00805F9B34FB"
 A2DP_SINK_UUID = "0000110B-0000-1000-8000-00805F9B34FB"
@@ -79,13 +80,11 @@ if __name__ == '__main__':
 	dbus.mainloop.glib.DBusGMainLoop(set_as_default=True)
 
 	bus = dbus.SystemBus()
-	manager = dbus.Interface(bus.get_object("org.bluez", "/"),
-						"org.bluez.Manager")
 
 	if len(sys.argv) > 1:
-		path = manager.FindAdapter(sys.argv[1])
+		path = testutils.find_adapter(sys.argv[1]).object_path
 	else:
-		path = manager.DefaultAdapter()
+		path = testutils.find_adapter().object_path
 
 	media = dbus.Interface(bus.get_object("org.bluez", path),
 						"org.bluez.Media")
diff --git a/test/simple-player b/test/simple-player
index 9e72f3e..a41ab60 100755
--- a/test/simple-player
+++ b/test/simple-player
@@ -7,6 +7,7 @@ import dbus
 import dbus.service
 import dbus.mainloop.glib
 import gobject
+import testutils
 
 class Player(dbus.service.Object):
 	properties = None
@@ -137,13 +138,11 @@ if __name__ == '__main__':
 	dbus.mainloop.glib.DBusGMainLoop(set_as_default=True)
 
 	bus = dbus.SystemBus()
-	manager = dbus.Interface(bus.get_object("org.bluez", "/"),
-						"org.bluez.Manager")
 
 	if len(sys.argv) > 1:
-		path = manager.FindAdapter(sys.argv[1])
+		path = testutils.find_adapter(sys.argv[1]).object_path
 	else:
-		path = manager.DefaultAdapter()
+		path = testutils.find_adapter().object_path
 
 	media = dbus.Interface(bus.get_object("org.bluez", path),
 						"org.bluez.Media")
diff --git a/test/simple-service b/test/simple-service
index ed27d0c..3b7c008 100755
--- a/test/simple-service
+++ b/test/simple-service
@@ -5,6 +5,7 @@ from __future__ import absolute_import, print_function, unicode_literals
 import sys
 import time
 import dbus
+import testutils
 
 xml = ' \
 <?xml version="1.0" encoding="UTF-8" ?> 	\
@@ -103,13 +104,11 @@ xml = ' \
 '
 
 bus = dbus.SystemBus()
-manager = dbus.Interface(bus.get_object("org.bluez", "/"),
-						"org.bluez.Manager")
 
 if len(sys.argv) > 1:
-	path = manager.FindAdapter(sys.argv[1])
+	path = testutils.find_adapter(sys.argv[1]).object_path
 else:
-	path = manager.DefaultAdapter()
+	path = testutils.find_adapter().object_path
 
 service = dbus.Interface(bus.get_object("org.bluez", path),
 						"org.bluez.Service")
diff --git a/test/test-adapter b/test/test-adapter
index a37dd30..94249e9 100755
--- a/test/test-adapter
+++ b/test/test-adapter
@@ -6,11 +6,10 @@ import sys
 import dbus
 import time
 from optparse import OptionParser, make_option
+import testutils
 
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
+adapter_path = testutils.find_adapter(options.dev_id).object_path
 adapter = dbus.Interface(bus.get_object("org.bluez", adapter_path),
 					"org.freedesktop.DBus.Properties")
 
diff --git a/test/test-attrib b/test/test-attrib
index f83859d..b67b58e 100755
--- a/test/test-attrib
+++ b/test/test-attrib
@@ -13,13 +13,12 @@ import sys
 import dbus
 import dbus.mainloop.glib
 from optparse import OptionParser, make_option
+import testutils
 
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
+adapter = testutils.find_adapter(options.dev_id)
 
 if (len(args) < 1):
 	print("Usage: %s <command>" % (sys.argv[0]))
diff --git a/test/test-device b/test/test-device
index c26d7f6..c0747a7 100755
--- a/test/test-device
+++ b/test/test-device
@@ -9,13 +9,12 @@ import dbus
 import dbus.mainloop.glib
 import re
 from optparse import OptionParser, make_option
+import testutils
 
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
+adapter = testutils.find_adapter(options.dev_id)
 
-adapter = dbus.Interface(bus.get_object("org.bluez", adapter_path),
-							"org.bluez.Adapter")
+adapter_path = adapter.object_path
 
 if (len(args) < 1):
 	print("Usage: %s <command>" % (sys.argv[0]))
diff --git a/test/test-discovery b/test/test-discovery
index e85ab60..0468009 100755
--- a/test/test-discovery
+++ b/test/test-discovery
@@ -7,6 +7,7 @@ from gi.repository import GObject
 import dbus
 import dbus.mainloop.glib
 from optparse import OptionParser, make_option
+import testutils
 
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
+	adapter = testutils.find_adapter(options.dev_id)
 
 	if options.compact:
 		compact = True;
 
-	adapter = dbus.Interface(bus.get_object("org.bluez", adapter_path),
-							"org.bluez.Adapter")
-
 	bus.add_signal_receiver(devices_found,
 					dbus_interface = "org.bluez.Adapter",
 					signal_name = "DevicesFound")
diff --git a/test/test-heartrate b/test/test-heartrate
index a7d05b4..b50b169 100755
--- a/test/test-heartrate
+++ b/test/test-heartrate
@@ -13,6 +13,7 @@ import dbus
 import dbus.service
 import dbus.mainloop.glib
 from optparse import OptionParser, make_option
+import testutils
 
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
+	adapter = testutils.find_adapter(options.adapter)
+	adapter_path = adapter.object_path
 	heartrateManager = dbus.Interface(bus.get_object("org.bluez",
 				adapter_path), "org.bluez.HeartRateManager")
 
diff --git a/test/test-manager b/test/test-manager
index 8a7e2f6..b3ecc6d 100755
--- a/test/test-manager
+++ b/test/test-manager
@@ -6,6 +6,7 @@ from gi.repository import GObject
 
 import dbus
 import dbus.mainloop.glib
+import testutils
 
 def adapter_added(path):
 	print("Adapter with path %s added" % (path))
@@ -31,7 +32,7 @@ if __name__ == "__main__":
 	manager.connect_to_signal("DefaultAdapterChanged", default_changed)
 
 	try:
-		path = manager.DefaultAdapter()
+		path = testutils.find_adapter().object_path
 		default_changed(path)
 	except:
 		pass
diff --git a/test/test-nap b/test/test-nap
index dc779ad..dd1c0b5 100755
--- a/test/test-nap
+++ b/test/test-nap
@@ -6,12 +6,10 @@ import sys
 import time
 import dbus
 from optparse import OptionParser, make_option
+import testutils
 
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
+adapter_path = testutils.find_adapter(options.dev_id).object_path
 server = dbus.Interface(bus.get_object("org.bluez", adapter_path),
 						"org.bluez.NetworkServer")
 
diff --git a/test/test-oob b/test/test-oob
index d44215f..1359bdd 100755
--- a/test/test-oob
+++ b/test/test-oob
@@ -5,6 +5,7 @@ from __future__ import absolute_import, print_function, unicode_literals
 import gobject
 
 import dbus.mainloop.glib
+import testutils
 
 def create_device_reply(device):
 	print("Pairing succeed!")
@@ -20,19 +21,19 @@ if __name__ == '__main__':
 	mainloop = gobject.MainLoop()
 
 	bus = dbus.SystemBus()
-	manager = dbus.Interface(bus.get_object("org.bluez", "/"),
-							"org.bluez.Manager")
 
-	adapter0_path = manager.FindAdapter("hci0")
-	adapter1_path = manager.FindAdapter("hci1")
+	managed_objects = testutils.get_managed_objects()
+	adapter0 = testutils.find_adapter_in_objects(managed_objects, "hci0")
+	adapter1 = testutils.find_adapter_in_objects(managed_objects, "hci1")
 
-	adapter0 = dbus.Interface(bus.get_object("org.bluez", adapter0_path),
-							"org.bluez.Adapter")
-	adapter1 = dbus.Interface(bus.get_object("org.bluez", adapter1_path),
-							"org.bluez.Adapter")
+	adapter0_path = adapter0.object_path
+	adapter1_path = adapter1.object_path
+
+	adapter0_address = managed_objects[adapter0_path][
+					testutils.ADAPTER_INTERFACE]["Address"]
+	adapter1_address = managed_objects[adapter1_path][
+					testutils.ADAPTER_INTERFACE]["Address"]
 
-	adapter0_address = adapter0.GetProperties()["Address"]
-	adapter1_address = adapter1.GetProperties()["Address"]
 	print("Adapters:")
 	print("    hci0: " + adapter0_address)
 	print("    hci1: " + adapter1_address)
diff --git a/test/test-proximity b/test/test-proximity
index b08a62a..a1e9460 100755
--- a/test/test-proximity
+++ b/test/test-proximity
@@ -12,6 +12,7 @@ import sys
 import dbus
 import dbus.mainloop.glib
 from optparse import OptionParser, make_option
+import testutils
 
 def property_changed(name, value):
 
@@ -23,9 +24,6 @@ if __name__ == "__main__":
 
 	bus = dbus.SystemBus()
 
-	manager = dbus.Interface(bus.get_object("org.bluez", "/"),
-					"org.bluez.Manager")
-
 	option_list = [
 		make_option("-i", "--adapter", action="store",
 			type="string", dest="dev_id"),
@@ -37,13 +35,7 @@ if __name__ == "__main__":
 
 	(options, args) = parser.parse_args()
 
-	if options.dev_id:
-		adapter_path = manager.FindAdapter(options.dev_id)
-	else:
-		adapter_path = manager.DefaultAdapter()
-
-	adapter = dbus.Interface(bus.get_object("org.bluez", adapter_path),
-							"org.bluez.Adapter")
+	adapter = testutils.find_adapter(options.dev_id)
 
 	if (len(args) < 1):
 		print("Usage: %s <command>" % (sys.argv[0]))
diff --git a/test/test-service b/test/test-service
index 8eea9e2..16cfe5c 100755
--- a/test/test-service
+++ b/test/test-service
@@ -6,11 +6,10 @@ import sys
 import dbus
 import time
 from optparse import OptionParser, make_option
+import testutils
 
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
+adapter_path = testutils.find_adapter(options.dev_id).object_path
 
 service = dbus.Interface(bus.get_object("org.bluez", adapter_path),
 						"org.bluez.Service")
diff --git a/test/test-thermometer b/test/test-thermometer
index 2ca260f..b82c55a 100755
--- a/test/test-thermometer
+++ b/test/test-thermometer
@@ -13,6 +13,7 @@ import dbus
 import dbus.service
 import dbus.mainloop.glib
 from optparse import OptionParser, make_option
+import testutils
 
 class Watcher(dbus.service.Object):
 	@dbus.service.method("org.bluez.ThermometerWatcher",
@@ -38,9 +39,6 @@ if __name__ == "__main__":
 
 	bus = dbus.SystemBus()
 
-	manager = dbus.Interface(bus.get_object("org.bluez", "/"),
-					"org.bluez.Manager")
-
 	option_list = [
 		make_option("-i", "--adapter", action="store",
 			type="string", dest="adapter"),
@@ -58,14 +56,8 @@ if __name__ == "__main__":
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
+	adapter = testutils.find_adapter(options.adapter)
+	adapter_path = adapter.object_path
 	thermometer_manager = dbus.Interface(bus.get_object("org.bluez",
 				adapter_path), "org.bluez.ThermometerManager")
 
-- 
1.7.11.7

