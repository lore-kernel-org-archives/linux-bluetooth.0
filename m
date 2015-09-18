Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] core/gatt-client: Fix WriteValue always failing after first request
Date: Fri, 18 Sep 2015 16:49:37 +0300
Message-Id: <1442584177-17918-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

WriteValue may use write without response proceduce in case it is
supported but since that don't have any response write_id is left set
after first request preventing blocking any new request.
---
 src/gatt-client.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/src/gatt-client.c b/src/gatt-client.c
index 399133a..6c10a82 100644
--- a/src/gatt-client.c
+++ b/src/gatt-client.c
@@ -946,11 +946,11 @@ static DBusMessage *characteristic_write_value(DBusConnection *conn,
 		goto fail;
 
 	supported = true;
-	chrc->write_id = bt_gatt_client_write_without_response(gatt,
+
+	if (bt_gatt_client_write_without_response(gatt,
 					chrc->value_handle,
 					chrc->props & BT_GATT_CHRC_PROP_AUTH,
-					value, value_len);
-	if (chrc->write_id)
+					value, value_len))
 		return dbus_message_new_method_return(msg);
 
 fail:
-- 
2.4.3

