Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Arman Uguray <armansito@chromium.org>
Subject: [PATCH v2 06/11] shared/gatt: Implement "Descriptor Discovery" procedure.
Date: Fri, 25 Jul 2014 15:08:38 -0700
Message-Id: <1406326123-10564-7-git-send-email-armansito@chromium.org>
In-Reply-To: <1406326123-10564-1-git-send-email-armansito@chromium.org>
References: <1406326123-10564-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch implements bt_gatt_discover_descriptors.
---
 src/shared/gatt-helpers.c | 155 +++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 153 insertions(+), 2 deletions(-)

diff --git a/src/shared/gatt-helpers.c b/src/shared/gatt-helpers.c
index 283e6d2..d02b212 100644
--- a/src/shared/gatt-helpers.c
+++ b/src/shared/gatt-helpers.c
@@ -691,14 +691,165 @@ bool bt_gatt_discover_characteristics(struct bt_att *att,
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
+	list_free(&op->data.results, free);
+
+	free(op);
+}
+
+static void discover_descs_cb(uint8_t opcode, const void *pdu,
+					uint16_t length, void *user_data)
+{
+	struct discover_descs_op *op = user_data;
+	bool success;
+	uint8_t att_ecode = 0;
+	struct bt_gatt_list *results = NULL;
+	uint8_t format;
+	uint16_t last_handle;
+	size_t data_length;
+	int i;
+
+	if (opcode == BT_ATT_OP_ERROR_RSP) {
+		success = false;
+		att_ecode = process_error(pdu, length);
+
+		if (att_ecode == BT_ATT_ERROR_ATTRIBUTE_NOT_FOUND &&
+					!list_isempty(&op->data.results))
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
+		success = false;
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
+		success = false;
+		goto done;
+	}
+
+	if ((length - 1) % data_length) {
+		success = false;
+		goto done;
+	}
+
+	for (i = 1; i < length; i += data_length) {
+		struct bt_gatt_descriptor *descr;
+
+		descr = new0(struct bt_gatt_descriptor, 1);
+		if (!descr) {
+			success = false;
+			goto done;
+		}
+
+		last_handle = get_le16(pdu + i);
+		descr->handle = last_handle;
+		convert_uuid_le(pdu + i + 2, data_length - 2, descr->uuid);
+
+		if (!list_add(&op->data.results, descr)) {
+			success = false;
+			goto done;
+		}
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
+		success = false;
+		goto done;
+	}
+
+success:
+	results = op->data.results.head;
+	success = true;
+
+done:
+	if (op->data.callback)
+		op->data.callback(success, att_ecode, results,
+							op->data.user_data);
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
+		free(op);
+		return false;
+	}
+
+	return true;
 }
 
 bool bt_gatt_read_value(struct bt_att *att, uint16_t value_handle,
-- 
2.0.0.526.g5318336

