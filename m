Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 26/35] android/avrcp-lib: Add support for parsing PlayItem PDU
Date: Fri, 25 Apr 2014 11:39:03 +0300
Message-Id: <1398415152-22950-27-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1398415152-22950-1-git-send-email-luiz.dentz@gmail.com>
References: <1398415152-22950-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 android/avrcp-lib.c | 43 +++++++++++++++++++++++++++++++++++++++++++
 android/avrcp-lib.h |  4 ++++
 2 files changed, 47 insertions(+)

diff --git a/android/avrcp-lib.c b/android/avrcp-lib.c
index f82c106..784e1af 100644
--- a/android/avrcp-lib.c
+++ b/android/avrcp-lib.c
@@ -892,10 +892,39 @@ static ssize_t get_item_attributes(struct avrcp *session, uint8_t transaction,
 						player->user_data);
 }
 
+static ssize_t play_item(struct avrcp *session, uint8_t transaction,
+					uint16_t params_len, uint8_t *params,
+					void *user_data)
+{
+	struct avrcp_player *player = user_data;
+	uint8_t scope;
+	uint64_t uid;
+	uint16_t counter;
+
+	DBG("");
+
+	if (!player->ind || !player->ind->play_item)
+		return -ENOSYS;
+
+	if (!params || params_len < 11)
+		return -EINVAL;
+
+	scope = params[0];
+	if (scope > AVRCP_MEDIA_NOW_PLAYING)
+		return -EBADRQC;
+
+	uid = get_be64(&params[1]);
+	counter = get_be16(&params[9]);
+
+	return player->ind->play_item(session, transaction, scope, uid,
+						counter, player->user_data);
+}
+
 static const struct avrcp_browsing_handler browsing_handlers[] = {
 		{ AVRCP_GET_FOLDER_ITEMS, get_folder_items },
 		{ AVRCP_CHANGE_PATH, change_path },
 		{ AVRCP_GET_ITEM_ATTRIBUTES, get_item_attributes },
+		{ AVRCP_PLAY_ITEM, play_item },
 		{ },
 };
 
@@ -2662,6 +2691,20 @@ int avrcp_get_item_attributes_rsp(struct avrcp *session, uint8_t transaction,
 					number * 2 + 1);
 }
 
+int avrcp_play_item_rsp(struct avrcp *session, uint8_t transaction)
+{
+	struct iovec iov;
+	uint8_t pdu;
+
+	pdu = AVRCP_STATUS_SUCCESS;
+
+	iov.iov_base = &pdu;
+	iov.iov_len = sizeof(pdu);
+
+	return avrcp_send_browsing(session, transaction, AVRCP_PLAY_ITEM,
+								&iov, 1);
+}
+
 int avrcp_send_passthrough(struct avrcp *session, uint32_t vendor, uint8_t op)
 {
 	uint8_t params[5];
diff --git a/android/avrcp-lib.h b/android/avrcp-lib.h
index 69eec50..cf21c56 100644
--- a/android/avrcp-lib.h
+++ b/android/avrcp-lib.h
@@ -170,6 +170,9 @@ struct avrcp_control_ind {
 					uint8_t scope, uint64_t uid,
 					uint16_t counter, uint8_t number,
 					uint32_t *attrs, void *user_data);
+	int (*play_item) (struct avrcp *session, uint8_t transaction,
+					uint8_t scope, uint64_t uid,
+					uint16_t counter, void *user_data);
 };
 
 struct avrcp_control_cfm {
@@ -313,5 +316,6 @@ int avrcp_change_path_rsp(struct avrcp *session, uint8_t transaction,
 int avrcp_get_item_attributes_rsp(struct avrcp *session, uint8_t transaction,
 					uint8_t number, uint32_t *attrs,
 					const char **text);
+int avrcp_play_item_rsp(struct avrcp *session, uint8_t transaction);
 
 int avrcp_send_passthrough(struct avrcp *session, uint32_t vendor, uint8_t op);
-- 
1.9.0

