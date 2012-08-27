Return-Path: <cyrus@holtmann.org>
From: Bruna Moreira <bruna.moreira@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Bruna Moreira <bruna.moreira@openbossa.org>
Subject: [RFC BlueZ 23/33] observer: Add python test script
Date: Mon, 27 Aug 2012 13:03:15 -0400
Message-Id: <1346087005-24693-24-git-send-email-bruna.moreira@openbossa.org>
In-Reply-To: <1346087005-24693-1-git-send-email-bruna.moreira@openbossa.org>
References: <1346087005-24693-1-git-send-email-bruna.moreira@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 test/test-observer |   87 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 87 insertions(+)
 create mode 100755 test/test-observer

diff --git a/test/test-observer b/test/test-observer
new file mode 100755
index 0000000..110f487
--- /dev/null
+++ b/test/test-observer
@@ -0,0 +1,87 @@
+#!/usr/bin/python
+
+'''Observer test script
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
+def dbus_data(data):
+	return "".join(["%02x" % c for c in data])
+
+class Observer(dbus.service.Object):
+	@dbus.service.method("org.bluez.Observer",
+					in_signature="sqv", out_signature="")
+	def ServiceReceived(self, address, uuid, value):
+		print("[ " + address + " ]")
+		print("    Service UUID = 0x%04x" % int(uuid))
+		print("    Data = %s" % dbus_data(value))
+		print()
+
+	@dbus.service.method("org.bluez.Observer",
+					in_signature="sqv", out_signature="")
+	def ManufacturerReceived(self, address, cid, value):
+		print("[ " + address + " ]")
+		print("    Company ID = 0x%04x" % int(cid))
+		print("    Data = %s" % dbus_data(value))
+		print()
+
+def property_changed(name, value):
+	print("PropertyChanged('%s', '%s')" % (name, value))
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
+		make_option("-s", "--service", action="store",
+			type="int", dest="service_uuid",
+			help="Service UUID (e.g. \"0x0001\")"),
+		make_option("-c", "--company", action="store",
+			type="int", dest="company_id",
+			help="Company Identifier Code (e.g. \"0x0002\")"),
+		]
+
+	parser = OptionParser(option_list=option_list)
+
+	(options, args) = parser.parse_args()
+
+	if not options.service_uuid and not options.company_id:
+		parser.error("At least one option is required: -c or -s")
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
+	path = "/test/observer"
+	observer = Observer(bus, path)
+
+	if options.service_uuid:
+		adapter.RegisterServiceObserver(path, dbus.UInt16(options.service_uuid))
+
+	if options.company_id:
+		adapter.RegisterManufacturerObserver(path, dbus.UInt16(options.company_id))
+
+	mainloop = GObject.MainLoop()
+	mainloop.run()
-- 
1.7.9.5

