Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [PATCH obexd v0 04/12] client-test: Update to wrapped OPP session type
Date: Mon, 21 May 2012 11:07:06 +0200
Message-Id: <1337591234-24919-5-git-send-email-mikel.astiz.oss@gmail.com>
In-Reply-To: <1337591234-24919-1-git-send-email-mikel.astiz.oss@gmail.com>
References: <1337591234-24919-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

---
 test/exchange-business-cards |   10 ++++-
 test/get-capabilities        |   16 ++++----
 test/pull-business-card      |    9 ++++-
 test/send-files              |   85 ++++++-----------------------------------
 4 files changed, 37 insertions(+), 83 deletions(-)

diff --git a/test/exchange-business-cards b/test/exchange-business-cards
index 4b0c7ed..548ad2d 100755
--- a/test/exchange-business-cards
+++ b/test/exchange-business-cards
@@ -11,5 +11,11 @@ if (len(sys.argv) < 4):
 	print "Usage: %s <device> <clientfile> <file>" % (sys.argv[0])
 	sys.exit(1)
 
-client.ExchangeBusinessCards({ "Destination": sys.argv[1] },
-						sys.argv[2], sys.argv[3])
+print "Creating Session"
+session_path = client.CreateSession({"Destination": sys.argv[1],
+					"Target": "OPP"})
+opp = dbus.Interface(bus.get_object("org.openobex.client",
+					session_path),
+					"org.openobex.ObjectPush")
+
+opp.ExchangeBusinessCards(sys.argv[2], sys.argv[3])
diff --git a/test/get-capabilities b/test/get-capabilities
index c835bd9..29120f1 100755
--- a/test/get-capabilities
+++ b/test/get-capabilities
@@ -7,14 +7,14 @@ bus = dbus.SessionBus()
 client = dbus.Interface(bus.get_object("org.openobex.client", "/"),
 					"org.openobex.Client")
 
-if (len(sys.argv) < 2):
-	print "Usage: %s <device> [target]" % (sys.argv[0])
+if (len(sys.argv) < 3):
+	print "Usage: %s <device> <target>" % (sys.argv[0])
 	sys.exit(1)
 
-if (len(sys.argv) == 3):
-	dict = {"Destination": sys.argv[1],
-		"Target": sys.argv[2]}
-else:
-	dict = {"Destination": sys.argv[1]}
+print "Creating Session"
+session_path = client.CreateSession({"Destination": sys.argv[1],
+						"Target": sys.argv[2]})
+session = dbus.Interface(bus.get_object("org.openobex.client", session_path),
+							"org.openobex.Session")
 
-print client.GetCapabilities(dict)
+print session.GetCapabilities()
diff --git a/test/pull-business-card b/test/pull-business-card
index b13968d..5912155 100755
--- a/test/pull-business-card
+++ b/test/pull-business-card
@@ -28,7 +28,14 @@ if __name__ == '__main__':
 		print "Usage: %s <device> <file>" % (sys.argv[0])
 		sys.exit(1)
 
-	client.PullBusinessCard({ "Destination": sys.argv[1] }, sys.argv[2],
+	print "Creating Session"
+	session_path = client.CreateSession({"Destination": sys.argv[1],
+						"Target": "OPP"})
+	opp = dbus.Interface(bus.get_object("org.openobex.client",
+						session_path),
+						"org.openobex.ObjectPush")
+
+	opp.PullBusinessCard(sys.argv[2],
 				reply_handler=success, error_handler=failure)
 
 	mainloop.run()
diff --git a/test/send-files b/test/send-files
index 52f9c04..504a066 100755
--- a/test/send-files
+++ b/test/send-files
@@ -1,82 +1,23 @@
 #!/usr/bin/python
 
-import gobject
-
 import os
 import sys
-import time
 import dbus
-import dbus.service
-import dbus.mainloop.glib
-
-class Agent(dbus.service.Object):
-	def __init__(self, conn=None, obj_path=None):
-		dbus.service.Object.__init__(self, conn, obj_path)
-
-	@dbus.service.method("org.openobex.Agent",
-					in_signature="o", out_signature="s")
-	def Request(self, path):
-		print "Transfer Request"
-		self.transfer = dbus.Interface(bus.get_object("org.openobex.client",
-						path), "org.openobex.Transfer")
-		properties = self.transfer.GetProperties()
-		for key in properties.keys():
-			print "  %s = %s" % (key, properties[key])
-		self.start = True
-		return ""
-
-	@dbus.service.method("org.openobex.Agent",
-					in_signature="ot", out_signature="")
-	def Progress(self, path, transferred):
-		if (self.start):
-			print "Transfer Started"
-			properties = self.transfer.GetProperties()
-			self.transfer_size = properties['Size']
-			self.start_time = time.time()
-			self.start = False
-		else:
-			speed = transferred / abs((time.time() - self.start_time) * 1000)
-			progress = "(" + str(transferred) + "/" + str(self.transfer_size) + " bytes) @ " + str(int(speed)) + " kB/s"
-			out = "\rTransfer progress " + progress
-			sys.stdout.write(out)
-			sys.stdout.flush()
-		return
-
-	@dbus.service.method("org.openobex.Agent",
-					in_signature="o", out_signature="")
-	def Complete(self, path):
-		print "\nTransfer finished"
-		return
-
-	@dbus.service.method("org.openobex.Agent",
-					in_signature="os", out_signature="")
-	def Error(self, path, error):
-		print "\nTransfer finished with an error: %s" % (error)
-		return
-
-	@dbus.service.method("org.openobex.Agent",
-					in_signature="", out_signature="")
-	def Release(self):
-		mainloop.quit()
-		return
-
-if __name__ == '__main__':
-	dbus.mainloop.glib.DBusGMainLoop(set_as_default=True)
-
-	bus = dbus.SessionBus()
-	client = dbus.Interface(bus.get_object("org.openobex.client", "/"),
-							"org.openobex.Client")
 
-	if (len(sys.argv) < 3):
-		print "Usage: %s <device> <file> [file*]" % (sys.argv[0])
-		sys.exit(1)
+bus = dbus.SessionBus()
+client = dbus.Interface(bus.get_object("org.openobex.client", "/"),
+						"org.openobex.Client")
 
-	path = "/test/agent"
-	agent = Agent(bus, path)
+if (len(sys.argv) < 3):
+	print "Usage: %s <device> <file> [file*]" % (sys.argv[0])
+	sys.exit(1)
 
-	mainloop = gobject.MainLoop()
-	files = [os.path.realpath(f) for f in sys.argv[2:]]
+files = [os.path.realpath(f) for f in sys.argv[2:]]
 
-	client.SendFiles({ "Destination": sys.argv[1] }, files, path)
+print "Creating Session"
+session_path = client.CreateSession({"Destination": sys.argv[1],
+					"Target": "OPP"})
+opp = dbus.Interface(bus.get_object("org.openobex.client", session_path),
+					"org.openobex.ObjectPush")
 
-	mainloop.run()
+opp.SendFiles(files)
-- 
1.7.7.6

