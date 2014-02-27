Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/4] android/avrcp: Implement get player attributes text
Date: Thu, 27 Feb 2014 15:35:11 +0200
Message-Id: <1393508113-18628-2-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1393508113-18628-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1393508113-18628-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

---
 android/avrcp-lib.c | 9 +++++++++
 android/avrcp-lib.h | 3 +++
 2 files changed, 12 insertions(+)

diff --git a/android/avrcp-lib.c b/android/avrcp-lib.c
index 3db5bda..52074a7 100644
--- a/android/avrcp-lib.c
+++ b/android/avrcp-lib.c
@@ -312,3 +312,12 @@ int avrcp_list_player_attributes(struct avrcp *session, avctp_rsp_cb func,
 				AVRCP_LIST_PLAYER_ATTRIBUTES, NULL, 0,
 				func, user_data);
 }
+
+int avrcp_get_player_attribute_text(struct avrcp *session, uint8_t *attributes,
+					uint8_t attr_len, avctp_rsp_cb func,
+					void *user_data)
+{
+	return avrcp_send_req(session, AVC_CTYPE_STATUS, AVC_SUBUNIT_PANEL,
+				AVRCP_GET_PLAYER_ATTRIBUTE_TEXT, attributes,
+				attr_len, func, user_data);
+}
diff --git a/android/avrcp-lib.h b/android/avrcp-lib.h
index 7283203..da8c990 100644
--- a/android/avrcp-lib.h
+++ b/android/avrcp-lib.h
@@ -110,3 +110,6 @@ int avrcp_get_capabilities(struct avrcp *session, uint8_t param,
 					avctp_rsp_cb func, void *user_data);
 int avrcp_list_player_attributes(struct avrcp *session, avctp_rsp_cb func,
 							void *user_data);
+int avrcp_get_player_attribute_text(struct avrcp *session, uint8_t *attributes,
+					uint8_t attr_len, avctp_rsp_cb func,
+					void *user_data);
-- 
1.8.3.2

