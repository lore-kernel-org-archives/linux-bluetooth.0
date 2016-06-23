Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/2] core/gatt-client: Always use bt_gatt_client_read_long_value
Date: Thu, 23 Jun 2016 14:02:21 +0300
Message-Id: <1466679741-17053-2-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1466679741-17053-1-git-send-email-luiz.dentz@gmail.com>
References: <1466679741-17053-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

bt_gatt_client_read_long_value always reads the full value so the code
don't have to check if there is more data to be read.
---
 src/gatt-client.c | 49 +++----------------------------------------------
 1 file changed, 3 insertions(+), 46 deletions(-)

diff --git a/src/gatt-client.c b/src/gatt-client.c
index c2a888f..7abb306 100644
--- a/src/gatt-client.c
+++ b/src/gatt-client.c
@@ -342,7 +342,6 @@ static void desc_read_cb(bool success, uint8_t att_ecode,
 {
 	struct async_dbus_op *op = user_data;
 	struct descriptor *desc = op->data;
-	struct service *service = desc->chrc->service;
 
 	if (!success)
 		goto fail;
@@ -357,23 +356,6 @@ static void desc_read_cb(bool success, uint8_t att_ecode,
 		goto fail;
 	}
 
-	/*
-	 * If the value length is exactly MTU-1, then we may not have read the
-	 * entire value. Perform a long read to obtain the rest, otherwise,
-	 * we're done.
-	 */
-	if (length == bt_gatt_client_get_mtu(service->client->gatt) - 1) {
-		op->offset += length;
-		op->id = bt_gatt_client_read_long_value(service->client->gatt,
-							desc->handle,
-							op->offset,
-							desc_read_cb,
-							async_dbus_op_ref(op),
-							async_dbus_op_unref);
-		if (op->id)
-			return;
-	}
-
 	/* Read the stored data from db */
 	if (!gatt_db_attribute_read(desc->attr, 0, 0, NULL, read_op_cb, op)) {
 		error("Failed to read database");
@@ -446,16 +428,9 @@ static struct async_dbus_op *read_value(struct bt_gatt_client *gatt,
 	op = async_dbus_op_new(msg, data);
 	op->offset = offset;
 
-	if (op->offset)
-		op->id = bt_gatt_client_read_long_value(gatt, handle, offset,
-							callback,
-							async_dbus_op_ref(op),
-							async_dbus_op_unref);
-	else
-		op->id = bt_gatt_client_read_value(gatt, handle, callback,
-							async_dbus_op_ref(op),
-							async_dbus_op_unref);
-
+	op->id = bt_gatt_client_read_long_value(gatt, handle, offset, callback,
+						async_dbus_op_ref(op),
+						async_dbus_op_unref);
 	if (op->id)
 		return op;
 
@@ -859,7 +834,6 @@ static void chrc_read_cb(bool success, uint8_t att_ecode, const uint8_t *value,
 {
 	struct async_dbus_op *op = user_data;
 	struct characteristic *chrc = op->data;
-	struct service *service = chrc->service;
 
 	if (!success)
 		goto fail;
@@ -874,23 +848,6 @@ static void chrc_read_cb(bool success, uint8_t att_ecode, const uint8_t *value,
 		goto fail;
 	}
 
-	/*
-	 * If the value length is exactly MTU-1, then we may not have read the
-	 * entire value. Perform a long read to obtain the rest, otherwise,
-	 * we're done.
-	 */
-	if (length == bt_gatt_client_get_mtu(service->client->gatt) - 1) {
-		op->offset += length;
-		op->id = bt_gatt_client_read_long_value(service->client->gatt,
-							chrc->value_handle,
-							op->offset,
-							chrc_read_cb,
-							async_dbus_op_ref(op),
-							async_dbus_op_unref);
-		if (op->id)
-			return;
-	}
-
 	/* Read the stored data from db */
 	if (!gatt_db_attribute_read(chrc->attr, 0, 0, NULL, read_op_cb, op)) {
 		error("Failed to read database");
-- 
2.5.5

