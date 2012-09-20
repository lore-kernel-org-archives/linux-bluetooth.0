Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Rafal Garbat <rafal.garbat@tieto.com>
Subject: [PATCH v6 13/13] heartrate: Add test script
Date: Thu, 20 Sep 2012 13:14:50 +0200
Message-ID: <1348139690-26985-14-git-send-email-andrzej.kaczmarek@tieto.com>
In-Reply-To: <1348139690-26985-1-git-send-email-andrzej.kaczmarek@tieto.com>
References: <1348139690-26985-1-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Rafal Garbat <rafal.garbat@tieto.com>

---
 Makefile.tools      |   4 +-
 test/test-heartrate | 103 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 105 insertions(+), 2 deletions(-)
 create mode 100755 test/test-heartrate

diff --git a/Makefile.tools b/Makefile.tools
index d3b6f57..f59a7c4 100644
--- a/Makefile.tools
+++ b/Makefile.tools
@@ -209,7 +209,7 @@ EXTRA_DIST += test/sap_client.py test/hsplay test/hsmicro \
 		test/test-network test/simple-agent test/simple-service \
 		test/simple-endpoint test/test-audio test/test-input \
 		test/test-sap-server test/test-oob test/test-attrib \
-		test/test-proximity test/test-thermometer test/test-health \
-		test/test-health-sink test/service-record.dtd \
+		test/test-proximity test/test-thermometer test/test-heartrate \
+		test/test-health test/test-health-sink test/service-record.dtd \
 		test/service-did.xml test/service-spp.xml test/service-opp.xml \
 		test/service-ftp.xml test/simple-player test/test-nap
diff --git a/test/test-heartrate b/test/test-heartrate
new file mode 100755
index 0000000..316375d
--- /dev/null
+++ b/test/test-heartrate
@@ -0,0 +1,103 @@
+#!/usr/bin/python
+
+from __future__ import absolute_import, print_function, unicode_literals
+
+'''
+Heart Rate Monitor test script
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
+	@dbus.service.method("org.bluez.HeartRateWatcher",
+					in_signature="oa{sv}", out_signature="")
+	def MeasurementReceived(self, device, measure):
+		print("Measurement received from %s" % device)
+		print("Value: ", measure["Value"])
+
+		if "Energy" in measure:
+			print("Energy: ", measure["Energy"])
+
+		if "Contact" in measure:
+			print("Contact: ", measure["Contact"])
+
+		if "Interval" in measure:
+			for i in measure["Interval"]:
+				print("Interval: ", i)
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
+		print("Usage: %s [-i <adapter>] -b <bdaddr> [cmd]" % (sys.argv[0]))
+		print("Possible commands:")
+		print("\tReset")
+		sys.exit(1)
+
+	if options.adapter:
+		adapter_path = manager.FindAdapter(options.adapter)
+	else:
+		adapter_path = manager.DefaultAdapter()
+
+	adapter = dbus.Interface(bus.get_object("org.bluez", adapter_path),
+							"org.bluez.Adapter")
+
+	heartrateManager = dbus.Interface(bus.get_object("org.bluez",
+				adapter_path), "org.bluez.HeartRateManager")
+
+	path = "/test/watcher"
+	heartrateManager.RegisterWatcher(path)
+
+	device_path = adapter.FindDevice(options.address)
+
+	device = dbus.Interface(bus.get_object("org.bluez", device_path),
+							"org.bluez.Device")
+
+	heartrate = dbus.Interface(bus.get_object("org.bluez",
+					device_path), "org.bluez.HeartRate")
+
+	watcher = Watcher(bus, path)
+
+	properties = heartrate.GetProperties()
+
+	if "Location" in properties:
+		print("Sensor location: %s" % properties["Location"])
+	else:
+		print("Sensor location is not supported")
+
+	if len(args) > 0:
+		if args[0] == "Reset":
+			reset_sup = properties["ResetSupported"]
+			if reset_sup:
+				heartrate.Reset()
+			else:
+				print("Reset not supported")
+				sys.exit(1)
+		else:
+			print("unknown command")
+			sys.exit(1)
+
+	mainloop = gobject.MainLoop()
+	mainloop.run()
-- 
1.7.11.3

