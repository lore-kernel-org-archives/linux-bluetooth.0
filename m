Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH obexd 1/2] test: Add progress support to ftp-client
Date: Fri,  8 Jun 2012 12:54:08 +0300
Message-Id: <1339149249-24734-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Print transfer progress when verbose mode is enabled.
---
 test/ftp-client |   23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/test/ftp-client b/test/ftp-client
index 39d7675..064a81a 100755
--- a/test/ftp-client
+++ b/test/ftp-client
@@ -35,7 +35,9 @@ def parse_options():
 
 class FtpClient:
 	def __init__(self, session_path, verbose=False):
+		self.progress = 0
 		self.transfer_path = None
+		self.transfer_size = 0
 		self.verbose = verbose
 		bus = dbus.SessionBus()
 		obj = bus.get_object("org.bluez.obex.client", session_path)
@@ -49,10 +51,16 @@ class FtpClient:
 				dbus_interface="org.bluez.obex.Transfer",
 				signal_name="Error",
 				path_keyword="path")
+		if self.verbose:
+			bus.add_signal_receiver(self.transfer_progress,
+				dbus_interface="org.bluez.obex.Transfer",
+				signal_name="PropertyChanged",
+				path_keyword="path")
 
 	def create_transfer_reply(self, reply):
 		(path, properties) = reply
 		self.transfer_path = path
+		self.transfer_size = properties["Size"]
 		if self.verbose:
 			print "Transfer created: %s" % path
 
@@ -77,6 +85,19 @@ class FtpClient:
 		print "Transfer finished with error %s: %s" % (code, message)
 		mainloop.quit()
 
+	def transfer_progress(self, prop, value, path):
+		if path != self.transfer_path:
+			return
+
+		if prop != "Progress":
+			return
+
+		speed = (value - self.progress) / 1000
+		print "Transfer progress %d/%d at %d kBps" % (value,
+							self.transfer_size,
+							speed)
+		self.progress = value
+
 	def change_folder(self, new_dir):
 		for node in new_dir.split("/"):
 			self.ftp.ChangeFolder(node)
@@ -136,7 +157,7 @@ if  __name__ == '__main__':
 	print "Creating Session"
 	path = client.CreateSession(options.device, { "Target": "ftp" })
 
-	ftp_client = FtpClient(path)
+	ftp_client = FtpClient(path, options.verbose)
 
 	if options.new_dir:
 		ftp_client.change_folder(options.new_dir)
-- 
1.7.10.2

