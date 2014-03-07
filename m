Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 1/4] android/avrcp-lib: Add avrcp_register_notification function
Date: Fri,  7 Mar 2014 14:15:40 +0200
Message-Id: <1394194543-3095-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds avrcp_register_notification which can be used to send
RegisterNotification PDUs.
---
 android/avrcp-lib.c | 15 +++++++++++++++
 android/avrcp-lib.h |  3 +++
 2 files changed, 18 insertions(+)

diff --git a/android/avrcp-lib.c b/android/avrcp-lib.c
index d66560b..a5530ec 100644
--- a/android/avrcp-lib.c
+++ b/android/avrcp-lib.c
@@ -334,6 +334,21 @@ int avrcp_get_capabilities(struct avrcp *session, uint8_t param,
 				func, user_data);
 }
 
+int avrcp_register_notification(struct avrcp *session, uint8_t event,
+					uint32_t interval, avctp_rsp_cb func,
+					void *user_data)
+{
+	uint8_t params[5];
+
+	params[0] = event;
+	bt_put_be32(interval, &params[1]);
+
+	return avrcp_send_req(session, AVC_CTYPE_NOTIFY, AVC_SUBUNIT_PANEL,
+					AVRCP_REGISTER_NOTIFICATION,
+					params, sizeof(params),
+					func, user_data);
+}
+
 int avrcp_list_player_attributes(struct avrcp *session, avctp_rsp_cb func,
 								void *user_data)
 {
diff --git a/android/avrcp-lib.h b/android/avrcp-lib.h
index ba1d84a..4a49fe7 100644
--- a/android/avrcp-lib.h
+++ b/android/avrcp-lib.h
@@ -132,6 +132,9 @@ int avrcp_send(struct avrcp *session, uint8_t transaction, uint8_t code,
 					uint8_t *params, size_t params_len);
 int avrcp_get_capabilities(struct avrcp *session, uint8_t param,
 					avctp_rsp_cb func, void *user_data);
+int avrcp_register_notification(struct avrcp *session, uint8_t event,
+					uint32_t interval, avctp_rsp_cb func,
+					void *user_data);
 int avrcp_list_player_attributes(struct avrcp *session, avctp_rsp_cb func,
 							void *user_data);
 int avrcp_get_player_attribute_text(struct avrcp *session, uint8_t *attributes,
-- 
1.8.5.3

