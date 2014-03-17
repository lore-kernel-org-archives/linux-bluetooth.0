Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 06/12] android/avrcp-lib: Add support for parsing GetPlayerValueText PDU
Date: Mon, 17 Mar 2014 10:08:51 +0200
Message-Id: <1395043737-8905-6-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1395043737-8905-1-git-send-email-luiz.dentz@gmail.com>
References: <1395043737-8905-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 android/avrcp-lib.c | 58 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 android/avrcp-lib.h |  6 ++++++
 2 files changed, 64 insertions(+)

diff --git a/android/avrcp-lib.c b/android/avrcp-lib.c
index 3275992..ad551cd 100644
--- a/android/avrcp-lib.c
+++ b/android/avrcp-lib.c
@@ -356,6 +356,61 @@ static ssize_t list_values(struct avrcp *session, uint8_t transaction,
 							player->user_data);
 }
 
+static bool check_value(uint8_t attr, uint8_t number, const uint8_t *values)
+{
+	int i;
+
+	for (i = 0; i < number; i++) {
+		/* Check for invalid value */
+		switch (attr) {
+		case AVRCP_ATTRIBUTE_EQUALIZER:
+			if (values[i] < AVRCP_EQUALIZER_OFF ||
+						values[i] > AVRCP_EQUALIZER_ON)
+				return false;
+		case AVRCP_ATTRIBUTE_REPEAT_MODE:
+			if (values[i] < AVRCP_REPEAT_MODE_OFF ||
+					values[i] > AVRCP_REPEAT_MODE_GROUP)
+				return false;
+		case AVRCP_ATTRIBUTE_SHUFFLE:
+			if (values[i] < AVRCP_SHUFFLE_OFF ||
+					values[i] > AVRCP_SHUFFLE_GROUP)
+				return false;
+		case AVRCP_ATTRIBUTE_SCAN:
+			if (values[i] < AVRCP_SCAN_OFF ||
+					values[i] > AVRCP_SCAN_GROUP)
+				return false;
+		}
+	}
+
+	return true;
+}
+
+static ssize_t get_value_text(struct avrcp *session, uint8_t transaction,
+					uint16_t params_len, uint8_t *params,
+					void *user_data)
+{
+	struct avrcp_player *player = user_data;
+
+	DBG("");
+
+	if (params_len != 2 + params[1])
+		return -EINVAL;
+
+	if (params[0] > AVRCP_ATTRIBUTE_LAST ||
+					params[0] == AVRCP_ATTRIBUTE_ILEGAL)
+		return -EINVAL;
+
+	if (!check_value(params[0], params[1], &params[2]))
+		return -EINVAL;
+
+	if (!player->ind || !player->ind->get_value_text)
+		return -ENOSYS;
+
+	return player->ind->get_value_text(session, transaction, params[0],
+						params[1], &params[2],
+						player->user_data);
+}
+
 static const struct avrcp_control_handler player_handlers[] = {
 		{ AVRCP_GET_CAPABILITIES,
 					AVC_CTYPE_STATUS, AVC_CTYPE_STABLE,
@@ -369,6 +424,9 @@ static const struct avrcp_control_handler player_handlers[] = {
 		{ AVRCP_LIST_PLAYER_VALUES,
 					AVC_CTYPE_STATUS, AVC_CTYPE_STABLE,
 					list_values },
+		{ AVRCP_GET_PLAYER_VALUE_TEXT,
+					AVC_CTYPE_STATUS, AVC_CTYPE_STABLE,
+					get_value_text },
 		{ },
 };
 
diff --git a/android/avrcp-lib.h b/android/avrcp-lib.h
index 2844000..b4ce2f4 100644
--- a/android/avrcp-lib.h
+++ b/android/avrcp-lib.h
@@ -130,6 +130,12 @@ struct avrcp_control_ind {
 					void *user_data);
 	int (*list_values) (struct avrcp *session, uint8_t transaction,
 					uint8_t attr, void *user_data);
+	int (*get_value_text) (struct avrcp *session, uint8_t transaction,
+					uint8_t attr, uint8_t number,
+					uint8_t *values, void *user_data);
+	int (*get_value) (struct avrcp *session, uint8_t transaction,
+					uint8_t number, uint8_t *attrs,
+					void *user_data);
 };
 
 struct avrcp_control_cfm {
-- 
1.8.5.3

