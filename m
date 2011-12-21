Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH BlueZ 2/2] Fix consecutive set value when disconnected
Date: Wed, 21 Dec 2011 18:41:50 -0300
Message-Id: <1324503710-29815-2-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1324503710-29815-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1324503710-29815-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

SetProperty for "Value" property needs to be queued when disconnected.
Registering ATTIO connection callback does not mean that the link is
established, GAttrib instance is assigned in the connection callback.
---
 attrib/client.c |    8 +++++---
 1 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/attrib/client.c b/attrib/client.c
index 5f1e6ce..4c8474c 100644
--- a/attrib/client.c
+++ b/attrib/client.c
@@ -420,15 +420,17 @@ static DBusMessage *set_value(DBusConnection *conn, DBusMessage *msg,
 
 	characteristic_set_value(chr, value, len);
 
-	if (gatt->attioid == 0) {
+	if (gatt->attioid == 0)
 		gatt->attioid = btd_device_add_attio_callback(gatt->dev,
 							attio_connected,
 							attio_disconnected,
 							gatt);
-		gatt->offline_chars = g_slist_append(gatt->offline_chars, chr);
-	} else
+
+	if (gatt->attrib)
 		gatt_write_cmd(gatt->attrib, chr->handle, value, len,
 								NULL, NULL);
+	else
+		gatt->offline_chars = g_slist_append(gatt->offline_chars, chr);
 
 	return dbus_message_new_method_return(msg);
 }
-- 
1.7.8

