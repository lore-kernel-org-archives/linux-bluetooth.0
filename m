Return-Path: <cyrus@holtmann.org>
From: Bruna Moreira <bruna.moreira@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Bruna Moreira <bruna.moreira@openbossa.org>
Subject: [PATCH BlueZ 25/25] broadcaster: Add python test script
Date: Fri, 21 Dec 2012 16:26:52 -0400
Message-Id: <1356121612-15172-26-git-send-email-bruna.moreira@openbossa.org>
In-Reply-To: <1356121612-15172-1-git-send-email-bruna.moreira@openbossa.org>
References: <1356121612-15172-1-git-send-email-bruna.moreira@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 test/test-broadcaster |   61 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 61 insertions(+)
 create mode 100755 test/test-broadcaster

diff --git a/test/test-broadcaster b/test/test-broadcaster
new file mode 100755
index 0000000..237887d
--- /dev/null
+++ b/test/test-broadcaster
@@ -0,0 +1,61 @@
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
+import time
+import bluezutils
+
+if __name__ == "__main__":
+	dbus.mainloop.glib.DBusGMainLoop(set_as_default=True)
+
+	bus = dbus.SystemBus()
+
+	option_list = [
+		make_option("-i", "--adapter", action="store",
+			type="string", dest="adapter"),
+		make_option("-s", "--service", action="store",
+			type="int", dest="service",
+			help="Format: Service UUID (0xNNNN) followed by" +
+			" Service Data (e.g. aa bb cc)"),
+		make_option("-m", "--manufacturer", action="store",
+			type="int", dest="manufacturer",
+			help="Format: Company Identifier Code (0xNNNN)" +
+			" followed by Manufacturer Specific Data (e.g. 11 22 aa)"),
+		]
+
+	parser = OptionParser(option_list=option_list,
+			usage="Usage: %prog <-s uuid | -m cid> <data bytes in hex>")
+
+	(options, args) = parser.parse_args()
+	if not args:
+		parser.error("Hex encoded data is required.")
+
+	if options.service and options.manufacturer:
+		parser.error("options -m and -s are mutually exclusive")
+
+	try:
+		data = dbus.Array(map(lambda i: dbus.Byte(int(i, 16)), args))
+	except ValueError:
+		parser.error("Invalid data. Should be hex encoded bytes" +
+		" separated by whitespace.")
+
+	adapter = bluezutils.find_adapter(options.adapter)
+
+	if options.service:
+		adapter.SetServiceData(dbus.UInt16(options.service), data)
+
+	if options.manufacturer:
+		adapter.SetManufacturerData(dbus.UInt16(options.manufacturer), data)
+
+	mainloop = GObject.MainLoop()
+	mainloop.run()
-- 
1.7.9.5

