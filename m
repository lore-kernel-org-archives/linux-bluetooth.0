Return-Path: <cyrus@holtmann.org>
From: Gu Chaojie <chao.jie.gu@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Gu Chaojie <chao.jie.gu@intel.com>
Subject: [PATCH 1/4] shared/att.c: Add signed command outgoing part
Date: Thu, 25 Sep 2014 14:35:28 +0800
Message-Id: <1411626931-8290-2-git-send-email-chao.jie.gu@intel.com>
In-Reply-To: <1411626931-8290-1-git-send-email-chao.jie.gu@intel.com>
References: <1411626931-8290-1-git-send-email-chao.jie.gu@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch focus on handling the singed write condition in ATT stack.
extended bt_att struct to store CSRK related information and struct
att_send_op to replace elment mtu by struct bt_att for signature PDU
need.

---
 src/shared/att-types.h   |    3 +++
 src/shared/att.c         |   40 +++++++++++++++++++++++++++++++++++++---
 src/shared/gatt-client.c |   11 ++++++-----
 3 files changed, 46 insertions(+), 8 deletions(-)

diff --git a/src/shared/att-types.h b/src/shared/att-types.h
index b85c969..da8b6ae 100644
--- a/src/shared/att-types.h
+++ b/src/shared/att-types.h
@@ -25,6 +25,9 @@
 
 #define BT_ATT_DEFAULT_LE_MTU 23
 
+/* Length of signature in write signed packet */
+#define BT_ATT_SIGNATURE_LEN		12
+
 /* ATT protocol opcodes */
 #define BT_ATT_OP_ERROR_RSP	      		0x01
 #define BT_ATT_OP_MTU_REQ			0x02
diff --git a/src/shared/att.c b/src/shared/att.c
index a5cab45..f3f531a 100644
--- a/src/shared/att.c
+++ b/src/shared/att.c
@@ -36,6 +36,7 @@
 #include "lib/uuid.h"
 #include "src/shared/att.h"
 #include "src/shared/att-types.h"
+#include "src/shared/crypto.h"
 
 #define ATT_MIN_PDU_LEN			1  /* At least 1 byte for the opcode. */
 #define ATT_OP_CMD_MASK			0x40
@@ -77,6 +78,12 @@ struct bt_att {
 	bt_att_debug_func_t debug_callback;
 	bt_att_destroy_func_t debug_destroy;
 	void *debug_data;
+
+	struct bt_crypto *crypto;
+
+	bool valid_local_csrk;
+	uint8_t local_csrk[16];
+	uint32_t local_sign_cnt;
 };
 
 enum att_op_type {
@@ -176,6 +183,8 @@ struct att_send_op {
 	bt_att_response_func_t callback;
 	bt_att_destroy_func_t destroy;
 	void *user_data;
+
+	struct bt_att *att;
 };
 
 static void destroy_att_send_op(void *data)
@@ -277,6 +286,10 @@ static bool encode_pdu(struct att_send_op *op, const void *pdu,
 						uint16_t length, uint16_t mtu)
 {
 	uint16_t pdu_len = 1;
+	struct bt_att *att = op->att;
+
+	if (op->opcode & ATT_OP_SIGNED_MASK)
+		pdu_len += BT_ATT_SIGNATURE_LEN;
 
 	if (length && pdu)
 		pdu_len += length;
@@ -293,17 +306,32 @@ static bool encode_pdu(struct att_send_op *op, const void *pdu,
 	if (pdu_len > 1)
 		memcpy(op->pdu + 1, pdu, length);
 
+	if (op->opcode & ATT_OP_SIGNED_MASK) {
+		if (bt_crypto_sign_att(att->crypto,
+					att->local_csrk,
+					op->pdu,
+					1 + length,
+					att->local_sign_cnt,
+					&((uint8_t *) op->pdu)[1 + length]))
+			att->local_sign_cnt++;
+		else
+			return false;
+	}
+
 	return true;
 }
 
-static struct att_send_op *create_att_send_op(uint8_t opcode, const void *pdu,
-						uint16_t length, uint16_t mtu,
+static struct att_send_op *create_att_send_op(uint8_t opcode,
+						const void *pdu,
+						uint16_t length,
+						struct bt_att *att,
 						bt_att_response_func_t callback,
 						void *user_data,
 						bt_att_destroy_func_t destroy)
 {
 	struct att_send_op *op;
 	enum att_op_type op_type;
+	uint16_t mtu = att->mtu;
 
 	if (length && !pdu)
 		return NULL;
@@ -334,6 +362,7 @@ static struct att_send_op *create_att_send_op(uint8_t opcode, const void *pdu,
 	op->callback = callback;
 	op->destroy = destroy;
 	op->user_data = user_data;
+	op->att = att;
 
 	if (!encode_pdu(op, pdu, length, mtu)) {
 		free(op);
@@ -707,6 +736,10 @@ struct bt_att *bt_att_new(int fd)
 	if (!att->io)
 		goto fail;
 
+	att->crypto = bt_crypto_new();
+	if (!att->crypto)
+		goto fail;
+
 	att->req_queue = queue_new();
 	if (!att->req_queue)
 		goto fail;
@@ -741,6 +774,7 @@ fail:
 	queue_destroy(att->write_queue, NULL);
 	queue_destroy(att->notify_list, NULL);
 	queue_destroy(att->disconn_list, NULL);
+	bt_crypto_unref(att->crypto);
 	io_destroy(att->io);
 	free(att->buf);
 	free(att);
@@ -931,7 +965,7 @@ unsigned int bt_att_send(struct bt_att *att, uint8_t opcode,
 	if (!att || !att->io)
 		return 0;
 
-	op = create_att_send_op(opcode, pdu, length, att->mtu, callback,
+	op = create_att_send_op(opcode, pdu, length, att, callback,
 							user_data, destroy);
 	if (!op)
 		return 0;
diff --git a/src/shared/gatt-client.c b/src/shared/gatt-client.c
index 1a157ec..b1619c6 100644
--- a/src/shared/gatt-client.c
+++ b/src/shared/gatt-client.c
@@ -973,19 +973,20 @@ bool bt_gatt_client_read_long_value(struct bt_gatt_client *client,
 bool bt_gatt_client_write_without_response(struct bt_gatt_client *client,
 					uint16_t value_handle,
 					bool signed_write,
-					uint8_t *value, uint16_t length) {
+					uint8_t *value, uint16_t length)
+{
 	uint8_t pdu[2 + length];
 
 	if (!client)
 		return 0;
 
-	/* TODO: Support this once bt_att_send supports signed writes. */
-	if (signed_write)
-		return 0;
-
 	put_le16(value_handle, pdu);
 	memcpy(pdu + 2, value, length);
 
+	if (signed_write)
+		return bt_att_send(client->att, BT_ATT_OP_SIGNED_WRITE_CMD,
+					pdu, sizeof(pdu), NULL, NULL, NULL);
+
 	return bt_att_send(client->att, BT_ATT_OP_WRITE_CMD, pdu, sizeof(pdu),
 							NULL, NULL, NULL);
 }
-- 
1.7.10.4

