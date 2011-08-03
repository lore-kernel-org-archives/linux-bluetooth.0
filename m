Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Sheldon Demario <sheldon.demario@openbossa.org>
Subject: [PATCH BlueZ v2] Test script for LinkLossAlertLevel property
Date: Wed,  3 Aug 2011 08:42:50 -0300
Message-Id: <1312371770-943-1-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <20110803093504.GA21750@dell>
References: <20110803093504.GA21750@dell>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Sheldon Demario <sheldon.demario@openbossa.org>

Initial test script for Proximity Monitor. This patch allows the
user to set the Link Loss alert level of a given Reporter.
Usage example:
$test-proximity -i hci1 --device <mac> LinkLossAlertLevel mild
---
 test/test-proximity |   65 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 65 insertions(+), 0 deletions(-)
 create mode 100755 test/test-proximity

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

