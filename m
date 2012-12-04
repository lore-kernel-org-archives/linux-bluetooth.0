Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Subject: [PATCH v3 19/20] test: Add cyclingspeed test script
Date: Tue, 4 Dec 2012 13:43:45 +0100
Message-ID: <1354625026-29358-20-git-send-email-andrzej.kaczmarek@tieto.com>
In-Reply-To: <1354625026-29358-1-git-send-email-andrzej.kaczmarek@tieto.com>
References: <1354625026-29358-1-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 Makefile.tools         |   3 +-
 test/test-cyclingspeed | 124 +++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 126 insertions(+), 1 deletion(-)
 create mode 100755 test/test-cyclingspeed

diff --git a/Makefile.tools b/Makefile.tools
index 689b4d2..ded9faf 100644
--- a/Makefile.tools
+++ b/Makefile.tools
@@ -209,4 +209,5 @@ EXTRA_DIST += test/sap_client.py test/hsplay test/hsmicro \
 		test/test-health-sink test/service-record.dtd \
 		test/service-did.xml test/service-spp.xml test/service-opp.xml \
 		test/service-ftp.xml test/simple-player test/test-nap \
-		test/test-heartrate test/test-alert test/test-hfp
+		test/test-heartrate test/test-alert test/test-hfp \
+		test/test-cycling
diff --git a/test/test-cyclingspeed b/test/test-cyclingspeed
new file mode 100755
index 0000000..92fe935
--- /dev/null
+++ b/test/test-cyclingspeed
@@ -0,0 +1,124 @@
+#!/usr/bin/python
+
+from __future__ import absolute_import, print_function, unicode_literals
+
+'''
+Cycling Speed and Cadence test script
+'''
+
+import gobject
+
+import sys
+import dbus
+import dbus.service
+import dbus.mainloop.glib
+from optparse import OptionParser, make_option
+
+class Watcher(dbus.service.Object):
+	@dbus.service.method("org.bluez.CyclingSpeedWatcher",
+					in_signature="oa{sv}", out_signature="")
+	def MeasurementReceived(self, device, measure):
+		print("Measurement received from %s" % device)
+
+		if "WheelRevolutions" in measure:
+			print("WheelRevolutions: ", measure["WheelRevolutions"])
+
+		if "LastWheelEventTime" in measure:
+			print("LastWheelEventTime: ", measure["LastWheelEventTime"])
+
+		if "CrankRevolutions" in measure:
+			print("CrankRevolutions: ", measure["CrankRevolutions"])
+
+		if "LastCrankEventTime" in measure:
+			print("LastCrankEventTime: ", measure["LastCrankEventTime"])
+
+def properties_changed(interface, changed, invalidated):
+	if "Location" in changed:
+		print("Sensor location: %s" % changed["Location"])
+
+if __name__ == "__main__":
+	dbus.mainloop.glib.DBusGMainLoop(set_as_default=True)
+
+	bus = dbus.SystemBus()
+
+	option_list = [
+		make_option("-i", "--adapter", action="store",
+			type="string", dest="adapter"),
+		make_option("-b", "--device", action="store",
+			type="string", dest="address"),
+		]
+
+	parser = OptionParser(option_list=option_list)
+
+	(options, args) = parser.parse_args()
+
+	if not options.address:
+		print("Usage: %s [-i <adapter>] -b <bdaddr> [-c <value>] [cmd]" % (sys.argv[0]))
+		print("Possible commands:")
+		print("\tShowSupportedLocations")
+		print("\tSetLocation <location>")
+		print("\tSetCumulativeWheelRevolutions <value>")
+		sys.exit(1)
+
+	manager = dbus.Interface(bus.get_object("org.bluez", "/"),
+					"org.bluez.Manager")
+	if options.adapter:
+		adapter_path = manager.FindAdapter(options.adapter)
+	else:
+		adapter_path = manager.DefaultAdapter()
+
+	adapter = dbus.Interface(bus.get_object("org.bluez", adapter_path),
+							"org.bluez.Adapter")
+
+	device_path = adapter.FindDevice(options.address)
+
+	cscmanager = dbus.Interface(bus.get_object("org.bluez", adapter_path),
+						"org.bluez.CyclingSpeedManager")
+
+	watcher_path = "/test/watcher"
+	watcher = Watcher(bus, watcher_path)
+	cscmanager.RegisterWatcher(watcher_path)
+
+	csc = dbus.Interface(bus.get_object("org.bluez", device_path),
+						"org.bluez.CyclingSpeed")
+
+	bus.add_signal_receiver(properties_changed, bus_name="org.bluez",
+				path=device_path,
+				dbus_interface="org.freedesktop.DBus.Properties",
+				signal_name="PropertiesChanged")
+
+	device_prop = dbus.Interface(bus.get_object("org.bluez", device_path),
+					"org.freedesktop.DBus.Properties")
+
+	properties = device_prop.GetAll("org.bluez.CyclingSpeed")
+
+	if "Location" in properties:
+		print("Sensor location: %s" % properties["Location"])
+	else:
+		print("Sensor location is not supported")
+
+	if len(args) > 0:
+		if args[0] == "ShowSupportedLocations":
+			if properties["MultipleSensorLocationsSupported"]:
+				print("Supported locations: ", properties["SupportedLocations"])
+			else:
+				print("Multiple sensor locations not supported")
+
+		elif args[0] == "SetLocation":
+			if properties["MultipleSensorLocationsSupported"]:
+				device_prop.Set("org.bluez.CyclingSpeed", "Location", args[1])
+			else:
+				print("Multiple sensor locations not supported")
+
+		elif args[0] == "SetCumulativeWheelRevolutions":
+			if properties["WheelRevolutionDataSupported"]:
+				csc.SetCumulativeWheelRevolutions(dbus.UInt32(args[1]))
+			else:
+				print("Wheel revolution data not supported")
+
+		else:
+			print("Unknown command")
+			sys.exit(1)
+
+	mainloop = gobject.MainLoop()
+	mainloop.run()
-- 
1.8.0

