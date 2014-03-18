Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv3 02/16] android/avrcp: Add avrcp_set_browsed_player() function
Date: Tue, 18 Mar 2014 11:20:33 +0200
Message-Id: <1395134447-8957-3-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1395134447-8957-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1395134447-8957-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

---
 android/avrcp-lib.c | 18 ++++++++++++++++++
 android/avrcp-lib.h |  9 +++++++++
 2 files changed, 27 insertions(+)

diff --git a/android/avrcp-lib.c b/android/avrcp-lib.c
index 13acae9..75af49b 100644
--- a/android/avrcp-lib.c
+++ b/android/avrcp-lib.c
@@ -1028,3 +1028,21 @@ int avrcp_send_passthrough(struct avrcp *session, uint32_t vendor, uint8_t op)
 	return avctp_send_passthrough(session->conn, AVC_VENDOR_UNIQUE, params,
 								sizeof(params));
 }
+
+int avrcp_set_browsed_player(struct avrcp *session, uint16_t player_id,
+				avctp_browsing_rsp_cb func, void *user_data)
+{
+	uint8_t buf[AVRCP_BROWSING_HEADER_LENGTH + 2];
+	struct avrcp_browsing_header *pdu = (void *) buf;
+
+	DBG("");
+
+	memset(buf, 0, sizeof(buf));
+
+	pdu->pdu_id = AVRCP_SET_BROWSED_PLAYER;
+	bt_put_be16(player_id, pdu->params);
+	pdu->param_len = htons(2);
+
+	return avctp_send_browsing_req(session->conn, buf, sizeof(buf),
+							func, user_data);
+}
diff --git a/android/avrcp-lib.h b/android/avrcp-lib.h
index 8d9782b..3f557fc 100644
--- a/android/avrcp-lib.h
+++ b/android/avrcp-lib.h
@@ -121,6 +121,13 @@
 /* Parameters legths */
 #define AVRCP_REGISTER_NOTIFICATION_PARAM_LENGTH       5
 
+struct avrcp_browsing_header {
+	uint8_t pdu_id;
+	uint16_t param_len;
+	uint8_t params[0];
+} __attribute__ ((packed));
+#define AVRCP_BROWSING_HEADER_LENGTH 3
+
 struct avrcp;
 
 struct avrcp_control_handler {
@@ -243,3 +250,5 @@ int avrcp_register_notification_rsp(struct avrcp *session, uint8_t transaction,
 int avrcp_set_addressed_player_rsp(struct avrcp *session, uint8_t transaction,
 							uint8_t status);
 int avrcp_send_passthrough(struct avrcp *session, uint32_t vendor, uint8_t op);
+int avrcp_set_browsed_player(struct avrcp *session, uint16_t player_id,
+				avctp_browsing_rsp_cb func, void *user_data);
-- 
1.8.3.2

