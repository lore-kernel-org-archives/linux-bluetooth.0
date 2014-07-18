Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Arman Uguray <armansito@chromium.org>
Subject: [PATCH 10/11] shared/gatt: Implement "Write Long Values" procedure.
Date: Fri, 18 Jul 2014 14:13:56 -0700
Message-Id: <1405718037-15401-11-git-send-email-armansito@chromium.org>
In-Reply-To: <1405718037-15401-1-git-send-email-armansito@chromium.org>
References: <1405718037-15401-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch implements bt_gatt_write_long_value.
---
 src/shared/gatt-helpers.c | 226 +++++++++++++++++++++++++++++++++++++++++++++-
 src/shared/gatt-helpers.h |   1 +
 2 files changed, 225 insertions(+), 2 deletions(-)

diff --git a/src/shared/gatt-helpers.c b/src/shared/gatt-helpers.c
index fdaf973..5afe91e 100644
--- a/src/shared/gatt-helpers.c
+++ b/src/shared/gatt-helpers.c
@@ -1142,6 +1142,166 @@ bool bt_gatt_write_value(struct bt_att *att, uint16_t value_handle,
 	return true;
 }
 
+struct write_long_op {
+	struct bt_att *att;
+	int ref_count;
+	bool reliable;
+	uint16_t status;
+	uint16_t value_handle;
+	uint8_t *value;
+	uint16_t length;
+	uint16_t offset;
+	uint16_t index;
+	uint16_t cur_length;
+	bt_gatt_result_callback_t callback;
+	void *user_data;
+	bt_gatt_destroy_func_t destroy;
+};
+
+static struct write_long_op *write_long_op_ref(struct write_long_op *op)
+{
+	__sync_fetch_and_add(&op->ref_count, 1);
+
+	return op;
+}
+
+static void write_long_op_unref(void *data)
+{
+	struct write_long_op *op = data;
+
+	if (__sync_sub_and_fetch(&op->ref_count, 1))
+		return;
+
+	if (op->destroy)
+		op->destroy(op->user_data);
+
+	free(op->value);
+	free(op);
+}
+
+static void execute_write_cb(uint8_t opcode, const void *pdu, uint16_t length,
+								void *user_data)
+{
+	struct write_long_op *op = user_data;
+	uint16_t status = op->status;
+
+	if (opcode == BT_ATT_OP_ERROR_RSP)
+		status = process_error(pdu, length);
+	else if (opcode != BT_ATT_OP_EXEC_WRITE_RSP || pdu || length)
+		status = BT_GATT_ERROR_INVALID_RSP;
+
+	if (op->callback)
+		op->callback(status, op->user_data);
+}
+
+static void complete_write_long_op(struct write_long_op *op, uint16_t status)
+{
+	uint8_t pdu;
+
+	op->status = status;
+
+	if (status) {
+		pdu = 0x00;  /* Cancel */
+	} else
+		pdu = 0x01;  /* Write */
+
+	if (bt_att_send(op->att, BT_ATT_OP_EXEC_WRITE_REQ, &pdu, sizeof(pdu),
+						execute_write_cb,
+						write_long_op_ref(op),
+						write_long_op_unref))
+		return;
+
+	write_long_op_unref(op);
+	status = BT_GATT_ERROR_UNKNOWN;
+
+	if (op->callback)
+		op->callback(status, op->user_data);
+}
+
+static void prepare_write_cb(uint8_t opcode, const void *pdu, uint16_t length,
+								void *user_data)
+{
+	struct write_long_op *op = user_data;
+	uint16_t status = 0;
+	uint16_t next_index;
+
+	if (opcode == BT_ATT_OP_ERROR_RSP) {
+		status = process_error(pdu, length);
+		goto done;
+	}
+
+	if (opcode != BT_ATT_OP_PREP_WRITE_RSP) {
+		status = BT_GATT_ERROR_INVALID_RSP;
+		goto done;
+	}
+
+	if (op->reliable) {
+		if (!pdu || length != (op->cur_length + 4)) {
+			status = BT_GATT_ERROR_RELIABLE_WRITE;
+			goto done;
+		}
+
+		if (get_le16(pdu) != op->value_handle ||
+				get_le16(pdu + 2) != (op->offset + op->index)) {
+			status = BT_GATT_ERROR_RELIABLE_WRITE;
+			goto done;
+		}
+
+		if (memcmp(pdu + 4, op->value + op->index, op->cur_length)) {
+			status = BT_GATT_ERROR_RELIABLE_WRITE;
+			goto done;
+		}
+	}
+
+	next_index = op->index + op->cur_length;
+	if (next_index == op->length) {
+		/* All bytes written */
+		goto done;
+	}
+
+	/* If the last written length greater than or equal to what can fit
+	 * inside a PDU, then there is more data to send.
+	 */
+	if (op->cur_length >= bt_att_get_mtu(op->att) - 5) {
+		uint8_t *pdu;
+
+		op->index = next_index;
+		op->cur_length = MIN(op->length - op->index,
+						bt_att_get_mtu(op->att) - 5);
+
+		pdu = malloc(op->cur_length + 4);
+		if (!pdu) {
+			status = BT_GATT_ERROR_FAILED_ALLOC;
+			goto done;
+		}
+
+		put_le16(op->value_handle, pdu);
+		put_le16(op->offset + op->index, pdu + 2);
+		memcpy(pdu + 4, op->value + op->index, op->cur_length);
+
+		if (!bt_att_send(op->att, BT_ATT_OP_PREP_WRITE_REQ,
+							pdu, op->cur_length + 4,
+							prepare_write_cb,
+							write_long_op_ref(op),
+							write_long_op_unref)) {
+			write_long_op_unref(op);
+			status = BT_GATT_ERROR_UNKNOWN;
+		}
+
+		free(pdu);
+
+		/* If status is 0, then the operation should continue.
+		 * Otherwise, there was an error and the procedure should be
+		 * completed.
+		 */
+		if (!status)
+			return;
+	}
+
+done:
+	complete_write_long_op(op, status);
+}
+
 bool bt_gatt_write_long_value(struct bt_att *att, bool reliable,
 					uint16_t value_handle, uint16_t offset,
 					uint8_t *value, uint16_t length,
@@ -1149,8 +1309,70 @@ bool bt_gatt_write_long_value(struct bt_att *att, bool reliable,
 					void *user_data,
 					bt_gatt_destroy_func_t destroy)
 {
-	/* TODO */
-	return false;
+	struct write_long_op *op;
+	uint8_t *pdu;
+	bool status;
+
+	if (!att)
+		return false;
+
+	if ((size_t)(length + offset) > UINT16_MAX)
+		return false;
+
+	/* Don't allow riting a 0-length value using this procedure. The
+	 * upper-layer should use bt_gatt_write_value for that instead.
+	 */
+	if (!length || !value)
+		return false;
+
+	op = new0(struct write_long_op, 1);
+	if (!op)
+		return false;
+
+	op->value = malloc(length);
+	if (!op->value) {
+		free(op);
+		return false;
+	}
+
+	memcpy(op->value, value, length);
+
+	op->att = att;
+	op->reliable = reliable;
+	op->value_handle = value_handle;
+	op->length = length;
+	op->offset = offset;
+	op->cur_length = MIN(length, bt_att_get_mtu(att) - 5);
+	op->callback = callback;
+	op->user_data = user_data;
+	op->destroy = destroy;
+
+	pdu = malloc(op->cur_length + 4);
+	if (!pdu) {
+		free(op->value);
+		free(op);
+		return false;
+	}
+
+	put_le16(value_handle, pdu);
+	put_le16(offset, pdu + 2);
+	memcpy(pdu + 4, op->value, op->cur_length);
+
+	status = bt_att_send(att, BT_ATT_OP_PREP_WRITE_REQ,
+							pdu, op->cur_length + 4,
+							prepare_write_cb,
+							write_long_op_ref(op),
+							write_long_op_unref);
+
+	free(pdu);
+
+	if (!status) {
+		free(op->value);
+		free(op);
+		return false;
+	}
+
+	return true;
 }
 
 unsigned int bt_gatt_register(struct bt_att *att, bool indications,
diff --git a/src/shared/gatt-helpers.h b/src/shared/gatt-helpers.h
index 068c4bb..56aff24 100644
--- a/src/shared/gatt-helpers.h
+++ b/src/shared/gatt-helpers.h
@@ -63,6 +63,7 @@ struct bt_gatt_descriptor {
 #define BT_GATT_ERROR_UNKNOWN		0x0100
 #define BT_GATT_ERROR_INVALID_RSP	0x0101
 #define BT_GATT_ERROR_FAILED_ALLOC	0x0102
+#define BT_GATT_ERROR_RELIABLE_WRITE	0x0103
 
 typedef void (*bt_gatt_destroy_func_t)(void *user_data);
 
-- 
2.0.0.526.g5318336

