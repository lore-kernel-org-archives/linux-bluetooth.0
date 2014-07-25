Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Arman Uguray <armansito@chromium.org>
Subject: [PATCH v2 05/11] shared/gatt: Implement "Characteristic Discovery" procedures.
Date: Fri, 25 Jul 2014 15:08:37 -0700
Message-Id: <1406326123-10564-6-git-send-email-armansito@chromium.org>
In-Reply-To: <1406326123-10564-1-git-send-email-armansito@chromium.org>
References: <1406326123-10564-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch implements bt_gatt_discover_characteristics, which can perform the
characteristic discovery procedures "Discover All Characteristics of a Service"
and "Discover Characteristics by UUID".
---
 src/shared/gatt-helpers.c | 174 +++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 172 insertions(+), 2 deletions(-)

diff --git a/src/shared/gatt-helpers.c b/src/shared/gatt-helpers.c
index e3ca681..283e6d2 100644
--- a/src/shared/gatt-helpers.c
+++ b/src/shared/gatt-helpers.c
@@ -510,6 +510,143 @@ bool bt_gatt_discover_included_services(struct bt_att *att,
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
+	list_free(&op->data.results, free);
+
+	free(op);
+}
+
+static void discover_chrcs_cb(uint8_t opcode, const void *pdu,
+					uint16_t length, void *user_data)
+{
+	struct discover_chrcs_op *op = user_data;
+	bool success;
+	uint8_t att_ecode = 0;
+	struct bt_gatt_list *results = NULL;
+	size_t data_length;
+	uint16_t last_handle;
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
+	/* PDU must contain at least the following (sans opcode):
+	 * - Attr Data Length (1 octet)
+	 * - Attr Data List (at least 7 octets):
+	 *   -- 2 octets: Attribute handle
+	 *   -- 1 octet: Characteristic properties
+	 *   -- 2 octets: Characteristic value handle
+	 *   -- 2 or 16 octets: characteristic UUID
+	 */
+	if (opcode != BT_ATT_OP_READ_BY_TYPE_RSP || !pdu || length < 8) {
+		success = false;
+		goto done;
+	}
+
+	data_length = ((uint8_t *) pdu)[0];
+
+	if (((length - 1) % data_length) ||
+			(data_length != 7 && data_length != 21)) {
+		success = false;
+		goto done;
+	}
+
+	for (i = 1; i < length; i += data_length) {
+		struct bt_gatt_characteristic *chrc;
+		bt_uuid_t uuid;
+
+		chrc = new0(struct bt_gatt_characteristic, 1);
+		if (!chrc) {
+			success = false;
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
+		if (!op->by_uuid || !bt_uuid_cmp(&uuid, &op->data.uuid)) {
+			if (!list_add(&op->data.results, chrc)) {
+				success = false;
+				goto done;
+			}
+		}
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
+		success = false;
+		goto done;
+	}
+
+success:
+	results = op->data.results.head;
+	success = true;
+
+	if (op->prev_chrc)
+		op->prev_chrc->end = op->end - 1;
+
+done:
+	if (op->data.callback)
+		op->data.callback(success, att_ecode, results,
+							op->data.user_data);
+}
+
 bool bt_gatt_discover_characteristics(struct bt_att *att,
 					uint16_t start, uint16_t end,
 					bt_uuid_t *uuid,
@@ -517,8 +654,41 @@ bool bt_gatt_discover_characteristics(struct bt_att *att,
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
+		free(op);
+		return false;
+	}
+
+	return true;
 }
 
 bool bt_gatt_discover_descriptors(struct bt_att *att,
-- 
2.0.0.526.g5318336

