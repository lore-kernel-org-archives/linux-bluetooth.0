Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 1/4] android/avrcp-lib: Add avrcp_send function
Date: Fri, 28 Feb 2014 15:42:30 +0200
Message-Id: <1393594953-4970-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds avrcp_send function which can be used to response to
outstanding requests.
---
 android/avrcp-lib.c | 27 +++++++++++++++++++++++++++
 android/avrcp-lib.h |  4 +++-
 2 files changed, 30 insertions(+), 1 deletion(-)

diff --git a/android/avrcp-lib.c b/android/avrcp-lib.c
index e71f95c..b1085f2 100644
--- a/android/avrcp-lib.c
+++ b/android/avrcp-lib.c
@@ -267,6 +267,33 @@ int avrcp_init_uinput(struct avrcp *session, const char *name,
 	return avctp_init_uinput(session->conn, name, address);
 }
 
+int avrcp_send(struct avrcp *session, uint8_t transaction, uint8_t code,
+					uint8_t subunit, uint8_t pdu_id,
+					uint8_t *params, size_t params_len)
+{
+	struct avrcp_header *pdu = (void *) session->tx_buf;
+	size_t len = sizeof(*pdu);
+
+	memset(pdu, 0, len);
+
+	hton24(pdu->company_id, IEEEID_BTSIG);
+	pdu->pdu_id = pdu_id;
+	pdu->packet_type = AVRCP_PACKET_TYPE_SINGLE;
+
+	if (params_len > 0) {
+		len += params_len;
+
+		if (len > session->tx_mtu)
+			return -ENOBUFS;
+
+		memcpy(pdu->params, params, params_len);
+		pdu->params_len = htons(params_len);
+	}
+
+	return avctp_send_vendordep(session->conn, transaction, code, subunit,
+							session->tx_buf, len);
+}
+
 static int avrcp_send_req(struct avrcp *session, uint8_t code, uint8_t subunit,
 					uint8_t pdu_id, uint8_t *params,
 					size_t params_len, avctp_rsp_cb func,
diff --git a/android/avrcp-lib.h b/android/avrcp-lib.h
index da8c990..86e07bc 100644
--- a/android/avrcp-lib.h
+++ b/android/avrcp-lib.h
@@ -105,7 +105,9 @@ void avrcp_set_passthrough_handlers(struct avrcp *session,
 			void *user_data);
 int avrcp_init_uinput(struct avrcp *session, const char *name,
 							const char *address);
-
+int avrcp_send(struct avrcp *session, uint8_t transaction, uint8_t code,
+					uint8_t subunit, uint8_t pdu_id,
+					uint8_t *params, size_t params_len);
 int avrcp_get_capabilities(struct avrcp *session, uint8_t param,
 					avctp_rsp_cb func, void *user_data);
 int avrcp_list_player_attributes(struct avrcp *session, avctp_rsp_cb func,
-- 
1.8.5.3

