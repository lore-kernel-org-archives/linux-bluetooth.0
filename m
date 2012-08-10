Return-Path: <cyrus@holtmann.org>
From: Vani-dineshbhai PATEL <vani.patel@stericsson.com>
To: User Name <linux-bluetooth@vger.kernel.org>,
	Luiz Augusto <luiz.dentz@gmail.com>
Cc: Vani <vani.patel@stericsson.com>,
	Joohi <Joohi.rastogi@stericsson.com>, Vani <vani273@gmail.com>
Subject: [PATCH BlueZ V5 5/5] AVRCP: Register/Unregister Browsing handler
Date: Fri, 10 Aug 2012 15:06:14 +0530
Message-ID: <1344591375-26459-1-git-send-email-vani.patel@stericsson.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Vani Patel <vani.patel@stericsson.com>

Add functions to register and unregister Browsing
handler
---
 audio/avctp.c |   51 +++++++++++++++++++++++++++++++++++++-
 audio/avctp.h |    8 ++++++
 audio/avrcp.c |   74 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 131 insertions(+), 2 deletions(-)

diff --git a/audio/avctp.c b/audio/avctp.c
index a159498..9b2bec6 100644
--- a/audio/avctp.c
+++ b/audio/avctp.c
@@ -157,6 +157,11 @@ struct avctp_pdu_handler {
 	unsigned int id;
 };
 
+struct avctp_browsing_pdu_handler {
+	avctp_browsing_pdu_cb cb;
+	void *user_data;
+};
+
 static struct {
 	const char *name;
 	uint8_t avc;
@@ -176,6 +181,7 @@ static GSList *callbacks = NULL;
 static GSList *servers = NULL;
 static GSList *control_handlers = NULL;
 static uint8_t id = 0;
+static struct avctp_browsing_pdu_handler *browsing_handler = NULL;
 
 static void auth_cb(DBusError *derr, void *user_data);
 
@@ -452,9 +458,9 @@ static gboolean session_browsing_cb(GIOChannel *chan, GIOCondition cond,
 				gpointer data)
 {
 	struct avctp *session = data;
-	uint8_t  *buf;
+	uint8_t *operands, *buf;
 	struct avctp_header *avctp;
-	int ret, sock;
+	int ret, packet_size, operand_count, sock;
 
 	buf = gnew(uint8_t, session->browsing_mtu);
 
@@ -467,6 +473,8 @@ static gboolean session_browsing_cb(GIOChannel *chan, GIOCondition cond,
 	if (ret <= 0)
 		goto failed;
 
+	DBG("Got %d bytes of data for AVCTP Browsing session %p", ret, session);
+
 	if ((unsigned int) ret < sizeof(struct avctp_header)) {
 		error("Too small AVRCP packet on browsing channel");
 		goto failed;
@@ -474,9 +482,30 @@ static gboolean session_browsing_cb(GIOChannel *chan, GIOCondition cond,
 
 	avctp = (struct avctp_header *) buf;
 
+	DBG("AVCTP transaction %u, packet type %u, C/R %u, IPID %u, "
+			"PID 0x%04X",
+			avctp->transaction, avctp->packet_type,
+			avctp->cr, avctp->ipid, ntohs(avctp->pid));
+
 	if (avctp->packet_type != AVCTP_PACKET_SINGLE)
 		goto failed;
 
+	operands = buf + AVCTP_HEADER_LENGTH;
+	ret -= AVCTP_HEADER_LENGTH;
+	operand_count = ret;
+
+	packet_size = AVCTP_HEADER_LENGTH;
+	avctp->cr = AVCTP_RESPONSE;
+	if (browsing_handler)
+		packet_size += browsing_handler->cb(session, avctp->transaction,
+			operands, operand_count, browsing_handler->user_data);
+
+	if (packet_size != 0) {
+		ret = write(sock, buf, packet_size);
+		if (ret != packet_size)
+			goto failed;
+	}
+
 	gfree(buf);
 	return TRUE;
 
@@ -1252,6 +1281,18 @@ unsigned int avctp_register_pdu_handler(uint8_t opcode, avctp_control_pdu_cb cb,
 	return handler->id;
 }
 
+unsigned int avctp_register_browsing_pdu_handler(avctp_browsing_pdu_cb cb,
+							void *user_data)
+{
+	unsigned int id = 0;
+
+	browsing_handler = g_new(struct avctp_browsing_pdu_handler, 1);
+	browsing_handler->cb = cb;
+	browsing_handler->user_data = user_data;
+
+	return ++id;
+}
+
 gboolean avctp_unregister_pdu_handler(unsigned int id)
 {
 	GSList *l;
@@ -1270,6 +1311,12 @@ gboolean avctp_unregister_pdu_handler(unsigned int id)
 	return FALSE;
 }
 
+gboolean avctp_unregister_browsing_pdu_handler()
+{
+	g_free(browsing_handler);
+	return TRUE;
+}
+
 struct avctp *avctp_connect(const bdaddr_t *src, const bdaddr_t *dst)
 {
 	struct avctp *session;
diff --git a/audio/avctp.h b/audio/avctp.h
index b80e300..3e1dabe 100644
--- a/audio/avctp.h
+++ b/audio/avctp.h
@@ -83,6 +83,10 @@ typedef size_t (*avctp_control_pdu_cb) (struct avctp *session,
 typedef gboolean (*avctp_rsp_cb) (struct avctp *session, uint8_t code,
 					uint8_t subunit, uint8_t *operands,
 					size_t operand_count, void *user_data);
+typedef size_t (*avctp_browsing_pdu_cb) (struct avctp *session,
+					uint8_t transaction,
+					uint8_t *operands, size_t operand_count,
+					void *user_data);
 
 unsigned int avctp_add_state_cb(avctp_state_cb cb, void *user_data);
 gboolean avctp_remove_state_cb(unsigned int id);
@@ -98,6 +102,10 @@ unsigned int avctp_register_pdu_handler(uint8_t opcode, avctp_control_pdu_cb cb,
 							void *user_data);
 gboolean avctp_unregister_pdu_handler(unsigned int id);
 
+unsigned int avctp_register_browsing_pdu_handler(avctp_browsing_pdu_cb cb,
+							void *user_data);
+
+gboolean avctp_unregister_browsing_pdu_handler();
 int avctp_send_passthrough(struct avctp *session, uint8_t op);
 int avctp_send_vendordep(struct avctp *session, uint8_t transaction,
 				uint8_t code, uint8_t subunit,
diff --git a/audio/avrcp.c b/audio/avrcp.c
index 9d29073..fa06f85 100644
--- a/audio/avrcp.c
+++ b/audio/avrcp.c
@@ -94,6 +94,10 @@
 #define AVRCP_ABORT_CONTINUING		0x41
 #define AVRCP_SET_ABSOLUTE_VOLUME	0x50
 
+#define AVRCP_INVALID_BROWSING_PDU	0x00
+
+#define AVRCP_GENERAL_REJECT			0xA0
+
 /* Capabilities for AVRCP_GET_CAPABILITIES pdu */
 #define CAP_COMPANY_ID		0x02
 #define CAP_EVENTS_SUPPORTED	0x03
@@ -140,6 +144,12 @@ struct avrcp_header {
 #error "Unknown byte order"
 #endif
 
+struct avrcp_browsing_header {
+	uint8_t browsing_pdu;
+	uint16_t param_len;
+} __attribute__ ((packed));
+#define AVRCP_BROWSING_HEADER_LENGTH 3
+
 #define AVRCP_MTU	(AVC_MTU - AVC_HEADER_LENGTH)
 #define AVRCP_PDU_MTU	(AVRCP_MTU - AVRCP_HEADER_LENGTH)
 
@@ -163,7 +173,9 @@ struct avrcp_player {
 	struct audio_device *dev;
 
 	unsigned int control_handler;
+	unsigned int browsing_handler;
 	uint16_t registered_events;
+	uint8_t transaction;
 	uint8_t transaction_events[AVRCP_EVENT_LAST + 1];
 	struct pending_pdu *pending_pdu;
 
@@ -1075,6 +1087,15 @@ static struct control_pdu_handler {
 		{ },
 };
 
+static struct pdu_browsing_handler {
+	uint8_t browsing_pdu;
+	void (*func) (struct avrcp_player *player,
+					struct avrcp_browsing_header *pdu);
+	} browsing_handlers[] = {
+		{ AVRCP_INVALID_BROWSING_PDU,
+					NULL },
+};
+
 /* handle vendordep pdu inside an avctp packet */
 static size_t handle_vendordep_pdu(struct avctp *session, uint8_t transaction,
 					uint8_t *code, uint8_t *subunit,
@@ -1134,6 +1155,49 @@ err_metadata:
 	return AVRCP_HEADER_LENGTH + 1;
 }
 
+static size_t handle_browsing_pdu(struct avctp *session,
+					uint8_t transaction, uint8_t *operands,
+					size_t operand_count, void *user_data)
+{
+	struct avrcp_player *player = user_data;
+	struct pdu_browsing_handler *b_handler;
+	struct avrcp_browsing_header *avrcp_browsing = (void *) operands;
+	uint8_t status;
+
+	operand_count += AVRCP_BROWSING_HEADER_LENGTH;
+
+	for (b_handler = browsing_handlers; b_handler; b_handler++) {
+		if (b_handler->browsing_pdu == AVRCP_INVALID_BROWSING_PDU) {
+			b_handler = NULL;
+			break;
+		}
+		if (b_handler->browsing_pdu == avrcp_browsing->browsing_pdu)
+			break;
+	}
+
+	if (!b_handler) {
+		avrcp_browsing->browsing_pdu = AVRCP_GENERAL_REJECT;
+		status = E_INVALID_COMMAND;
+		goto err;
+	}
+
+	if (!b_handler->func) {
+		status = E_INVALID_PARAM;
+		avrcp_browsing->param_len = htons(sizeof(status));
+		goto err;
+	}
+	player->transaction = transaction;
+	b_handler->func(player, avrcp_browsing);
+	return AVRCP_BROWSING_HEADER_LENGTH + ntohs(avrcp_browsing->param_len);
+
+err:
+	avrcp_browsing->param_len = htons(sizeof(status));
+	memcpy(&operands[AVRCP_BROWSING_HEADER_LENGTH], &status,
+							(sizeof(status)));
+	return AVRCP_BROWSING_HEADER_LENGTH + sizeof(status);
+}
+
+
 size_t avrcp_handle_vendor_reject(uint8_t *code, uint8_t *operands)
 {
 	struct avrcp_header *pdu = (void *) operands;
@@ -1233,6 +1297,10 @@ static void state_changed(struct audio_device *dev, avctp_state_t old_state,
 			avctp_unregister_pdu_handler(player->control_handler);
 			player->control_handler = 0;
 		}
+		if (player->browsing_handler) {
+			avctp_unregister_browsing_pdu_handler();
+			player->browsing_handler = 0;
+		}
 
 		break;
 	case AVCTP_STATE_CONNECTING:
@@ -1244,6 +1312,12 @@ static void state_changed(struct audio_device *dev, avctp_state_t old_state,
 							AVC_OP_VENDORDEP,
 							handle_vendordep_pdu,
 							player);
+		if (!player->browsing_handler)
+			player->browsing_handler =
+					avctp_register_browsing_pdu_handler(
+							handle_browsing_pdu,
+							player);
+
 		break;
 	case AVCTP_STATE_CONNECTED:
 		rec = btd_device_get_record(dev->btd_dev, AVRCP_TARGET_UUID);
-- 
1.7.5.4

