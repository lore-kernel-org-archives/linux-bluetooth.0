Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 09/12] android/avrcp-lib: Add support for parsing GetPlayStatus PDU
Date: Mon, 17 Mar 2014 10:08:54 +0200
Message-Id: <1395043737-8905-9-git-send-email-luiz.dentz@gmail.com>
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
index 2bb84e4..9577bf0 100644
--- a/android/avrcp-lib.c
+++ b/android/avrcp-lib.c
@@ -459,6 +459,21 @@ static ssize_t set_value(struct avrcp *session, uint8_t transaction,
 					&params[1], player->user_data);
 }
 
+static ssize_t get_play_status(struct avrcp *session, uint8_t transaction,
+					uint16_t params_len, uint8_t *params,
+					void *user_data)
+{
+	struct avrcp_player *player = user_data;
+
+	DBG("");
+
+	if (!player->ind || !player->ind->get_play_status)
+		return -ENOSYS;
+
+	return player->ind->get_play_status(session, transaction,
+							player->user_data);
+}
+
 static const struct avrcp_control_handler player_handlers[] = {
 		{ AVRCP_GET_CAPABILITIES,
 					AVC_CTYPE_STATUS, AVC_CTYPE_STABLE,
@@ -481,6 +496,9 @@ static const struct avrcp_control_handler player_handlers[] = {
 		{ AVRCP_SET_PLAYER_VALUE,
 					AVC_CTYPE_CONTROL, AVC_CTYPE_STABLE,
 					set_value },
+		{ AVRCP_GET_PLAY_STATUS,
+					AVC_CTYPE_STATUS, AVC_CTYPE_STABLE,
+					get_play_status },
 		{ },
 };
 
diff --git a/android/avrcp-lib.h b/android/avrcp-lib.h
index feac9af..71d710f 100644
--- a/android/avrcp-lib.h
+++ b/android/avrcp-lib.h
@@ -139,6 +139,8 @@ struct avrcp_control_ind {
 	int (*set_value) (struct avrcp *session, uint8_t transaction,
 					uint8_t number, uint8_t *attrs,
 					void *user_data);
+	int (*get_play_status) (struct avrcp *session, uint8_t transaction,
+					void *user_data);
 };
 
 struct avrcp_control_cfm {
-- 
1.8.5.3

