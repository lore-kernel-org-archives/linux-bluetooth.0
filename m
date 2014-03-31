Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv4 06/20] android/avrcp: Add avrcp_get_folder_items() function
Date: Mon, 31 Mar 2014 15:25:00 +0300
Message-Id: <1396268714-4056-6-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1396268714-4056-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1396268714-4056-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

---
 android/avrcp-lib.c | 29 +++++++++++++++++++++++++++++
 android/avrcp-lib.h | 10 ++++++++++
 2 files changed, 39 insertions(+)

diff --git a/android/avrcp-lib.c b/android/avrcp-lib.c
index 48c5221..c7d44b5 100644
--- a/android/avrcp-lib.c
+++ b/android/avrcp-lib.c
@@ -1700,3 +1700,32 @@ int avrcp_set_browsed_player(struct avrcp *session, uint16_t player_id,
 	return avctp_send_browsing_req(session->conn, buf, sizeof(buf),
 							func, user_data);
 }
+
+int avrcp_get_folder_items(struct avrcp *session, uint8_t scope,
+				uint32_t start, uint32_t end, uint32_t *attr,
+				size_t attr_count, avctp_browsing_rsp_cb func,
+				void *user_data)
+{
+	uint8_t buf[AVRCP_BROWSING_HEADER_LENGTH + 10 +
+						attr_count * sizeof(uint32_t)];
+	struct avrcp_browsing_header *pdu = (void *) buf;
+
+	memset(buf, 0, sizeof(buf));
+
+	pdu->pdu_id = AVRCP_GET_FOLDER_ITEMS;
+	pdu->param_len = htons(10 + attr_count * sizeof(uint32_t));
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
index ed26220..1254f6c 100644
--- a/android/avrcp-lib.h
+++ b/android/avrcp-lib.h
@@ -115,6 +115,12 @@
 #define AVRCP_MEDIA_ATTRIBUTE_DURATION	0x07
 #define AVRCP_MEDIA_ATTRIBUTE_LAST	AVRCP_MEDIA_ATTRIBUTE_DURATION
 
+/* Media Scope */
+#define AVRCP_MEDIA_PLAYER_LIST			0x00
+#define AVRCP_MEDIA_PLAYER_VFS			0x01
+#define AVRCP_MEDIA_SEARCH			0x02
+#define AVRCP_MEDIA_NOW_PLAYING			0x03
+
 /* Company IDs for vendor dependent commands */
 #define IEEEID_BTSIG		0x001958
 
@@ -277,3 +283,7 @@ int avrcp_set_addressed_player_rsp(struct avrcp *session, uint8_t transaction,
 int avrcp_send_passthrough(struct avrcp *session, uint32_t vendor, uint8_t op);
 int avrcp_set_browsed_player(struct avrcp *session, uint16_t player_id,
 				avctp_browsing_rsp_cb func, void *user_data);
+int avrcp_get_folder_items(struct avrcp *session, uint8_t scope,
+				uint32_t start, uint32_t end, uint32_t *attr,
+				size_t attr_count, avctp_browsing_rsp_cb func,
+				void *user_data);
-- 
1.8.3.2

