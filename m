Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Arman Uguray <armansito@chromium.org>
Subject: [PATCH 06/11] shared/gatt: Implement "Descriptor Discovery" procedure.
Date: Fri, 18 Jul 2014 14:13:52 -0700
Message-Id: <1405718037-15401-7-git-send-email-armansito@chromium.org>
In-Reply-To: <1405718037-15401-1-git-send-email-armansito@chromium.org>
References: <1405718037-15401-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch implements bt_gatt_discover_descriptors.
---
 src/shared/gatt-helpers.c | 156 +++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 154 insertions(+), 2 deletions(-)

diff --git a/src/shared/gatt-helpers.c b/src/shared/gatt-helpers.c
index ad544f7..302cc89 100644
--- a/src/shared/gatt-helpers.c
+++ b/src/shared/gatt-helpers.c
@@ -609,14 +609,166 @@ bool bt_gatt_discover_characteristics(struct bt_att *att,
 	return true;
 }
 
+struct discover_descs_op {
+	struct discovery_op data;
+	uint16_t end;
+};
+
+static struct discover_descs_op *discover_descs_op_ref(
+						struct discover_descs_op *op)
+{
+	__sync_fetch_and_add(&op->data.ref_count, 1);
+
+	return op;
+}
+
+static void discover_descs_op_unref(void *data)
+{
+	struct discover_descs_op *op = data;
+
+	if (__sync_sub_and_fetch(&op->data.ref_count, 1))
+		return;
+
+	if (op->data.destroy)
+		op->data.destroy(op->data.user_data);
+
+	queue_destroy(op->data.results, free);
+
+	free(op);
+}
+
+static void discover_descs_cb(uint8_t opcode, const void *pdu,
+					uint16_t length, void *user_data)
+{
+	struct discover_descs_op *op = user_data;
+	uint16_t status;
+	struct queue *results = NULL;
+	uint8_t format;
+	uint16_t last_handle;
+	size_t data_length;
+	int i;
+
+	if (opcode == BT_ATT_OP_ERROR_RSP) {
+		status = process_error(pdu, length);
+
+		if (status == BT_ATT_ERROR_ATTRIBUTE_NOT_FOUND &&
+					!queue_isempty(op->data.results))
+			goto success;
+
+		goto done;
+	}
+
+	/* The PDU should contain the following data (sans opcode):
+	 * - Format (1 octet)
+	 * - Attr Data List (at least 4 octets):
+	 *   -- 2 octets: Attribute handle
+	 *   -- 2 or 16 octets: UUID.
+	 */
+	if (opcode != BT_ATT_OP_FIND_INFO_RSP || !pdu || length < 5) {
+		status = BT_GATT_ERROR_INVALID_RSP;
+		goto done;
+	}
+
+	format = ((uint8_t *) pdu)[0];
+
+	if (format == 0x01)
+		data_length = 4;
+	else if (format == 0x02)
+		data_length = 18;
+	else {
+		status = BT_GATT_ERROR_INVALID_RSP;
+		goto done;
+	}
+
+	if ((length - 1) % data_length) {
+		status = BT_GATT_ERROR_INVALID_RSP;
+		goto done;
+	}
+
+	for (i = 1; i < length; i += data_length) {
+		struct bt_gatt_descriptor *descr;
+
+		descr = new0(struct bt_gatt_descriptor, 1);
+		if (!descr) {
+			status = BT_GATT_ERROR_FAILED_ALLOC;
+			goto done;
+		}
+
+		last_handle = get_le16(pdu + i);
+		descr->handle = last_handle;
+		convert_uuid_le(pdu + i + 2, data_length - 2, descr->uuid);
+
+		queue_push_tail(op->data.results, descr);
+	}
+
+	if (last_handle != op->end) {
+		uint8_t pdu[4];
+
+		put_le16(last_handle + 1, pdu);
+		put_le16(op->end, pdu + 2);
+
+		if (bt_att_send(op->data.att, BT_ATT_OP_FIND_INFO_REQ,
+						pdu, sizeof(pdu),
+						discover_descs_cb,
+						discover_descs_op_ref(op),
+						discover_descs_op_unref))
+			return;
+
+		discover_descs_op_unref(op);
+		status = BT_GATT_ERROR_UNKNOWN;
+		goto done;
+	}
+
+success:
+	results = op->data.results;
+	status = 0;
+
+done:
+	if (op->data.callback)
+		op->data.callback(status, results, op->data.user_data);
+}
+
 bool bt_gatt_discover_descriptors(struct bt_att *att,
 					uint16_t start, uint16_t end,
 					bt_gatt_discovery_callback_t callback,
 					void *user_data,
 					bt_gatt_destroy_func_t destroy)
 {
-	/* TODO */
-	return false;
+	struct discover_descs_op *op;
+	uint8_t pdu[4];
+
+	if (!att)
+		return false;
+
+	op = new0(struct discover_descs_op, 1);
+	if (!op)
+		return false;
+
+	op->data.results = queue_new();
+	if (!op->data.results) {
+		free(op);
+		return false;
+	}
+
+	op->data.att = att;
+	op->data.callback = callback;
+	op->data.user_data = user_data;
+	op->data.destroy = destroy;
+	op->end = end;
+
+	put_le16(start, pdu);
+	put_le16(end, pdu + 2);
+
+	if (!bt_att_send(att, BT_ATT_OP_FIND_INFO_REQ, pdu, sizeof(pdu),
+						discover_descs_cb,
+						discover_descs_op_ref(op),
+						discover_descs_op_unref)) {
+		queue_destroy(op->data.results, free);
+		free(op);
+		return false;
+	}
+
+	return true;
 }
 
 bool bt_gatt_read_value(struct bt_att *att, uint16_t value_handle,
-- 
2.0.0.526.g5318336

