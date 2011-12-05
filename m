Return-Path: <cyrus@holtmann.org>
From: Bartosz Szatkowski <bulislaw@linux.com>
To: linux-bluetooth@vger.kernel.org
Cc: Bartosz Szatkowski <bulislaw@linux.com>
Subject: [PATCH obexd 4/6] Add simple helper for MAP client
Date: Mon,  5 Dec 2011 12:41:47 +0100
Message-Id: <1323085309-23094-4-git-send-email-bulislaw@linux.com>
In-Reply-To: <1323085309-23094-1-git-send-email-bulislaw@linux.com>
References: <1323085309-23094-1-git-send-email-bulislaw@linux.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 Makefile.am     |    3 ++-
 test/map-client |   52 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 54 insertions(+), 1 deletions(-)
 create mode 100755 test/map-client

diff --git a/Makefile.am b/Makefile.am
index 60c4982..0b0f670 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -9,7 +9,8 @@ doc_files = doc/obexd-api.txt doc/agent-api.txt doc/client-api.txt
 
 test_files = test/simple-agent test/send-files \
 		test/pull-business-card test/exchange-business-cards \
-		test/list-folders test/pbap-client test/ftp-client
+		test/list-folders test/pbap-client test/ftp-client \
+		test/map-client
 
 gdbus_sources = gdbus/gdbus.h gdbus/mainloop.c gdbus/watch.c \
 					gdbus/object.c gdbus/polkit.c
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

