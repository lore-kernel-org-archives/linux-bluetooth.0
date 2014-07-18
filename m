Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Arman Uguray <armansito@chromium.org>
Subject: [PATCH 07/11] shared/gatt: Implement "Read" procedure.
Date: Fri, 18 Jul 2014 14:13:53 -0700
Message-Id: <1405718037-15401-8-git-send-email-armansito@chromium.org>
In-Reply-To: <1405718037-15401-1-git-send-email-armansito@chromium.org>
References: <1405718037-15401-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch implements bt_gatt_read_value, which can be used to read the value of
a characteristic or descriptor.
---
 src/shared/gatt-helpers.c | 70 +++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 68 insertions(+), 2 deletions(-)

diff --git a/src/shared/gatt-helpers.c b/src/shared/gatt-helpers.c
index 302cc89..d614d3e 100644
--- a/src/shared/gatt-helpers.c
+++ b/src/shared/gatt-helpers.c
@@ -771,13 +771,79 @@ bool bt_gatt_discover_descriptors(struct bt_att *att,
 	return true;
 }
 
+struct read_op {
+	bt_gatt_read_callback_t callback;
+	void *user_data;
+	bt_gatt_destroy_func_t destroy;
+};
+
+static void destroy_read_op(void *data)
+{
+	struct read_op *op = data;
+
+	if (op->destroy)
+		op->destroy(op->user_data);
+
+	free(op);
+}
+
+static void read_cb(uint8_t opcode, const void *pdu, uint16_t length,
+								void *user_data)
+{
+	struct read_op *op = user_data;
+	uint16_t status;
+	const uint8_t *value = NULL;
+	uint16_t value_len = 0;
+
+	if (opcode == BT_ATT_OP_ERROR_RSP) {
+		status = process_error(pdu, length);
+		goto done;
+	}
+
+	if (opcode != BT_ATT_OP_READ_RSP || (!pdu && length)) {
+		status = BT_GATT_ERROR_INVALID_RSP;
+		goto done;
+	}
+
+	status = 0;
+	value_len = length;
+	if (value_len)
+		value = pdu;
+
+done:
+	if (op->callback)
+		op->callback(status, value, length, op->user_data);
+}
+
 bool bt_gatt_read_value(struct bt_att *att, uint16_t value_handle,
 					bt_gatt_read_callback_t callback,
 					void *user_data,
 					bt_gatt_destroy_func_t destroy)
 {
-	/* TODO */
-	return false;
+	struct read_op *op;
+	uint8_t pdu[2];
+
+	if (!att)
+		return false;
+
+	op = new0(struct read_op, 1);
+	if (!op)
+		return false;
+
+	op->callback = callback;
+	op->user_data = user_data;
+	op->destroy = destroy;
+
+	put_le16(value_handle, pdu);
+
+	if (!bt_att_send(att, BT_ATT_OP_READ_REQ, pdu, sizeof(pdu),
+							read_cb, op,
+							destroy_read_op)) {
+		free(op);
+		return false;
+	}
+
+	return true;
 }
 
 bool bt_gatt_read_long_value(struct bt_att *att,
-- 
2.0.0.526.g5318336

