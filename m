Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH obexd 2/2 v2] test: Use longer D-Bus timeout in test scripts
Date: Thu, 20 Sep 2012 15:07:15 +0300
Message-Id: <1348142835-13146-2-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1348142835-13146-1-git-send-email-luiz.dentz@gmail.com>
References: <1348142835-13146-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

As the daemon already waits for 60 seconds for the first response this
just use the same timeout for calls that don't use transfer but return the
response as reply.
---
 test/map-client | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/test/map-client b/test/map-client
index ac1a8ca..7741c7f 100755
--- a/test/map-client
+++ b/test/map-client
@@ -109,11 +109,11 @@ class MapClient:
 			print "%s/" % (i["Name"])
 
 	def list_messages(self, folder):
-		ret = self.map.GetMessageListing(folder, dict())
+		ret = self.map.GetMessageListing(folder, dict(), timeout=60)
 		print pformat(unwrap(ret))
 
 	def get_message(self, handle):
-		self.map.GetMessageListing("", dict())
+		self.map.GetMessageListing("", dict(), timeout=60)
 		path = self.path + "/message" + handle
 		obj = bus.get_object("org.bluez.obex.client", path)
 		msg = dbus.Interface(obj, "org.bluez.obex.Message")
-- 
1.7.11.4

