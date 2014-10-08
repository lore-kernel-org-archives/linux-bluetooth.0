Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 1/8] android/avrcp-lib: Add support for SetBrowsedPlayer PDU
Date: Wed,  8 Oct 2014 15:31:42 +0300
Message-Id: <1412771509-7996-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 android/avrcp-lib.c | 77 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 android/avrcp-lib.h |  6 +++++
 2 files changed, 83 insertions(+)

diff --git a/android/avrcp-lib.c b/android/avrcp-lib.c
index 9a074ae..8350497 100644
--- a/android/avrcp-lib.c
+++ b/android/avrcp-lib.c
@@ -1243,6 +1243,30 @@ static void avrcp_set_control_handlers(struct avrcp *session,
 	session->control_data = user_data;
 }
 
+static ssize_t set_browsed(struct avrcp *session, uint8_t transaction,
+					uint16_t params_len, uint8_t *params,
+					void *user_data)
+{
+	struct avrcp_player *player = user_data;
+	struct set_browsed_req *req;
+	uint16_t id;
+
+	DBG("");
+
+	if (!player->ind || !player->ind->set_browsed)
+		return -ENOSYS;
+
+	if (!params || params_len != sizeof(*req))
+		return -EINVAL;
+
+	req = (void *) params;
+
+	id = get_be16(&req->id);
+
+	return player->ind->set_browsed(session, transaction, id,
+							player->user_data);
+}
+
 static ssize_t get_folder_items(struct avrcp *session, uint8_t transaction,
 					uint16_t params_len, uint8_t *params,
 					void *user_data)
@@ -1449,6 +1473,7 @@ static ssize_t add_to_now_playing(struct avrcp *session, uint8_t transaction,
 }
 
 static const struct avrcp_browsing_handler browsing_handlers[] = {
+		{ AVRCP_SET_BROWSED_PLAYER, set_browsed },
 		{ AVRCP_GET_FOLDER_ITEMS, get_folder_items },
 		{ AVRCP_CHANGE_PATH, change_path },
 		{ AVRCP_GET_ITEM_ATTRIBUTES, get_item_attributes },
@@ -3295,6 +3320,58 @@ int avrcp_set_addressed_player_rsp(struct avrcp *session, uint8_t transaction,
 				&iov, 1);
 }
 
+int avrcp_set_browsed_player_rsp(struct avrcp *session, uint8_t transaction,
+					uint8_t status, uint16_t counter,
+					uint32_t items, uint8_t depth,
+					const char **folders)
+{
+	struct iovec iov[UINT8_MAX * 2 + 1];
+	struct set_browsed_rsp rsp;
+	uint16_t len[UINT8_MAX];
+	int i;
+
+	if (status != AVRCP_STATUS_SUCCESS) {
+		iov[0].iov_base = &status;
+		iov[0].iov_len = sizeof(status);
+		return avrcp_send_browsing(session, transaction,
+						AVRCP_SET_BROWSED_PLAYER,
+						iov, 1);
+	}
+
+	rsp.status = status;
+	put_be16(counter, &rsp.counter);
+	put_be32(items, &rsp.items);
+	put_be16(AVRCP_CHARSET_UTF8, &rsp.charset);
+	rsp.depth = depth;
+
+	iov[0].iov_base = &rsp;
+	iov[0].iov_len = sizeof(rsp);
+
+	if (!depth)
+		return avrcp_send_browsing(session, transaction,
+						AVRCP_SET_BROWSED_PLAYER,
+						iov, 1);
+
+	for (i = 0; i < depth; i++) {
+		if (!folders[i])
+			return -EINVAL;
+
+		len[i] = strlen(folders[i]);
+
+		iov[i * 2 + 2].iov_base = (void *) folders[i];
+		iov[i * 2 + 2].iov_len = len[i];
+
+		put_be16(len[i], &len[i]);
+
+		iov[i * 2 + 1].iov_base = &len[i];
+		iov[i * 2 + 1].iov_len = sizeof(len[i]);
+	}
+
+	return avrcp_send_browsing(session, transaction,
+					AVRCP_SET_BROWSED_PLAYER, iov,
+					depth * 2 + 1);
+}
+
 int avrcp_get_folder_items_rsp(struct avrcp *session, uint8_t transaction,
 					uint16_t counter, uint8_t number,
 					uint8_t *type, uint16_t *len,
diff --git a/android/avrcp-lib.h b/android/avrcp-lib.h
index 2b6eccb..dd82deb 100644
--- a/android/avrcp-lib.h
+++ b/android/avrcp-lib.h
@@ -161,6 +161,8 @@ struct avrcp_control_ind {
 					uint8_t volume, void *user_data);
 	int (*set_addressed) (struct avrcp *session, uint8_t transaction,
 					uint16_t id, void *user_data);
+	int (*set_browsed) (struct avrcp *session, uint8_t transaction,
+					uint16_t id, void *user_data);
 	int (*get_folder_items) (struct avrcp *session, uint8_t transaction,
 					uint8_t scope, uint32_t start,
 					uint32_t end, uint16_t number,
@@ -319,6 +321,10 @@ int avrcp_set_volume_rsp(struct avrcp *session, uint8_t transaction,
 							uint8_t volume);
 int avrcp_set_addressed_player_rsp(struct avrcp *session, uint8_t transaction,
 							uint8_t status);
+int avrcp_set_browsed_player_rsp(struct avrcp *session, uint8_t transaction,
+					uint8_t status, uint16_t counter,
+					uint32_t items, uint8_t depth,
+					const char **folders);
 int avrcp_get_folder_items_rsp(struct avrcp *session, uint8_t transaction,
 					uint16_t counter, uint8_t number,
 					uint8_t *type, uint16_t *len,
-- 
1.9.3

