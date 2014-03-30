Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 BlueZ 04/12] android/avrcp-lib: Add avrcp_list_player_values
Date: Sun, 30 Mar 2014 22:33:30 +0300
Message-Id: <1396208018-23453-4-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1396208018-23453-1-git-send-email-luiz.dentz@gmail.com>
References: <1396208018-23453-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This function can be used to send ListPlayerValues command PDUs.
---
 android/avrcp-lib.c | 7 +++++++
 android/avrcp-lib.h | 1 +
 2 files changed, 8 insertions(+)

diff --git a/android/avrcp-lib.c b/android/avrcp-lib.c
index e73d751..dccb400 100644
--- a/android/avrcp-lib.c
+++ b/android/avrcp-lib.c
@@ -970,6 +970,13 @@ int avrcp_get_player_attribute_text(struct avrcp *session, uint8_t number,
 				get_attribute_text_rsp, session);
 }
 
+int avrcp_list_player_values(struct avrcp *session, uint8_t attr)
+{
+	return avrcp_send_req(session, AVC_CTYPE_STATUS, AVC_SUBUNIT_PANEL,
+				AVRCP_LIST_PLAYER_VALUES, &attr, sizeof(attr),
+				NULL, NULL);
+}
+
 int avrcp_get_current_player_value(struct avrcp *session, uint8_t *attrs,
 					uint8_t attr_count, avctp_rsp_cb func,
 					void *user_data)
diff --git a/android/avrcp-lib.h b/android/avrcp-lib.h
index 9ed172e..4a61948 100644
--- a/android/avrcp-lib.h
+++ b/android/avrcp-lib.h
@@ -206,6 +206,7 @@ int avrcp_register_notification(struct avrcp *session, uint8_t event,
 int avrcp_list_player_attributes(struct avrcp *session);
 int avrcp_get_player_attribute_text(struct avrcp *session, uint8_t number,
 							uint8_t *attrs);
+int avrcp_list_player_values(struct avrcp *session, uint8_t attr);
 int avrcp_set_player_value(struct avrcp *session, uint8_t *attributes,
 					uint8_t attr_count, uint8_t *values,
 					avctp_rsp_cb func, void *user_data);
-- 
1.8.5.3

