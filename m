Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Arman Uguray <armansito@chromium.org>
Subject: [PATCH 09/11] shared/gatt: Implement "Write Value" and "Write Without Response" procedures.
Date: Fri, 18 Jul 2014 14:13:55 -0700
Message-Id: <1405718037-15401-10-git-send-email-armansito@chromium.org>
In-Reply-To: <1405718037-15401-1-git-send-email-armansito@chromium.org>
References: <1405718037-15401-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch implements the bt_gatt_write_without_response and bt_gatt_write_value
functions.
---
 src/shared/gatt-helpers.c | 80 ++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 75 insertions(+), 5 deletions(-)

diff --git a/src/shared/gatt-helpers.c b/src/shared/gatt-helpers.c
index 8db80e7..fdaf973 100644
--- a/src/shared/gatt-helpers.c
+++ b/src/shared/gatt-helpers.c
@@ -1055,11 +1055,58 @@ bool bt_gatt_read_long_value(struct bt_att *att,
 
 bool bt_gatt_write_without_response(struct bt_att *att,
 					uint16_t value_handle,
-                                        bool signed_write,
+					bool signed_write,
 					uint8_t *value, uint16_t length)
 {
-	/* TODO */
-	return false;
+	uint8_t pdu[2 + length];
+
+	if (!att)
+		return 0;
+
+	/* TODO: Support this once bt_att_send supports signed writes. */
+	if (signed_write)
+		return 0;
+
+	put_le16(value_handle, pdu);
+	memcpy(pdu + 2, value, length);
+
+	return bt_att_send(att, BT_ATT_OP_WRITE_CMD, pdu, sizeof(pdu),
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
+	uint16_t status = 0;
+
+	if (opcode == BT_ATT_OP_ERROR_RSP) {
+		status = process_error(pdu, length);
+		goto done;
+	}
+
+	if (opcode != BT_ATT_OP_WRITE_RSP || pdu || length)
+		status = BT_GATT_ERROR_INVALID_RSP;
+
+done:
+	if (op->callback)
+		op->callback(status, op->user_data);
 }
 
 bool bt_gatt_write_value(struct bt_att *att, uint16_t value_handle,
@@ -1068,8 +1115,31 @@ bool bt_gatt_write_value(struct bt_att *att, uint16_t value_handle,
 					void *user_data,
 					bt_gatt_destroy_func_t destroy)
 {
-	/* TODO */
-	return false;
+	struct write_op *op;
+	uint8_t pdu[2 + length];
+
+	if (!att)
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
+	if (!bt_att_send(att, BT_ATT_OP_WRITE_REQ, pdu, sizeof(pdu),
+							write_cb, op,
+							destroy_write_op)) {
+		free(op);
+		return false;
+	}
+
+	return true;
 }
 
 bool bt_gatt_write_long_value(struct bt_att *att, bool reliable,
-- 
2.0.0.526.g5318336

