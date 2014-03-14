Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv2 11/16] android/avrcp: Add avrcp_change_path() function
Date: Fri, 14 Mar 2014 17:17:53 +0200
Message-Id: <1394810278-11013-12-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1394810278-11013-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1394810278-11013-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

---
 android/avrcp-lib.c | 20 ++++++++++++++++++++
 android/avrcp-lib.h |  3 +++
 2 files changed, 23 insertions(+)

diff --git a/android/avrcp-lib.c b/android/avrcp-lib.c
index e9220b7..cf4aeab 100644
--- a/android/avrcp-lib.c
+++ b/android/avrcp-lib.c
@@ -550,3 +550,23 @@ int avrcp_get_folder_items(struct avrcp *session, uint8_t scope,
 	return avctp_send_browsing_req(session->conn, buf, sizeof(buf),
 							func, user_data);
 }
+
+int avrcp_change_path(struct avrcp *session, uint8_t direction, uint64_t uid,
+				uint16_t counter, avctp_browsing_rsp_cb func,
+				void *user_data)
+{
+	uint8_t buf[AVRCP_BROWSING_HEADER_LENGTH + 11];
+	struct avrcp_browsing_header *pdu = (void *) buf;
+
+	memset(buf, 0, sizeof(buf));
+
+	pdu->pdu_id = AVRCP_CHANGE_PATH;
+	pdu->param_len = htons(11);
+
+	bt_put_be16(counter, &pdu->params[0]);
+	pdu->params[2] = direction;
+	bt_put_be64(uid, &pdu->params[3]);
+
+	return avctp_send_browsing_req(session->conn, buf, sizeof(buf),
+							func, user_data);
+}
diff --git a/android/avrcp-lib.h b/android/avrcp-lib.h
index 72fd89a..575cd2d 100644
--- a/android/avrcp-lib.h
+++ b/android/avrcp-lib.h
@@ -189,3 +189,6 @@ int avrcp_get_folder_items(struct avrcp *session, uint8_t scope,
 				uint32_t start, uint32_t end, uint32_t *attr,
 				size_t attr_count, avctp_browsing_rsp_cb func,
 				void *user_data);
+int avrcp_change_path(struct avrcp *session, uint8_t direction, uint64_t uid,
+				uint16_t counter, avctp_browsing_rsp_cb func,
+				void *user_data);
-- 
1.8.3.2

