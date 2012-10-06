Return-Path: <cyrus@holtmann.org>
From: Srinivasa Ragavan <srinivasa.ragavan.venkateswaran@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Srinivasa Ragavan <srinivasa.ragavan.venkateswaran@intel.com>
Subject: [PATCH 3/3] test: Update map-client to include UpdateInbox.
Date: Sat,  6 Oct 2012 19:22:14 +0530
Message-Id: <1349531535-706-6-git-send-email-srinivasa.ragavan.venkateswaran@intel.com>
In-Reply-To: <1349531535-706-1-git-send-email-srinivasa.ragavan.venkateswaran@intel.com>
References: <1349531535-706-1-git-send-email-srinivasa.ragavan.venkateswaran@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 test/map-client |    7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/test/map-client b/test/map-client
index e8c42e3..756ebb8 100755
--- a/test/map-client
+++ b/test/map-client
@@ -51,6 +51,8 @@ def parse_options():
 			help="Deletes the message from the folder")
 	parser.add_option("--mark-undeleted", action="store", dest="mark_msg_undeleted",
 			help="Undeletes the message")
+	parser.add_option("-u", "--update-inbox", action="store_true", dest="update_inbox",
+			help="Checks for new mails")
 
 	return parser.parse_args()
 
@@ -145,6 +147,9 @@ class MapClient:
 		msg = dbus.Interface(obj, "org.bluez.obex.Message")
 		msg.SetProperty (prop, flag);
 
+	def update_inbox(self):
+		self.map.UpdateInbox()
+
 
 if  __name__ == '__main__':
 
@@ -196,5 +201,7 @@ if  __name__ == '__main__':
 	if options.mark_msg_undeleted is not None:
 		map_client.set_message_property(options.mark_msg_undeleted, "Deleted", False)
 
+	if options.update_inbox:
+		map_client.update_inbox()
 
 	mainloop.run()
-- 
1.7.10.4

