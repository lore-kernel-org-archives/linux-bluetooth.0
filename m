Return-Path: <cyrus@holtmann.org>
From: Gu Chaojie <chao.jie.gu@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Gu Chaojie <chao.jie.gu@intel.com>
Subject: [PATCH v2 1/3] shared/att.c: Add signed command outgoing and related CSRK function
Date: Thu, 25 Sep 2014 16:28:56 +0800
Message-Id: <1411633738-19108-2-git-send-email-chao.jie.gu@intel.com>
In-Reply-To: <1411633738-19108-1-git-send-email-chao.jie.gu@intel.com>
References: <1411633738-19108-1-git-send-email-chao.jie.gu@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch focus on handling signed write in ATT stack.
extend struct bt_att to store CSRK related information
and struct att_send_op to replace mtu by struct bt_att
for signature PDU need.

And add three CSRK related function for upper layer
Set CSRK into bt_att structure
Get CSRK into bt_att structure
Decide if CSRK is valid or not

---
 src/shared/att-types.h |    3 ++
 src/shared/att.c       |  101 ++++++++++++++++++++++++++++++++++++++++++++++--
 src/shared/att.h       |   13 +++++++
 3 files changed, 114 insertions(+), 3 deletions(-)

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
index a5cab45..b31eb9e 100644
--- a/src/shared/att.c
+++ b/src/shared/att.c
@@ -36,6 +36,7 @@
 #include "lib/uuid.h"
 #include "src/shared/att.h"
 #include "src/shared/att-types.h"
+#include "src/shared/crypto.h"
 
 #define ATT_MIN_PDU_LEN			1  /* At least 1 byte for the opcode. */
 #define ATT_OP_CMD_MASK			0x40
@@ -77,6 +78,16 @@ struct bt_att {
 	bt_att_debug_func_t debug_callback;
 	bt_att_destroy_func_t debug_destroy;
 	void *debug_data;
+
+	struct bt_crypto *crypto;
+
+	bool valid_local_csrk;
+	uint8_t local_csrk[16];
+	uint32_t local_sign_cnt;
+
+	bool valid_remote_csrk;
+	uint8_t remote_csrk[16];
+	uint32_t remote_sign_cnt;
 };
 
 enum att_op_type {
@@ -176,6 +187,8 @@ struct att_send_op {
 	bt_att_response_func_t callback;
 	bt_att_destroy_func_t destroy;
 	void *user_data;
+
+	struct bt_att *att;
 };
 
 static void destroy_att_send_op(void *data)
@@ -277,6 +290,10 @@ static bool encode_pdu(struct att_send_op *op, const void *pdu,
 						uint16_t length, uint16_t mtu)
 {
 	uint16_t pdu_len = 1;
+	struct bt_att *att = op->att;
+
+	if (op->opcode & ATT_OP_SIGNED_MASK)
+		pdu_len += BT_ATT_SIGNATURE_LEN;
 
 	if (length && pdu)
 		pdu_len += length;
@@ -293,17 +310,32 @@ static bool encode_pdu(struct att_send_op *op, const void *pdu,
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
@@ -334,6 +366,7 @@ static struct att_send_op *create_att_send_op(uint8_t opcode, const void *pdu,
 	op->callback = callback;
 	op->destroy = destroy;
 	op->user_data = user_data;
+	op->att = att;
 
 	if (!encode_pdu(op, pdu, length, mtu)) {
 		free(op);
@@ -698,6 +731,8 @@ struct bt_att *bt_att_new(int fd)
 
 	att->fd = fd;
 
+	att->local_sign_cnt = 0;
+	att->remote_sign_cnt = 0;
 	att->mtu = BT_ATT_DEFAULT_LE_MTU;
 	att->buf = malloc(att->mtu);
 	if (!att->buf)
@@ -707,6 +742,10 @@ struct bt_att *bt_att_new(int fd)
 	if (!att->io)
 		goto fail;
 
+	att->crypto = bt_crypto_new();
+	if (!att->crypto)
+		goto fail;
+
 	att->req_queue = queue_new();
 	if (!att->req_queue)
 		goto fail;
@@ -741,6 +780,7 @@ fail:
 	queue_destroy(att->write_queue, NULL);
 	queue_destroy(att->notify_list, NULL);
 	queue_destroy(att->disconn_list, NULL);
+	bt_crypto_unref(att->crypto);
 	io_destroy(att->io);
 	free(att->buf);
 	free(att);
@@ -931,7 +971,7 @@ unsigned int bt_att_send(struct bt_att *att, uint8_t opcode,
 	if (!att || !att->io)
 		return 0;
 
-	op = create_att_send_op(opcode, pdu, length, att->mtu, callback,
+	op = create_att_send_op(opcode, pdu, length, att, callback,
 							user_data, destroy);
 	if (!op)
 		return 0;
@@ -1116,3 +1156,58 @@ bool bt_att_unregister_all(struct bt_att *att)
 
 	return true;
 }
+
+bool bt_att_set_csrk(struct bt_att *att, enum bt_csrk_type type,
+				bool valid_csrk, uint8_t key[16])
+{
+
+	bool local = (type == LOCAL_CSRK);
+
+	if (!att)
+		return false;
+
+	if (local) {
+		att->valid_local_csrk = valid_csrk;
+		memcpy(att->local_csrk, key, 16);
+	} else {
+		att->valid_remote_csrk = valid_csrk;
+		memcpy(att->remote_csrk, key, 16);
+	}
+
+	return true;
+}
+
+bool bt_att_get_csrk(struct bt_att *att, enum bt_csrk_type type,
+				uint8_t key[16], uint32_t *sign_cnt)
+{
+	bool local = (type == LOCAL_CSRK);
+
+	if (!att)
+		return false;
+
+	if (local && att->valid_local_csrk) {
+		memcpy(key, att->local_csrk, 16);
+		*sign_cnt = att->local_sign_cnt;
+	} else if (!local && att->valid_remote_csrk) {
+		memcpy(key, att->remote_csrk, 16);
+		*sign_cnt = att->remote_sign_cnt;
+	} else {
+		return false;
+	}
+
+	return true;
+}
+
+bool bt_att_csrk_is_valid(struct bt_att *att, enum bt_csrk_type type)
+{
+	bool local = (type == LOCAL_CSRK);
+
+	if (!att)
+		return false;
+
+	if (local)
+		return att->valid_local_csrk;
+	else
+		return att->valid_remote_csrk;
+
+}
diff --git a/src/shared/att.h b/src/shared/att.h
index 1063021..9a54f64 100644
--- a/src/shared/att.h
+++ b/src/shared/att.h
@@ -26,6 +26,11 @@
 
 #include "src/shared/att-types.h"
 
+enum bt_csrk_type {
+	LOCAL_CSRK,
+	REMOTE_CSRK,
+};
+
 struct bt_att;
 
 struct bt_att *bt_att_new(int fd);
@@ -76,3 +81,11 @@ unsigned int bt_att_register_disconnect(struct bt_att *att,
 bool bt_att_unregister_disconnect(struct bt_att *att, unsigned int id);
 
 bool bt_att_unregister_all(struct bt_att *att);
+
+bool bt_att_set_csrk(struct bt_att *att, enum bt_csrk_type type,
+				bool valid_csrk, uint8_t key[16]);
+
+bool bt_att_get_csrk(struct bt_att *att, enum bt_csrk_type type,
+				uint8_t key[16], uint32_t *sign_cnt);
+
+bool bt_att_csrk_is_valid(struct bt_att *att, enum bt_csrk_type type);
-- 
1.7.10.4

