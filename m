Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 4/4] test: Update map-client to use D-Bus properties interface
Date: Fri, 14 Dec 2012 23:32:00 +0200
Message-Id: <1355520720-11731-4-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1355520720-11731-1-git-send-email-luiz.dentz@gmail.com>
References: <1355520720-11731-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 test/map-client | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/test/map-client b/test/map-client
index 756ebb8..39dd79f 100755
--- a/test/map-client
+++ b/test/map-client
@@ -136,8 +136,8 @@ class MapClient:
 		self.map.ListMessages("", dict())
 		path = self.path + "/message" + handle
 		obj = bus.get_object("org.bluez.obex.client", path)
-		msg = dbus.Interface(obj, "org.bluez.obex.Message")
-		ret = msg.GetProperties()
+		msg = dbus.Interface(obj, "org.freedesktop.DBus.Properties")
+		ret = msg.GetAll("org.bluez.obex.Message")
 		print pformat(unwrap(ret))
 
 	def set_message_property(self, handle, prop, flag):
-- 
1.7.11.7

