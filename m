Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv2 8/9] android/avrcp: Add avrcp_set_player_value() function
Date: Fri, 28 Feb 2014 16:18:44 +0200
Message-Id: <1393597125-18176-8-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1393597125-18176-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1393597125-18176-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

---
 android/avrcp-lib.c | 18 ++++++++++++++++++
 android/avrcp-lib.h |  3 +++
 2 files changed, 21 insertions(+)

diff --git a/android/avrcp-lib.c b/android/avrcp-lib.c
index 053e9e1..41c354c 100644
--- a/android/avrcp-lib.c
+++ b/android/avrcp-lib.c
@@ -340,5 +340,23 @@ int avrcp_get_current_player_value(struct avrcp *session, uint8_t *attributes,
 	return avrcp_send_req(session, AVC_CTYPE_STATUS, AVC_SUBUNIT_PANEL,
 				AVRCP_GET_CURRENT_PLAYER_VALUE, buf,
 				attr_count + 1, func, user_data);
+}
+
+int avrcp_set_player_value(struct avrcp *session, uint8_t *attributes,
+					uint8_t attr_count, uint8_t *values,
+					avctp_rsp_cb func, void *user_data)
+{
+	uint8_t buf[2 * attr_count + 1];
+	int i;
 
+	buf[0] = attr_count;
+
+	for (i = 0; i < attr_count; i++) {
+		buf[i * 2 + 1] = attributes[i];
+		buf[i * 2 + 2] = values[i];
+	}
+
+	return avrcp_send_req(session, AVC_CTYPE_CONTROL, AVC_SUBUNIT_PANEL,
+				AVRCP_SET_PLAYER_VALUE, buf, 2 * attr_count + 1,
+				func, user_data);
 }
diff --git a/android/avrcp-lib.h b/android/avrcp-lib.h
index 1f7eab0..c6d61e4 100644
--- a/android/avrcp-lib.h
+++ b/android/avrcp-lib.h
@@ -124,3 +124,6 @@ int avrcp_get_player_attribute_text(struct avrcp *session, uint8_t *attributes,
 int avrcp_get_current_player_value(struct avrcp *session, uint8_t *attributes,
 					uint8_t attr_count, avctp_rsp_cb func,
 					void *user_data);
+int avrcp_set_player_value(struct avrcp *session, uint8_t *attributes,
+					uint8_t attr_count, uint8_t *values,
+					avctp_rsp_cb func, void *user_data);
-- 
1.8.3.2

