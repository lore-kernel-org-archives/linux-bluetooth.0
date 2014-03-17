Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 11/12] android/avrcp-lib: Add support for parsing ResgisterNotification PDU
Date: Mon, 17 Mar 2014 10:08:56 +0200
Message-Id: <1395043737-8905-11-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1395043737-8905-1-git-send-email-luiz.dentz@gmail.com>
References: <1395043737-8905-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 android/avrcp-lib.c | 25 +++++++++++++++++++++++++
 android/avrcp-lib.h |  3 +++
 2 files changed, 28 insertions(+)

diff --git a/android/avrcp-lib.c b/android/avrcp-lib.c
index d32f791..91f51b5 100644
--- a/android/avrcp-lib.c
+++ b/android/avrcp-lib.c
@@ -508,6 +508,28 @@ static ssize_t get_element_attributes(struct avrcp *session,
 							player->user_data);
 }
 
+static ssize_t register_notification(struct avrcp *session, uint8_t transaction,
+					uint16_t params_len, uint8_t *params,
+					void *user_data)
+{
+	struct avrcp_player *player = user_data;
+	uint32_t interval;
+
+	DBG("");
+
+	if (!params || params_len != 5)
+		return -EINVAL;
+
+	if (!player->ind || !player->ind->register_notification)
+		return -ENOSYS;
+
+	interval = bt_get_be32(&params[1]);
+
+	return player->ind->register_notification(session, transaction,
+							params[0], interval,
+							player->user_data);
+}
+
 static const struct avrcp_control_handler player_handlers[] = {
 		{ AVRCP_GET_CAPABILITIES,
 					AVC_CTYPE_STATUS, AVC_CTYPE_STABLE,
@@ -536,6 +558,9 @@ static const struct avrcp_control_handler player_handlers[] = {
 		{ AVRCP_GET_ELEMENT_ATTRIBUTES,
 					AVC_CTYPE_STATUS, AVC_CTYPE_STABLE,
 					get_element_attributes },
+		{ AVRCP_REGISTER_NOTIFICATION,
+					AVC_CTYPE_NOTIFY, AVC_CTYPE_INTERIM,
+					register_notification },
 		{ },
 };
 
diff --git a/android/avrcp-lib.h b/android/avrcp-lib.h
index 9257de7..256576d 100644
--- a/android/avrcp-lib.h
+++ b/android/avrcp-lib.h
@@ -156,6 +156,9 @@ struct avrcp_control_ind {
 					uint8_t transaction, uint64_t uid,
 					uint8_t number, uint32_t *attrs,
 					void *user_data);
+	int (*register_notification) (struct avrcp *session,
+					uint8_t transaction, uint8_t event,
+					uint32_t interval, void *user_data);
 };
 
 struct avrcp_control_cfm {
-- 
1.8.5.3

