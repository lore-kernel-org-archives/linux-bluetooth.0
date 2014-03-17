Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 12/12] android/avrcp-lib: Add support for parsing SetAddressedPlayer PDU
Date: Mon, 17 Mar 2014 10:08:57 +0200
Message-Id: <1395043737-8905-12-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1395043737-8905-1-git-send-email-luiz.dentz@gmail.com>
References: <1395043737-8905-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 android/avrcp-lib.c | 24 ++++++++++++++++++++++++
 android/avrcp-lib.h |  2 ++
 2 files changed, 26 insertions(+)

diff --git a/android/avrcp-lib.c b/android/avrcp-lib.c
index 91f51b5..083d7af 100644
--- a/android/avrcp-lib.c
+++ b/android/avrcp-lib.c
@@ -530,6 +530,27 @@ static ssize_t register_notification(struct avrcp *session, uint8_t transaction,
 							player->user_data);
 }
 
+static ssize_t set_addressed(struct avrcp *session, uint8_t transaction,
+					uint16_t params_len, uint8_t *params,
+					void *user_data)
+{
+	struct avrcp_player *player = user_data;
+	uint16_t id;
+
+	DBG("");
+
+	if (!params || params_len != 2)
+		return -EINVAL;
+
+	if (!player->ind || !player->ind->set_addressed)
+		return -ENOSYS;
+
+	id = bt_get_be16(params);
+
+	return player->ind->set_addressed(session, transaction, id,
+							player->user_data);
+}
+
 static const struct avrcp_control_handler player_handlers[] = {
 		{ AVRCP_GET_CAPABILITIES,
 					AVC_CTYPE_STATUS, AVC_CTYPE_STABLE,
@@ -561,6 +582,9 @@ static const struct avrcp_control_handler player_handlers[] = {
 		{ AVRCP_REGISTER_NOTIFICATION,
 					AVC_CTYPE_NOTIFY, AVC_CTYPE_INTERIM,
 					register_notification },
+		{ AVRCP_SET_ADDRESSED_PLAYER,
+					AVC_CTYPE_CONTROL, AVC_CTYPE_STABLE,
+					set_addressed },
 		{ },
 };
 
diff --git a/android/avrcp-lib.h b/android/avrcp-lib.h
index 256576d..54bdf4f 100644
--- a/android/avrcp-lib.h
+++ b/android/avrcp-lib.h
@@ -159,6 +159,8 @@ struct avrcp_control_ind {
 	int (*register_notification) (struct avrcp *session,
 					uint8_t transaction, uint8_t event,
 					uint32_t interval, void *user_data);
+	int (*set_addressed) (struct avrcp *session, uint8_t transaction,
+					uint16_t id, void *user_data);
 };
 
 struct avrcp_control_cfm {
-- 
1.8.5.3

