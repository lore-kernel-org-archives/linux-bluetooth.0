Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH obexd 5/8] test: Update map-client to work with changes in MessageAccess interface
Date: Thu, 13 Sep 2012 16:06:58 +0300
Message-Id: <1347541621-26858-5-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1347541621-26858-1-git-send-email-luiz.dentz@gmail.com>
References: <1347541621-26858-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 test/map-client | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/test/map-client b/test/map-client
index ac1a8ca..dbb67df 100755
--- a/test/map-client
+++ b/test/map-client
@@ -105,15 +105,15 @@ class MapClient:
 		self.map.SetFolder(new_dir)
 
 	def list_folders(self):
-		for i in self.map.GetFolderListing(dict()):
+		for i in self.map.ListFolders(dict()):
 			print "%s/" % (i["Name"])
 
 	def list_messages(self, folder):
-		ret = self.map.GetMessageListing(folder, dict())
+		ret = self.map.ListMessages(folder, dict())
 		print pformat(unwrap(ret))
 
 	def get_message(self, handle):
-		self.map.GetMessageListing("", dict())
+		self.map.ListMessages("", dict())
 		path = self.path + "/message" + handle
 		obj = bus.get_object("org.bluez.obex.client", path)
 		msg = dbus.Interface(obj, "org.bluez.obex.Message")
-- 
1.7.11.4

