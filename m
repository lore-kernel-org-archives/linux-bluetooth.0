Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [RFC BlueZ v0 12/13] test: Add test-service script
Date: Mon,  6 May 2013 10:43:29 +0200
Message-Id: <1367829810-8262-13-git-send-email-mikel.astiz.oss@gmail.com>
In-Reply-To: <1367829810-8262-1-git-send-email-mikel.astiz.oss@gmail.com>
References: <1367829810-8262-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

This simple script can be used to control the org.bluez.Service1 API.
---
 test/test-service | 156 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 156 insertions(+)
 create mode 100755 test/test-service

diff --git a/test/test-service b/test/test-service
new file mode 100755
index 0000000..7143891
--- /dev/null
+++ b/test/test-service
@@ -0,0 +1,156 @@
+#!/usr/bin/python
+
+# Copyright (C) 2012-2013  BMW Car IT GmbH.
+
+from __future__ import absolute_import, print_function, unicode_literals
+
+from gi.repository import GObject
+
+import sys
+import dbus
+import dbus.mainloop.glib
+from optparse import OptionParser, make_option
+import bluezutils
+
+BUS_NAME = 'org.bluez'
+SERVICE_INTERFACE = 'org.bluez.Service1'
+
+dbus.mainloop.glib.DBusGMainLoop(set_as_default=True)
+bus = dbus.SystemBus()
+mainloop = GObject.MainLoop()
+
+option_list = [
+		make_option("-i", "--adapter", action="store",
+				type="string", dest="adap_id"),
+		]
+
+description="Test script to operate on org.bluez.Service1 interfaces"
+usage = "usage: %prog [options] <command> [<args>]"
+epilog="""
+Commands:
+	list [<address>]
+	connect <address> <service-path-suffix>
+	disconnect <address> <service-path-suffix>
+
+"""
+
+OptionParser.format_epilog = lambda self, formatter: self.epilog
+parser = OptionParser(
+	usage=usage,
+	description = description,
+	epilog = epilog,
+	option_list=option_list)
+
+(options, args) = parser.parse_args()
+
+if len(args) < 1:
+	parser.print_help()
+	sys.exit(1)
+
+if args[0] == "list":
+	if len(args) > 2:
+		parser.print_help()
+		sys.exit(1)
+
+	adapter = bluezutils.find_adapter(options.adap_id)
+	adapter_path = adapter.object_path
+
+	om = dbus.Interface(bus.get_object("org.bluez", "/"),
+					"org.freedesktop.DBus.ObjectManager")
+	objects = om.GetManagedObjects()
+
+	all_services = (str(path) for path, interfaces in objects.iteritems()
+			if SERVICE_INTERFACE in interfaces.keys())
+	all_services = list(all_services)
+
+	for path, interfaces in objects.iteritems():
+		if "org.bluez.Device1" not in interfaces:
+			continue
+
+		properties = interfaces["org.bluez.Device1"]
+		if properties["Adapter"] != adapter_path:
+			continue
+
+		address = properties["Address"]
+		if len(args) >= 2 and args[1] != address:
+			continue
+
+		print("[ %s ]" % address)
+
+		for service_path in all_services:
+			service = objects[service_path]
+			properties = service[SERVICE_INTERFACE]
+
+			if properties["Device"] != path:
+				continue
+
+			print("    [ " + service_path + " ]")
+
+			for key in properties.keys():
+				value = properties[key]
+				extra = ""
+				if key == "Device":
+					continue
+				elif key == "UUID":
+					alias = bluezutils.get_uuid_alias(value)
+					if alias:
+						extra = " (%s)" % alias
+				print("        %s = %s%s" % (key, value, extra))
+
+		print("")
+
+	sys.exit(0)
+
+def service_do(func):
+	if len(args) < 3:
+		parser.print_help()
+		sys.exit(1)
+
+	objects = bluezutils.get_managed_objects()
+	adapter = bluezutils.find_adapter_in_objects(objects, options.adap_id)
+	device = bluezutils.find_device_in_objects(objects, args[1],
+								options.adap_id)
+	path_suffix = args[2]
+	found = False
+	for path, ifaces in objects.iteritems():
+		service = ifaces.get(SERVICE_INTERFACE)
+		if service is None:
+			continue
+		if device.object_path != service["Device"]:
+			continue
+		if not(path.endswith(path_suffix)):
+			continue
+		try:
+			found = True
+			service = bus.get_object(BUS_NAME, path)
+			iface = dbus.Interface(service, SERVICE_INTERFACE)
+			func(path, iface)
+		except dbus.exceptions.DBusException as e:
+			print(e)
+			print()
+
+	if not(found):
+		raise Exception("Service not found")
+
+if args[0] == "connect":
+	def connect(path, iface):
+		print("Connecting service %s..." % path)
+		iface.Connect()
+		print("Done.")
+		print()
+
+	service_do(connect)
+	sys.exit(0)
+
+if args[0] == "disconnect":
+	def disconnect(path, iface):
+		print("Disconnecting service %s..." % path)
+		iface.Disconnect()
+		print("Done.")
+		print()
+
+	service_do(disconnect)
+	sys.exit(0)
+
+parser.print_help()
+sys.exit(1)
-- 
1.8.1.4

