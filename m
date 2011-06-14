Return-Path: <cyrus@holtmann.org>
From: Dmitriy Paliy <dmitriy.paliy@nokia.com>
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Cc: Dmitriy Paliy <dmitriy.paliy@nokia.com>
Subject: [PATCH] Add capability option to simple-agent
Date: Tue, 14 Jun 2011 10:19:41 +0300
Message-Id: <1308035981-3623-2-git-send-email-dmitriy.paliy@nokia.com>
In-Reply-To: <1308035981-3623-1-git-send-email-dmitriy.paliy@nokia.com>
References: <1308035981-3623-1-git-send-email-dmitriy.paliy@nokia.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

A new option is added to simple-agent facilitating use of "DisplayOnly",
"DisplayYesNo", "KeyboardOnly" and "NoInputNoOutput" agent capabilities.
---
 test/simple-agent |   24 +++++++++++++++++-------
 1 files changed, 17 insertions(+), 7 deletions(-)

diff --git a/test/simple-agent b/test/simple-agent
index f2cc3dd..8d65860 100755
--- a/test/simple-agent
+++ b/test/simple-agent
@@ -6,6 +6,7 @@ import sys
 import dbus
 import dbus.service
 import dbus.mainloop.glib
+from optparse import OptionParser
 
 class Rejected(dbus.DBusException):
 	_dbus_error_name = "org.bluez.Error.Rejected"
@@ -88,8 +89,17 @@ if __name__ == '__main__':
 	manager = dbus.Interface(bus.get_object("org.bluez", "/"),
 							"org.bluez.Manager")
 
-	if len(sys.argv) > 1:
-		path = manager.FindAdapter(sys.argv[1])
+	capability = "DisplayYesNo"
+
+	parser = OptionParser()
+	parser.add_option("-c", "--capability", action="store",
+					type="string", dest="capability")
+	(options, args) = parser.parse_args()
+	if options.capability:
+		capability  = options.capability
+
+	if len(args) > 0:
+		path = manager.FindAdapter(args[0])
 	else:
 		path = manager.DefaultAdapter()
 
@@ -101,17 +111,17 @@ if __name__ == '__main__':
 
 	mainloop = gobject.MainLoop()
 
-	if len(sys.argv) > 2:
-		if len(sys.argv) > 3:
-			device = adapter.FindDevice(sys.argv[2])
+	if len(args) > 1:
+		if len(args) > 2:
+			device = adapter.FindDevice(args[1])
 			adapter.RemoveDevice(device)
 
 		agent.set_exit_on_release(False)
-		adapter.CreatePairedDevice(sys.argv[2], path, "DisplayYesNo",
+		adapter.CreatePairedDevice(args[1], path, capability,
 					reply_handler=create_device_reply,
 					error_handler=create_device_error)
 	else:
-		adapter.RegisterAgent(path, "DisplayYesNo")
+		adapter.RegisterAgent(path, capability)
 		print "Agent registered"
 
 	mainloop.run()
-- 
1.7.4.1

