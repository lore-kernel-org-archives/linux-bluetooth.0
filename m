Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH obexd 10/10] test: Add support for Message.Get to map-client
Date: Tue,  3 Jul 2012 21:28:14 +0300
Message-Id: <1341340094-32522-10-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1341340094-32522-1-git-send-email-luiz.dentz@gmail.com>
References: <1341340094-32522-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds -g/--get <handle> option to map-client so it downloads and
prints the contents of the message.

In addition add MapClient class to handle transfer signals similar to
what other scripts do.
---
 test/map-client |   93 ++++++++++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 85 insertions(+), 8 deletions(-)

diff --git a/test/map-client b/test/map-client
index be3c307..ac1a8ca 100755
--- a/test/map-client
+++ b/test/map-client
@@ -2,6 +2,8 @@
 
 import gobject
 
+import sys
+import os
 import dbus
 import dbus.mainloop.glib
 from optparse import OptionParser
@@ -37,12 +39,87 @@ def parse_options():
 	parser.add_option("-v", "--verbose", action="store_true", dest="verbose")
 	parser.add_option("-L", "--lsmsg", action="store", dest="ls_msg",
 			help="List messages in supplied CWD subdir")
+	parser.add_option("-g", "--get", action="store", dest="get_msg",
+			help="Get message contents")
 
 	return parser.parse_args()
 
 def set_folder(session, new_dir):
 	session.SetFolder(new_dir)
 
+class MapClient:
+	def __init__(self, session_path, verbose=False):
+		self.progress = 0
+		self.transfer_path = None
+		self.props = dict()
+		self.verbose = verbose
+		self.path = session_path
+		bus = dbus.SessionBus()
+		obj = bus.get_object("org.bluez.obex.client", session_path)
+		self.session = dbus.Interface(obj, "org.bluez.obex.Session")
+		self.map = dbus.Interface(obj, "org.bluez.obex.MessageAccess")
+		bus.add_signal_receiver(self.transfer_complete,
+				dbus_interface="org.bluez.obex.Transfer",
+				signal_name="Complete",
+				path_keyword="path")
+		bus.add_signal_receiver(self.transfer_error,
+				dbus_interface="org.bluez.obex.Transfer",
+				signal_name="Error",
+				path_keyword="path")
+
+	def create_transfer_reply(self, reply):
+		(path, properties) = reply
+		self.transfer_path = path
+		self.props[path] = properties
+		if self.verbose:
+			print "Transfer created: %s (file %s)" % (path,
+							properties["Filename"])
+
+	def generic_reply(self):
+		if self.verbose:
+			print "Operation succeeded"
+
+	def error(self, err):
+		print err
+		mainloop.quit()
+
+	def transfer_complete(self, path):
+		if path != self.transfer_path:
+			return
+		if self.verbose:
+			print "Transfer finished"
+		properties = self.props.get(path)
+		if properties == None:
+			return
+		f = open(properties["Filename"], "r")
+		os.remove(properties["Filename"])
+		print f.readlines()
+
+	def transfer_error(self, code, message, path):
+		if path != self.transfer_path:
+			return
+		print "Transfer finished with error %s: %s" % (code, message)
+		mainloop.quit()
+
+	def set_folder(self, new_dir):
+		self.map.SetFolder(new_dir)
+
+	def list_folders(self):
+		for i in self.map.GetFolderListing(dict()):
+			print "%s/" % (i["Name"])
+
+	def list_messages(self, folder):
+		ret = self.map.GetMessageListing(folder, dict())
+		print pformat(unwrap(ret))
+
+	def get_message(self, handle):
+		self.map.GetMessageListing("", dict())
+		path = self.path + "/message" + handle
+		obj = bus.get_object("org.bluez.obex.client", path)
+		msg = dbus.Interface(obj, "org.bluez.obex.Message")
+		msg.Get("",reply_handler=self.create_transfer_reply,
+						error_handler=self.error)
+
 if  __name__ == '__main__':
 
 	dbus.mainloop.glib.DBusGMainLoop(set_as_default=True)
@@ -61,21 +138,21 @@ if  __name__ == '__main__':
 	client = dbus.Interface(bus.get_object("org.bluez.obex.client", "/"),
 				"org.bluez.obex.Client")
 
+	print "Creating Session"
 	path = client.CreateSession(options.device, { "Target": "map" })
 
-	obj = bus.get_object("org.bluez.obex.client", path)
-	session = dbus.Interface(obj, "org.bluez.obex.Session")
-	map = dbus.Interface(obj, "org.bluez.obex.MessageAccess")
+	map_client = MapClient(path, options.verbose)
 
 	if options.new_dir:
-		set_folder(map, options.new_dir)
+		map_client.set_folder(options.new_dir)
 
 	if options.ls_dir:
-		for i in map.GetFolderListing(dict()):
-			print "%s/" % (i["Name"])
+		map_client.list_folders()
 
 	if options.ls_msg is not None:
-		ret = map.GetMessageListing(options.ls_msg, dict())
-		print pformat(unwrap(ret))
+		map_client.list_messages(options.ls_msg)
+
+	if options.get_msg is not None:
+		map_client.get_message(options.get_msg)
 
 	mainloop.run()
-- 
1.7.10.4

