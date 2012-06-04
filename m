Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [PATCH obexd v2 14/15] client-test: Add opp-client
Date: Mon,  4 Jun 2012 15:50:27 +0200
Message-Id: <1338817828-12166-15-git-send-email-mikel.astiz.oss@gmail.com>
In-Reply-To: <1338817828-12166-1-git-send-email-mikel.astiz.oss@gmail.com>
References: <1338817828-12166-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

This new scripts replaces previous pull-business-card and send-files.
---
 test/opp-client         |   97 +++++++++++++++++++++++++++++++++++++++++++++++
 test/pull-business-card |   40 -------------------
 test/send-files         |   23 -----------
 3 files changed, 97 insertions(+), 63 deletions(-)
 create mode 100755 test/opp-client
 delete mode 100755 test/pull-business-card
 delete mode 100755 test/send-files

diff --git a/test/opp-client b/test/opp-client
new file mode 100755
index 0000000..2ff38c8
--- /dev/null
+++ b/test/opp-client
@@ -0,0 +1,97 @@
+#!/usr/bin/python
+
+import sys
+import dbus
+import gobject
+import dbus.mainloop.glib
+import os.path
+from optparse import OptionParser
+
+def parse_options():
+	parser.add_option("-d", "--device", dest="device",
+					help="Device to connect",
+					metavar="DEVICE")
+	parser.add_option("-p", "--pull", dest="pull_to_file",
+					help="Pull vcard and store in FILE",
+					metavar="FILE")
+	parser.add_option("-s", "--send", dest="send_file",
+					help="Send FILE", metavar="FILE")
+
+	return parser.parse_args()
+
+class OppClient:
+	def __init__(self, session_path):
+		self.transfer_path = None
+		bus = dbus.SessionBus()
+		obj = bus.get_object("org.openobex.client", session_path)
+		self.session = dbus.Interface(obj, "org.openobex.Session")
+		self.opp = dbus.Interface(obj, "org.openobex.ObjectPush")
+		bus.add_signal_receiver(self.transfer_complete,
+					dbus_interface="org.openobex.Transfer",
+					signal_name="Complete",
+					path_keyword="path")
+		bus.add_signal_receiver(self.transfer_error,
+					dbus_interface="org.openobex.Transfer",
+					signal_name="Error",
+					path_keyword="path")
+
+	def create_transfer_reply(self, reply):
+		(path, properties) = reply
+		self.transfer_path = path
+		print "Transfer created: %s" % path
+
+	def error(self, err):
+		print err
+		mainloop.quit()
+
+	def transfer_complete(self, path):
+		if path != self.transfer_path:
+			return
+		print "Transfer finished"
+		mainloop.quit()
+
+	def transfer_error(self, code, message, path):
+		if path != self.transfer_path:
+			return
+		print "Transfer finished with error %s: %s" % (code, message)
+		mainloop.quit()
+
+	def pull_business_card(self, filename):
+		self.opp.PullBusinessCard(os.path.abspath(filename),
+				reply_handler=self.create_transfer_reply,
+				error_handler=self.error)
+
+	def send_file(self, filename):
+		self.opp.SendFile(os.path.abspath(filename),
+				reply_handler=self.create_transfer_reply,
+				error_handler=self.error)
+
+if __name__ == '__main__':
+
+	dbus.mainloop.glib.DBusGMainLoop(set_as_default=True)
+
+	parser = OptionParser()
+
+	(options, args) = parse_options()
+
+	if not options.device:
+		parser.print_help()
+		sys.exit(0)
+
+	bus = dbus.SessionBus()
+	mainloop = gobject.MainLoop()
+
+	client = dbus.Interface(bus.get_object("org.openobex.client", "/"),
+							"org.openobex.Client")
+
+	print "Creating Session"
+	session_path = client.CreateSession(options.device, { "Target": "OPP" })
+	opp_client = OppClient(session_path)
+
+	if options.pull_to_file:
+		opp_client.pull_business_card(options.pull_to_file)
+
+	if options.send_file:
+		opp_client.send_file(options.send_file)
+
+	mainloop.run()
diff --git a/test/pull-business-card b/test/pull-business-card
deleted file mode 100755
index 6f9267b..0000000
--- a/test/pull-business-card
+++ /dev/null
@@ -1,40 +0,0 @@
-#!/usr/bin/python
-
-import sys
-import dbus
-import gobject
-import dbus.mainloop.glib
-
-def success():
-	mainloop.quit()
-	return
-
-def failure(error):
-	print error
-	mainloop.quit()
-	return
-
-
-if __name__ == '__main__':
-	dbus.mainloop.glib.DBusGMainLoop(set_as_default=True)
-
-	mainloop = gobject.MainLoop()
-
-	bus = dbus.SessionBus()
-	client = dbus.Interface(bus.get_object("org.openobex.client", "/"),
-							"org.openobex.Client")
-
-	if (len(sys.argv) < 3):
-		print "Usage: %s <device> <file>" % (sys.argv[0])
-		sys.exit(1)
-
-	print "Creating Session"
-	session_path = client.CreateSession(sys.argv[1], { "Target": "OPP" })
-	opp = dbus.Interface(bus.get_object("org.openobex.client",
-						session_path),
-						"org.openobex.ObjectPush")
-
-	opp.PullBusinessCard(sys.argv[2],
-				reply_handler=success, error_handler=failure)
-
-	mainloop.run()
diff --git a/test/send-files b/test/send-files
deleted file mode 100755
index 5310c06..0000000
--- a/test/send-files
+++ /dev/null
@@ -1,23 +0,0 @@
-#!/usr/bin/python
-
-import os
-import sys
-import dbus
-
-bus = dbus.SessionBus()
-client = dbus.Interface(bus.get_object("org.openobex.client", "/"),
-						"org.openobex.Client")
-
-if (len(sys.argv) < 3):
-	print "Usage: %s <device> <file> [file*]" % (sys.argv[0])
-	sys.exit(1)
-
-files = [os.path.realpath(f) for f in sys.argv[2:]]
-
-print "Creating Session"
-session_path = client.CreateSession(sys.argv[1], { "Target": "OPP" })
-opp = dbus.Interface(bus.get_object("org.openobex.client", session_path),
-					"org.openobex.ObjectPush")
-
-for f in files:
-	opp.SendFile(f)
-- 
1.7.7.6

