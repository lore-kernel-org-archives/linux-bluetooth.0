Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH obexd 7/8] test: Update map-client to work with changes in Message.Get
Date: Thu, 13 Sep 2012 16:07:00 +0300
Message-Id: <1347541621-26858-7-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1347541621-26858-1-git-send-email-luiz.dentz@gmail.com>
References: <1347541621-26858-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 test/map-client | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/test/map-client b/test/map-client
index dbb67df..2075844 100755
--- a/test/map-client
+++ b/test/map-client
@@ -117,7 +117,7 @@ class MapClient:
 		path = self.path + "/message" + handle
 		obj = bus.get_object("org.bluez.obex.client", path)
 		msg = dbus.Interface(obj, "org.bluez.obex.Message")
-		msg.Get("",reply_handler=self.create_transfer_reply,
+		msg.Get("", True, reply_handler=self.create_transfer_reply,
 						error_handler=self.error)
 
 if  __name__ == '__main__':
-- 
1.7.11.4

