Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH obexd 21/23 v2] test: Use org.bluez.obex namespace in opp-client script
Date: Tue,  5 Jun 2012 16:03:09 +0300
Message-Id: <1338901391-17138-22-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1338901391-17138-1-git-send-email-luiz.dentz@gmail.com>
References: <1338901391-17138-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 test/opp-client |   26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/test/opp-client b/test/opp-client
index ef76d18..b7e434c 100755
--- a/test/opp-client
+++ b/test/opp-client
@@ -21,17 +21,17 @@ class OppClient:
 	def __init__(self, session_path):
 		self.transfer_path = None
 		bus = dbus.SessionBus()
-		obj = bus.get_object("org.openobex.client", session_path)
-		self.session = dbus.Interface(obj, "org.openobex.Session")
-		self.opp = dbus.Interface(obj, "org.openobex.ObjectPush")
+		obj = bus.get_object("org.bluez.obex.client", session_path)
+		self.session = dbus.Interface(obj, "org.bluez.obex.Session")
+		self.opp = dbus.Interface(obj, "org.bluez.obex.ObjectPush")
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
 
 	def create_transfer_reply(self, reply):
 		(path, properties) = reply
@@ -79,13 +79,13 @@ if  __name__ == '__main__':
 	bus = dbus.SessionBus()
 	mainloop = gobject.MainLoop()
 
-	client = dbus.Interface(bus.get_object("org.openobex.client", "/"),
-				"org.openobex.Client")
+	client = dbus.Interface(bus.get_object("org.bluez.obex.client", "/"),
+				"org.bluez.obex.Client")
 
 	print "Creating Session"
-	session_path = client.CreateSession(options.device, { "Target": "OPP" })
+	path = client.CreateSession(options.device, { "Target": "OPP" })
 
-	opp_client = OppClient(session_path)
+	opp_client = OppClient(path)
 
 	if options.pull_to_file:
 		opp_client.pull_business_card(options.pull_to_file)
-- 
1.7.10.2

