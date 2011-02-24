Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [PATCH] Fix test/test-attrib script
Date: Thu, 24 Feb 2011 18:47:00 -0300
Message-Id: <1298584020-14568-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Characteristics are not being fetched anymore when the device is
created. Discover method needs to be called actively to discover the
characteristics exposed by a given service.
---
 test/test-attrib |   12 ++++++++----
 1 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/test/test-attrib b/test/test-attrib
index 05ee381..dc3f804 100755
--- a/test/test-attrib
+++ b/test/test-attrib
@@ -62,13 +62,17 @@ class Watcher(dbus.service.Object):
         print "Watcher: new value for %s: %s" % (char, dbus_type_to_str(newvalue))
 
 def handle_characteristics(char):
-    for (path, props) in char.GetCharacteristics().iteritems():
-        if options.char_path and path != options.char_path:
+    char.Discover()
+    for c in char.GetProperties()["Characteristics"]:
+        char = dbus.Interface(bus.get_object("org.bluez", c),
+                "org.bluez.Characteristic")
+
+        if options.char_path and c != options.char_path:
             continue
 
         if not options.set_property:
-            ret = "Characteristic: %s\nProperties:\n" % path
-            for (k, v) in props.iteritems():
+            ret = "Characteristic: %s\nProperties:\n" % c
+            for (k, v) in char.GetProperties().iteritems():
                 ret += "\t%s: %s\n" % (k, dbus_type_to_str(v))
             print ret
         elif options.set_property.get(path, None):
-- 
1.7.0.4

