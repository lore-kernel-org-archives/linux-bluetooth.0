Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 06/12] android/avrcp-lib: Add avrcp_get_player_value_text
Date: Wed, 26 Mar 2014 16:13:46 +0200
Message-Id: <1395843232-26750-6-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1395843232-26750-1-git-send-email-luiz.dentz@gmail.com>
References: <1395843232-26750-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This function can be used to send GetPlayerValueText command PDUs.
---
 android/avrcp-lib.c | 8 ++++++++
 android/avrcp-lib.h | 2 ++
 2 files changed, 10 insertions(+)

diff --git a/android/avrcp-lib.c b/android/avrcp-lib.c
index 43037dd..c901656 100644
--- a/android/avrcp-lib.c
+++ b/android/avrcp-lib.c
@@ -1018,6 +1018,14 @@ int avrcp_list_player_values(struct avrcp *session, uint8_t attr)
 				list_values_rsp, session);
 }
 
+int avrcp_get_player_value_text(struct avrcp *session, uint8_t attr,
+					uint8_t number, uint8_t *values)
+{
+	return avrcp_send_req(session, AVC_CTYPE_STATUS, AVC_SUBUNIT_PANEL,
+				AVRCP_GET_PLAYER_VALUE_TEXT, &attr,
+				sizeof(attr), NULL, NULL);
+}
+
 int avrcp_get_current_player_value(struct avrcp *session, uint8_t *attrs,
 					uint8_t attr_count, avctp_rsp_cb func,
 					void *user_data)
diff --git a/android/avrcp-lib.h b/android/avrcp-lib.h
index 5cbbed5..fea4f95 100644
--- a/android/avrcp-lib.h
+++ b/android/avrcp-lib.h
@@ -210,6 +210,8 @@ int avrcp_list_player_attributes(struct avrcp *session);
 int avrcp_get_player_attribute_text(struct avrcp *session, uint8_t number,
 							uint8_t *attrs);
 int avrcp_list_player_values(struct avrcp *session, uint8_t attr);
+int avrcp_get_player_value_text(struct avrcp *session, uint8_t attr,
+					uint8_t number, uint8_t *values);
 int avrcp_set_player_value(struct avrcp *session, uint8_t *attributes,
 					uint8_t attr_count, uint8_t *values,
 					avctp_rsp_cb func, void *user_data);
-- 
1.8.5.3

