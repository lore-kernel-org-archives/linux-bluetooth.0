Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 08/12] android/avrcp-lib: Add support for parsing SetPlayerValue PDU
Date: Mon, 17 Mar 2014 10:08:53 +0200
Message-Id: <1395043737-8905-8-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1395043737-8905-1-git-send-email-luiz.dentz@gmail.com>
References: <1395043737-8905-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 android/avrcp-lib.c | 30 ++++++++++++++++++++++++++++++
 android/avrcp-lib.h |  3 +++
 2 files changed, 33 insertions(+)

diff --git a/android/avrcp-lib.c b/android/avrcp-lib.c
index f6bcbdf..2bb84e4 100644
--- a/android/avrcp-lib.c
+++ b/android/avrcp-lib.c
@@ -432,6 +432,33 @@ static ssize_t get_value(struct avrcp *session, uint8_t transaction,
 					&params[1], player->user_data);
 }
 
+static ssize_t set_value(struct avrcp *session, uint8_t transaction,
+					uint16_t params_len, uint8_t *params,
+					void *user_data)
+{
+	struct avrcp_player *player = user_data;
+	int i;
+
+	DBG("");
+
+	if (!params || params_len != params[0] * 2 + 1)
+		return -EINVAL;
+
+	for (i = 0; i < params[0]; i++) {
+		uint8_t attr = params[i * 2 + 1];
+		uint8_t val = params[i * 2 + 2];
+
+		if (!check_value(attr, 1, &val))
+			return -EINVAL;
+	}
+
+	if (!player->ind || !player->ind->set_value)
+		return -ENOSYS;
+
+	return player->ind->set_value(session, transaction, params[0],
+					&params[1], player->user_data);
+}
+
 static const struct avrcp_control_handler player_handlers[] = {
 		{ AVRCP_GET_CAPABILITIES,
 					AVC_CTYPE_STATUS, AVC_CTYPE_STABLE,
@@ -451,6 +478,9 @@ static const struct avrcp_control_handler player_handlers[] = {
 		{ AVRCP_GET_CURRENT_PLAYER_VALUE,
 					AVC_CTYPE_STATUS, AVC_CTYPE_STABLE,
 					get_value },
+		{ AVRCP_SET_PLAYER_VALUE,
+					AVC_CTYPE_CONTROL, AVC_CTYPE_STABLE,
+					set_value },
 		{ },
 };
 
diff --git a/android/avrcp-lib.h b/android/avrcp-lib.h
index b4ce2f4..feac9af 100644
--- a/android/avrcp-lib.h
+++ b/android/avrcp-lib.h
@@ -136,6 +136,9 @@ struct avrcp_control_ind {
 	int (*get_value) (struct avrcp *session, uint8_t transaction,
 					uint8_t number, uint8_t *attrs,
 					void *user_data);
+	int (*set_value) (struct avrcp *session, uint8_t transaction,
+					uint8_t number, uint8_t *attrs,
+					void *user_data);
 };
 
 struct avrcp_control_cfm {
-- 
1.8.5.3

