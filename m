Return-Path: <cyrus@holtmann.org>
From: Gu Chaojie <chao.jie.gu@intel.com>
To: linux-bluetooth@vger.kernel.org,
	marcel@holtmann.org,
	armansito@chromium.org
Cc: Gu Chaojie <chao.jie.gu@intel.com>
Subject: [PATCH] ATT signed write command
Date: Thu, 11 Sep 2014 17:09:46 +0800
Message-Id: <1410426586-9075-1-git-send-email-chao.jie.gu@intel.com>
List-ID: <linux-bluetooth.vger.kernel.org>

This patch for signing outgoing, csrk and cryto stored in bt_att.
the verifying incoming ATT PDU implementation introduce the 
shared/gatt-server which combined with shared/gatt-db.c, so need
more disccussion.

Signed-off-by: Gu Chaojie <chao.jie.gu@intel.com>
---
 src/shared/att-types.h   |    3 +++
 src/shared/att.c         |   32 ++++++++++++++++++++++++++++++++
 src/shared/gatt-client.c |   12 +++++++-----
 3 files changed, 42 insertions(+), 5 deletions(-)

diff --git a/src/shared/att-types.h b/src/shared/att-types.h
index b85c969..b03b8f2 100644
--- a/src/shared/att-types.h
+++ b/src/shared/att-types.h
@@ -25,6 +25,9 @@
 
 #define BT_ATT_DEFAULT_LE_MTU 23
 
+/* Len of signature in write signed packet */
+#define BT_ATT_SIGNATURE_LEN		12
+
 /* ATT protocol opcodes */
 #define BT_ATT_OP_ERROR_RSP	      		0x01
 #define BT_ATT_OP_MTU_REQ			0x02
diff --git a/src/shared/att.c b/src/shared/att.c
index a5cab45..76fc360 100644
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
+	bool valid_remote_csrk;
+	uint8_t remote_csrk[16];
+	uint32_t remote_sign_cnt;
+
+	bool valid_local_csrk;
+	uint8_t local_csrk[16];
+	uint32_t local_sign_cnt;
 };
 
 enum att_op_type {
@@ -277,6 +288,12 @@ static bool encode_pdu(struct att_send_op *op, const void *pdu,
 						uint16_t length, uint16_t mtu)
 {
 	uint16_t pdu_len = 1;
+	struct bt_att *att = NULL;
+
+	if (op->opcode == BT_ATT_OP_SIGNED_WRITE_CMD) {
+		pdu_len += BT_ATT_SIGNATURE_LEN;
+		att = op->user_data;
+	}
 
 	if (length && pdu)
 		pdu_len += length;
@@ -293,6 +310,16 @@ static bool encode_pdu(struct att_send_op *op, const void *pdu,
 	if (pdu_len > 1)
 		memcpy(op->pdu + 1, pdu, length);
 
+	if (att) {
+		if (!bt_crypto_sign_att(att->crypto,
+					att->local_csrk,
+					op->pdu,
+					1 + length,
+					att->local_sign_cnt,
+					&((uint8_t *) op->pdu)[1 + length]))
+		return false;
+	}
+
 	return true;
 }
 
@@ -707,6 +734,10 @@ struct bt_att *bt_att_new(int fd)
 	if (!att->io)
 		goto fail;
 
+	att->crypto = bt_crypto_new();
+	if (!att->crypto)
+		goto fail;
+
 	att->req_queue = queue_new();
 	if (!att->req_queue)
 		goto fail;
@@ -741,6 +772,7 @@ fail:
 	queue_destroy(att->write_queue, NULL);
 	queue_destroy(att->notify_list, NULL);
 	queue_destroy(att->disconn_list, NULL);
+	bt_crypto_unref(att->crypto);
 	io_destroy(att->io);
 	free(att->buf);
 	free(att);
diff --git a/src/shared/gatt-client.c b/src/shared/gatt-client.c
index 1a157ec..2c94ad3 100644
--- a/src/shared/gatt-client.c
+++ b/src/shared/gatt-client.c
@@ -973,19 +973,21 @@ bool bt_gatt_client_read_long_value(struct bt_gatt_client *client,
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
+					pdu, sizeof(pdu), NULL,
+					client->att, NULL);
+
 	return bt_att_send(client->att, BT_ATT_OP_WRITE_CMD, pdu, sizeof(pdu),
 							NULL, NULL, NULL);
 }
-- 
1.7.10.4
