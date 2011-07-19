Return-Path: <cyrus@holtmann.org>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [RFC 13/19] Add script to test control interface
Date: Tue, 19 Jul 2011 16:49:24 -0300
Message-Id: <1311104970-18600-14-git-send-email-lucas.demarchi@profusion.mobi>
In-Reply-To: <1311104970-18600-1-git-send-email-lucas.demarchi@profusion.mobi>
References: <1311104970-18600-1-git-send-email-lucas.demarchi@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 test/test-control |   67 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 67 insertions(+), 0 deletions(-)
 create mode 100755 test/test-control

diff --git a/test/test-control b/test/test-control
new file mode 100755
index 0000000..4351d73
--- /dev/null
+++ b/test/test-control
@@ -0,0 +1,67 @@
+#!/usr/bin/python
+
+import sys
+import dbus
+from optparse import OptionParser, make_option
+
+USAGE = """Usage: %s <command> [args]
+
+	changetrack <bdaddr> <key> <value> [<key> <value> ...]
+	""" % sys.argv[0]
+
+bus = dbus.SystemBus()
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
+if len(args) < 2:
+	print(USAGE)
+	sys.exit(1)
+
+device = adapter.FindDevice(args[1])
+control = dbus.Interface(bus.get_object("org.bluez", device),
+                                "org.bluez.Control")
+
+def handle_change_track(control, args):
+    if len(args) % 2 != 0:
+        print("Don't know how to handle odd number of parameters")
+        print(USAGE)
+        sys.exit(1)
+
+    d = dict()
+    for i in range(2, len(args), 2):
+        key = args[i]
+        if key == "Title" or key == "Artist" or key == "Album" \
+                                            or key == "Genre":
+            d[key] = dbus.String(args[i + 1].decode(sys.stdin.encoding))
+        elif key == "NumberOfTracks" or key == "TrackNumber"       \
+                                            or key == "TrackDuration":
+            d[key] = dbus.UInt32(int(args[i + 1]))
+        else:
+            print("Unknown metadata: %s" % key)
+            sys.exit(1)
+
+    d = dbus.Dictionary(d, signature='sv')
+    control.ChangeTrack(d)
+
+if args[0] == "changetrack":
+    handle_change_track(control, args)
+else:
+    print("Unknown command -- %s" % argv[1])
+    print(USAGE)
+    sys.exit(1)
-- 
1.7.6

