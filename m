Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 29/35] android/avrcp-lib: Add support for parsing Search PDU
Date: Fri, 25 Apr 2014 11:39:06 +0300
Message-Id: <1398415152-22950-30-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1398415152-22950-1-git-send-email-luiz.dentz@gmail.com>
References: <1398415152-22950-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 android/avrcp-lib.c | 49 +++++++++++++++++++++++++++++++++++++++++++++++++
 android/avrcp-lib.h |  4 ++++
 2 files changed, 53 insertions(+)

diff --git a/android/avrcp-lib.c b/android/avrcp-lib.c
index 784e1af..a6f69ff 100644
--- a/android/avrcp-lib.c
+++ b/android/avrcp-lib.c
@@ -920,11 +920,43 @@ static ssize_t play_item(struct avrcp *session, uint8_t transaction,
 						counter, player->user_data);
 }
 
+static ssize_t search(struct avrcp *session, uint8_t transaction,
+					uint16_t params_len, uint8_t *params,
+					void *user_data)
+{
+	struct avrcp_player *player = user_data;
+	char *string;
+	uint16_t len;
+	int ret;
+
+	DBG("");
+
+	if (!player->ind || !player->ind->search)
+		return -ENOSYS;
+
+	if (!params || params_len < 4)
+		return -EINVAL;
+
+	len = get_be16(&params[2]);
+	if (!len)
+		return -EINVAL;
+
+	string = strndup((void *) &params[4], len);
+
+	ret = player->ind->search(session, transaction, string,
+							player->user_data);
+
+	free(string);
+
+	return ret;
+}
+
 static const struct avrcp_browsing_handler browsing_handlers[] = {
 		{ AVRCP_GET_FOLDER_ITEMS, get_folder_items },
 		{ AVRCP_CHANGE_PATH, change_path },
 		{ AVRCP_GET_ITEM_ATTRIBUTES, get_item_attributes },
 		{ AVRCP_PLAY_ITEM, play_item },
+		{ AVRCP_SEARCH, search },
 		{ },
 };
 
@@ -2705,6 +2737,23 @@ int avrcp_play_item_rsp(struct avrcp *session, uint8_t transaction)
 								&iov, 1);
 }
 
+int avrcp_search_rsp(struct avrcp *session, uint8_t transaction,
+					uint16_t counter, uint32_t items)
+{
+	struct iovec iov;
+	uint8_t pdu[7];
+
+	pdu[0] = AVRCP_STATUS_SUCCESS;
+	put_be16(counter, &pdu[1]);
+	put_be32(items, &pdu[3]);
+
+	iov.iov_base = pdu;
+	iov.iov_len = sizeof(pdu);
+
+	return avrcp_send_browsing(session, transaction, AVRCP_SEARCH,
+								&iov, 1);
+}
+
 int avrcp_send_passthrough(struct avrcp *session, uint32_t vendor, uint8_t op)
 {
 	uint8_t params[5];
diff --git a/android/avrcp-lib.h b/android/avrcp-lib.h
index cf21c56..fb097af 100644
--- a/android/avrcp-lib.h
+++ b/android/avrcp-lib.h
@@ -173,6 +173,8 @@ struct avrcp_control_ind {
 	int (*play_item) (struct avrcp *session, uint8_t transaction,
 					uint8_t scope, uint64_t uid,
 					uint16_t counter, void *user_data);
+	int (*search) (struct avrcp *session, uint8_t transaction,
+					const char *string, void *user_data);
 };
 
 struct avrcp_control_cfm {
@@ -317,5 +319,7 @@ int avrcp_get_item_attributes_rsp(struct avrcp *session, uint8_t transaction,
 					uint8_t number, uint32_t *attrs,
 					const char **text);
 int avrcp_play_item_rsp(struct avrcp *session, uint8_t transaction);
+int avrcp_search_rsp(struct avrcp *session, uint8_t transaction,
+					uint16_t counter, uint32_t items);
 
 int avrcp_send_passthrough(struct avrcp *session, uint32_t vendor, uint8_t op);
-- 
1.9.0

