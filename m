Return-Path: <cyrus@holtmann.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv2 1/9] shared/gatt-helpers: Add read-by-type functionality
Date: Wed, 19 Nov 2014 12:26:25 +0100
Message-Id: <1416396393-19997-2-git-send-email-marcin.kraglak@tieto.com>
In-Reply-To: <1416396393-19997-1-git-send-email-marcin.kraglak@tieto.com>
References: <1416396393-19997-1-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This is exposed to allow client reading characteristic values
with known uuid.
---
 src/shared/gatt-helpers.c | 105 ++++++++++++++++++++++++++++++++++++++++++++++
 src/shared/gatt-helpers.h |   6 +++
 2 files changed, 111 insertions(+)

diff --git a/src/shared/gatt-helpers.c b/src/shared/gatt-helpers.c
index 97e62fe..0c3fd34 100644
--- a/src/shared/gatt-helpers.c
+++ b/src/shared/gatt-helpers.c
@@ -1217,6 +1217,111 @@ bool bt_gatt_discover_characteristics(struct bt_att *att,
 	return true;
 }
 
+static void read_by_type_cb(uint8_t opcode, const void *pdu,
+					uint16_t length, void *user_data)
+{
+	struct discovery_op *op = user_data;
+	bool success;
+	uint8_t att_ecode = 0;
+	size_t data_length;
+	uint16_t last_handle;
+
+	if (opcode == BT_ATT_OP_ERROR_RSP) {
+		att_ecode = process_error(pdu, length);
+
+		if (att_ecode == BT_ATT_ERROR_ATTRIBUTE_NOT_FOUND &&
+							op->result_head)
+			success = true;
+		else
+			success = false;
+
+		goto done;
+	}
+
+	if (opcode != BT_ATT_OP_READ_BY_TYPE_RSP || !pdu) {
+		success = false;
+		att_ecode = 0;
+		goto done;
+	}
+
+	data_length = ((uint8_t *) pdu)[0];
+	if (((length - 1) % data_length)) {
+		success = false;
+		att_ecode = 0;
+		goto done;
+	}
+
+	if (!result_append(opcode, pdu + 1, length - 1, data_length, op)) {
+		success = false;
+		att_ecode = 0;
+		goto done;
+	}
+
+	last_handle = get_le16(pdu + length - data_length);
+	if (last_handle != op->end_handle) {
+		uint8_t pdu[4 + get_uuid_len(&op->uuid)];
+
+		put_le16(last_handle + 1, pdu);
+		put_le16(op->end_handle, pdu + 2);
+		put_uuid_le(&op->uuid, pdu + 4);
+
+		if (bt_att_send(op->att, BT_ATT_OP_READ_BY_TYPE_REQ,
+						pdu, sizeof(pdu),
+						read_by_type_cb,
+						discovery_op_ref(op),
+						discovery_op_unref))
+			return;
+
+		discovery_op_unref(op);
+		success = false;
+		goto done;
+	}
+
+	success = true;
+
+done:
+	if (op->callback)
+		op->callback(success, att_ecode, success ? op->result_head :
+							NULL, op->user_data);
+}
+
+bool bt_gatt_read_by_type(struct bt_att *att, uint16_t start, uint16_t end,
+					const bt_uuid_t *uuid,
+					bt_gatt_discovery_callback_t callback,
+					void *user_data,
+					bt_gatt_destroy_func_t destroy)
+{
+	struct discovery_op *op;
+	uint8_t pdu[4 + get_uuid_len(uuid)];
+
+	if (!att || !uuid || uuid->type == BT_UUID_UNSPEC)
+		return false;
+
+	op = new0(struct discovery_op, 1);
+	if (!op)
+		return false;
+
+	op->att = att;
+	op->callback = callback;
+	op->user_data = user_data;
+	op->destroy = destroy;
+	op->end_handle = end;
+	op->uuid = *uuid;
+
+	put_le16(start, pdu);
+	put_le16(end, pdu + 2);
+	put_uuid_le(uuid, pdu + 4);
+
+	if (!bt_att_send(att, BT_ATT_OP_READ_BY_TYPE_REQ, pdu, sizeof(pdu),
+					read_by_type_cb, discovery_op_ref(op),
+					discovery_op_unref)) {
+		free(op);
+		return false;
+	}
+
+	return true;
+}
+
 static void discover_descs_cb(uint8_t opcode, const void *pdu,
 					uint16_t length, void *user_data)
 {
diff --git a/src/shared/gatt-helpers.h b/src/shared/gatt-helpers.h
index 07c145d..2cc37c6 100644
--- a/src/shared/gatt-helpers.h
+++ b/src/shared/gatt-helpers.h
@@ -96,3 +96,9 @@ bool bt_gatt_discover_descriptors(struct bt_att *att,
 					bt_gatt_discovery_callback_t callback,
 					void *user_data,
 					bt_gatt_destroy_func_t destroy);
+
+bool bt_gatt_read_by_type(struct bt_att *att, uint16_t start, uint16_t end,
+					const bt_uuid_t *uuid,
+					bt_gatt_discovery_callback_t callback,
+					void *user_data,
+					bt_gatt_destroy_func_t destroy);
-- 
1.9.3

