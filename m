Return-Path: <cyrus@holtmann.org>
From: Srinivasa Ragavan <srinivasa.ragavan.venkateswaran@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Srinivasa Ragavan <srinivasa.ragavan.venkateswaran@intel.com>
Subject: [PATCH 4/4] test: Update map-client to include Message.SetProperty and Message.GetProperties
Date: Thu,  4 Oct 2012 19:52:40 +0530
Message-Id: <1349360560-21631-4-git-send-email-srinivasa.ragavan.venkateswaran@intel.com>
In-Reply-To: <1349360560-21631-1-git-send-email-srinivasa.ragavan.venkateswaran@intel.com>
References: <1349360560-21631-1-git-send-email-srinivasa.ragavan.venkateswaran@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 test/map-client |   42 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/test/map-client b/test/map-client
index 2075844..e8c42e3 100755
--- a/test/map-client
+++ b/test/map-client
@@ -41,6 +41,16 @@ def parse_options():
 			help="List messages in supplied CWD subdir")
 	parser.add_option("-g", "--get", action="store", dest="get_msg",
 			help="Get message contents")
+	parser.add_option("--get-properties", action="store", dest="get_msg_properties",
+			help="Get message properties")
+	parser.add_option("--mark-read", action="store", dest="mark_msg_read",
+			help="Marks the messages as read")
+	parser.add_option("--mark-unread", action="store", dest="mark_msg_unread",
+			help="Marks the messages as unread")
+	parser.add_option("--mark-deleted", action="store", dest="mark_msg_deleted",
+			help="Deletes the message from the folder")
+	parser.add_option("--mark-undeleted", action="store", dest="mark_msg_undeleted",
+			help="Undeletes the message")
 
 	return parser.parse_args()
 
@@ -120,6 +130,22 @@ class MapClient:
 		msg.Get("", True, reply_handler=self.create_transfer_reply,
 						error_handler=self.error)
 
+	def get_message_properties(self, handle):
+		self.map.ListMessages("", dict())
+		path = self.path + "/message" + handle
+		obj = bus.get_object("org.bluez.obex.client", path)
+		msg = dbus.Interface(obj, "org.bluez.obex.Message")
+		ret = msg.GetProperties()
+		print pformat(unwrap(ret))
+
+	def set_message_property(self, handle, prop, flag):
+		self.map.ListMessages("", dict())
+		path = self.path + "/message" + handle
+		obj = bus.get_object("org.bluez.obex.client", path)
+		msg = dbus.Interface(obj, "org.bluez.obex.Message")
+		msg.SetProperty (prop, flag);
+
+
 if  __name__ == '__main__':
 
 	dbus.mainloop.glib.DBusGMainLoop(set_as_default=True)
@@ -155,4 +181,20 @@ if  __name__ == '__main__':
 	if options.get_msg is not None:
 		map_client.get_message(options.get_msg)
 
+	if options.get_msg_properties is not None:
+		map_client.get_message_properties(options.get_msg_properties)
+
+	if options.mark_msg_read is not None:
+		map_client.set_message_property(options.mark_msg_read, "Read", True)
+
+	if options.mark_msg_unread is not None:
+		map_client.set_message_property(options.mark_msg_unread, "Read", False)
+
+	if options.mark_msg_deleted is not None:
+		map_client.set_message_property(options.mark_msg_deleted, "Deleted", True)
+
+	if options.mark_msg_undeleted is not None:
+		map_client.set_message_property(options.mark_msg_undeleted, "Deleted", False)
+
+
 	mainloop.run()
-- 
1.7.10.4

