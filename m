Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv2 02/10] android/avrcp: Add avrcp_get_element_attributes() function
Date: Mon, 10 Mar 2014 11:09:45 +0200
Message-Id: <1394442593-4233-2-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1394442593-4233-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1394442593-4233-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

---
 android/avrcp-lib.c | 13 +++++++++++++
 android/avrcp-lib.h |  2 ++
 2 files changed, 15 insertions(+)

diff --git a/android/avrcp-lib.c b/android/avrcp-lib.c
index b67fa32..5400f80 100644
--- a/android/avrcp-lib.c
+++ b/android/avrcp-lib.c
@@ -427,6 +427,19 @@ int avrcp_set_volume(struct avrcp *session, uint8_t volume, avctp_rsp_cb func,
 						func, user_data);
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
index 30d220e..4c845d3 100644
--- a/android/avrcp-lib.h
+++ b/android/avrcp-lib.h
@@ -150,6 +150,8 @@ int avrcp_get_play_status(struct avrcp *session, avctp_rsp_cb func,
 							void *user_data);
 int avrcp_set_volume(struct avrcp *session, uint8_t volume, avctp_rsp_cb func,
 							void *user_data);
+int avrcp_get_element_attributes(struct avrcp *session, avctp_rsp_cb func,
+							void *user_data);
 
 int avrcp_get_play_status_rsp(struct avrcp *session, uint8_t transaction,
 				uint32_t position, uint32_t duration,
-- 
1.8.3.2

