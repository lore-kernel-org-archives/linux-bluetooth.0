Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Arman Uguray <armansito@chromium.org>
Subject: [PATCH BlueZ 03/10] shared/gatt-client: Added simple write operations.
Date: Wed,  3 Sep 2014 12:46:04 -0700
Message-Id: <1409773571-28417-4-git-send-email-armansito@chromium.org>
In-Reply-To: <1409773571-28417-1-git-send-email-armansito@chromium.org>
References: <1409773571-28417-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Moved the bt_gatt_write_without_response and bt_gatt_write_value functions from
shared/gatt-helpers to shared/gatt-client.
---
 src/shared/gatt-client.c  | 91 +++++++++++++++++++++++++++++++++++++++++++++++
 src/shared/gatt-client.h  | 11 ++++++
 src/shared/gatt-helpers.c | 91 -----------------------------------------------
 src/shared/gatt-helpers.h |  9 +----
 4 files changed, 103 insertions(+), 99 deletions(-)

diff --git a/src/shared/gatt-client.c b/src/shared/gatt-client.c
index b839db1..764cc75 100644
--- a/src/shared/gatt-client.c
+++ b/src/shared/gatt-client.c
@@ -947,3 +947,94 @@ bool bt_gatt_client_read_long_value(struct bt_gatt_client *client,
 
 	return true;
 }
+
+bool bt_gatt_client_write_without_response(struct bt_gatt_client *client,
+					uint16_t value_handle,
+					bool signed_write,
+					uint8_t *value, uint16_t length) {
+	uint8_t pdu[2 + length];
+
+	if (!client)
+		return 0;
+
+	/* TODO: Support this once bt_att_send supports signed writes. */
+	if (signed_write)
+		return 0;
+
+	put_le16(value_handle, pdu);
+	memcpy(pdu + 2, value, length);
+
+	return bt_att_send(client->att, BT_ATT_OP_WRITE_CMD, pdu, sizeof(pdu),
+							NULL, NULL, NULL);
+}
+
+struct write_op {
+	bt_gatt_result_callback_t callback;
+	void *user_data;
+	bt_gatt_destroy_func_t destroy;
+};
+
+static void destroy_write_op(void *data)
+{
+	struct write_op *op = data;
+
+	if (op->destroy)
+		op->destroy(op->user_data);
+
+	free(op);
+}
+
+static void write_cb(uint8_t opcode, const void *pdu, uint16_t length,
+								void *user_data)
+{
+	struct write_op *op = user_data;
+	bool success = true;
+	uint8_t att_ecode = 0;
+
+	if (opcode == BT_ATT_OP_ERROR_RSP) {
+		success = false;
+		att_ecode = process_error(pdu, length);
+		goto done;
+	}
+
+	if (opcode != BT_ATT_OP_WRITE_RSP || pdu || length)
+		success = false;
+
+done:
+	if (op->callback)
+		op->callback(success, att_ecode, op->user_data);
+}
+
+bool bt_gatt_client_write_value(struct bt_gatt_client *client,
+					uint16_t value_handle,
+					uint8_t *value, uint16_t length,
+					bt_gatt_client_callback_t callback,
+					void *user_data,
+					bt_gatt_client_destroy_func_t destroy)
+{
+	struct write_op *op;
+	uint8_t pdu[2 + length];
+
+	if (!client)
+		return false;
+
+	op = new0(struct write_op, 1);
+	if (!op)
+		return false;
+
+	op->callback = callback;
+	op->user_data = user_data;
+	op->destroy = destroy;
+
+	put_le16(value_handle, pdu);
+	memcpy(pdu + 2, value, length);
+
+	if (!bt_att_send(client->att, BT_ATT_OP_WRITE_REQ, pdu, sizeof(pdu),
+							write_cb, op,
+							destroy_write_op)) {
+		free(op);
+		return false;
+	}
+
+	return true;
+}
diff --git a/src/shared/gatt-client.h b/src/shared/gatt-client.h
index bcb8ab1..c3b3e20 100644
--- a/src/shared/gatt-client.h
+++ b/src/shared/gatt-client.h
@@ -102,3 +102,14 @@ bool bt_gatt_client_read_long_value(struct bt_gatt_client *client,
 					bt_gatt_client_read_callback_t callback,
 					void *user_data,
 					bt_gatt_client_destroy_func_t destroy);
+
+bool bt_gatt_client_write_without_response(struct bt_gatt_client *client,
+					uint16_t value_handle,
+					bool signed_write,
+					uint8_t *value, uint16_t length);
+bool bt_gatt_client_write_value(struct bt_gatt_client *client,
+					uint16_t value_handle,
+					uint8_t *value, uint16_t length,
+					bt_gatt_client_callback_t callback,
+					void *user_data,
+					bt_gatt_client_destroy_func_t destroy);
diff --git a/src/shared/gatt-helpers.c b/src/shared/gatt-helpers.c
index 81fb039..0331851 100644
--- a/src/shared/gatt-helpers.c
+++ b/src/shared/gatt-helpers.c
@@ -912,97 +912,6 @@ bool bt_gatt_discover_descriptors(struct bt_att *att,
 	return true;
 }
 
-bool bt_gatt_write_without_response(struct bt_att *att,
-					uint16_t value_handle,
-					bool signed_write,
-					uint8_t *value, uint16_t length)
-{
-	uint8_t pdu[2 + length];
-
-	if (!att)
-		return 0;
-
-	/* TODO: Support this once bt_att_send supports signed writes. */
-	if (signed_write)
-		return 0;
-
-	put_le16(value_handle, pdu);
-	memcpy(pdu + 2, value, length);
-
-	return bt_att_send(att, BT_ATT_OP_WRITE_CMD, pdu, sizeof(pdu),
-							NULL, NULL, NULL);
-}
-
-struct write_op {
-	bt_gatt_result_callback_t callback;
-	void *user_data;
-	bt_gatt_destroy_func_t destroy;
-};
-
-static void destroy_write_op(void *data)
-{
-	struct write_op *op = data;
-
-	if (op->destroy)
-		op->destroy(op->user_data);
-
-	free(op);
-}
-
-static void write_cb(uint8_t opcode, const void *pdu, uint16_t length,
-								void *user_data)
-{
-	struct write_op *op = user_data;
-	bool success = true;
-	uint8_t att_ecode = 0;
-
-	if (opcode == BT_ATT_OP_ERROR_RSP) {
-		success = false;
-		att_ecode = process_error(pdu, length);
-		goto done;
-	}
-
-	if (opcode != BT_ATT_OP_WRITE_RSP || pdu || length)
-		success = false;
-
-done:
-	if (op->callback)
-		op->callback(success, att_ecode, op->user_data);
-}
-
-bool bt_gatt_write_value(struct bt_att *att, uint16_t value_handle,
-					uint8_t *value, uint16_t length,
-					bt_gatt_result_callback_t callback,
-					void *user_data,
-					bt_gatt_destroy_func_t destroy)
-{
-	struct write_op *op;
-	uint8_t pdu[2 + length];
-
-	if (!att)
-		return false;
-
-	op = new0(struct write_op, 1);
-	if (!op)
-		return false;
-
-	op->callback = callback;
-	op->user_data = user_data;
-	op->destroy = destroy;
-
-	put_le16(value_handle, pdu);
-	memcpy(pdu + 2, value, length);
-
-	if (!bt_att_send(att, BT_ATT_OP_WRITE_REQ, pdu, sizeof(pdu),
-							write_cb, op,
-							destroy_write_op)) {
-		free(op);
-		return false;
-	}
-
-	return true;
-}
-
 struct write_long_op {
 	struct bt_att *att;
 	int ref_count;
diff --git a/src/shared/gatt-helpers.h b/src/shared/gatt-helpers.h
index 60feeaa..a8e5f98 100644
--- a/src/shared/gatt-helpers.h
+++ b/src/shared/gatt-helpers.h
@@ -90,14 +90,7 @@ bool bt_gatt_discover_descriptors(struct bt_att *att,
 					void *user_data,
 					bt_gatt_destroy_func_t destroy);
 
-bool bt_gatt_write_without_response(struct bt_att *att, uint16_t value_handle,
-					bool signed_write,
-					uint8_t *value, uint16_t length);
-bool bt_gatt_write_value(struct bt_att *att, uint16_t value_handle,
-					uint8_t *value, uint16_t length,
-					bt_gatt_result_callback_t callback,
-					void *user_data,
-					bt_gatt_destroy_func_t destroy);
+
 bool bt_gatt_write_long_value(struct bt_att *att, bool reliable,
 					uint16_t value_handle, uint16_t offset,
 					uint8_t *value, uint16_t length,
-- 
2.1.0.rc2.206.gedb03e5

