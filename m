Return-Path: <cyrus@holtmann.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv5 02/14] shared/gatt: Add initial implementation of discover_included_services
Date: Thu, 16 Oct 2014 12:17:14 +0200
Message-Id: <1413454646-23076-3-git-send-email-marcin.kraglak@tieto.com>
In-Reply-To: <1413454646-23076-1-git-send-email-marcin.kraglak@tieto.com>
References: <1413454646-23076-1-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Current implementation allow to discover included services with
16 bit UUID only.
---
 src/shared/gatt-helpers.c | 108 +++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 106 insertions(+), 2 deletions(-)

diff --git a/src/shared/gatt-helpers.c b/src/shared/gatt-helpers.c
index 4dc787f..dcb2a2f 100644
--- a/src/shared/gatt-helpers.c
+++ b/src/shared/gatt-helpers.c
@@ -692,6 +692,82 @@ bool bt_gatt_discover_secondary_services(struct bt_att *att, bt_uuid_t *uuid,
 								destroy, false);
 }
 
+static void discover_included_cb(uint8_t opcode, const void *pdu,
+					uint16_t length, void *user_data)
+{
+	struct bt_gatt_result *final_result = NULL;
+	struct discovery_op *op = user_data;
+	struct bt_gatt_result *cur_result;
+	uint8_t att_ecode = 0;
+	uint16_t last_handle;
+	size_t data_length;
+	bool success;
+
+	if (opcode == BT_ATT_OP_ERROR_RSP) {
+		success = false;
+		att_ecode = process_error(pdu, length);
+
+		if (att_ecode == BT_ATT_ERROR_ATTRIBUTE_NOT_FOUND &&
+							op->result_head)
+			goto success;
+
+		goto done;
+	}
+
+	if (opcode != BT_ATT_OP_READ_BY_TYPE_RSP || !pdu || length < 6) {
+		success = false;
+		goto done;
+	}
+
+	data_length = ((uint8_t *) pdu)[0];
+
+	if ((length - 1) % data_length || data_length != 8) {
+		success = false;
+		goto done;
+	}
+
+	cur_result = result_create(opcode, pdu + 1, length - 1,
+							data_length, op);
+	if (!cur_result) {
+		success = false;
+		goto done;
+	}
+
+	if (!op->result_head)
+		op->result_head = op->result_tail = cur_result;
+	else {
+		op->result_tail->next = cur_result;
+		op->result_tail = cur_result;
+	}
+
+	last_handle = get_le16(pdu + length - data_length);
+	if (last_handle != op->end_handle) {
+		uint8_t pdu[6];
+
+		put_le16(last_handle + 1, pdu);
+		put_le16(op->end_handle, pdu + 2);
+		put_le16(GATT_INCLUDE_UUID, pdu + 4);
+
+		if (bt_att_send(op->att, BT_ATT_OP_READ_BY_TYPE_REQ,
+							pdu, sizeof(pdu),
+							discover_included_cb,
+							discovery_op_ref(op),
+							discovery_op_unref))
+			return;
+
+		discovery_op_unref(op);
+		success = false;
+	}
+
+success:
+	success = true;
+	final_result = op->result_head;
+
+done:
+	if (op->callback)
+		op->callback(success, att_ecode, final_result, op->user_data);
+}
+
 bool bt_gatt_discover_included_services(struct bt_att *att,
 					uint16_t start, uint16_t end,
 					bt_uuid_t *uuid,
@@ -699,8 +775,36 @@ bool bt_gatt_discover_included_services(struct bt_att *att,
 					void *user_data,
 					bt_gatt_destroy_func_t destroy)
 {
-	/* TODO */
-	return false;
+	struct discovery_op *op;
+	uint8_t pdu[6];
+
+	if (!att)
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
+
+	put_le16(start, pdu);
+	put_le16(end, pdu + 2);
+	put_le16(GATT_INCLUDE_UUID, pdu + 4);
+
+	if (!bt_att_send(att, BT_ATT_OP_READ_BY_TYPE_REQ,
+					pdu, sizeof(pdu),
+					discover_included_cb,
+					discovery_op_ref(op),
+					discovery_op_unref)) {
+		free(op);
+		return false;
+	}
+
+	return true;
 }
 
 static void discover_chrcs_cb(uint8_t opcode, const void *pdu,
-- 
1.9.3

