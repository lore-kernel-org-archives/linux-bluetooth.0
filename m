Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [RFC BlueZ 3/4] Update test-attrib to handle notifications and indications
Date: Fri, 11 Nov 2011 21:20:08 -0300
Message-Id: <1321057209-24931-4-git-send-email-vinicius.gomes@openbossa.org>
In-Reply-To: <1321057209-24931-1-git-send-email-vinicius.gomes@openbossa.org>
References: <1321057209-24931-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

For supporting indications and notification we need two features,
a way to configure the CCC attribute (implemented recently) and
a way to listen for notifications, that was already implemented
using the Characteristic Watcher.
---
 test/test-attrib |   45 +++++++++++++++++++++++++++++++++++++++++++--
 1 files changed, 43 insertions(+), 2 deletions(-)

diff --git a/test/test-attrib b/test/test-attrib
index b9e83c5..f5787e1 100755
--- a/test/test-attrib
+++ b/test/test-attrib
@@ -9,9 +9,18 @@ import gobject
 
 import sys
 import dbus
+import dbus.service
 import dbus.mainloop.glib
 from optparse import OptionParser, make_option
 
+class Watcher(dbus.service.Object):
+	exit_on_release = True
+
+	@dbus.service.method("org.bluez.Watcher",
+					in_signature="oay", out_signature="")
+	def ValueChanged(self, characteristic, value):
+		print "ValueChanged: %s -> %s" % (characteristic, value)
+
 dbus.mainloop.glib.DBusGMainLoop(set_as_default=True)
 bus = dbus.SystemBus()
 mainloop = gobject.MainLoop()
@@ -34,6 +43,9 @@ else:
 adapter = dbus.Interface(bus.get_object("org.bluez", adapter_path),
 							"org.bluez.Adapter")
 
+watcher_path = "/test/watcher"
+watcher = Watcher(bus, watcher_path);
+
 if (len(args) < 1):
 	print "Usage: %s <command>" % (sys.argv[0])
 	print ""
@@ -41,6 +53,8 @@ if (len(args) < 1):
 	print "	 services <address>"
 	print "	 discover <service path>"
 	print "	 chars <service path>"
+	print "	 register <service path>"
+	print "	 config <char path> [\"notify\", \"indicate\" or \"none\"]"
 	sys.exit(1)
 
 if (args[0] == "list"):
@@ -98,11 +112,38 @@ if (args[0] == "chars"):
 			char = dbus.Interface(bus.get_object("org.bluez", path),
 								 "org.bluez.Characteristic")
 			charprop = char.GetProperties()
-			print "	Name: %s" % charprop["Name"]
-			print "	UUID: %s" % charprop["UUID"]
+			for (k, v) in charprop.items():
+					print "%s: %s" % (k, v);
 			print
 		print
 	sys.exit(0)
 
+if (args[0] == "register"):
+	if (len(args) < 2):
+		print "Need service path parameter"
+		sys.exit(0)
+
+	service = dbus.Interface(bus.get_object("org.bluez", args[1]),
+								 "org.bluez.Characteristic")
+
+	service.RegisterCharacteristicsWatcher(dbus.ObjectPath(watcher_path))
+	mainloop.run()
+
+if (args[0] == "config"):
+	if (len(args) < 2):
+		print "Need characteristic path parameter"
+		sys.exit(0)
+
+	char = dbus.Interface(bus.get_object("org.bluez", args[1]),
+									"org.bluez.Characteristic")
+	if (len(args) == 2):
+		charprop = char.GetProperties()
+		print "config %s" % (charprop["Config"])
+	else:
+		char.SetProperty("Config", args[2])
+		charprop = char.GetProperties()
+		print "config %s" % (charprop["Config"])
+	sys.exit(0)
+
 print "Unknown command"
 sys.exit(1)
-- 
1.7.7

