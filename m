Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH obexd 2/2] test: Add progress support to opp-client
Date: Fri,  8 Jun 2012 12:54:09 +0300
Message-Id: <1339149249-24734-2-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1339149249-24734-1-git-send-email-luiz.dentz@gmail.com>
References: <1339149249-24734-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Print transfer progress when verbose mode is enabled.
---
 test/opp-client |   33 +++++++++++++++++++++++++++++----
 1 file changed, 29 insertions(+), 4 deletions(-)

diff --git a/test/opp-client b/test/opp-client
index b7e434c..3d23dfb 100755
--- a/test/opp-client
+++ b/test/opp-client
@@ -14,12 +14,16 @@ def parse_options():
 			help="Pull vcard and store in FILE", metavar="FILE")
 	parser.add_option("-s", "--send", dest="send_file",
 			help="Send FILE", metavar="FILE")
+	parser.add_option("-v", "--verbose", action="store_true",
+			dest="verbose")
 
 	return parser.parse_args()
 
 class OppClient:
-	def __init__(self, session_path):
+	def __init__(self, session_path, verbose=False):
+		self.progress = 0
 		self.transfer_path = None
+		self.verbose = verbose
 		bus = dbus.SessionBus()
 		obj = bus.get_object("org.bluez.obex.client", session_path)
 		self.session = dbus.Interface(obj, "org.bluez.obex.Session")
@@ -32,11 +36,18 @@ class OppClient:
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
-		print "Transfer created: %s" % path
+		self.transfer_size = properties["Size"]
+		if self.verbose:
+			print "Transfer created: %s" % path
 
 	def error(self, err):
 		print err
@@ -45,7 +56,8 @@ class OppClient:
 	def transfer_complete(self, path):
 		if path != self.transfer_path:
 			return
-		print "Transfer finished"
+		if self.verbose:
+			print "Transfer finished"
 		mainloop.quit()
 
 	def transfer_error(self, code, message, path):
@@ -54,6 +66,19 @@ class OppClient:
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
 	def pull_business_card(self, filename):
 		self.opp.PullBusinessCard(os.path.abspath(filename),
 				reply_handler=self.create_transfer_reply,
@@ -85,7 +110,7 @@ if  __name__ == '__main__':
 	print "Creating Session"
 	path = client.CreateSession(options.device, { "Target": "OPP" })
 
-	opp_client = OppClient(path)
+	opp_client = OppClient(path, options.verbose)
 
 	if options.pull_to_file:
 		opp_client.pull_business_card(options.pull_to_file)
-- 
1.7.10.2

