Return-Path: <cyrus@holtmann.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/8] shared/gatt-client: Implement Read Multiple request
Date: Wed, 19 Nov 2014 14:01:28 +0100
Message-Id: <1416402095-5137-2-git-send-email-marcin.kraglak@tieto.com>
In-Reply-To: <1416402095-5137-1-git-send-email-marcin.kraglak@tieto.com>
References: <1416402095-5137-1-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

It will perform Read Multiple request and return atributes values.
---
 src/shared/gatt-client.c | 65 ++++++++++++++++++++++++++++++++++++++++++++++++
 src/shared/gatt-client.h |  7 ++++++
 2 files changed, 72 insertions(+)

diff --git a/src/shared/gatt-client.c b/src/shared/gatt-client.c
index cf93d4b..4a645eb 100644
--- a/src/shared/gatt-client.c
+++ b/src/shared/gatt-client.c
@@ -1799,6 +1799,71 @@ bool bt_gatt_client_read_value(struct bt_gatt_client *client,
 	return true;
 }
 
+static void read_multiple_cb(uint8_t opcode, const void *pdu, uint16_t length,
+								void *user_data)
+{
+	struct read_op *op = user_data;
+	uint8_t att_ecode;
+	bool success;
+
+	if (opcode != BT_ATT_OP_READ_MULT_RSP || (!pdu && length)) {
+		success = false;
+
+		if (opcode == BT_ATT_OP_ERROR_RSP)
+			att_ecode = process_error(pdu, length);
+		else
+			att_ecode = 0;
+
+		pdu = NULL;
+		length = 0;
+	} else {
+		success = true;
+		att_ecode = 0;
+	}
+
+	if (op->callback)
+		op->callback(success, att_ecode, pdu, length, op->user_data);
+}
+
+bool bt_gatt_client_read_multiple(struct bt_gatt_client *client,
+					uint16_t *handles, uint8_t num_handles,
+					bt_gatt_client_read_callback_t callback,
+					void *user_data,
+					bt_gatt_client_destroy_func_t destroy)
+{
+	uint8_t pdu[num_handles * 2];
+	struct read_op *op;
+	int i;
+
+	if (!client)
+		return false;
+
+	if (num_handles < 2)
+		return false;
+
+	if (num_handles * 2 > bt_att_get_mtu(client->att) - 1)
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
+	for (i = 0; i < num_handles; i++)
+		put_le16(handles[i], pdu + (2 * i));
+
+	if (!bt_att_send(client->att, BT_ATT_OP_READ_MULT_REQ, pdu, sizeof(pdu),
+				read_multiple_cb, op, destroy_read_op)) {
+		free(op);
+		return false;
+	}
+
+	return true;
+}
+
 struct read_long_op {
 	struct bt_gatt_client *client;
 	int ref_count;
diff --git a/src/shared/gatt-client.h b/src/shared/gatt-client.h
index adccfc5..11b1f37 100644
--- a/src/shared/gatt-client.h
+++ b/src/shared/gatt-client.h
@@ -145,6 +145,13 @@ bool bt_gatt_client_read_long_value(struct bt_gatt_client *client,
 					void *user_data,
 					bt_gatt_client_destroy_func_t destroy);
 
+
+bool bt_gatt_client_read_multiple(struct bt_gatt_client *client,
+					uint16_t *handles, uint8_t num_handles,
+					bt_gatt_client_read_callback_t callback,
+					void *user_data,
+					bt_gatt_client_destroy_func_t destroy);
+
 bool bt_gatt_client_write_without_response(struct bt_gatt_client *client,
 					uint16_t value_handle,
 					bool signed_write,
-- 
1.9.3

