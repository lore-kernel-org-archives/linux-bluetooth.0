Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/3] android/avrcp-lib: Add avrcp_set_control_handlers
Date: Thu, 20 Feb 2014 16:40:54 +0200
Message-Id: <1392907255-29758-2-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1392907255-29758-1-git-send-email-luiz.dentz@gmail.com>
References: <1392907255-29758-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds avrcp_set_control_handlers which can be used to set control
PDU handlers table and user data.
---
 android/avrcp-lib.c | 138 +++++++++++++++++++++++++++++++++++++++++++++++++++-
 android/avrcp-lib.h |  37 ++++++++++++++
 2 files changed, 173 insertions(+), 2 deletions(-)

diff --git a/android/avrcp-lib.c b/android/avrcp-lib.c
index 8450480..c508516 100644
--- a/android/avrcp-lib.c
+++ b/android/avrcp-lib.c
@@ -35,18 +35,139 @@
 #include "avctp.h"
 #include "avrcp-lib.h"
 
+/* Company IDs for vendor dependent commands */
+#define IEEEID_BTSIG		0x001958
+
+/* Status codes */
+#define AVRCP_STATUS_INVALID_COMMAND		0x00
+#define AVRCP_STATUS_INVALID_PARAM		0x01
+#define AVRCP_STATUS_PARAM_NOT_FOUND		0x02
+#define AVRCP_STATUS_INTERNAL_ERROR		0x03
+#define AVRCP_STATUS_SUCCESS			0x04
+#define AVRCP_STATUS_OUT_OF_BOUNDS		0x0b
+#define AVRCP_STATUS_INVALID_PLAYER_ID		0x11
+#define AVRCP_STATUS_PLAYER_NOT_BROWSABLE	0x12
+#define AVRCP_STATUS_NO_AVAILABLE_PLAYERS	0x15
+#define AVRCP_STATUS_ADDRESSED_PLAYER_CHANGED	0x16
+
+#if __BYTE_ORDER == __LITTLE_ENDIAN
+
+struct avrcp_header {
+	uint8_t company_id[3];
+	uint8_t pdu_id;
+	uint8_t packet_type:2;
+	uint8_t rsvd:6;
+	uint16_t params_len;
+	uint8_t params[0];
+} __attribute__ ((packed));
+#define AVRCP_HEADER_LENGTH 7
+
+static inline uint32_t ntoh24(const uint8_t src[3])
+{
+	return src[0] << 16 | src[1] << 8 | src[2];
+}
+
+#elif __BYTE_ORDER == __BIG_ENDIAN
+
+struct avrcp_header {
+	uint8_t company_id[3];
+	uint8_t pdu_id;
+	uint8_t rsvd:6;
+	uint8_t packet_type:2;
+	uint16_t params_len;
+	uint8_t params[0];
+} __attribute__ ((packed));
+#define AVRCP_HEADER_LENGTH 7
+
+static inline uint32_t ntoh24(const uint8_t src[3])
+{
+	uint32_t dst;
+
+	memcpy(&dst, src, sizeof(src));
+
+	return dst;
+}
+
+#else
+#error "Unknown byte order"
+#endif
+
 struct avrcp {
-	struct avctp	*conn;
+	struct avctp *conn;
+
+	const struct avrcp_control_handler *control_handlers;
+	void *control_data;
+	unsigned int control_id;
 };
 
 void avrcp_shutdown(struct avrcp *session)
 {
-	if (session->conn)
+	if (session->conn) {
+		if (session->control_id > 0)
+			avctp_unregister_pdu_handler(session->conn,
+							session->control_id);
 		avctp_shutdown(session->conn);
+	}
 
 	g_free(session);
 }
 
+static size_t handle_vendordep_pdu(struct avctp *conn, uint8_t transaction,
+					uint8_t *code, uint8_t *subunit,
+					uint8_t *operands, size_t operand_count,
+					void *user_data)
+{
+	struct avrcp *session = user_data;
+	const struct avrcp_control_handler *handler;
+	struct avrcp_header *pdu = (void *) operands;
+	uint32_t company_id = ntoh24(pdu->company_id);
+
+	if (company_id != IEEEID_BTSIG) {
+		*code = AVC_CTYPE_NOT_IMPLEMENTED;
+		return 0;
+	}
+
+	DBG("AVRCP PDU 0x%02X, len 0x%04X", pdu->pdu_id,
+						ntohs(pdu->params_len));
+
+	pdu->packet_type = 0;
+	pdu->rsvd = 0;
+
+	if (operand_count < AVRCP_HEADER_LENGTH) {
+		pdu->params[0] = AVRCP_STATUS_INVALID_COMMAND;
+		goto reject;
+	}
+
+	if (!session->control_handlers)
+		goto reject;
+
+	for (handler = session->control_handlers; handler->id; handler++) {
+		if (handler->id == pdu->pdu_id)
+			break;
+	}
+
+	if (handler->id != pdu->pdu_id || handler->code != *code) {
+		pdu->params[0] = AVRCP_STATUS_INVALID_COMMAND;
+		goto reject;
+	}
+
+	if (!handler->func) {
+		pdu->params[0] = AVRCP_STATUS_INVALID_PARAM;
+		goto reject;
+	}
+
+	*code = handler->func(session, transaction, &pdu->params_len,
+					pdu->params, session->control_data);
+
+	return AVRCP_HEADER_LENGTH + ntohs(pdu->params_len);
+
+reject:
+	pdu->params_len = htons(1);
+	*code = AVC_CTYPE_REJECTED;
+
+	return AVRCP_HEADER_LENGTH + 1;
+}
+
 struct avrcp *avrcp_new(int fd, size_t imtu, size_t omtu, uint16_t version)
 {
 	struct avrcp *session;
@@ -59,6 +180,11 @@ struct avrcp *avrcp_new(int fd, size_t imtu, size_t omtu, uint16_t version)
 		return NULL;
 	}
 
+	session->control_id = avctp_register_pdu_handler(session->conn,
+							AVC_OP_VENDORDEP,
+							handle_vendordep_pdu,
+							session);
+
 	return session;
 }
 
@@ -68,6 +194,14 @@ void avrcp_set_destroy_cb(struct avrcp *session, avrcp_destroy_cb_t cb,
 	avctp_set_destroy_cb(session->conn, cb, user_data);
 }
 
+void avrcp_set_control_handlers(struct avrcp *session,
+				const struct avrcp_control_handler *handlers,
+				void *user_data)
+{
+	session->control_handlers = handlers;
+	session->control_data = user_data;
+}
+
 int avrcp_init_uinput(struct avrcp *session, const char *name,
 							const char *address)
 {
diff --git a/android/avrcp-lib.h b/android/avrcp-lib.h
index 7955d56..1a135cc 100644
--- a/android/avrcp-lib.h
+++ b/android/avrcp-lib.h
@@ -21,11 +21,48 @@
  *
  */
 
+/* Control PDU ids */
+#define AVRCP_GET_CAPABILITIES		0x10
+#define AVRCP_LIST_PLAYER_ATTRIBUTES	0X11
+#define AVRCP_LIST_PLAYER_VALUES	0x12
+#define AVRCP_GET_CURRENT_PLAYER_VALUE	0x13
+#define AVRCP_SET_PLAYER_VALUE		0x14
+#define AVRCP_GET_PLAYER_ATTRIBUTE_TEXT	0x15
+#define AVRCP_GET_PLAYER_VALUE_TEXT	0x16
+#define AVRCP_DISPLAYABLE_CHARSET	0x17
+#define AVRCP_CT_BATTERY_STATUS		0x18
+#define AVRCP_GET_ELEMENT_ATTRIBUTES	0x20
+#define AVRCP_GET_PLAY_STATUS		0x30
+#define AVRCP_REGISTER_NOTIFICATION	0x31
+#define AVRCP_REQUEST_CONTINUING	0x40
+#define AVRCP_ABORT_CONTINUING		0x41
+#define AVRCP_SET_ABSOLUTE_VOLUME	0x50
+#define AVRCP_SET_BROWSED_PLAYER	0x70
+#define AVRCP_GET_FOLDER_ITEMS		0x71
+#define AVRCP_CHANGE_PATH		0x72
+#define AVRCP_GET_ITEM_ATTRIBUTES	0x73
+#define AVRCP_PLAY_ITEM			0x74
+#define AVRCP_SEARCH			0x80
+#define AVRCP_ADD_TO_NOW_PLAYING	0x90
+#define AVRCP_GENERAL_REJECT		0xA0
+
+struct avrcp;
+
+struct avrcp_control_handler {
+	uint8_t id;
+	uint8_t code;
+	uint8_t (*func) (struct avrcp *session, uint8_t transaction,
+			uint16_t *params_len, uint8_t *params, void *user_data);
+};
+
 typedef void (*avrcp_destroy_cb_t) (void *user_data);
 
 struct avrcp *avrcp_new(int fd, size_t imtu, size_t omtu, uint16_t version);
 void avrcp_shutdown(struct avrcp *session);
 void avrcp_set_destroy_cb(struct avrcp *session, avrcp_destroy_cb_t cb,
 							void *user_data);
+void avrcp_set_control_handlers(struct avrcp *session,
+				const struct avrcp_control_handler *handlers,
+				void *user_data);
 int avrcp_init_uinput(struct avrcp *session, const char *name,
 							const char *address);
-- 
1.8.5.3

