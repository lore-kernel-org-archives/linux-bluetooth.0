Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC BlueZ 2/5] shared/att.c: Add server signing key support
Date: Fri, 20 Feb 2015 17:03:35 +0200
Message-Id: <1424444618-12393-2-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1424444618-12393-1-git-send-email-luiz.dentz@gmail.com>
References: <1424444618-12393-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds support for setting remote signing keys along with a callback
for validating the counter.
---
 src/shared/att.c | 92 +++++++++++++++++++++++++++++++++++++++++---------------
 src/shared/att.h |  2 ++
 2 files changed, 70 insertions(+), 24 deletions(-)

diff --git a/src/shared/att.c b/src/shared/att.c
index ebda308..34cf853 100644
--- a/src/shared/att.c
+++ b/src/shared/att.c
@@ -93,6 +93,7 @@ struct bt_att {
 	struct bt_crypto *crypto;
 
 	struct sign_write_info *local_info;
+	struct sign_write_info *remote_info;
 };
 
 struct sign_write_info {
@@ -686,21 +687,6 @@ static bool opcode_match(uint8_t opcode, uint8_t test_opcode)
 	return opcode == test_opcode;
 }
 
-static void notify_handler(void *data, void *user_data)
-{
-	struct att_notify *notify = data;
-	struct notify_data *not_data = user_data;
-
-	if (!opcode_match(notify->opcode, not_data->opcode))
-		return;
-
-	not_data->handler_found = true;
-
-	if (notify->callback)
-		notify->callback(not_data->opcode, not_data->pdu,
-					not_data->pdu_len, notify->user_data);
-}
-
 static void respond_not_supported(struct bt_att *att, uint8_t opcode)
 {
 	uint8_t pdu[4];
@@ -714,28 +700,76 @@ static void respond_not_supported(struct bt_att *att, uint8_t opcode)
 									NULL);
 }
 
+static bool handle_signed(struct bt_att *att, uint8_t opcode, uint8_t *pdu,
+								ssize_t pdu_len)
+{
+	uint8_t *signature;
+	uint32_t sign_cnt;
+	struct sign_write_info *info;
+
+	/* Check if there is enough data for a signature */
+	if (pdu_len < 2 + BT_ATT_SIGNATURE_LEN)
+		goto fail;
+
+	info = att->remote_info;
+	if (!info)
+		goto fail;
+
+	signature = pdu + (pdu_len - BT_ATT_SIGNATURE_LEN);
+	sign_cnt = get_le32(signature);
+
+	/* Validate counter */
+	if (!info->counter(&sign_cnt, info->user_data))
+		goto fail;
+
+	/* Generate signature and verify it */
+	if (!bt_crypto_sign_att(att->crypto, info->key, pdu,
+				pdu_len - BT_ATT_SIGNATURE_LEN, sign_cnt,
+				signature))
+		goto fail;
+
+	return true;
+
+fail:
+	util_debug(att->debug_callback, att->debug_data,
+			"ATT failed to verify signature: 0x%02x", opcode);
+
+	return false;
+}
+
 static void handle_notify(struct bt_att *att, uint8_t opcode, uint8_t *pdu,
 								ssize_t pdu_len)
 {
-	struct notify_data data;
+	const struct queue_entry *entry;
+	bool found;
+
+	if (opcode & ATT_OP_SIGNED_MASK) {
+		if (!handle_signed(att, opcode, pdu, pdu_len))
+			return;
+		pdu_len -= BT_ATT_SIGNATURE_LEN;
+	}
 
 	bt_att_ref(att);
 
-	memset(&data, 0, sizeof(data));
-	data.opcode = opcode;
+	for (found = false, entry = queue_get_entries(att->notify_list); entry;
+							entry = entry->next) {
+		struct att_notify *notify = entry->data;
 
-	if (pdu_len > 0) {
-		data.pdu = pdu;
-		data.pdu_len = pdu_len;
-	}
+		if (!opcode_match(notify->opcode, opcode))
+			continue;
+
+		found = true;
 
-	queue_foreach(att->notify_list, notify_handler, &data);
+		if (notify->callback)
+			notify->callback(opcode, pdu, pdu_len,
+							notify->user_data);
+	}
 
 	/*
 	 * If this was a request and no handler was registered for it, respond
 	 * with "Not Supported"
 	 */
-	if (!data.handler_found && get_op_type(opcode) == ATT_OP_TYPE_REQ)
+	if (!found && get_op_type(opcode) == ATT_OP_TYPE_REQ)
 		respond_not_supported(att, opcode);
 
 	bt_att_unref(att);
@@ -862,6 +896,7 @@ static void bt_att_free(struct bt_att *att)
 		att->debug_destroy(att->debug_data);
 
 	free(att->local_info);
+	free(att->remote_info);
 
 	free(att->buf);
 
@@ -1376,3 +1411,12 @@ bool bt_att_set_local_key(struct bt_att *att, uint8_t sign_key[16],
 
 	return sign_info_set_key(&att->local_info, sign_key, func, user_data);
 }
+
+bool bt_att_set_remote_key(struct bt_att *att, uint8_t sign_key[16],
+				bt_att_counter_func_t func, void *user_data)
+{
+	if (!att)
+		return false;
+
+	return sign_info_set_key(&att->remote_info, sign_key, func, user_data);
+}
diff --git a/src/shared/att.h b/src/shared/att.h
index 0cd1a4c..a440aaf 100644
--- a/src/shared/att.h
+++ b/src/shared/att.h
@@ -88,3 +88,5 @@ bool bt_att_set_sec_level(struct bt_att *att, int level);
 
 bool bt_att_set_local_key(struct bt_att *att, uint8_t sign_key[16],
 			bt_att_counter_func_t func, void *user_data);
+bool bt_att_set_remote_key(struct bt_att *att, uint8_t sign_key[16],
+			bt_att_counter_func_t func, void *user_data);
-- 
2.1.0

