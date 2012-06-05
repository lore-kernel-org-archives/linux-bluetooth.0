Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH obexd 22/23] test: Use org.bluez.obex namespace in pbap-client script
Date: Tue,  5 Jun 2012 13:57:20 +0300
Message-Id: <1338893841-14234-23-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1338893841-14234-1-git-send-email-luiz.dentz@gmail.com>
References: <1338893841-14234-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 test/pbap-client |   38 ++++++++++++++++++++++----------------
 1 file changed, 22 insertions(+), 16 deletions(-)

diff --git a/test/pbap-client b/test/pbap-client
index 0ed8b1e..4933b88 100755
--- a/test/pbap-client
+++ b/test/pbap-client
@@ -20,17 +20,18 @@ class PbapClient:
 		self.transfer_dict = dict()
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
@@ -56,7 +57,8 @@ class PbapClient:
 		del self.transfer_dict[path]
 		req.callback_func(lines)
 
-		if (len(self.transfer_dict) == 0) and (self.pending_transfers == 0):
+		if (len(self.transfer_dict) == 0) and
+						(self.pending_transfers == 0):
 			if self.flush_func != None:
 				f = self.flush_func
 				self.flush_func = None
@@ -84,7 +86,8 @@ class PbapClient:
 		self.pending_transfers += 1
 
 	def flush_transfers(self, func):
-		if (len(self.transfer_dict) == 0) and (self.pending_transfers == 0):
+		if (len(self.transfer_dict) == 0) and
+						(self.pending_transfers == 0):
 			return
 		self.flush_func = func
 
@@ -98,8 +101,8 @@ if  __name__ == '__main__':
 	bus = dbus.SessionBus()
 	mainloop = gobject.MainLoop()
 
-	client = dbus.Interface(bus.get_object("org.openobex.client", "/"),
-				"org.openobex.Client")
+	client = dbus.Interface(bus.get_object("org.bluez.obex.client", "/"),
+				"org.bluez.obex.Client")
 
 	if (len(sys.argv) < 2):
 		print "Usage: %s <device>" % (sys.argv[0])
@@ -138,12 +141,15 @@ if  __name__ == '__main__':
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

