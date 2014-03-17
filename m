Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 10/12] android/avrcp-lib: Add support for parsing GetElementAttributes PDU
Date: Mon, 17 Mar 2014 10:08:55 +0200
Message-Id: <1395043737-8905-10-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1395043737-8905-1-git-send-email-luiz.dentz@gmail.com>
References: <1395043737-8905-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 android/avrcp-lib.c | 37 +++++++++++++++++++++++++++++++++++++
 android/avrcp-lib.h | 15 +++++++++++++++
 2 files changed, 52 insertions(+)

diff --git a/android/avrcp-lib.c b/android/avrcp-lib.c
index 9577bf0..d32f791 100644
--- a/android/avrcp-lib.c
+++ b/android/avrcp-lib.c
@@ -474,6 +474,40 @@ static ssize_t get_play_status(struct avrcp *session, uint8_t transaction,
 							player->user_data);
 }
 
+static ssize_t get_element_attributes(struct avrcp *session,
+						uint8_t transaction,
+						uint16_t params_len,
+						uint8_t *params,
+						void *user_data)
+{
+	struct avrcp_player *player = user_data;
+	uint64_t uid;
+	uint32_t attrs[AVRCP_MEDIA_ATTRIBUTE_LAST];
+	int i;
+
+	DBG("");
+
+	if (!params || params_len != 9 + params[8] * 4)
+		return -EINVAL;
+
+	uid = bt_get_be64(params);
+
+	for (i = 0; i < params[8]; i++) {
+		attrs[i] = bt_get_be32(&params[9 + i * 4]);
+
+		if (attrs[i] < AVRCP_MEDIA_ATTRIBUTE_TITLE ||
+				attrs[i] > AVRCP_MEDIA_ATTRIBUTE_DURATION)
+			return -EINVAL;
+	}
+
+	if (!player->ind || !player->ind->get_element_attributes)
+		return -ENOSYS;
+
+	return player->ind->get_element_attributes(session, transaction, uid,
+							params[8], attrs,
+							player->user_data);
+}
+
 static const struct avrcp_control_handler player_handlers[] = {
 		{ AVRCP_GET_CAPABILITIES,
 					AVC_CTYPE_STATUS, AVC_CTYPE_STABLE,
@@ -499,6 +533,9 @@ static const struct avrcp_control_handler player_handlers[] = {
 		{ AVRCP_GET_PLAY_STATUS,
 					AVC_CTYPE_STATUS, AVC_CTYPE_STABLE,
 					get_play_status },
+		{ AVRCP_GET_ELEMENT_ATTRIBUTES,
+					AVC_CTYPE_STATUS, AVC_CTYPE_STABLE,
+					get_element_attributes },
 		{ },
 };
 
diff --git a/android/avrcp-lib.h b/android/avrcp-lib.h
index 71d710f..9257de7 100644
--- a/android/avrcp-lib.h
+++ b/android/avrcp-lib.h
@@ -104,6 +104,17 @@
 #define AVRCP_SCAN_ALL			0x02
 #define AVRCP_SCAN_GROUP		0x03
 
+/* media attributes */
+#define AVRCP_MEDIA_ATTRIBUTE_ILLEGAL	0x00
+#define AVRCP_MEDIA_ATTRIBUTE_TITLE	0x01
+#define AVRCP_MEDIA_ATTRIBUTE_ARTIST	0x02
+#define AVRCP_MEDIA_ATTRIBUTE_ALBUM	0x03
+#define AVRCP_MEDIA_ATTRIBUTE_TRACK	0x04
+#define AVRCP_MEDIA_ATTRIBUTE_N_TRACKS	0x05
+#define AVRCP_MEDIA_ATTRIBUTE_GENRE	0x06
+#define AVRCP_MEDIA_ATTRIBUTE_DURATION	0x07
+#define AVRCP_MEDIA_ATTRIBUTE_LAST	AVRCP_MEDIA_ATTRIBUTE_DURATION
+
 /* Company IDs for vendor dependent commands */
 #define IEEEID_BTSIG		0x001958
 
@@ -141,6 +152,10 @@ struct avrcp_control_ind {
 					void *user_data);
 	int (*get_play_status) (struct avrcp *session, uint8_t transaction,
 					void *user_data);
+	int (*get_element_attributes) (struct avrcp *session,
+					uint8_t transaction, uint64_t uid,
+					uint8_t number, uint32_t *attrs,
+					void *user_data);
 };
 
 struct avrcp_control_cfm {
-- 
1.8.5.3

