Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 05/12] android/avrcp-lib: Add support for parsing ListPlayerValues PDU
Date: Mon, 17 Mar 2014 10:08:50 +0200
Message-Id: <1395043737-8905-5-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1395043737-8905-1-git-send-email-luiz.dentz@gmail.com>
References: <1395043737-8905-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 android/avrcp-lib.c | 25 +++++++++++++++++++++++++
 android/avrcp-lib.h | 22 ++++++++++++++++++++++
 2 files changed, 47 insertions(+)

diff --git a/android/avrcp-lib.c b/android/avrcp-lib.c
index e0b1cd7..3275992 100644
--- a/android/avrcp-lib.c
+++ b/android/avrcp-lib.c
@@ -334,6 +334,28 @@ static ssize_t get_attribute_text(struct avrcp *session, uint8_t transaction,
 						&params[1], player->user_data);
 }
 
+static ssize_t list_values(struct avrcp *session, uint8_t transaction,
+					uint16_t params_len, uint8_t *params,
+					void *user_data)
+{
+	struct avrcp_player *player = user_data;
+
+	DBG("");
+
+	if (!params || params_len != 1)
+		return -EINVAL;
+
+	if (params[0] > AVRCP_ATTRIBUTE_LAST ||
+					params[0] == AVRCP_ATTRIBUTE_ILEGAL)
+		return -EINVAL;
+
+	if (!player->ind || !player->ind->list_values)
+		return -ENOSYS;
+
+	return player->ind->list_values(session, transaction, params[0],
+							player->user_data);
+}
+
 static const struct avrcp_control_handler player_handlers[] = {
 		{ AVRCP_GET_CAPABILITIES,
 					AVC_CTYPE_STATUS, AVC_CTYPE_STABLE,
@@ -344,6 +366,9 @@ static const struct avrcp_control_handler player_handlers[] = {
 		{ AVRCP_GET_PLAYER_ATTRIBUTE_TEXT,
 					AVC_CTYPE_STATUS, AVC_CTYPE_STABLE,
 					get_attribute_text },
+		{ AVRCP_LIST_PLAYER_VALUES,
+					AVC_CTYPE_STATUS, AVC_CTYPE_STABLE,
+					list_values },
 		{ },
 };
 
diff --git a/android/avrcp-lib.h b/android/avrcp-lib.h
index 9b24509..2844000 100644
--- a/android/avrcp-lib.h
+++ b/android/avrcp-lib.h
@@ -84,6 +84,26 @@
 #define AVRCP_ATTRIBUTE_SCAN			0x04
 #define AVRCP_ATTRIBUTE_LAST			AVRCP_ATTRIBUTE_SCAN
 
+/* equalizer values */
+#define AVRCP_EQUALIZER_OFF		0x01
+#define AVRCP_EQUALIZER_ON		0x02
+
+/* repeat mode values */
+#define AVRCP_REPEAT_MODE_OFF		0x01
+#define AVRCP_REPEAT_MODE_SINGLE	0x02
+#define AVRCP_REPEAT_MODE_ALL		0x03
+#define AVRCP_REPEAT_MODE_GROUP		0x04
+
+/* shuffle values */
+#define AVRCP_SHUFFLE_OFF		0x01
+#define AVRCP_SHUFFLE_ALL		0x02
+#define AVRCP_SHUFFLE_GROUP		0x03
+
+/* scan values */
+#define AVRCP_SCAN_OFF			0x01
+#define AVRCP_SCAN_ALL			0x02
+#define AVRCP_SCAN_GROUP		0x03
+
 /* Company IDs for vendor dependent commands */
 #define IEEEID_BTSIG		0x001958
 
@@ -108,6 +128,8 @@ struct avrcp_control_ind {
 	int (*get_attribute_text) (struct avrcp *session, uint8_t transaction,
 					uint8_t number, uint8_t *attrs,
 					void *user_data);
+	int (*list_values) (struct avrcp *session, uint8_t transaction,
+					uint8_t attr, void *user_data);
 };
 
 struct avrcp_control_cfm {
-- 
1.8.5.3

