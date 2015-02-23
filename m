Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 1/5] shared/att.c: Add client signing key support
Date: Mon, 23 Feb 2015 20:13:57 +0200
Message-Id: <1424715241-4980-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds support for setting local signing keys along with a callback
for loading the counter.
---
 src/shared/att.c | 87 ++++++++++++++++++++++++++++++++++++++++++++++++++------
 src/shared/att.h |  4 +++
 2 files changed, 82 insertions(+), 9 deletions(-)

diff --git a/src/shared/att.c b/src/shared/att.c
index 152f49c..4bfae5f 100644
--- a/src/shared/att.c
+++ b/src/shared/att.c
@@ -36,6 +36,7 @@
 #include "lib/bluetooth.h"
 #include "lib/uuid.h"
 #include "src/shared/att.h"
+#include "src/shared/crypto.h"
 
 #define ATT_MIN_PDU_LEN			1  /* At least 1 byte for the opcode. */
 #define ATT_OP_CMD_MASK			0x40
@@ -52,6 +53,9 @@
 #define BT_ERROR_ALREADY_IN_PROGRESS		0xfe
 #define BT_ERROR_OUT_OF_RANGE			0xff
 
+/* Length of signature in write signed packet */
+#define BT_ATT_SIGNATURE_LEN		12
+
 struct att_send_op;
 
 struct bt_att {
@@ -85,6 +89,16 @@ struct bt_att {
 	bt_att_debug_func_t debug_callback;
 	bt_att_destroy_func_t debug_destroy;
 	void *debug_data;
+
+	struct bt_crypto *crypto;
+
+	struct sign_info *local_sign;
+};
+
+struct sign_info {
+	uint8_t key[16];
+	bt_att_counter_func_t counter;
+	void *user_data;
 };
 
 enum att_op_type {
@@ -262,15 +276,20 @@ static bool match_disconn_id(const void *a, const void *b)
 	return disconn->id == id;
 }
 
-static bool encode_pdu(struct att_send_op *op, const void *pdu,
-						uint16_t length, uint16_t mtu)
+static bool encode_pdu(struct bt_att *att, struct att_send_op *op,
+					const void *pdu, uint16_t length)
 {
 	uint16_t pdu_len = 1;
+	struct sign_info *sign;
+	uint32_t sign_cnt;
+
+	if (op->opcode & ATT_OP_SIGNED_MASK)
+		pdu_len += BT_ATT_SIGNATURE_LEN;
 
 	if (length && pdu)
 		pdu_len += length;
 
-	if (pdu_len > mtu)
+	if (pdu_len > att->mtu)
 		return false;
 
 	op->len = pdu_len;
@@ -282,11 +301,29 @@ static bool encode_pdu(struct att_send_op *op, const void *pdu,
 	if (pdu_len > 1)
 		memcpy(op->pdu + 1, pdu, length);
 
-	return true;
+	if (!(op->opcode & ATT_OP_SIGNED_MASK))
+		return true;
+
+	sign = att->local_sign;
+	if (!sign)
+		goto fail;
+
+	if (!sign->counter(&sign_cnt, sign->user_data))
+		goto fail;
+
+	if ((bt_crypto_sign_att(att->crypto, sign->key, op->pdu, 1 + length,
+				sign_cnt, &((uint8_t *) op->pdu)[1 + length])))
+		return true;
+
+fail:
+	free(op->pdu);
+	return false;
 }
 
-static struct att_send_op *create_att_send_op(uint8_t opcode, const void *pdu,
-						uint16_t length, uint16_t mtu,
+static struct att_send_op *create_att_send_op(struct bt_att *att,
+						uint8_t opcode,
+						const void *pdu,
+						uint16_t length,
 						bt_att_response_func_t callback,
 						void *user_data,
 						bt_att_destroy_func_t destroy)
@@ -324,7 +361,7 @@ static struct att_send_op *create_att_send_op(uint8_t opcode, const void *pdu,
 	op->destroy = destroy;
 	op->user_data = user_data;
 
-	if (!encode_pdu(op, pdu, length, mtu)) {
+	if (!encode_pdu(att, op, pdu, length)) {
 		free(op);
 		return NULL;
 	}
@@ -810,6 +847,7 @@ static void bt_att_free(struct bt_att *att)
 		destroy_att_send_op(att->pending_ind);
 
 	io_destroy(att->io);
+	bt_crypto_unref(att->crypto);
 
 	queue_destroy(att->req_queue, NULL);
 	queue_destroy(att->ind_queue, NULL);
@@ -823,6 +861,8 @@ static void bt_att_free(struct bt_att *att)
 	if (att->debug_destroy)
 		att->debug_destroy(att->debug_data);
 
+	free(att->local_sign);
+
 	free(att->buf);
 
 	free(att);
@@ -850,6 +890,10 @@ struct bt_att *bt_att_new(int fd)
 	if (!att->io)
 		goto fail;
 
+	att->crypto = bt_crypto_new();
+	if (!att->crypto)
+		goto fail;
+
 	att->req_queue = queue_new();
 	if (!att->req_queue)
 		goto fail;
@@ -1047,8 +1091,8 @@ unsigned int bt_att_send(struct bt_att *att, uint8_t opcode,
 	if (!att || !att->io)
 		return 0;
 
-	op = create_att_send_op(opcode, pdu, length, att->mtu, callback,
-							user_data, destroy);
+	op = create_att_send_op(att, opcode, pdu, length, callback, user_data,
+								destroy);
 	if (!op)
 		return 0;
 
@@ -1307,3 +1351,28 @@ bool bt_att_set_sec_level(struct bt_att *att, int level)
 
 	return true;
 }
+
+static bool sign_set_key(struct sign_info **sign, uint8_t key[16],
+				bt_att_counter_func_t func, void *user_data)
+{
+	if (!(*sign)) {
+		*sign = new0(struct sign_info, 1);
+		if (!(*sign))
+			return false;
+	}
+
+	(*sign)->counter = func;
+	(*sign)->user_data = user_data;
+	memcpy((*sign)->key, key, 16);
+
+	return true;
+}
+
+bool bt_att_set_local_key(struct bt_att *att, uint8_t sign_key[16],
+				bt_att_counter_func_t func, void *user_data)
+{
+	if (!att)
+		return false;
+
+	return sign_set_key(&att->local_sign, sign_key, func, user_data);
+}
diff --git a/src/shared/att.h b/src/shared/att.h
index 5256ff9..0cd1a4c 100644
--- a/src/shared/att.h
+++ b/src/shared/att.h
@@ -46,6 +46,7 @@ typedef void (*bt_att_debug_func_t)(const char *str, void *user_data);
 typedef void (*bt_att_timeout_func_t)(unsigned int id, uint8_t opcode,
 							void *user_data);
 typedef void (*bt_att_disconnect_func_t)(int err, void *user_data);
+typedef bool (*bt_att_counter_func_t)(uint32_t *sign_cnt, void *user_data);
 
 bool bt_att_set_debug(struct bt_att *att, bt_att_debug_func_t callback,
 				void *user_data, bt_att_destroy_func_t destroy);
@@ -84,3 +85,6 @@ bool bt_att_unregister_all(struct bt_att *att);
 
 int bt_att_get_sec_level(struct bt_att *att);
 bool bt_att_set_sec_level(struct bt_att *att, int level);
+
+bool bt_att_set_local_key(struct bt_att *att, uint8_t sign_key[16],
+			bt_att_counter_func_t func, void *user_data);
-- 
2.1.0

