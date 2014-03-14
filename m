Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv2 13/16] android/avrcp: Add avrcp_get_item_attributes() function
Date: Fri, 14 Mar 2014 17:17:55 +0200
Message-Id: <1394810278-11013-14-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1394810278-11013-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1394810278-11013-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

---
 android/avrcp-lib.c | 28 ++++++++++++++++++++++++++++
 android/avrcp-lib.h |  4 ++++
 2 files changed, 32 insertions(+)

diff --git a/android/avrcp-lib.c b/android/avrcp-lib.c
index cf4aeab..b3f3975 100644
--- a/android/avrcp-lib.c
+++ b/android/avrcp-lib.c
@@ -570,3 +570,31 @@ int avrcp_change_path(struct avrcp *session, uint8_t direction, uint64_t uid,
 	return avctp_send_browsing_req(session->conn, buf, sizeof(buf),
 							func, user_data);
 }
+
+int avrcp_get_item_attributes(struct avrcp *session, uint8_t scope,
+				uint64_t uid, uint16_t counter, uint32_t *attr,
+				size_t attr_count, avctp_browsing_rsp_cb func,
+				void *user_data)
+{
+	uint8_t buf[AVRCP_BROWSING_HEADER_LENGTH + 12 +
+						attr_count * sizeof(uint32_t)];
+	struct avrcp_browsing_header *pdu = (void *) buf;
+
+	memset(buf, 0, sizeof(buf));
+
+	pdu->pdu_id = AVRCP_GET_ITEM_ATTRIBUTES;
+	pdu->param_len = htons(12 + attr_count * sizeof(uint32_t));
+
+	/* Scope */
+	pdu->params[0] = scope;
+
+	bt_put_be64(uid, &pdu->params[1]);
+	bt_put_be16(counter, &pdu->params[9]);
+
+	pdu->params[11] = attr_count;
+
+	memcpy(&pdu->params[12], attr, attr_count * sizeof(uint32_t));
+
+	return avctp_send_browsing_req(session->conn, buf, sizeof(buf),
+							func, user_data);
+}
diff --git a/android/avrcp-lib.h b/android/avrcp-lib.h
index 575cd2d..8188dad 100644
--- a/android/avrcp-lib.h
+++ b/android/avrcp-lib.h
@@ -192,3 +192,7 @@ int avrcp_get_folder_items(struct avrcp *session, uint8_t scope,
 int avrcp_change_path(struct avrcp *session, uint8_t direction, uint64_t uid,
 				uint16_t counter, avctp_browsing_rsp_cb func,
 				void *user_data);
+int avrcp_get_item_attributes(struct avrcp *session, uint8_t scope,
+				uint64_t uid, uint16_t counter, uint32_t *attr,
+				size_t attr_count, avctp_browsing_rsp_cb func,
+				void *user_data);
-- 
1.8.3.2

