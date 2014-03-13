Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv2 6/7] android/avrcp: Add avrcp_get_folder_items() function
Date: Thu, 13 Mar 2014 14:31:20 +0200
Message-Id: <1394713881-21349-6-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1394713881-21349-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1394640297-27467-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1394713881-21349-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

---
 android/avrcp-lib.c | 28 ++++++++++++++++++++++++++++
 android/avrcp-lib.h | 10 ++++++++++
 2 files changed, 38 insertions(+)

diff --git a/android/avrcp-lib.c b/android/avrcp-lib.c
index fe6d7b4..969c519 100644
--- a/android/avrcp-lib.c
+++ b/android/avrcp-lib.c
@@ -521,3 +521,31 @@ int avrcp_set_browsed_player(struct avrcp *session, uint16_t player_id,
 	return avctp_send_browsing_req(session->conn, buf, sizeof(buf),
 							func, user_data);
 }
+
+int avrcp_get_folder_items(struct avrcp *session, uint8_t scope,
+				uint32_t start, uint32_t end, uint8_t *attr,
+				size_t attr_count, avctp_browsing_rsp_cb func,
+				void *user_data)
+{
+	uint8_t buf[AVRCP_BROWSING_HEADER_LENGTH + 10 + attr_count];
+	struct avrcp_browsing_header *pdu = (void *) buf;
+
+	memset(buf, 0, sizeof(buf));
+
+	pdu->pdu_id = AVRCP_GET_FOLDER_ITEMS;
+	pdu->param_len = htons(10 + attr_count);
+
+	/* Scope */
+	pdu->params[0] = scope;
+
+	bt_put_be32(start, &pdu->params[1]);
+	bt_put_be32(end, &pdu->params[5]);
+
+	/* attr count */
+	pdu->params[9] = attr_count;
+
+	memcpy(&pdu->params[10], attr, attr_count);
+
+	return avctp_send_browsing_req(session->conn, buf, sizeof(buf),
+							func, user_data);
+}
diff --git a/android/avrcp-lib.h b/android/avrcp-lib.h
index 88d2126..803f877 100644
--- a/android/avrcp-lib.h
+++ b/android/avrcp-lib.h
@@ -84,6 +84,12 @@
 #define AVRCP_ATTRIBUTE_SCAN			0x04
 #define AVRCP_ATTRIBUTE_LAST			AVRCP_ATTRIBUTE_SCAN
 
+/* Media Scope */
+#define AVRCP_MEDIA_PLAYER_LIST			0x00
+#define AVRCP_MEDIA_PLAYER_VFS			0x01
+#define AVRCP_MEDIA_SEARCH			0x02
+#define AVRCP_MEDIA_NOW_PLAYING			0x03
+
 /* Company IDs for vendor dependent commands */
 #define IEEEID_BTSIG		0x001958
 
@@ -179,3 +185,7 @@ int avrcp_register_notification_rsp(struct avrcp *session, uint8_t transaction,
 int avrcp_send_passthrough(struct avrcp *session, uint32_t vendor, uint8_t op);
 int avrcp_set_browsed_player(struct avrcp *session, uint16_t player_id,
 				avctp_browsing_rsp_cb func, void *user_data);
+int avrcp_get_folder_items(struct avrcp *session, uint8_t scope,
+				uint32_t start, uint32_t end, uint8_t *attr,
+				size_t attr_count, avctp_browsing_rsp_cb func,
+				void *user_data);
-- 
1.8.3.2

