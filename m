Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 04/12] android/avrcp-lib: Add support for parsing GetPlayerAttributeText PDU
Date: Mon, 17 Mar 2014 10:08:49 +0200
Message-Id: <1395043737-8905-4-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1395043737-8905-1-git-send-email-luiz.dentz@gmail.com>
References: <1395043737-8905-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 android/avrcp-lib.c | 37 +++++++++++++++++++++++++++++++++++++
 android/avrcp-lib.h |  3 +++
 2 files changed, 40 insertions(+)

diff --git a/android/avrcp-lib.c b/android/avrcp-lib.c
index 547d429..e0b1cd7 100644
--- a/android/avrcp-lib.c
+++ b/android/avrcp-lib.c
@@ -300,6 +300,40 @@ static ssize_t list_attributes(struct avrcp *session, uint8_t transaction,
 							player->user_data);
 }
 
+static bool check_attributes(uint8_t number, const uint8_t *attrs)
+{
+	int i;
+
+	for (i = 0; i < number; i++) {
+		if (attrs[i] > AVRCP_ATTRIBUTE_LAST ||
+					attrs[i] == AVRCP_ATTRIBUTE_ILEGAL)
+			return false;
+	}
+
+	return true;
+}
+
+static ssize_t get_attribute_text(struct avrcp *session, uint8_t transaction,
+					uint16_t params_len, uint8_t *params,
+					void *user_data)
+{
+	struct avrcp_player *player = user_data;
+
+	DBG("");
+
+	if (!params || params_len != 1 + params[0])
+		return -EINVAL;
+
+	if (!check_attributes(params[0], &params[1]))
+		return -EINVAL;
+
+	if (!player->ind || !player->ind->get_attribute_text)
+		return -ENOSYS;
+
+	return player->ind->get_attribute_text(session, transaction, params[0],
+						&params[1], player->user_data);
+}
+
 static const struct avrcp_control_handler player_handlers[] = {
 		{ AVRCP_GET_CAPABILITIES,
 					AVC_CTYPE_STATUS, AVC_CTYPE_STABLE,
@@ -307,6 +341,9 @@ static const struct avrcp_control_handler player_handlers[] = {
 		{ AVRCP_LIST_PLAYER_ATTRIBUTES,
 					AVC_CTYPE_STATUS, AVC_CTYPE_STABLE,
 					list_attributes },
+		{ AVRCP_GET_PLAYER_ATTRIBUTE_TEXT,
+					AVC_CTYPE_STATUS, AVC_CTYPE_STABLE,
+					get_attribute_text },
 		{ },
 };
 
diff --git a/android/avrcp-lib.h b/android/avrcp-lib.h
index 0043362..9b24509 100644
--- a/android/avrcp-lib.h
+++ b/android/avrcp-lib.h
@@ -105,6 +105,9 @@ struct avrcp_control_ind {
 							void *user_data);
 	int (*list_attributes) (struct avrcp *session, uint8_t transaction,
 							void *user_data);
+	int (*get_attribute_text) (struct avrcp *session, uint8_t transaction,
+					uint8_t number, uint8_t *attrs,
+					void *user_data);
 };
 
 struct avrcp_control_cfm {
-- 
1.8.5.3

