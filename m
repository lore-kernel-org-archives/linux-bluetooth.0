Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 03/12] android/avrcp-lib: Add support for parsing ListPlayerAttributes PDU
Date: Mon, 17 Mar 2014 10:08:48 +0200
Message-Id: <1395043737-8905-3-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1395043737-8905-1-git-send-email-luiz.dentz@gmail.com>
References: <1395043737-8905-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 android/avrcp-lib.c | 18 ++++++++++++++++++
 android/avrcp-lib.h |  2 ++
 2 files changed, 20 insertions(+)

diff --git a/android/avrcp-lib.c b/android/avrcp-lib.c
index 9c19092..547d429 100644
--- a/android/avrcp-lib.c
+++ b/android/avrcp-lib.c
@@ -285,10 +285,28 @@ static ssize_t get_capabilities(struct avrcp *session, uint8_t transaction,
 	return -EINVAL;
 }
 
+static ssize_t list_attributes(struct avrcp *session, uint8_t transaction,
+				uint16_t params_len, uint8_t *params,
+				void *user_data)
+{
+	struct avrcp_player *player = user_data;
+
+	DBG("");
+
+	if (!player->ind || !player->ind->list_attributes)
+		return -ENOSYS;
+
+	return player->ind->list_attributes(session, transaction,
+							player->user_data);
+}
+
 static const struct avrcp_control_handler player_handlers[] = {
 		{ AVRCP_GET_CAPABILITIES,
 					AVC_CTYPE_STATUS, AVC_CTYPE_STABLE,
 					get_capabilities },
+		{ AVRCP_LIST_PLAYER_ATTRIBUTES,
+					AVC_CTYPE_STATUS, AVC_CTYPE_STABLE,
+					list_attributes },
 		{ },
 };
 
diff --git a/android/avrcp-lib.h b/android/avrcp-lib.h
index 34c88c5..0043362 100644
--- a/android/avrcp-lib.h
+++ b/android/avrcp-lib.h
@@ -103,6 +103,8 @@ struct avrcp_control_handler {
 struct avrcp_control_ind {
 	int (*get_capabilities) (struct avrcp *session, uint8_t transaction,
 							void *user_data);
+	int (*list_attributes) (struct avrcp *session, uint8_t transaction,
+							void *user_data);
 };
 
 struct avrcp_control_cfm {
-- 
1.8.5.3

