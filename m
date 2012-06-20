Return-Path: <cyrus@holtmann.org>
From: Jefferson Delfes <jefferson.delfes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Bruna Moreira <bruna.moreira@openbossa.org>
Subject: [PATCH BlueZ 3/5] observer: Add python test script
Date: Wed, 20 Jun 2012 14:05:16 -0400
Message-Id: <1340215518-6694-4-git-send-email-jefferson.delfes@openbossa.org>
In-Reply-To: <1340215518-6694-1-git-send-email-jefferson.delfes@openbossa.org>
References: <1340215518-6694-1-git-send-email-jefferson.delfes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Bruna Moreira <bruna.moreira@openbossa.org>

---
 test/test-observer | 86 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 86 insertions(+)
 create mode 100755 test/test-observer

diff --git a/test/test-observer b/test/test-observer
new file mode 100755
index 0000000..450306d
--- /dev/null
+++ b/test/test-observer
@@ -0,0 +1,86 @@
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
+properties = {'CompanyIdentifierCode': "ManufacturerData", 'ServiceUUID': "ServiceData"}
+
+class Observer(dbus.service.Object):
+	def __init__(self, bus, object_path, data_type):
+		dbus.service.Object.__init__(self, bus, object_path)
+		self.data_type = data_type
+
+	@dbus.service.method("org.bluez.Observer",
+					in_signature="sv", out_signature="")
+	def BroadcastReceived(self, address, value):
+		print("[ " + address + " ]")
+
+		if type(value) is dbus.String:
+			value = unicode(value).encode('ascii', 'replace')
+
+		print("    %s = %s" % (properties[self.data_type], value))
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
+	if options.service_uuid:
+		path = "/test/observer/service"
+		service_observer = Observer(bus, path, "ServiceUUID")
+		adapter.RegisterObserver(path, "ServiceUUID", options.service_uuid)
+
+	if options.company_id:
+		path = "/test/observer/company"
+		company_observer = Observer(bus, path, "CompanyIdentifierCode")
+		adapter.RegisterObserver(path, "CompanyIdentifierCode", options.company_id)
+
+	mainloop = GObject.MainLoop()
+	mainloop.run()
-- 
1.7.11

