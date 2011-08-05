Return-Path: <cyrus@holtmann.org>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [PATCH 22/23] Add script to test control interface
Date: Fri,  5 Aug 2011 15:15:31 -0300
Message-Id: <1312568132-21112-22-git-send-email-lucas.demarchi@profusion.mobi>
In-Reply-To: <1312568132-21112-1-git-send-email-lucas.demarchi@profusion.mobi>
References: <1312568132-21112-1-git-send-email-lucas.demarchi@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 test/test-control |  108 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 108 insertions(+), 0 deletions(-)
 create mode 100755 test/test-control

diff --git a/test/test-control b/test/test-control
new file mode 100755
index 0000000..280886f
--- /dev/null
+++ b/test/test-control
@@ -0,0 +1,108 @@
+#!/usr/bin/python
+
+import sys
+import dbus
+from optparse import OptionParser, make_option
+
+USAGE = "Usage: %prog [options] <command> [args]"
+COMMANDS = """
+Commands:
+    changetrack <bdaddr> <key> <value> [<key> <value> ...]
+
+    changeplayback <bdaddr> status elapsed-time
+        status: one of playing, stopped, paused, forward-seek, reverse-seek
+                or error.
+        elapsed-time: in milliseconds
+
+    changesetting <bdaddr> setting value
+        setting: one of Equalizer, Repeat, Shuffle or Scan
+        value: value correspondent to the setting specified
+"""
+
+class MyParser(OptionParser):
+    def format_epilog(self, formatter):
+        return self.epilog
+
+bus = dbus.SystemBus()
+
+manager = dbus.Interface(bus.get_object("org.bluez", "/"), "org.bluez.Manager")
+
+option_list = [
+		make_option("-i", "--device", action="store",
+				type="string", dest="dev_id"),
+		]
+parser = MyParser(option_list=option_list, usage=USAGE, epilog=COMMANDS)
+
+(options, args) = parser.parse_args()
+
+if len(args) < 2:
+    parser.print_help()
+    sys.exit(1)
+
+if options.dev_id:
+	adapter_path = manager.FindAdapter(options.dev_id)
+else:
+	adapter_path = manager.DefaultAdapter()
+
+adapter = dbus.Interface(bus.get_object("org.bluez", adapter_path),
+							"org.bluez.Adapter")
+
+device = adapter.FindDevice(args[1])
+control = dbus.Interface(bus.get_object("org.bluez", device),
+                                "org.bluez.Control")
+mp = dbus.Interface(bus.get_object("org.bluez", device),
+                                "org.bluez.MediaPlayer")
+
+def handle_change_track(mp, args):
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
+    mp.ChangeTrack(d)
+
+def handle_change_playback(mp, args):
+    if len(args) != 4:
+        print(USAGE)
+        sys.exit(1)
+
+    status = dbus.String(args[2])
+    elapsed = dbus.UInt32(long(args[3]))
+
+    mp.ChangePlayback(status, elapsed)
+
+def handle_change_setting(mp, args):
+    if len(args) != 4:
+        print(USAGE)
+        sys.exit(1)
+
+    setting = dbus.String(args[2])
+    value = dbus.String(args[3])
+
+    mp.ChangeSetting(setting, value)
+
+
+handlers = { 'changetrack': handle_change_track,
+             'changeplayback': handle_change_playback,
+             'changesetting': handle_change_setting }
+
+if not args[0] in handlers:
+    print("Unknown command -- %s" % argv[1])
+    print(USAGE)
+    sys.exit(1)
+
+handlers[args[0]](mp, args)
-- 
1.7.6

