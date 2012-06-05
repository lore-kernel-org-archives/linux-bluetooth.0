Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH obexd 06/23] test: Use org.bluez.obex namespace in simple-agent script
Date: Tue,  5 Jun 2012 13:57:04 +0300
Message-Id: <1338893841-14234-7-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1338893841-14234-1-git-send-email-luiz.dentz@gmail.com>
References: <1338893841-14234-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 test/simple-agent |   37 +++++++++++++++++++------------------
 1 file changed, 19 insertions(+), 18 deletions(-)

diff --git a/test/simple-agent b/test/simple-agent
index 1ac4c17..1902082 100755
--- a/test/simple-agent
+++ b/test/simple-agent
@@ -12,8 +12,8 @@ class Agent(dbus.service.Object):
 		dbus.service.Object.__init__(self, conn, obj_path)
 		self.pending_auth = False
 
-	@dbus.service.method("org.openobex.Agent",
-					in_signature="osssii", out_signature="s")
+	@dbus.service.method("org.bluez.obex.Agent", in_signature="osssii",
+							out_signature="s")
 	def Authorize(self, dpath, device, filename, ftype, length, time):
 		global transfers
 
@@ -23,8 +23,9 @@ class Agent(dbus.service.Object):
 
 		if auth == "n" or auth == "N":
 			self.pending_auth = False
-			raise dbus.DBusException("org.openobex.Error.Rejected: "
-									"Not Autorized")
+			raise dbus.DBusException(
+					"org.bluez.obex.Error.Rejected: "
+					"Not Autorized")
 
 		print "Full filename (including path):"
 		self.pending_auth = False
@@ -32,8 +33,8 @@ class Agent(dbus.service.Object):
 		transfers.append(Transfer(dpath, filename, 0, length))
 		return raw_input().strip("\n ")
 
-	@dbus.service.method("org.openobex.Agent",
-					in_signature="", out_signature="")
+	@dbus.service.method("org.bluez.obex.Agent", in_signature="",
+							out_signature="")
 	def Cancel(self):
 		print "Authorization Canceled"
 		self.pending_auth = False
@@ -53,9 +54,9 @@ class Transfer(object):
 		self.size = total
 
 	def cancel(self):
-		transfer_iface = dbus.Interface(bus.get_object("org.openobex",
-														self.dpath),
-										"org.openobex.Transfer")
+		transfer_iface = dbus.Interface(bus.get_object(
+						"org.bluez.obex", self.dpath),
+						"org.bluez.obex.Transfer")
 		transfer_iface.Cancel()
 
 	def __str__(self):
@@ -71,9 +72,9 @@ if __name__ == '__main__':
 	def new_transfer(dpath):
 		print "new transfer"
 		bus.add_signal_receiver(progress,
-								dbus_interface="org.openobex.Transfer",
-								signal_name="Progress",
-								path_keyword="dpath")
+				dbus_interface="org.bluez.obex.Transfer",
+				signal_name="Progress",
+				path_keyword="dpath")
 
 	def transfer_completed(dpath, success):
 		global transfers
@@ -96,15 +97,15 @@ if __name__ == '__main__':
 	dbus.mainloop.glib.DBusGMainLoop(set_as_default=True)
 
 	bus = dbus.SessionBus()
-	manager = dbus.Interface(bus.get_object("org.openobex", "/"),
-							"org.openobex.Manager")
+	manager = dbus.Interface(bus.get_object("org.bluez.obex", "/"),
+						"org.bluez.obex.Manager")
 	bus.add_signal_receiver(new_transfer,
-							dbus_interface="org.openobex.Manager",
-							signal_name="TransferStarted")
+				dbus_interface="org.bluez.obex.Manager",
+				signal_name="TransferStarted")
 
 	bus.add_signal_receiver(transfer_completed,
-							dbus_interface="org.openobex.Manager",
-							signal_name="TransferCompleted")
+				dbus_interface="org.bluez.obex.Manager",
+				signal_name="TransferCompleted")
 
 	path = "/test/agent"
 	agent = Agent(bus, path)
-- 
1.7.10.2

