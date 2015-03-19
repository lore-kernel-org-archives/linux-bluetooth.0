Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v3 6/7] core/gatt: Fix not replying if db operation fail
Date: Thu, 19 Mar 2015 16:21:26 +0200
Message-Id: <1426774887-25646-6-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1426774887-25646-1-git-send-email-luiz.dentz@gmail.com>
References: <1426774887-25646-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 src/gatt-client.c | 61 ++++++++++++++++++++++++++++++++++++-------------------
 1 file changed, 40 insertions(+), 21 deletions(-)

diff --git a/src/gatt-client.c b/src/gatt-client.c
index a85b9d2..8f67db3 100644
--- a/src/gatt-client.c
+++ b/src/gatt-client.c
@@ -344,20 +344,19 @@ static void desc_read_cb(bool success, uint8_t att_ecode,
 	struct async_dbus_op *op = user_data;
 	struct descriptor *desc = op->data;
 	struct service *service = desc->chrc->service;
+	DBusMessage *reply;
 
-	if (!success) {
-		DBusMessage *reply = create_gatt_dbus_error(op->msg, att_ecode);
-
-		desc->read_id = 0;
-		g_dbus_send_message(btd_get_dbus_connection(), reply);
-		return;
-	}
+	if (!success)
+		goto fail;
 
 	if (!op->offset)
 		gatt_db_attribute_reset(desc->attr);
 
-	gatt_db_attribute_write(desc->attr, op->offset, value, length, 0, NULL,
-						write_descriptor_cb, desc);
+	if (gatt_db_attribute_write(desc->attr, op->offset, value, length, 0,
+					NULL, write_descriptor_cb, desc)) {
+		error("Failed to store attribute");
+		goto fail;
+	}
 
 	/*
 	 * If the value length is exactly MTU-1, then we may not have read the
@@ -377,10 +376,21 @@ static void desc_read_cb(bool success, uint8_t att_ecode,
 			return;
 	}
 
+	/* Read the stored data from db */
+	if (gatt_db_attribute_read(desc->attr, 0, 0, NULL, read_op_cb, op)) {
+		error("Failed to read database");
+		goto fail;
+	}
+
 	desc->read_id = 0;
 
-	/* Read the stored data from db */
-	gatt_db_attribute_read(desc->attr, 0, 0, NULL, read_op_cb, op);
+	return;
+
+fail:
+	reply = create_gatt_dbus_error(op->msg, att_ecode);
+	desc->read_id = 0;
+	g_dbus_send_message(btd_get_dbus_connection(), reply);
+	return;
 }
 
 static DBusMessage *descriptor_read_value(DBusConnection *conn,
@@ -778,20 +788,19 @@ static void chrc_read_cb(bool success, uint8_t att_ecode, const uint8_t *value,
 	struct async_dbus_op *op = user_data;
 	struct characteristic *chrc = op->data;
 	struct service *service = chrc->service;
+	DBusMessage *reply;
 
-	if (!success) {
-		DBusMessage *reply = create_gatt_dbus_error(op->msg, att_ecode);
-
-		chrc->read_id = 0;
-		g_dbus_send_message(btd_get_dbus_connection(), reply);
-		return ;
-	}
+	if (!success)
+		goto fail;
 
 	if (!op->offset)
 		gatt_db_attribute_reset(chrc->attr);
 
-	gatt_db_attribute_write(chrc->attr, op->offset, value, length, 0, NULL,
-						write_characteristic_cb, chrc);
+	if (!gatt_db_attribute_write(chrc->attr, op->offset, value, length, 0,
+					NULL, write_characteristic_cb, chrc)) {
+		error("Failed to store attribute");
+		goto fail;
+	}
 
 	/*
 	 * If the value length is exactly MTU-1, then we may not have read the
@@ -814,7 +823,17 @@ static void chrc_read_cb(bool success, uint8_t att_ecode, const uint8_t *value,
 	chrc->read_id = 0;
 
 	/* Read the stored data from db */
-	gatt_db_attribute_read(chrc->attr, 0, 0, NULL, read_op_cb, op);
+	if (!gatt_db_attribute_read(chrc->attr, 0, 0, NULL, read_op_cb, op)) {
+		error("Failed to read database");
+		goto fail;
+	}
+
+	return;
+
+fail:
+	reply = create_gatt_dbus_error(op->msg, att_ecode);
+	chrc->read_id = 0;
+	g_dbus_send_message(btd_get_dbus_connection(), reply);
 }
 
 static DBusMessage *characteristic_read_value(DBusConnection *conn,
-- 
2.1.0

