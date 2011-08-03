Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Sheldon Demario <sheldon.demario@openbossa.org>
Subject: [PATCH BlueZ v3] Test script for LinkLossAlertLevel property
Date: Wed,  3 Aug 2011 09:45:46 -0300
Message-Id: <1312375546-19293-1-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <CAKT1EBdDvDkmTAyfgcoc1Y-25nwcpvLj=jLa6Y85rKyVi55AFQ@mail.gmail.com>
References: <CAKT1EBdDvDkmTAyfgcoc1Y-25nwcpvLj=jLa6Y85rKyVi55AFQ@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Sheldon Demario <sheldon.demario@openbossa.org>

Initial test script for Proximity Monitor. This patch allows the
user to set the Link Loss alert level of a given Reporter.
Usage example:
$test-proximity -i hci1 --device <mac> LinkLossAlertLevel mild
---
 Makefile.tools      |    7 +++--
 test/test-proximity |   65 +++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 69 insertions(+), 3 deletions(-)
 create mode 100755 test/test-proximity

diff --git a/Makefile.tools b/Makefile.tools
index 1cd8c9e..91599c6 100644
--- a/Makefile.tools
+++ b/Makefile.tools
@@ -206,9 +206,10 @@ EXTRA_DIST += test/apitest test/sap-client test/hsplay test/hsmicro \
 		test/test-device test/test-service test/test-serial \
 		test/test-telephony test/test-network test/simple-agent \
 		test/simple-service test/simple-endpoint test/test-audio \
-		test/test-input test/test-attrib test/test-sap-server \
-		test/test-oob test/service-record.dtd test/service-did.xml \
-		test/service-spp.xml test/service-opp.xml test/service-ftp.xml
+		test/test-input test/test-attrib test/test-proximity \
+		test/test-sap-server test/test-oob test/service-record.dtd \
+		test/service-did.xml test/service-spp.xml \
+		test/service-opp.xml test/service-ftp.xml
 
 
 if HIDD
diff --git a/test/test-proximity b/test/test-proximity
new file mode 100755
index 0000000..04faf4e
--- /dev/null
+++ b/test/test-proximity
@@ -0,0 +1,65 @@
+#!/usr/bin/python
+
+'''
+Proximity Monitor test script
+'''
+
+import gobject
+
+import sys
+import dbus
+import dbus.mainloop.glib
+from optparse import OptionParser, make_option
+
+def property_changed(name, value):
+
+	print "PropertyChanged('%s', '%s')" % (name, value)
+	mainloop.quit()
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
+			type="string", dest="dev_id"),
+		make_option("-b", "--device", action="store",
+			type="string", dest="address"),
+
+		]
+	parser = OptionParser(option_list=option_list)
+
+	(options, args) = parser.parse_args()
+
+	if options.dev_id:
+		adapter_path = manager.FindAdapter(options.dev_id)
+	else:
+		adapter_path = manager.DefaultAdapter()
+
+	adapter = dbus.Interface(bus.get_object("org.bluez", adapter_path),
+							"org.bluez.Adapter")
+
+	if (len(args) < 1):
+		print "Usage: %s <command>" % (sys.argv[0])
+		print ""
+		print "  LinkLossAlertLevel <none|mild|high>"
+		sys.exit(1)
+
+	device_path = adapter.FindDevice(options.address)
+
+	bus.add_signal_receiver(property_changed, bus_name="org.bluez",
+				dbus_interface="org.bluez.Proximity",
+				signal_name="PropertyChanged")
+
+	proximity = dbus.Interface(bus.get_object("org.bluez",
+					device_path), "org.bluez.Proximity")
+
+	print "Proximity SetProperty('%s', '%s')" % (args[0], args[1])
+	proximity.SetProperty(args[0], args[1])
+
+	mainloop = gobject.MainLoop()
+	mainloop.run()
-- 
1.7.6

