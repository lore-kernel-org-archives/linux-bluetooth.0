Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv3 15/16] android/avrcp: Add avrcp_search() function
Date: Tue, 18 Mar 2014 11:20:46 +0200
Message-Id: <1395134447-8957-16-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1395134447-8957-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1395134447-8957-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

---
 android/avrcp-lib.c | 23 +++++++++++++++++++++--
 android/avrcp-lib.h |  4 ++++
 2 files changed, 25 insertions(+), 2 deletions(-)

diff --git a/android/avrcp-lib.c b/android/avrcp-lib.c
index 7304b11..5bbc407 100644
--- a/android/avrcp-lib.c
+++ b/android/avrcp-lib.c
@@ -28,6 +28,7 @@
 #include <stdbool.h>
 #include <glib.h>
 #include <errno.h>
+#include <string.h>
 
 #include "lib/bluetooth.h"
 
@@ -43,8 +44,6 @@
 #define AVRCP_PACKET_TYPE_CONTINUING		0x02
 #define AVRCP_PACKET_TYPE_END			0x03
 
-#define AVRCP_CHARSET_UTF8			106
-
 #if __BYTE_ORDER == __LITTLE_ENDIAN
 
 struct avrcp_header {
@@ -1123,3 +1122,23 @@ int avrcp_get_item_attributes(struct avrcp *session, uint8_t scope,
 	return avctp_send_browsing_req(session->conn, buf, sizeof(buf),
 							func, user_data);
 }
+
+int avrcp_search(struct avrcp *session, uint16_t charset, const char *string,
+				avctp_browsing_rsp_cb func, void *user_data)
+{
+	size_t str_len = strnlen(string, 255 - 4);
+	uint8_t buf[AVRCP_BROWSING_HEADER_LENGTH + str_len + 4];
+	struct avrcp_browsing_header *pdu = (void *) buf;
+
+	memset(buf, 0, sizeof(buf));
+
+	pdu->pdu_id = AVRCP_SEARCH;
+	pdu->param_len = htons(str_len + 4);
+
+	bt_put_be16(charset, &pdu->params[0]);
+	bt_put_be16(str_len, &pdu->params[2]);
+	memcpy(&pdu->params[4], string, str_len);
+
+	return avctp_send_browsing_req(session->conn, buf, sizeof(buf),
+							func, user_data);
+}
diff --git a/android/avrcp-lib.h b/android/avrcp-lib.h
index 653a98e..3a452d5 100644
--- a/android/avrcp-lib.h
+++ b/android/avrcp-lib.h
@@ -124,6 +124,8 @@
 /* Company IDs for vendor dependent commands */
 #define IEEEID_BTSIG		0x001958
 
+#define AVRCP_CHARSET_UTF8	0x006a
+
 /* Parameters legths */
 #define AVRCP_REGISTER_NOTIFICATION_PARAM_LENGTH       5
 
@@ -269,3 +271,5 @@ int avrcp_get_item_attributes(struct avrcp *session, uint8_t scope,
 				uint64_t uid, uint16_t counter, uint32_t *attr,
 				size_t attr_count, avctp_browsing_rsp_cb func,
 				void *user_data);
+int avrcp_search(struct avrcp *session, uint16_t charset, const char *string,
+				avctp_browsing_rsp_cb func, void *user_data);
-- 
1.8.3.2

