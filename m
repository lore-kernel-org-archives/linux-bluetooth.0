Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv2 5/9] android/avrcp: Add avrcp_get_current_player_value() function
Date: Fri, 28 Feb 2014 16:18:41 +0200
Message-Id: <1393597125-18176-5-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1393597125-18176-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1393597125-18176-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

---
 android/avrcp-lib.c | 21 +++++++++++++++++++++
 android/avrcp-lib.h | 11 +++++++++++
 2 files changed, 32 insertions(+)

diff --git a/android/avrcp-lib.c b/android/avrcp-lib.c
index 52074a7..053e9e1 100644
--- a/android/avrcp-lib.c
+++ b/android/avrcp-lib.c
@@ -321,3 +321,24 @@ int avrcp_get_player_attribute_text(struct avrcp *session, uint8_t *attributes,
 				AVRCP_GET_PLAYER_ATTRIBUTE_TEXT, attributes,
 				attr_len, func, user_data);
 }
+
+int avrcp_get_current_player_value(struct avrcp *session, uint8_t *attributes,
+					uint8_t attr_count, avctp_rsp_cb func,
+					void *user_data)
+
+{
+	uint8_t buf[AVRCP_ATTRIBUTE_LAST + 1];
+
+	if (attr_count > AVRCP_ATTRIBUTE_LAST)
+		return -EINVAL;
+
+	if (attributes && attr_count) {
+		buf[0] = attr_count;
+		memcpy(buf + 1, attributes, attr_count);
+	}
+
+	return avrcp_send_req(session, AVC_CTYPE_STATUS, AVC_SUBUNIT_PANEL,
+				AVRCP_GET_CURRENT_PLAYER_VALUE, buf,
+				attr_count + 1, func, user_data);
+
+}
diff --git a/android/avrcp-lib.h b/android/avrcp-lib.h
index da8c990..1f7eab0 100644
--- a/android/avrcp-lib.h
+++ b/android/avrcp-lib.h
@@ -74,6 +74,14 @@
 #define CAP_COMPANY_ID				0x02
 #define CAP_EVENTS_SUPPORTED			0x03
 
+/* Player Attributes */
+#define AVRCP_ATTRIBUTE_ILEGAL			0x00
+#define AVRCP_ATTRIBUTE_EQUALIZER		0x01
+#define AVRCP_ATTRIBUTE_REPEAT_MODE		0x02
+#define AVRCP_ATTRIBUTE_SHUFFLE			0x03
+#define AVRCP_ATTRIBUTE_SCAN			0x04
+#define AVRCP_ATTRIBUTE_LAST			AVRCP_ATTRIBUTE_SCAN
+
 /* Company IDs for vendor dependent commands */
 #define IEEEID_BTSIG		0x001958
 
@@ -113,3 +121,6 @@ int avrcp_list_player_attributes(struct avrcp *session, avctp_rsp_cb func,
 int avrcp_get_player_attribute_text(struct avrcp *session, uint8_t *attributes,
 					uint8_t attr_len, avctp_rsp_cb func,
 					void *user_data);
+int avrcp_get_current_player_value(struct avrcp *session, uint8_t *attributes,
+					uint8_t attr_count, avctp_rsp_cb func,
+					void *user_data);
-- 
1.8.3.2

