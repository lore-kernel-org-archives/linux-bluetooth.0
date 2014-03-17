Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 07/12] android/avrcp-lib: Add support for parsing GetCurrentPlayerValue PDU
Date: Mon, 17 Mar 2014 10:08:52 +0200
Message-Id: <1395043737-8905-7-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1395043737-8905-1-git-send-email-luiz.dentz@gmail.com>
References: <1395043737-8905-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 android/avrcp-lib.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/android/avrcp-lib.c b/android/avrcp-lib.c
index ad551cd..f6bcbdf 100644
--- a/android/avrcp-lib.c
+++ b/android/avrcp-lib.c
@@ -411,6 +411,27 @@ static ssize_t get_value_text(struct avrcp *session, uint8_t transaction,
 						player->user_data);
 }
 
+static ssize_t get_value(struct avrcp *session, uint8_t transaction,
+					uint16_t params_len, uint8_t *params,
+					void *user_data)
+{
+	struct avrcp_player *player = user_data;
+
+	DBG("");
+
+	if (!params || params_len < 1 + params[0])
+		return -EINVAL;
+
+	if (!check_attributes(params[0], &params[1]))
+		return -EINVAL;
+
+	if (!player->ind || !player->ind->get_value)
+		return -ENOSYS;
+
+	return player->ind->get_value(session, transaction, params[0],
+					&params[1], player->user_data);
+}
+
 static const struct avrcp_control_handler player_handlers[] = {
 		{ AVRCP_GET_CAPABILITIES,
 					AVC_CTYPE_STATUS, AVC_CTYPE_STABLE,
@@ -427,6 +448,9 @@ static const struct avrcp_control_handler player_handlers[] = {
 		{ AVRCP_GET_PLAYER_VALUE_TEXT,
 					AVC_CTYPE_STATUS, AVC_CTYPE_STABLE,
 					get_value_text },
+		{ AVRCP_GET_CURRENT_PLAYER_VALUE,
+					AVC_CTYPE_STATUS, AVC_CTYPE_STABLE,
+					get_value },
 		{ },
 };
 
-- 
1.8.5.3

