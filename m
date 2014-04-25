Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 33/35] android/avrcp-lib: Add support for parsing AddToNowPlaying PDU
Date: Fri, 25 Apr 2014 11:39:10 +0300
Message-Id: <1398415152-22950-34-git-send-email-luiz.dentz@gmail.com>
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
index 6c2928b..ef0f882 100644
--- a/android/avrcp-lib.c
+++ b/android/avrcp-lib.c
@@ -951,12 +951,41 @@ static ssize_t search(struct avrcp *session, uint8_t transaction,
 	return ret;
 }
 
+static ssize_t add_to_now_playing(struct avrcp *session, uint8_t transaction,
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
+	if (!player->ind || !player->ind->add_to_now_playing)
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
+	return player->ind->add_to_now_playing(session, transaction, scope, uid,
+						counter, player->user_data);
+}
+
 static const struct avrcp_browsing_handler browsing_handlers[] = {
 		{ AVRCP_GET_FOLDER_ITEMS, get_folder_items },
 		{ AVRCP_CHANGE_PATH, change_path },
 		{ AVRCP_GET_ITEM_ATTRIBUTES, get_item_attributes },
 		{ AVRCP_PLAY_ITEM, play_item },
 		{ AVRCP_SEARCH, search },
+		{ AVRCP_ADD_TO_NOW_PLAYING, add_to_now_playing },
 		{ },
 };
 
@@ -2802,6 +2831,20 @@ int avrcp_search_rsp(struct avrcp *session, uint8_t transaction,
 								&iov, 1);
 }
 
+int avrcp_add_to_now_playing_rsp(struct avrcp *session, uint8_t transaction)
+{
+	struct iovec iov;
+	uint8_t pdu;
+
+	pdu = AVRCP_STATUS_SUCCESS;
+
+	iov.iov_base = &pdu;
+	iov.iov_len = sizeof(pdu);
+
+	return avrcp_send_browsing(session, transaction,
+					AVRCP_ADD_TO_NOW_PLAYING, &iov, 1);
+}
+
 int avrcp_send_passthrough(struct avrcp *session, uint32_t vendor, uint8_t op)
 {
 	uint8_t params[5];
diff --git a/android/avrcp-lib.h b/android/avrcp-lib.h
index 83bc72e..050880c 100644
--- a/android/avrcp-lib.h
+++ b/android/avrcp-lib.h
@@ -175,6 +175,9 @@ struct avrcp_control_ind {
 					uint16_t counter, void *user_data);
 	int (*search) (struct avrcp *session, uint8_t transaction,
 					const char *string, void *user_data);
+	int (*add_to_now_playing) (struct avrcp *session, uint8_t transaction,
+					uint8_t scope, uint64_t uid,
+					uint16_t counter, void *user_data);
 };
 
 struct avrcp_control_cfm {
@@ -325,5 +328,6 @@ int avrcp_get_item_attributes_rsp(struct avrcp *session, uint8_t transaction,
 int avrcp_play_item_rsp(struct avrcp *session, uint8_t transaction);
 int avrcp_search_rsp(struct avrcp *session, uint8_t transaction,
 					uint16_t counter, uint32_t items);
+int avrcp_add_to_now_playing_rsp(struct avrcp *session, uint8_t transaction);
 
 int avrcp_send_passthrough(struct avrcp *session, uint32_t vendor, uint8_t op);
-- 
1.9.0

