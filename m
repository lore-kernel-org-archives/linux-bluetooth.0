Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 15/35] android/avrcp-lib: Add support for parsing ChangePath PDU
Date: Fri, 25 Apr 2014 11:38:52 +0300
Message-Id: <1398415152-22950-16-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1398415152-22950-1-git-send-email-luiz.dentz@gmail.com>
References: <1398415152-22950-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 android/avrcp-lib.c | 42 ++++++++++++++++++++++++++++++++++++++++++
 android/avrcp-lib.h |  5 +++++
 2 files changed, 47 insertions(+)

diff --git a/android/avrcp-lib.c b/android/avrcp-lib.c
index be3305d..ce7309f 100644
--- a/android/avrcp-lib.c
+++ b/android/avrcp-lib.c
@@ -826,8 +826,34 @@ static ssize_t get_folder_items(struct avrcp *session, uint8_t transaction,
 							player->user_data);
 }
 
+static ssize_t change_path(struct avrcp *session, uint8_t transaction,
+					uint16_t params_len, uint8_t *params,
+					void *user_data)
+{
+	struct avrcp_player *player = user_data;
+	uint8_t direction;
+	uint16_t counter;
+	uint64_t uid;
+
+	DBG("");
+
+	if (!player->ind || !player->ind->change_path)
+		return -ENOSYS;
+
+	if (!params || params_len < 11)
+		return -EINVAL;
+
+	counter = get_be16(&params[0]);
+	direction = params[2];
+	uid = get_be64(&params[3]);
+
+	return player->ind->change_path(session, transaction, counter,
+					direction, uid, player->user_data);
+}
+
 static const struct avrcp_browsing_handler browsing_handlers[] = {
 		{ AVRCP_GET_FOLDER_ITEMS, get_folder_items },
+		{ AVRCP_CHANGE_PATH, change_path },
 		{ },
 };
 
@@ -2487,6 +2513,22 @@ int avrcp_get_folder_items_rsp(struct avrcp *session, uint8_t transaction,
 							iov, number * 2 + 1);
 }
 
+int avrcp_change_path_rsp(struct avrcp *session, uint8_t transaction,
+								uint32_t items)
+{
+	struct iovec iov;
+	uint8_t pdu[5];
+
+	pdu[0] = AVRCP_STATUS_SUCCESS;
+	put_be32(items, &pdu[1]);
+
+	iov.iov_base = pdu;
+	iov.iov_len = sizeof(pdu);
+
+	return avrcp_send_browsing(session, transaction, AVRCP_CHANGE_PATH,
+								&iov, 1);
+}
+
 int avrcp_send_passthrough(struct avrcp *session, uint32_t vendor, uint8_t op)
 {
 	uint8_t params[5];
diff --git a/android/avrcp-lib.h b/android/avrcp-lib.h
index 90fb5dd..0fb3586 100644
--- a/android/avrcp-lib.h
+++ b/android/avrcp-lib.h
@@ -163,6 +163,9 @@ struct avrcp_control_ind {
 					uint8_t scope, uint32_t start,
 					uint32_t end, uint16_t number,
 					uint32_t *attrs, void *user_data);
+	int (*change_path) (struct avrcp *session, uint8_t transaction,
+					uint16_t counter, uint8_t direction,
+					uint64_t uid, void *user_data);
 };
 
 struct avrcp_control_cfm {
@@ -298,5 +301,7 @@ int avrcp_get_folder_items_rsp(struct avrcp *session, uint8_t transaction,
 					uint16_t counter, uint8_t number,
 					uint8_t *type, uint16_t *len,
 					uint8_t **params);
+int avrcp_change_path_rsp(struct avrcp *session, uint8_t transaction,
+								uint32_t items);
 
 int avrcp_send_passthrough(struct avrcp *session, uint32_t vendor, uint8_t op);
-- 
1.9.0

