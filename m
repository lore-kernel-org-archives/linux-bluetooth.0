Return-Path: <cyrus@holtmann.org>
From: Santiago Carot-Nemesio <sancane@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Santiago Carot-Nemesio <sancane@gmail.com>
Subject: [PATCH] Add thermometer python script
Date: Tue, 22 Nov 2011 13:10:15 +0100
Message-Id: <1321963815-9295-1-git-send-email-sancane@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 Makefile.tools        |    1 +
 test/test-thermometer |   89 +++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 90 insertions(+), 0 deletions(-)
 create mode 100755 test/test-thermometer

diff --git a/Makefile.tools b/Makefile.tools
index ff93bc9..c0a54d0 100644
--- a/Makefile.tools
+++ b/Makefile.tools
@@ -214,6 +214,7 @@ EXTRA_DIST += test/apitest test/sap-client test/hsplay test/hsmicro \
 		test/simple-service test/simple-endpoint test/test-audio \
 		test/test-input test/test-attrib test/test-proximity \
 		test/test-sap-server test/test-oob test/test-serial-proxy \
+		test/test-thermometer \
 		test/service-record.dtd test/service-did.xml \
 		test/service-spp.xml test/service-opp.xml test/service-ftp.xml
 
diff --git a/test/test-thermometer b/test/test-thermometer
new file mode 100755
index 0000000..a00efbb
--- /dev/null
+++ b/test/test-thermometer
@@ -0,0 +1,89 @@
+#!/usr/bin/python
+
+'''
+Thermometer test script
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
+
+	@dbus.service.method("org.bluez.ThermometerWatcher",
+					in_signature="a{sv}", out_signature="")
+	def MeasurementReceived(self, measure):
+		print measure["Measurement"], " measurement received"
+		print "Exponent: ", measure["Exponent"]
+		print "Mantissa: ", measure["Mantissa"]
+		print "Unit: ", measure["Unit"]
+
+		if measure.has_key("Time"):
+			print "Time: ", measure["Time"]
+
+		print "Type: ", measure["Type"]
+
+def property_changed(name, value):
+
+	print "PropertyChanged('%s', '%s')" % (name, value)
+
+if __name__ == "__main__":
+	dbus.mainloop.glib.DBusGMainLoop(set_as_default=True)
+
+	bus = dbus.SystemBus()
+
+	manager = dbus.Interface(bus.get_object("org.bluez", "/"),
+					"org.bluez.Manager")
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
+		print "Usage: %s -b MAC [command]" % (sys.argv[0])
+		print ""
+		print "EnableIntermediateMeasurement"
+                sys.exit(1)
+
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
+	bus.add_signal_receiver(property_changed, bus_name="org.bluez",
+				dbus_interface="org.bluez.Thermometer",
+				signal_name="PropertyChanged")
+
+	thermometer = dbus.Interface(bus.get_object("org.bluez",
+					device_path), "org.bluez.Thermometer")
+
+	path = "/test/watcher"
+	watcher = Watcher(bus, path)
+
+	thermometer.RegisterWatcher(path)
+
+	if len(args) > 0:
+		if args[0] == "EnableIntermediateMeasurement":
+			thermometer.EnableIntermediateMeasurement(path)
+		else:
+			print "unknown command"
+			sys.exit(1)
+
+	mainloop = gobject.MainLoop()
+	mainloop.run()
-- 
1.7.7.4

