Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 19/35] android/avrcp-lib: Add support for parsing GetItemAttributes PDU
Date: Fri, 25 Apr 2014 11:38:56 +0300
Message-Id: <1398415152-22950-20-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1398415152-22950-1-git-send-email-luiz.dentz@gmail.com>
References: <1398415152-22950-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 android/avrcp-lib.c | 86 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 android/avrcp-lib.h |  7 +++++
 2 files changed, 93 insertions(+)

diff --git a/android/avrcp-lib.c b/android/avrcp-lib.c
index ce7309f..66581b9 100644
--- a/android/avrcp-lib.c
+++ b/android/avrcp-lib.c
@@ -851,9 +851,51 @@ static ssize_t change_path(struct avrcp *session, uint8_t transaction,
 					direction, uid, player->user_data);
 }
 
+static ssize_t get_item_attributes(struct avrcp *session, uint8_t transaction,
+					uint16_t params_len, uint8_t *params,
+					void *user_data)
+{
+	struct avrcp_player *player = user_data;
+	uint8_t scope;
+	uint64_t uid;
+	uint16_t counter;
+	uint8_t number;
+	uint32_t attrs[AVRCP_MEDIA_ATTRIBUTE_LAST];
+	int i;
+
+	DBG("");
+
+	if (!player->ind || !player->ind->get_item_attributes)
+		return -ENOSYS;
+
+	if (!params || params_len < 12)
+		return -EINVAL;
+
+	scope = params[0];
+	if (scope > AVRCP_MEDIA_NOW_PLAYING)
+		return -EBADRQC;
+
+	uid = get_be64(&params[1]);
+	counter = get_be16(&params[9]);
+	number = params[11];
+
+	for (i = 0; i < number; i++) {
+		attrs[i] = get_be32(&params[12 + i * 4]);
+
+		if (attrs[i] == AVRCP_MEDIA_ATTRIBUTE_ILLEGAL ||
+				attrs[i] > AVRCP_MEDIA_ATTRIBUTE_LAST)
+			return -EINVAL;
+	}
+
+	return player->ind->get_item_attributes(session, transaction, scope,
+						uid, counter, number, attrs,
+						player->user_data);
+}
+
 static const struct avrcp_browsing_handler browsing_handlers[] = {
 		{ AVRCP_GET_FOLDER_ITEMS, get_folder_items },
 		{ AVRCP_CHANGE_PATH, change_path },
+		{ AVRCP_GET_ITEM_ATTRIBUTES, get_item_attributes },
 		{ },
 };
 
@@ -2529,6 +2571,50 @@ int avrcp_change_path_rsp(struct avrcp *session, uint8_t transaction,
 								&iov, 1);
 }
 
+int avrcp_get_item_attributes_rsp(struct avrcp *session, uint8_t transaction,
+					uint8_t number, uint32_t *attrs,
+					const char **text)
+{
+	struct iovec iov[AVRCP_MEDIA_ATTRIBUTE_LAST * 2 + 1];
+	uint8_t val[AVRCP_MEDIA_ATTRIBUTE_LAST][8];
+	uint8_t pdu[2];
+	int i;
+
+	if (number > AVRCP_MEDIA_ATTRIBUTE_LAST)
+		return -EINVAL;
+
+	pdu[0] = AVRCP_STATUS_SUCCESS;
+	pdu[1] = number;
+
+	iov[0].iov_base = pdu;
+	iov[0].iov_len = sizeof(pdu);
+
+	for (i = 0; i < number; i++) {
+		uint16_t len = 0;
+
+		if (attrs[i] > AVRCP_MEDIA_ATTRIBUTE_LAST ||
+				attrs[i] == AVRCP_MEDIA_ATTRIBUTE_ILLEGAL)
+			return -EINVAL;
+
+		if (text[i])
+			len = strlen(text[i]);
+
+		put_be32(attrs[i], &val[i][0]);
+		put_be16(AVRCP_CHARSET_UTF8, &val[i][4]);
+		put_be16(len, &val[i][6]);
+
+		iov[i + 1].iov_base = val[i];
+		iov[i + 1].iov_len = sizeof(val[i]);
+
+		iov[i + 2].iov_base = (void *) text[i];
+		iov[i + 2].iov_len = len;
+	}
+
+	return avrcp_send_browsing(session, transaction,
+					AVRCP_GET_ITEM_ATTRIBUTES, iov,
+					number * 2 + 1);
+}
+
 int avrcp_send_passthrough(struct avrcp *session, uint32_t vendor, uint8_t op)
 {
 	uint8_t params[5];
diff --git a/android/avrcp-lib.h b/android/avrcp-lib.h
index 0fb3586..0b09b4e 100644
--- a/android/avrcp-lib.h
+++ b/android/avrcp-lib.h
@@ -166,6 +166,10 @@ struct avrcp_control_ind {
 	int (*change_path) (struct avrcp *session, uint8_t transaction,
 					uint16_t counter, uint8_t direction,
 					uint64_t uid, void *user_data);
+	int (*get_item_attributes) (struct avrcp *session, uint8_t transaction,
+					uint8_t scope, uint64_t uid,
+					uint16_t counter, uint8_t number,
+					uint32_t *attrs, void *user_data);
 };
 
 struct avrcp_control_cfm {
@@ -303,5 +307,8 @@ int avrcp_get_folder_items_rsp(struct avrcp *session, uint8_t transaction,
 					uint8_t **params);
 int avrcp_change_path_rsp(struct avrcp *session, uint8_t transaction,
 								uint32_t items);
+int avrcp_get_item_attributes_rsp(struct avrcp *session, uint8_t transaction,
+					uint8_t number, uint32_t *attrs,
+					const char **text);
 
 int avrcp_send_passthrough(struct avrcp *session, uint32_t vendor, uint8_t op);
-- 
1.9.0

