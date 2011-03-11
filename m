Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [PATCH 4/4] Update the test-attrib test script
Date: Fri, 11 Mar 2011 14:53:02 -0300
Message-Id: <1299865982-13601-4-git-send-email-vinicius.gomes@openbossa.org>
In-Reply-To: <1299865982-13601-1-git-send-email-vinicius.gomes@openbossa.org>
References: <1299865982-13601-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Now it is more similar to the other test-* scripts. And allows to
exercise more of the API.
---
 test/test-attrib |  211 +++++++++++++++++++++++++-----------------------------
 1 files changed, 97 insertions(+), 114 deletions(-)

diff --git a/test/test-attrib b/test/test-attrib
index dc3f804..1a4684e 100755
--- a/test/test-attrib
+++ b/test/test-attrib
@@ -6,119 +6,102 @@ from optparse import OptionParser, OptionValueError
 from binascii import hexlify, unhexlify
 
 import gobject
+
+import sys
 import dbus
-import dbus.service
 import dbus.mainloop.glib
-
-def handle_set_property(option, opt_str, value, parser):
-    """Handle --set-property parameter."""
-
-    char_path = parser.values.char_path
-    if not char_path:
-        raise OptionValueError, "%s requires --char-path" % opt_str
-    if len(value.split("=")) != 2:
-        raise OptionValueError, "%s must have format \"property=value\"" % opt_str
-    if not getattr(parser.values, option.dest, None):
-        setattr(parser.values, option.dest, {})
-    props = getattr(parser.values, option.dest)
-    if not props.get(char_path):
-        props[char_path] = []
-    props[char_path].append(value.split("="))
-
-def command_parse():
-    """Parse command line options."""
-
-    usage = """
-    Usage: %s [options]""" % sys.argv[0]
-    parser = OptionParser(usage=usage)
-    parser.add_option("-i", "--adapter", action="store", type="string",
-            help="Specify local adapter interface")
-    parser.add_option("--listen", action="store_true",
-            help="Listen for notifications and indications (requires policy changes)")
-    parser.add_option("--char-path", action="store", type="string",
-            help="D-Bus path for specific characteristic")
-    parser.add_option("--set-property", action="callback", type="string",
-            metavar="NAME=VALUE", callback=handle_set_property,
-            help="Set property for characteristic")
-    return parser.parse_args()
-
-def dbus_type_to_str(d):
-    """Convert a D-Bus array to a hexdump."""
-
-    if isinstance(d, dbus.Array):
-        return hexlify("".join([str(x) for x in d]))
-    else:
-        return str(d)
-
-def hexdump_to_dbus(data):
-    """Convert an hexadecimal dump to D-Bus array."""
-
-    d = [dbus.Byte(ord(i)) for i in unhexlify(data)]
-    return dbus.Array(d, signature=dbus.Signature('y'), variant_level=1)
-
-class Watcher(dbus.service.Object):
-    @dbus.service.method("org.bluez.Watcher", in_signature="oay", out_signature="")
-    def ValueChanged(self, char, newvalue):
-        print "Watcher: new value for %s: %s" % (char, dbus_type_to_str(newvalue))
-
-def handle_characteristics(char):
-    char.Discover()
-    for c in char.GetProperties()["Characteristics"]:
-        char = dbus.Interface(bus.get_object("org.bluez", c),
-                "org.bluez.Characteristic")
-
-        if options.char_path and c != options.char_path:
-            continue
-
-        if not options.set_property:
-            ret = "Characteristic: %s\nProperties:\n" % c
-            for (k, v) in char.GetProperties().iteritems():
-                ret += "\t%s: %s\n" % (k, dbus_type_to_str(v))
-            print ret
-        elif options.set_property.get(path, None):
-            for (k, v) in options.set_property[path]:
-                char2 = dbus.Interface(bus.get_object("org.bluez",
-                    path), "org.bluez.Characteristic")
-                if k == "Value":
-                    char2.SetProperty(k, hexdump_to_dbus(v))
-                else:
-                    char2.SetProperty(k, v)
-
-def handle_services(device):
-    for s in device.GetProperties()["Services"]:
-        char = dbus.Interface(bus.get_object("org.bluez", s),
-                "org.bluez.Characteristic")
-        if options.listen:
-            char.RegisterCharacteristicsWatcher(watcher_path)
-        else:
-            handle_characteristics(char)
-
-if __name__ == "__main__":
-    (options, args) = command_parse()
-
-    dbus.mainloop.glib.DBusGMainLoop(set_as_default=True)
-    bus = dbus.SystemBus()
-    manager = dbus.Interface(bus.get_object("org.bluez", "/"),
-            "org.bluez.Manager")
-
-    if options.adapter:
-        path = manager.FindAdapter(options.adapter)
-    else:
-        path = manager.DefaultAdapter()
-
-    adapter = dbus.Interface(bus.get_object("org.bluez", path),
-            "org.bluez.Adapter")
-
-    if options.listen:
-        watcher_path = "/test/watcher"
-        watcher = Watcher(bus, watcher_path)
-
-    for d in adapter.GetProperties()["Devices"]:
-        device = dbus.Interface(bus.get_object("org.bluez", d),
-                "org.bluez.Device")
-        handle_services(device)
-
-    if options.listen:
-        print "Waiting for incoming notifications/indications..."
-        mainloop = gobject.MainLoop()
-        mainloop.run()
+from optparse import OptionParser, make_option
+
+dbus.mainloop.glib.DBusGMainLoop(set_as_default=True)
+bus = dbus.SystemBus()
+mainloop = gobject.MainLoop()
+
+manager = dbus.Interface(bus.get_object("org.bluez", "/"), "org.bluez.Manager")
+
+option_list = [
+		make_option("-i", "--device", action="store",
+				type="string", dest="dev_id"),
+		]
+parser = OptionParser(option_list=option_list)
+
+(options, args) = parser.parse_args()
+
+if options.dev_id:
+	adapter_path = manager.FindAdapter(options.dev_id)
+else:
+	adapter_path = manager.DefaultAdapter()
+
+adapter = dbus.Interface(bus.get_object("org.bluez", adapter_path),
+							"org.bluez.Adapter")
+
+if (len(args) < 1):
+	print "Usage: %s <command>" % (sys.argv[0])
+	print ""
+	print "	 list"
+	print "	 services <address>"
+	print "	 discover <service path>"
+	print "	 chars <service path>"
+	sys.exit(1)
+
+if (args[0] == "list"):
+	for path in adapter.ListDevices():
+		device = dbus.Interface(bus.get_object("org.bluez", path),
+							"org.bluez.Device")
+		devprop = device.GetProperties()
+		print "[ %s ]" % devprop["Address"]
+		for path in devprop["Services"]:
+
+			service = dbus.Interface(bus.get_object("org.bluez", path),
+									 "org.bluez.Characteristic")
+			srvprop = service.GetProperties()
+			print " * %s" % (path)
+			print "	UUID: %s" % srvprop["UUID"]
+			print "	Chars: ",
+			for char in srvprop["Characteristics"]:
+				print "%s " % char,
+			print
+			print
+		print
+	sys.exit(0)
+
+if (args[0] == "services"):
+	if (len(args) < 2):
+		print "Need address parameter"
+	else:
+		path = adapter.FindDevice(args[1])
+		device = dbus.Interface(bus.get_object("org.bluez", path),
+							"org.bluez.Device")
+		properties = device.GetProperties()
+		for path in properties["Services"]:
+			print path
+	sys.exit(0)
+
+if (args[0] == "discover"):
+	if (len(args) < 2):
+		print "Need service path parameter"
+	else:
+		service = dbus.Interface(bus.get_object("org.bluez", args[1]),
+							"org.bluez.Characteristic")
+		service.Discover()
+	sys.exit(0)
+
+if (args[0] == "chars"):
+	if (len(args) < 2):
+		print "Need service path parameter"
+	else:
+		service = dbus.Interface(bus.get_object("org.bluez", args[1]),
+								 "org.bluez.Characteristic")
+		srvprop = service.GetProperties()
+		for path in srvprop["Characteristics"]:
+			print "[ %s ]" % (path)
+			char = dbus.Interface(bus.get_object("org.bluez", path),
+								 "org.bluez.Characteristic")
+			charprop = char.GetProperties()
+			print "	Name: %s" % charprop["Name"]
+			print "	UUID: %s" % charprop["UUID"]
+			print
+		print
+	sys.exit(0)
+
+print "Unknown command"
+sys.exit(1)
-- 
1.7.4.1

