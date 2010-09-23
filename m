Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [PATCH] Add test/test-attrib for testing Attribute API
Date: Thu, 23 Sep 2010 09:35:24 -0400
Message-Id: <1285248924-12834-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This is an initial version. Watcher registration is not working properly
yet. For now it will list all characteristics and its properties.
---
 test/test-attrib |   93 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 93 insertions(+), 0 deletions(-)
 create mode 100755 test/test-attrib

diff --git a/test/test-attrib b/test/test-attrib
new file mode 100755
index 0000000..bf3334b
--- /dev/null
+++ b/test/test-attrib
@@ -0,0 +1,93 @@
+#!/usr/bin/python
+import sys
+from optparse import OptionParser
+from xml.etree import ElementTree as ET
+from binascii import hexlify
+
+#import gobject
+import dbus
+#import dbus.service
+#import dbus.mainloop.glib
+
+#TEMPERATURE_UUID = "0000a006-0000-1000-8000-00805f9b34fb"
+
+def command_parse():
+    """Parse command line options."""
+
+    usage = """
+    Usage: %s [options]"""
+    parser = OptionParser(usage=usage)
+    parser.add_option("-i", "--adapter", action="store", type="string",
+            dest="adapter", help="Specify local adapter interface")
+    return parser.parse_args()
+
+# FIXME: implement a better way of discovering GATT services
+def gatt_services(device_path):
+    """Get GATT services for a given device."""
+
+    intro = dbus.Interface(bus.get_object("org.bluez", device_path),
+            "org.freedesktop.DBus.Introspectable")
+    tree = ET.fromstring(intro.Introspect())
+    services = [n.attrib["name"] for n in tree.getiterator("node")]
+    services = filter(lambda x: x.startswith("service"), services)
+    services = map(lambda x: device_path + "/" + x, services)
+
+    return services
+
+def characteristics(service_path):
+    """Get characteristics for a given GATT service."""
+
+    char = dbus.Interface(bus.get_object("org.bluez", service_path),
+            "org.bluez.Characteristic")
+
+    return char.GetCharacteristics()
+
+def dbus_type_str(d):
+    """Convert a D-Bus array to a hexdump."""
+
+    if isinstance(d, dbus.Array):
+        return hexlify("".join([str(x) for x in d]))
+    else:
+        return str(d)
+
+#class Watcher(dbus.service.Object):
+#    @dbus.service.method("org.bluez.Watcher", in_signature="oay", out_signature="")
+#    def ValueChanged(self, char, newvalue):
+#        print "XXX: new value for %s: %s" % (char, newvalue)
+
+if __name__ == "__main__":
+    #dbus.mainloop.glib.DBusGMainLoop(set_as_default=True)
+    bus = dbus.SystemBus()
+    manager = dbus.Interface(bus.get_object("org.bluez", "/"),
+            "org.bluez.Manager")
+
+    (options, args) = command_parse()
+
+    if options.adapter:
+        path = manager.FindAdapter(options.adapter)
+    else:
+        path = manager.DefaultAdapter()
+
+    adapter = dbus.Interface(bus.get_object("org.bluez", path),
+            "org.bluez.Adapter")
+
+    #watcher = None
+
+    for d in adapter.GetProperties()["Devices"]:
+        for s in gatt_services(d):
+            for (path, props) in characteristics(s).iteritems():
+                ret = "Characteristic: %s\nProperties:\n" % path
+                for (k, v) in props.iteritems():
+                    # FIXME: Watcher registration not working properly. We
+                    # still need to figure out how to properly create the
+                    # Object whose ValueChanged() method will be called
+                    #if (k, v) == ["UUID", TEMPERATURE_UUID]:
+                    #    char = dbus.Interface(bus.get_object("org.bluez", s),
+                    #            "org.bluez.Characteristic")
+                    #    watcher = Watcher(bus, path)
+                    #    char.RegisterCharacteristicsWatcher(path)
+                    ret += "\t%s: %s\n" % (k, dbus_type_str(v))
+                print ret
+
+    #mainloop = gobject.MainLoop()
+    #mainloop.run()
-- 
1.7.0.4

