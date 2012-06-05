Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH obexd 22/23 v2] test: Use org.bluez.obex namespace in pbap-client script
Date: Tue,  5 Jun 2012 16:03:10 +0300
Message-Id: <1338901391-17138-23-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1338901391-17138-1-git-send-email-luiz.dentz@gmail.com>
References: <1338901391-17138-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 test/pbap-client |   54 +++++++++++++++++++++++++++++-------------------------
 1 file changed, 29 insertions(+), 25 deletions(-)

diff --git a/test/pbap-client b/test/pbap-client
index 0ed8b1e..498f8a3 100755
--- a/test/pbap-client
+++ b/test/pbap-client
@@ -16,27 +16,28 @@ class Transfer:
 
 class PbapClient:
 	def __init__(self, session_path):
-		self.pending_transfers = 0
-		self.transfer_dict = dict()
+		self.transfers = 0
+		self.props = dict()
 		self.flush_func = None
 		bus = dbus.SessionBus()
-		obj = bus.get_object("org.openobex.client", session_path)
-		self.session = dbus.Interface(obj, "org.openobex.Session")
-		self.pbap = dbus.Interface(obj, "org.openobex.PhonebookAccess")
+		obj = bus.get_object("org.bluez.obex.client", session_path)
+		self.session = dbus.Interface(obj, "org.bluez.obex.Session")
+		self.pbap = dbus.Interface(obj,
+					"org.bluez.obex.PhonebookAccess")
 		bus.add_signal_receiver(self.transfer_complete,
-					dbus_interface="org.openobex.Transfer",
-					signal_name="Complete",
-					path_keyword="path")
+				dbus_interface="org.bluez.obex.Transfer",
+				signal_name="Complete",
+				path_keyword="path")
 		bus.add_signal_receiver(self.transfer_error,
-					dbus_interface="org.openobex.Transfer",
-					signal_name="Error",
-					path_keyword="path")
+				dbus_interface="org.bluez.obex.Transfer",
+				signal_name="Error",
+				path_keyword="path")
 
 	def register(self, reply, transfer):
 		(path, properties) = reply
 		transfer.path = path
 		transfer.filename = properties["Filename"]
-		self.transfer_dict[path] = transfer
+		self.props[path] = transfer
 		print "Transfer created: %s (file %s)" % (path,
 							transfer.filename)
 
@@ -45,25 +46,25 @@ class PbapClient:
 		mainloop.quit()
 
 	def transfer_complete(self, path):
-		req = self.transfer_dict.get(path)
+		req = self.props.get(path)
 		if req == None:
 			return
-		self.pending_transfers -= 1
+		self.transfers -= 1
 		print "Transfer %s finished" % path
 		f = open(req.filename, "r")
 		os.remove(req.filename)
 		lines = f.readlines()
-		del self.transfer_dict[path]
+		del self.props[path]
 		req.callback_func(lines)
 
-		if (len(self.transfer_dict) == 0) and (self.pending_transfers == 0):
+		if (len(self.props) == 0) and (self.transfers == 0):
 			if self.flush_func != None:
 				f = self.flush_func
 				self.flush_func = None
 				f()
 
 	def transfer_error(self, code, message, path):
-		req = self.transfer_dict.get(path)
+		req = self.props.get(path)
 		if req == None:
 			return
 		print "Transfer finished with error %s: %s" % (code, message)
@@ -74,17 +75,17 @@ class PbapClient:
 		self.pbap.Pull(vcard, "",
 				reply_handler=lambda r: self.register(r, req),
 				error_handler=self.error)
-		self.pending_transfers += 1
+		self.transfers += 1
 
 	def pull_all(self, func):
 		req = Transfer(func)
 		self.pbap.PullAll("",
 				reply_handler=lambda r: self.register(r, req),
 				error_handler=self.error)
-		self.pending_transfers += 1
+		self.transfers += 1
 
 	def flush_transfers(self, func):
-		if (len(self.transfer_dict) == 0) and (self.pending_transfers == 0):
+		if (len(self.props) == 0) and (self.transfers == 0):
 			return
 		self.flush_func = func
 
@@ -98,8 +99,8 @@ if  __name__ == '__main__':
 	bus = dbus.SessionBus()
 	mainloop = gobject.MainLoop()
 
-	client = dbus.Interface(bus.get_object("org.openobex.client", "/"),
-				"org.openobex.Client")
+	client = dbus.Interface(bus.get_object("org.bluez.obex.client", "/"),
+				"org.bluez.obex.Client")
 
 	if (len(sys.argv) < 2):
 		print "Usage: %s <device>" % (sys.argv[0])
@@ -138,12 +139,15 @@ if  __name__ == '__main__':
 		for item in ret:
 			print "%s : %s" % (item[0], item[1])
 			pbap_client.interface().SetFormat("vcard30")
-			pbap_client.interface().SetFilter(["VERSION", "FN", "TEL"]);
-			pbap_client.pull(item[0], lambda x: process_result(x, None))
+			pbap_client.interface().SetFilter(["VERSION", "FN",
+								"TEL"]);
+			pbap_client.pull(item[0],
+					lambda x: process_result(x, None))
 
 		pbap_client.interface().SetFormat("vcard30")
 		pbap_client.interface().SetFilter(["VERSION", "FN", "TEL"]);
-		pbap_client.pull_all(lambda x: process_result(x, "\n--- PullAll ---\n"))
+		pbap_client.pull_all(lambda x: process_result(x,
+							"\n--- PullAll ---\n"))
 
 		pbap_client.flush_transfers(lambda: test_paths(paths[1:]))
 
-- 
1.7.10.2

