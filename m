Return-Path: <cyrus@holtmann.org>
From: Jefferson Delfes <jefferson.delfes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Bruna Moreira <bruna.moreira@openbossa.org>
Subject: [PATCH BlueZ 5/5] broadcaster: Add python test script
Date: Wed, 20 Jun 2012 14:05:18 -0400
Message-Id: <1340215518-6694-6-git-send-email-jefferson.delfes@openbossa.org>
In-Reply-To: <1340215518-6694-1-git-send-email-jefferson.delfes@openbossa.org>
References: <1340215518-6694-1-git-send-email-jefferson.delfes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Bruna Moreira <bruna.moreira@openbossa.org>

---
 test/test-broadcaster | 84 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 84 insertions(+)
 create mode 100755 test/test-broadcaster

diff --git a/test/test-broadcaster b/test/test-broadcaster
new file mode 100755
index 0000000..96489a4
--- /dev/null
+++ b/test/test-broadcaster
@@ -0,0 +1,84 @@
+#!/usr/bin/python
+
+'''Broadcaster test script
+'''
+
+from __future__ import absolute_import, print_function, unicode_literals
+
+from gi.repository import GObject
+
+import sys
+import dbus
+import dbus.service
+import dbus.mainloop.glib
+from optparse import OptionParser, make_option
+
+def property_changed(name, value):
+	print("PropertyChanged('%s', '%s')" % (name, value))
+
+if __name__ == "__main__":
+	dbus.mainloop.glib.DBusGMainLoop(set_as_default=True)
+
+	bus = dbus.SystemBus()
+
+	option_list = [
+		make_option("-i", "--adapter", action="store",
+			type="string", dest="adapter"),
+		make_option("-s", "--service", action="store_true",
+			dest="service",
+			help="Type of the data: Service Data"),
+		make_option("-m", "--manufacturer", action="store_true",
+			dest="manufacturer",
+			help="Type of the data: Manufacturer Specific Data"),
+		make_option("-u", "--uuid", action="store",
+			type="int", dest="uuid",
+			help="An uint16 of Service UUID or Company" + 
+			" Identifier Code following by hex encoded bytes" +
+			" (e.g. \"0x1002 08 5f 9a\")"),
+		]
+
+	parser = OptionParser(option_list=option_list,
+			usage="Usage: %prog <-s|-m> -u <uuid> <data bytes in hex>")
+
+	(options, args) = parser.parse_args()
+	if not args:
+		parser.error("Hex encoded data is required.")
+
+	if options.service and options.manufacturer:
+		parser.error("options -m and -s are mutually exclusive")
+
+	if options.service or options.manufacturer:
+		if not options.uuid:
+			parser.error("option -u is required")
+	try:
+		data = dbus.Array(map(lambda i: dbus.Byte(int(i, 16)), args))
+	except ValueError:
+		parser.error("Invalid data. Should be hex encoded bytes" +
+		" separated by whitespace.")
+
+	manager = dbus.Interface(bus.get_object("org.bluez", "/"),
+					"org.bluez.Manager")
+
+	if options.adapter:
+		adapter_path = manager.FindAdapter(options.adapter)
+	else:
+		adapter_path = manager.DefaultAdapter()
+
+	adapter = dbus.Interface(bus.get_object("org.bluez", adapter_path),
+							"org.bluez.Adapter")
+
+	bus.add_signal_receiver(property_changed, bus_name="org.bluez",
+				dbus_interface="org.bluez.Adapter",
+				signal_name="PropertyChanged")
+
+	if options.service:
+		properties = dbus.Dictionary({ "ServiceUUID" : options.uuid,
+						"Data" : data }) 
+		adapter.RegisterBroadcaster("ServiceData", properties)
+	else:
+		properties = dbus.Dictionary({ "CompanyIdentifierCode" : options.uuid,
+						"Data" : data }) 
+		adapter.RegisterBroadcaster("ManufacturerSpecificData", properties)
+
+	mainloop = GObject.MainLoop()
+	mainloop.run()
-- 
1.7.11

