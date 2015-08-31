Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] shared/att: Make crypto really optional
Date: Mon, 31 Aug 2015 16:32:52 +0300
Message-Id: <1441027972-15511-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

If bt_crypt_new fails or ext_signed should disable any signing operation
but currently only incoming operations were being ignored and only if
ext_signed is set which ignores the fact that bt_crypt_new can still
fail if the necessary kernel modules are not available.
---
 src/shared/att.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/src/shared/att.c b/src/shared/att.c
index 70f5d72..d88169e 100644
--- a/src/shared/att.c
+++ b/src/shared/att.c
@@ -82,7 +82,6 @@ struct bt_att {
 	void *debug_data;
 
 	struct bt_crypto *crypto;
-	bool ext_signed;
 
 	struct sign_info *local_sign;
 	struct sign_info *remote_sign;
@@ -294,7 +293,7 @@ static bool encode_pdu(struct bt_att *att, struct att_send_op *op,
 	if (pdu_len > 1)
 		memcpy(op->pdu + 1, pdu, length);
 
-	if (!sign || !(op->opcode & ATT_OP_SIGNED_MASK))
+	if (!sign || !(op->opcode & ATT_OP_SIGNED_MASK) || !att->crypto)
 		return true;
 
 	if (!sign->counter(&sign_cnt, sign->user_data))
@@ -782,7 +781,7 @@ static void handle_notify(struct bt_att *att, uint8_t opcode, uint8_t *pdu,
 	const struct queue_entry *entry;
 	bool found;
 
-	if ((opcode & ATT_OP_SIGNED_MASK) && !att->ext_signed) {
+	if ((opcode & ATT_OP_SIGNED_MASK) && !att->crypto) {
 		if (!handle_signed(att, opcode, pdu, pdu_len))
 			return;
 		pdu_len -= BT_ATT_SIGNATURE_LEN;
@@ -962,7 +961,6 @@ struct bt_att *bt_att_new(int fd, bool ext_signed)
 		return NULL;
 
 	att->fd = fd;
-	att->ext_signed = ext_signed;
 	att->mtu = BT_ATT_DEFAULT_LE_MTU;
 	att->buf = malloc(att->mtu);
 	if (!att->buf)
-- 
2.4.3

