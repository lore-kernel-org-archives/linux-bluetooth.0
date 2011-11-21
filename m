Return-Path: <cyrus@holtmann.org>
From: Santiago Carot-Nemesio <sancane@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Santiago Carot-Nemesio <sancane@gmail.com>
Subject: [PATCH] Add thermometer python script
Date: Mon, 21 Nov 2011 15:06:35 +0100
Message-Id: <1321884395-7904-1-git-send-email-sancane@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 test/test-thermometer.py |   81 ++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 81 insertions(+), 0 deletions(-)
 create mode 100644 test/test-thermometer.py

diff --git a/test/test-thermometer.py b/test/test-thermometer.py
new file mode 100644
index 0000000..93dba86
--- /dev/null
+++ b/test/test-thermometer.py
@@ -0,0 +1,81 @@
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
+	exit_on_release = True
+
+	def set_exit_on_release(self, exit_on_release):
+		self.exit_on_release = exit_on_release
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
+	thermometer.EnableIntermediateMeasurement(path)
+
+	mainloop = gobject.MainLoop()
+	mainloop.run()
-- 
1.7.7.4

