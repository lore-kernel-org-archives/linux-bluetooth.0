Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH obexd 05/10] test: Update map-client to the changes in GetMessageListing
Date: Tue,  3 Jul 2012 21:28:09 +0300
Message-Id: <1341340094-32522-5-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1341340094-32522-1-git-send-email-luiz.dentz@gmail.com>
References: <1341340094-32522-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This makes map-client to print the object path and properties of each
message found.
---
 test/map-client |   24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/test/map-client b/test/map-client
index da357a9..be3c307 100755
--- a/test/map-client
+++ b/test/map-client
@@ -6,6 +6,27 @@ import dbus
 import dbus.mainloop.glib
 from optparse import OptionParser
 
+from pprint import pformat
+
+def unwrap(x):
+    """Hack to unwrap D-Bus values, so that they're easier to read when
+    printed. Taken from d-feet """
+
+    if isinstance(x, list):
+        return map(unwrap, x)
+
+    if isinstance(x, tuple):
+        return tuple(map(unwrap, x))
+
+    if isinstance(x, dict):
+        return dict([(unwrap(k), unwrap(v)) for k, v in x.iteritems()])
+
+    for t in [unicode, str, long, int, float, bool]:
+        if isinstance(x, t):
+            return t(x)
+
+    return x
+
 def parse_options():
 	parser.add_option("-d", "--device", dest="device",
 			help="Device to connect", metavar="DEVICE")
@@ -54,6 +75,7 @@ if  __name__ == '__main__':
 			print "%s/" % (i["Name"])
 
 	if options.ls_msg is not None:
-		print map.GetMessageListing(options.ls_msg, dict())
+		ret = map.GetMessageListing(options.ls_msg, dict())
+		print pformat(unwrap(ret))
 
 	mainloop.run()
-- 
1.7.10.4

