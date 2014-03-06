Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 6/7] android/avrcp: Add avrcp_register_notification() function
Date: Thu,  6 Mar 2014 16:43:04 +0200
Message-Id: <1394116985-28247-6-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1394116985-28247-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1394116985-28247-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

---
 android/avrcp-lib.c | 14 ++++++++++++++
 android/avrcp-lib.h |  6 ++++++
 2 files changed, 20 insertions(+)

diff --git a/android/avrcp-lib.c b/android/avrcp-lib.c
index fbaa48d..1663218 100644
--- a/android/avrcp-lib.c
+++ b/android/avrcp-lib.c
@@ -416,6 +416,20 @@ int avrcp_get_element_attributes(struct avrcp *session, avctp_rsp_cb func,
 				func, user_data);
 }
 
+int avrcp_register_notification(struct avrcp *session, uint8_t event,
+				uint32_t interval, avctp_rsp_cb func,
+				void *user_data)
+{
+	uint8_t pdu[AVRCP_REGISTER_NOTIFICATION_PARAM_LENGTH];
+
+	pdu[0] = event;
+	bt_put_be32(interval, &pdu[1]);
+
+	return avrcp_send_req(session, AVC_CTYPE_NOTIFY, AVC_SUBUNIT_PANEL,
+				AVRCP_REGISTER_NOTIFICATION, pdu, sizeof(pdu),
+				func, user_data);
+}
+
 int avrcp_get_play_status_rsp(struct avrcp *session, uint8_t transaction,
 				uint32_t position, uint32_t duration,
 				uint8_t status)
diff --git a/android/avrcp-lib.h b/android/avrcp-lib.h
index 5e90ea1..b0a1025 100644
--- a/android/avrcp-lib.h
+++ b/android/avrcp-lib.h
@@ -86,6 +86,9 @@
 /* Company IDs for vendor dependent commands */
 #define IEEEID_BTSIG		0x001958
 
+/* Parameters legths */
+#define AVRCP_REGISTER_NOTIFICATION_PARAM_LENGTH	5
+
 struct avrcp;
 
 struct avrcp_control_handler {
@@ -147,6 +150,9 @@ int avrcp_get_play_status(struct avrcp *session, avctp_rsp_cb func,
 							void *user_data);
 int avrcp_get_element_attributes(struct avrcp *session, avctp_rsp_cb func,
 							void *user_data);
+int avrcp_register_notification(struct avrcp *session, uint8_t event,
+				uint32_t interval, avctp_rsp_cb func,
+				void *user_data);
 
 int avrcp_get_play_status_rsp(struct avrcp *session, uint8_t transaction,
 				uint32_t position, uint32_t duration,
-- 
1.8.3.2

