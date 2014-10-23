Return-Path: <cyrus@holtmann.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv6 03/14] shared/gatt: Discover included services 128 bit UUIDS
Date: Thu, 23 Oct 2014 12:15:26 +0200
Message-Id: <1414059337-12040-4-git-send-email-marcin.kraglak@tieto.com>
In-Reply-To: <1414059337-12040-1-git-send-email-marcin.kraglak@tieto.com>
References: <1414059337-12040-1-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

If included services has 128 bit UUID, it won't be returned in
READ_BY_TYPE_RSP. To get UUID READ_REQUEST is used.
This procedure is described in CORE SPEC 4.5.1 "Find Included Services".
---
 src/shared/gatt-helpers.c | 167 +++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 166 insertions(+), 1 deletion(-)

diff --git a/src/shared/gatt-helpers.c b/src/shared/gatt-helpers.c
index 4cc483a..d689c56 100644
--- a/src/shared/gatt-helpers.c
+++ b/src/shared/gatt-helpers.c
@@ -692,6 +692,157 @@ bool bt_gatt_discover_secondary_services(struct bt_att *att, bt_uuid_t *uuid,
 								destroy, false);
 }
 
+struct read_incl_data {
+	struct discovery_op *op;
+	struct bt_gatt_result *result;
+	int pos;
+	int ref_count;
+};
+
+static struct read_incl_data *new_read_included(struct bt_gatt_result *res)
+{
+	struct read_incl_data *data;
+
+	data = new0(struct read_incl_data, 1);
+	if (!data)
+		return NULL;
+
+	data->op = discovery_op_ref(res->op);
+	data->result = res;
+
+	return data;
+};
+
+static struct read_incl_data *read_included_ref(struct read_incl_data *data)
+{
+	__sync_fetch_and_add(&data->ref_count, 1);
+
+	return data;
+}
+
+static void read_included_unref(void *data)
+{
+	struct read_incl_data *read_data = data;
+
+	if (__sync_sub_and_fetch(&read_data->ref_count, 1))
+		return;
+
+	discovery_op_unref(read_data->op);
+
+	free(read_data);
+}
+
+static void discover_included_cb(uint8_t opcode, const void *pdu,
+					uint16_t length, void *user_data);
+
+static void read_included_cb(uint8_t opcode, const void *pdu,
+					uint16_t length, void *user_data)
+{
+	struct read_incl_data *data = user_data;
+	struct bt_gatt_result *final_result = NULL;
+	struct discovery_op *op = data->op;
+	struct bt_gatt_result *cur_result;
+	uint8_t att_ecode = 0;
+	uint8_t read_pdu[2];
+	bool success;
+
+	if (opcode == BT_ATT_OP_ERROR_RSP) {
+		success = false;
+		att_ecode = process_error(pdu, length);
+		goto done;
+	}
+
+	if (opcode != BT_ATT_OP_READ_RSP || (!pdu && length)) {
+		success = false;
+		goto done;
+	}
+
+	/*
+	 * UUID should be in 128 bit format, as it couldn't be read in
+	 * READ_BY_TYPE request
+	 */
+	if (length != 16) {
+		success = false;
+		goto done;
+	}
+
+	cur_result = result_create(opcode, pdu, length, length, op);
+	if (!cur_result) {
+		success = false;
+		goto done;
+	}
+
+	if (!op->result_head) {
+		op->result_head = op->result_tail = cur_result;
+	} else {
+		op->result_tail->next = cur_result;
+		op->result_tail = cur_result;
+	}
+
+	if (data->pos == data->result->pdu_len) {
+		uint16_t last_handle;
+		uint8_t pdu[6];
+
+		last_handle = get_le16(data->result->pdu + data->pos -
+							data->result->data_len);
+		if (last_handle == op->end_handle) {
+			final_result = op->result_head;
+			success = true;
+			goto done;
+		}
+
+		put_le16(last_handle + 1, pdu);
+		put_le16(op->end_handle, pdu + 2);
+		put_le16(GATT_INCLUDE_UUID, pdu + 4);
+
+		if (bt_att_send(op->att, BT_ATT_OP_READ_BY_TYPE_REQ,
+				pdu, sizeof(pdu), discover_included_cb,
+				discovery_op_ref(op), discovery_op_unref))
+			return;
+
+		discovery_op_unref(op);
+		success = false;
+		goto done;
+	}
+
+	memcpy(read_pdu, data->result->pdu + data->pos + 2, sizeof(uint16_t));
+
+	data->pos += data->result->data_len;
+
+	if (bt_att_send(op->att, BT_ATT_OP_READ_REQ, read_pdu, sizeof(read_pdu),
+				read_included_cb, read_included_ref(data),
+				read_included_unref))
+		return;
+
+	read_included_unref(data);
+	success = false;
+
+done:
+	if (op->callback)
+		op->callback(success, att_ecode, final_result, op->user_data);
+}
+
+static void read_included(struct read_incl_data *data)
+{
+	struct discovery_op *op = data->op;
+	uint8_t pdu[2];
+
+	memcpy(pdu, data->result->pdu + 2, sizeof(uint16_t));
+
+	data->pos += data->result->data_len;
+
+	if (bt_att_send(op->att, BT_ATT_OP_READ_REQ, pdu, sizeof(pdu),
+							read_included_cb,
+							read_included_ref(data),
+							read_included_unref))
+		return;
+
+	read_included_unref(data);
+
+	if (op->callback)
+		op->callback(false, 0, NULL, data->op->user_data);
+}
+
 static void discover_included_cb(uint8_t opcode, const void *pdu,
 					uint16_t length, void *user_data)
 {
@@ -730,7 +881,8 @@ static void discover_included_cb(uint8_t opcode, const void *pdu,
 	 * 2 octets - end handle of included service
 	 * optional 2 octets - Bluetooth UUID of included service
 	 */
-	if (data_length != 8 || (length - 1) % data_length) {
+	if ((data_length != 8 && data_length != 6) ||
+						(length - 1) % data_length) {
 		success = false;
 		goto failed;
 	}
@@ -749,6 +901,19 @@ static void discover_included_cb(uint8_t opcode, const void *pdu,
 		op->result_tail = cur_result;
 	}
 
+	if (data_length == 6) {
+		struct read_incl_data *data;
+
+		data = new_read_included(cur_result);
+		if (!data) {
+			success = false;
+			goto done;
+		}
+
+		read_included(data);
+		return;
+	}
+
 	last_handle = get_le16(pdu + length - data_length);
 	if (last_handle != op->end_handle) {
 		uint8_t pdu[6];
-- 
1.9.3

