Return-Path: <cyrus@holtmann.org>
From: Bartosz Szatkowski <bulislaw@linux.com>
To: linux-bluetooth@vger.kernel.org
Cc: Bartosz Szatkowski <bulislaw@linux.com>
Subject: [PATCHv2 obexd 4/4] Add simple helper for MAP client
Date: Fri,  2 Dec 2011 13:32:22 +0100
Message-Id: <1322829142-7855-4-git-send-email-bulislaw@linux.com>
In-Reply-To: <1322829142-7855-1-git-send-email-bulislaw@linux.com>
References: <1322829142-7855-1-git-send-email-bulislaw@linux.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 test/map-client |   52 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 52 insertions(+), 0 deletions(-)
 create mode 100755 test/map-client

diff --git a/test/map-client b/test/map-client
new file mode 100755
index 0000000..5ee4331
--- /dev/null
+++ b/test/map-client
@@ -0,0 +1,52 @@
+#!/usr/bin/python
+
+import gobject
+
+import dbus
+import dbus.mainloop.glib
+from optparse import OptionParser
+
+def parse_options():
+    parser.add_option("-d", "--device", dest="device",
+                      help="Device to connect", metavar="DEVICE")
+    parser.add_option("-c", "--chdir", dest="new_dir",
+                      help="Change current directory to DIR", metavar="DIR")
+    parser.add_option("-v", "--verbose", action="store_true", dest="verbose")
+
+    return parser.parse_args()
+
+def set_folder(session, new_dir):
+    for node in new_dir.split("/"):
+        session.SetFolder(node)
+
+if  __name__ == '__main__':
+
+    dbus.mainloop.glib.DBusGMainLoop(set_as_default=True)
+
+    parser = OptionParser()
+
+    (options, args) = parse_options()
+
+    if not options.device:
+        parser.print_help()
+        exit(0)
+
+    bus = dbus.SessionBus()
+    mainloop = gobject.MainLoop()
+
+    client = dbus.Interface(bus.get_object("org.openobex.client", "/"),
+                            "org.openobex.Client")
+
+    session_path = client.CreateSession({ "Destination": options.device,
+                                          "Target": "map"})
+
+    session = dbus.Interface(bus.get_object("org.openobex.client", session_path),
+                 "org.openobex.Session")
+
+    map = dbus.Interface(bus.get_object("org.openobex.client", session_path),
+                 "org.openobex.MessageAccess")
+
+    if options.new_dir:
+        set_folder(map, options.new_dir)
+
+    mainloop.run()
-- 
1.7.4.1

