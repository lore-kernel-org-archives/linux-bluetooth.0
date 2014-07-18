Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Arman Uguray <armansito@chromium.org>
Subject: [PATCH 05/11] shared/gatt: Implement "Characteristic Discovery" procedures.
Date: Fri, 18 Jul 2014 14:13:51 -0700
Message-Id: <1405718037-15401-6-git-send-email-armansito@chromium.org>
In-Reply-To: <1405718037-15401-1-git-send-email-armansito@chromium.org>
References: <1405718037-15401-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch implements bt_gatt_discover_characteristics, which can perform the
characteristic discovery procedures "Discover All Characteristics of a Service"
and "Discover Characteristics by UUID".
---
 src/shared/gatt-helpers.c | 174 +++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 172 insertions(+), 2 deletions(-)

diff --git a/src/shared/gatt-helpers.c b/src/shared/gatt-helpers.c
index fb5a7b6..ad544f7 100644
--- a/src/shared/gatt-helpers.c
+++ b/src/shared/gatt-helpers.c
@@ -428,6 +428,136 @@ bool bt_gatt_discover_included_services(struct bt_att *att,
 	return false;
 }
 
+struct discover_chrcs_op {
+	struct discovery_op data;
+	bool by_uuid;
+	uint16_t end;
+	struct bt_gatt_characteristic *prev_chrc;
+};
+
+static struct discover_chrcs_op *discover_chrcs_op_ref(
+						struct discover_chrcs_op *op)
+{
+	__sync_fetch_and_add(&op->data.ref_count, 1);
+
+	return op;
+}
+
+static void discover_chrcs_op_unref(void *data)
+{
+	struct discover_chrcs_op *op = data;
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
+static void discover_chrcs_cb(uint8_t opcode, const void *pdu,
+					uint16_t length, void *user_data)
+{
+	struct discover_chrcs_op *op = user_data;
+	uint16_t status;
+	struct queue *results = NULL;
+	size_t data_length;
+	uint16_t last_handle;
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
+	/* PDU must contain at least the following (sans opcode):
+	 * - Attr Data Length (1 octet)
+	 * - Attr Data List (at least 7 octets):
+	 *   -- 2 octets: Attribute handle
+	 *   -- 1 octet: Characteristic properties
+	 *   -- 2 octets: Characteristic value handle
+	 *   -- 2 or 16 octets: characteristic UUID
+	 */
+	if (opcode != BT_ATT_OP_READ_BY_TYPE_RSP || !pdu || length < 8) {
+		status = BT_GATT_ERROR_INVALID_RSP;
+		goto done;
+	}
+
+	data_length = ((uint8_t *) pdu)[0];
+
+	if (((length - 1) % data_length) ||
+			(data_length != 7 && data_length != 21)) {
+		status = BT_GATT_ERROR_INVALID_RSP;
+		goto done;
+	}
+
+	for (i = 1; i < length; i += data_length) {
+		struct bt_gatt_characteristic *chrc;
+		bt_uuid_t uuid;
+
+		chrc = new0(struct bt_gatt_characteristic, 1);
+		if (!chrc) {
+			status = BT_GATT_ERROR_FAILED_ALLOC;
+			goto done;
+		}
+
+		last_handle = get_le16(pdu + i);
+		chrc->start = last_handle;
+		chrc->properties = ((uint8_t *) pdu)[i + 2];
+		chrc->value = get_le16(pdu + i + 3);
+		convert_uuid_le(pdu + i + 5, data_length - 5, chrc->uuid);
+
+		uuid.type = BT_UUID128;
+		memcpy(&uuid.value.u128, chrc->uuid, 16);
+
+		if (op->prev_chrc)
+			op->prev_chrc->end = chrc->start - 1;
+
+		op->prev_chrc = chrc;
+
+		if (!op->by_uuid || !bt_uuid_cmp(&uuid, &op->data.uuid))
+			queue_push_tail(op->data.results, chrc);
+	}
+
+	if (last_handle != op->end) {
+		uint8_t pdu[6];
+
+		put_le16(last_handle + 1, pdu);
+		put_le16(op->end, pdu + 2);
+		put_le16(GATT_CHARAC_UUID, pdu + 4);
+
+		if (bt_att_send(op->data.att, BT_ATT_OP_READ_BY_TYPE_REQ,
+						pdu, sizeof(pdu),
+						discover_chrcs_cb,
+						discover_chrcs_op_ref(op),
+						discover_chrcs_op_unref))
+			return;
+
+		discover_chrcs_op_unref(op);
+		status = BT_GATT_ERROR_UNKNOWN;
+		goto done;
+	}
+
+success:
+	results = op->data.results;
+	status = 0;
+
+	if (op->prev_chrc)
+		op->prev_chrc->end = op->end - 1;
+
+done:
+	if (op->data.callback)
+		op->data.callback(status, results, op->data.user_data);
+}
+
 bool bt_gatt_discover_characteristics(struct bt_att *att,
 					uint16_t start, uint16_t end,
 					bt_uuid_t *uuid,
@@ -435,8 +565,48 @@ bool bt_gatt_discover_characteristics(struct bt_att *att,
 					void *user_data,
 					bt_gatt_destroy_func_t destroy)
 {
-	/* TODO */
-	return false;
+	struct discover_chrcs_op *op;
+	uint8_t pdu[6];
+
+	if (!att)
+		return false;
+
+	op = new0(struct discover_chrcs_op, 1);
+	if (!op)
+		return false;
+
+	op->data.results = queue_new();
+	if (!op->data.results) {
+		free(op);
+		return false;
+	}
+
+	if (uuid) {
+		op->by_uuid = true;
+		op->data.uuid = *uuid;
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
+	put_le16(GATT_CHARAC_UUID, pdu + 4);
+
+	if (!bt_att_send(att, BT_ATT_OP_READ_BY_TYPE_REQ,
+					pdu, sizeof(pdu),
+					discover_chrcs_cb,
+					discover_chrcs_op_ref(op),
+					discover_chrcs_op_unref)) {
+		queue_destroy(op->data.results, free);
+		free(op);
+		return false;
+	}
+
+	return true;
 }
 
 bool bt_gatt_discover_descriptors(struct bt_att *att,
-- 
2.0.0.526.g5318336

