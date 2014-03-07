Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/9] android/avrcp: Add avrcp_get_element_attributes() function
Date: Fri,  7 Mar 2014 13:51:46 +0200
Message-Id: <1394193113-32347-2-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1394193113-32347-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1394193113-32347-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

---
 android/avrcp-lib.c | 13 +++++++++++++
 android/avrcp-lib.h |  2 ++
 2 files changed, 15 insertions(+)

diff --git a/android/avrcp-lib.c b/android/avrcp-lib.c
index cd39071..fbaa48d 100644
--- a/android/avrcp-lib.c
+++ b/android/avrcp-lib.c
@@ -403,6 +403,19 @@ int avrcp_get_play_status(struct avrcp *session, avctp_rsp_cb func,
 				user_data);
 }
 
+int avrcp_get_element_attributes(struct avrcp *session, avctp_rsp_cb func,
+								void *user_data)
+{
+	uint8_t buf[9];
+
+	/* This returns all attributes */
+	memset(buf, 0, sizeof(buf));
+
+	return avrcp_send_req(session, AVC_CTYPE_STATUS, AVC_SUBUNIT_PANEL,
+				AVRCP_GET_ELEMENT_ATTRIBUTES, buf, sizeof(buf),
+				func, user_data);
+}
+
 int avrcp_get_play_status_rsp(struct avrcp *session, uint8_t transaction,
 				uint32_t position, uint32_t duration,
 				uint8_t status)
diff --git a/android/avrcp-lib.h b/android/avrcp-lib.h
index ba1d84a..5e90ea1 100644
--- a/android/avrcp-lib.h
+++ b/android/avrcp-lib.h
@@ -145,6 +145,8 @@ int avrcp_get_current_player_value(struct avrcp *session, uint8_t *attrs,
 					void *user_data);
 int avrcp_get_play_status(struct avrcp *session, avctp_rsp_cb func,
 							void *user_data);
+int avrcp_get_element_attributes(struct avrcp *session, avctp_rsp_cb func,
+							void *user_data);
 
 int avrcp_get_play_status_rsp(struct avrcp *session, uint8_t transaction,
 				uint32_t position, uint32_t duration,
-- 
1.8.3.2

