Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH obexd] test: Add sync-client script
Date: Mon, 25 Jun 2012 12:22:09 +0300
Message-Id: <1340616129-7288-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds testing script for org.bluez.obex.Syncronization API
---
 test/sync-client |   95 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 95 insertions(+)
 create mode 100755 test/sync-client

diff --git a/test/sync-client b/test/sync-client
new file mode 100755
index 0000000..ad0963a
--- /dev/null
+++ b/test/sync-client
@@ -0,0 +1,95 @@
+#!/usr/bin/python
+
+import gobject
+
+import sys
+import os
+import dbus
+import dbus.service
+import dbus.mainloop.glib
+
+class Transfer:
+	def __init__(self):
+		self.path = None
+		self.filename = None
+
+class SyncClient:
+	def __init__(self, path):
+		self.props = dict()
+		bus = dbus.SessionBus()
+		obj = bus.get_object("org.bluez.obex.client", path)
+		self.session = dbus.Interface(obj, "org.bluez.obex.Session")
+		self.sync = dbus.Interface(obj,
+					"org.bluez.obex.Synchronization")
+		bus.add_signal_receiver(self.transfer_complete,
+				dbus_interface="org.bluez.obex.Transfer",
+				signal_name="Complete",
+				path_keyword="path")
+		bus.add_signal_receiver(self.transfer_error,
+				dbus_interface="org.bluez.obex.Transfer",
+				signal_name="Error",
+				path_keyword="path")
+
+	def register(self, reply, transfer):
+		(path, properties) = reply
+		transfer.path = path
+		transfer.filename = properties["Filename"]
+		self.props[path] = transfer
+		print "Transfer created: %s (file %s)" % (path,
+							transfer.filename)
+
+	def error(self, err):
+		print err
+		mainloop.quit()
+
+	def transfer_complete(self, path):
+		req = self.props.get(path)
+		if req == None:
+			return
+		print "Transfer %s finished" % path
+		f = open(req.filename, "r")
+		os.remove(req.filename)
+		print f.readlines()
+		del self.props[path]
+
+	def transfer_error(self, code, message, path):
+		req = self.props.get(path)
+		if req == None:
+			return
+		print "Transfer finished with error %s: %s" % (code, message)
+		mainloop.quit()
+
+	def get_phonebook(self):
+		req = Transfer()
+		self.sync.GetPhonebook("",
+				reply_handler=lambda r: self.register(r, req),
+				error_handler=self.error)
+
+	def interface(self):
+		return self.sync
+
+if  __name__ == '__main__':
+
+	dbus.mainloop.glib.DBusGMainLoop(set_as_default=True)
+
+	bus = dbus.SessionBus()
+	mainloop = gobject.MainLoop()
+
+	client = dbus.Interface(bus.get_object("org.bluez.obex.client", "/"),
+				"org.bluez.obex.Client")
+
+	if (len(sys.argv) < 2):
+		print "Usage: %s <device>" % (sys.argv[0])
+		sys.exit(1)
+
+	print "Creating Session"
+	path = client.CreateSession(sys.argv[1], { "Target": "SYNC" })
+
+	sync = SyncClient(path)
+
+	print "\n--- SetLocation ---\n"
+	sync.interface().SetLocation("INT")
+	print "\n--- GetPhonebook ---\n"
+	sync.get_phonebook()
+
+	mainloop.run()
-- 
1.7.10.2

