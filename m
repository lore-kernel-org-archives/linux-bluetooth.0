Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/2] core/gatt-client: Fix not return empty array for ReadValue
Date: Fri,  2 Sep 2016 15:49:09 +0300
Message-Id: <1472820549-1976-2-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1472820549-1976-1-git-send-email-luiz.dentz@gmail.com>
References: <1472820549-1976-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

The response to ReadValue shall be an array which can be empty.
---
 src/gatt-client.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/src/gatt-client.c b/src/gatt-client.c
index 2af6979..57a1f66 100644
--- a/src/gatt-client.c
+++ b/src/gatt-client.c
@@ -297,7 +297,7 @@ static void write_descriptor_cb(struct gatt_db_attribute *attr, int err,
 }
 
 static void async_dbus_op_reply(struct async_dbus_op *op, int err,
-				const uint8_t *value, size_t length)
+				const uint8_t *value, ssize_t length)
 {
 	const struct queue_entry *entry;
 	DBusMessage *reply;
@@ -319,7 +319,7 @@ static void async_dbus_op_reply(struct async_dbus_op *op, int err,
 			return;
 		}
 
-		if (value)
+		if (length >= 0)
 			message_append_byte_array(reply, value, length);
 
 send_reply:
@@ -489,7 +489,7 @@ static void write_result_cb(bool success, bool reliable_error,
 	}
 
 done:
-	async_dbus_op_reply(op, err, NULL, 0);
+	async_dbus_op_reply(op, err, NULL, -1);
 }
 
 static void write_cb(bool success, uint8_t att_ecode, void *user_data)
@@ -1126,7 +1126,7 @@ static void create_notify_reply(struct async_dbus_op *op, bool success,
 	else
 		err = att_ecode ? att_ecode : -ENOENT;
 
-	async_dbus_op_reply(op, err, NULL, 0);
+	async_dbus_op_reply(op, err, NULL, -1);
 }
 
 static void register_notify_cb(uint16_t att_ecode, void *user_data)
-- 
2.7.4

