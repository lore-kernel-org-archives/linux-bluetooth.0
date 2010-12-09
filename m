Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH] Convert CreateDevice on test-device script to an asynchronous call
Date: Thu,  9 Dec 2010 16:42:14 -0300
Message-Id: <1291923734-30979-1-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1291923166-30880-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1291923166-30880-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Change required to test the scenario when the sender of a CreateDevice
request disconnects from the system bus. Current implementation is
blocking and it doesn't allow the user to cancel a request.
---
 test/test-device |   22 +++++++++++++++++++---
 1 files changed, 19 insertions(+), 3 deletions(-)

diff --git a/test/test-device b/test/test-device
index a04ff35..828349c 100755
--- a/test/test-device
+++ b/test/test-device
@@ -1,11 +1,16 @@
 #!/usr/bin/python
 
+import gobject
+
 import sys
 import dbus
+import dbus.mainloop.glib
 import re
 from optparse import OptionParser, make_option
 
+dbus.mainloop.glib.DBusGMainLoop(set_as_default=True)
 bus = dbus.SystemBus()
+mainloop = gobject.MainLoop()
 
 manager = dbus.Interface(bus.get_object("org.bluez", "/"), "org.bluez.Manager")
 
@@ -48,13 +53,24 @@ if (args[0] == "list"):
 
 	sys.exit(0)
 
+def create_device_reply(device):
+	print "New device (%s)" % device
+	mainloop.quit()
+	sys.exit(0)
+
+def create_device_error(error):
+	print "Creating device failed: %s" % error
+	mainloop.quit()
+	sys.exit(1)
+
 if (args[0] == "create"):
 	if (len(args) < 2):
 		print "Need address parameter"
 	else:
-		device = adapter.CreateDevice(args[1])
-		print device
-	sys.exit(0)
+		adapter.CreateDevice(args[1],
+				reply_handler=create_device_reply,
+				error_handler=create_device_error)
+	mainloop.run()
 
 if (args[0] == "remove"):
 	if (len(args) < 2):
-- 
1.7.3.3

