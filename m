Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv2 07/10] android/avrcp: Add avrcp_set_player_value() function
Date: Tue,  4 Mar 2014 16:02:12 +0200
Message-Id: <1393941735-12187-8-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1393941735-12187-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1393941735-12187-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

---
 android/avrcp-lib.c | 19 +++++++++++++++++++
 android/avrcp-lib.h |  3 +++
 2 files changed, 22 insertions(+)

diff --git a/android/avrcp-lib.c b/android/avrcp-lib.c
index 8f18b9c..865a3f9 100644
--- a/android/avrcp-lib.c
+++ b/android/avrcp-lib.c
@@ -404,3 +404,22 @@ int avrcp_get_current_player_value(struct avrcp *session, uint8_t *attributes,
 				AVRCP_GET_CURRENT_PLAYER_VALUE, buf,
 				attr_count + 1, func, user_data);
 }
+
+int avrcp_set_player_value(struct avrcp *session, uint8_t *attributes,
+					uint8_t attr_count, uint8_t *values,
+					avctp_rsp_cb func, void *user_data)
+{
+	uint8_t buf[2 * attr_count + 1];
+	int i;
+
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
+}
diff --git a/android/avrcp-lib.h b/android/avrcp-lib.h
index 5e396bb..554e064 100644
--- a/android/avrcp-lib.h
+++ b/android/avrcp-lib.h
@@ -149,3 +149,6 @@ int avrcp_register_notification_rsp(struct avrcp *session, uint8_t transaction,
 int avrcp_get_current_player_value(struct avrcp *session, uint8_t *attributes,
 					uint8_t attr_count, avctp_rsp_cb func,
 					void *user_data);
+int avrcp_set_player_value(struct avrcp *session, uint8_t *attributes,
+					uint8_t attr_count, uint8_t *values,
+					avctp_rsp_cb func, void *user_data);
-- 
1.8.3.2

