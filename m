Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH obexd 19/23 v2] test: Use org.bluez.obex namespace in ftp-client script
Date: Tue,  5 Jun 2012 16:03:07 +0300
Message-Id: <1338901391-17138-20-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1338901391-17138-1-git-send-email-luiz.dentz@gmail.com>
References: <1338901391-17138-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 test/ftp-client |   27 +++++++++++++--------------
 1 file changed, 13 insertions(+), 14 deletions(-)

diff --git a/test/ftp-client b/test/ftp-client
index 7cf9bfc..39d7675 100755
--- a/test/ftp-client
+++ b/test/ftp-client
@@ -38,17 +38,17 @@ class FtpClient:
 		self.transfer_path = None
 		self.verbose = verbose
 		bus = dbus.SessionBus()
-		obj = bus.get_object("org.openobex.client", session_path)
-		self.session = dbus.Interface(obj, "org.openobex.Session")
-		self.ftp = dbus.Interface(obj, "org.openobex.FileTransfer")
+		obj = bus.get_object("org.bluez.obex.client", session_path)
+		self.session = dbus.Interface(obj, "org.bluez.obex.Session")
+		self.ftp = dbus.Interface(obj, "org.bluez.obex.FileTransfer")
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
@@ -130,14 +130,13 @@ if  __name__ == '__main__':
 	bus = dbus.SessionBus()
 	mainloop = gobject.MainLoop()
 
-	client = dbus.Interface(bus.get_object("org.openobex.client", "/"),
-				"org.openobex.Client")
+	client = dbus.Interface(bus.get_object("org.bluez.obex.client", "/"),
+				"org.bluez.obex.Client")
 
 	print "Creating Session"
-	session_path = client.CreateSession(options.device,
-					{ "Target": "ftp" })
+	path = client.CreateSession(options.device, { "Target": "ftp" })
 
-	ftp_client = FtpClient(session_path)
+	ftp_client = FtpClient(path)
 
 	if options.new_dir:
 		ftp_client.change_folder(options.new_dir)
-- 
1.7.10.2

