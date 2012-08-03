Return-Path: <cyrus@holtmann.org>
From: Vani-dineshbhai PATEL <vani.patel@stericsson.com>
To: User Name <linux-bluetooth@vger.kernel.org>,
	Luiz Augusto <luiz.dentz@gmail.com>,
	Lucas De Marchi <lucas.demarchi@profusion.mobi>
Cc: Vani <vani.patel@stericsson.com>,
	Joohi <Joohi.rastogi@stericsson.com>, Vani <vani273@gmail.com>
Subject: [PATCH BlueZ V2 5/5] AVRCP: Add handler for browsing pdu
Date: Fri, 3 Aug 2012 12:15:57 +0530
Message-ID: <1343976357-13566-1-git-send-email-vani.patel@stericsson.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Vani Patel <vani.patel@stericsson.com>

Implement generic handling of browsing
PDU IDs
---
 audio/avctp.c |   25 +++++++++++++++++-
 audio/avctp.h |    2 +-
 audio/avrcp.c |   78 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 3 files changed, 101 insertions(+), 4 deletions(-)

diff --git a/audio/avctp.c b/audio/avctp.c
index cbe80f5..a9622a3 100644
--- a/audio/avctp.c
+++ b/audio/avctp.c
@@ -459,9 +459,9 @@ static gboolean session_browsing_cb(GIOChannel *chan, GIOCondition cond,
 				gpointer data)
 {
 	struct avctp *session = data;
-	uint8_t  *buf;
+	uint8_t *operands, *buf;
 	struct avctp_header *avctp;
-	int ret, sock;
+	int ret, packet_size, operand_count, sock;
 
 	buf = (uint8_t *)malloc(session->browsing_mtu);
 	if (!(cond & G_IO_IN))
@@ -472,6 +472,7 @@ static gboolean session_browsing_cb(GIOChannel *chan, GIOCondition cond,
 
 	if (ret <= 0)
 		goto failed;
+	DBG("Got %d bytes of data for AVCTP Browsing session %p", ret, session);
 
 	if ((unsigned int) ret < sizeof(struct avctp_header)) {
 		error("Too small AVRCP packet on browsing channel");
@@ -480,8 +481,28 @@ static gboolean session_browsing_cb(GIOChannel *chan, GIOCondition cond,
 
 	avctp = (struct avctp_header *) buf;
 
+	DBG("AVCTP transaction %u, packet type %u, C/R %u, IPID %u, "
+			"PID 0x%04X",
+			avctp->transaction, avctp->packet_type,
+			avctp->cr, avctp->ipid, ntohs(avctp->pid));
 	if (avctp->packet_type != AVCTP_PACKET_SINGLE)
 		goto failed;
+	operands = buf + AVCTP_HEADER_LENGTH;
+	ret -= AVCTP_HEADER_LENGTH;
+	operand_count = ret;
+
+	packet_size = AVCTP_HEADER_LENGTH;
+	avctp->cr = AVCTP_RESPONSE;
+
+	if (browsing_handler)
+		packet_size += browsing_handler->cb(session, avctp->transaction,
+			operands, operand_count, browsing_handler->user_data);
+
+	if (packet_size != 0) {
+		ret = write(sock, buf, packet_size);
+		if (ret != packet_size)
+			goto failed;
+	}
 
 	free(buf);
 	return TRUE;
diff --git a/audio/avctp.h b/audio/avctp.h
index fa6eebf..3e1dabe 100644
--- a/audio/avctp.h
+++ b/audio/avctp.h
@@ -83,7 +83,7 @@ typedef size_t (*avctp_control_pdu_cb) (struct avctp *session,
 typedef gboolean (*avctp_rsp_cb) (struct avctp *session, uint8_t code,
 					uint8_t subunit, uint8_t *operands,
 					size_t operand_count, void *user_data);
-typedef void (*avctp_browsing_pdu_cb) (struct avctp *session,
+typedef size_t (*avctp_browsing_pdu_cb) (struct avctp *session,
 					uint8_t transaction,
 					uint8_t *operands, size_t operand_count,
 					void *user_data);
diff --git a/audio/avrcp.c b/audio/avrcp.c
index aa1b4b1..1e02e0b 100644
--- a/audio/avrcp.c
+++ b/audio/avrcp.c
@@ -94,6 +94,9 @@
 #define AVRCP_ABORT_CONTINUING		0x41
 #define AVRCP_SET_ABSOLUTE_VOLUME	0x50
 
+#define AVRCP_GENERAL_REJECT		0xA0
+#define AVRCP_INVALID_BROWSING_PDU	0x00
+
 /* Capabilities for AVRCP_GET_CAPABILITIES pdu */
 #define CAP_COMPANY_ID		0x02
 #define CAP_EVENTS_SUPPORTED	0x03
@@ -140,6 +143,11 @@ struct avrcp_header {
 #error "Unknown byte order"
 #endif
 
+struct avrcp_browsing_header {
+	uint8_t browsing_pdu;
+	uint16_t param_len;
+} __attribute__ ((packed));
+#define AVRCP_BROWSING_HEADER_LENGTH 3
 #define AVRCP_MTU	(AVC_MTU - AVC_HEADER_LENGTH)
 #define AVRCP_PDU_MTU	(AVRCP_MTU - AVRCP_HEADER_LENGTH)
 
@@ -163,7 +171,9 @@ struct avrcp_player {
 	struct audio_device *dev;
 
 	unsigned int control_handler;
+	unsigned int browsing_handler;
 	uint16_t registered_events;
+	uint8_t transaction;
 	uint8_t transaction_events[AVRCP_EVENT_LAST + 1];
 	struct pending_pdu *pending_pdu;
 
@@ -436,7 +446,7 @@ int avrcp_player_event(struct avrcp_player *player, uint8_t id, void *data)
 
 	pdu->params_len = htons(size);
 
-	err = avctp_send_vendordep(player->session, 
+	err = avctp_send_vendordep(player->session,
 					player->transaction_events[id],
 					AVC_CTYPE_CHANGED, AVC_SUBUNIT_PANEL,
 					buf, size + AVRCP_HEADER_LENGTH);
@@ -1076,6 +1086,15 @@ static struct control_pdu_handler {
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
@@ -1135,6 +1154,50 @@ err_metadata:
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
+		status = AVRCP_STATUS_INVALID_COMMAND;
+		goto err;
+	}
+
+
+	if (!b_handler->func) {
+		status = AVRCP_STATUS_INVALID_PARAM;
+		avrcp_browsing->param_len = htons(sizeof(status));
+		goto err;
+	}
+
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
 size_t avrcp_handle_vendor_reject(uint8_t *code, uint8_t *operands)
 {
 	struct avrcp_header *pdu = (void *) operands;
@@ -1235,6 +1298,12 @@ static void state_changed(struct audio_device *dev, avctp_state_t old_state,
 			player->control_handler = 0;
 		}
 
+		if (player->browsing_handler) {
+			avctp_unregister_browsing_pdu_handler(
+							player->browsing_handler);
+			player->browsing_handler = 0;
+		}
+
 		break;
 	case AVCTP_STATE_CONNECTING:
 		player->session = avctp_connect(&dev->src, &dev->dst);
@@ -1245,6 +1314,13 @@ static void state_changed(struct audio_device *dev, avctp_state_t old_state,
 							AVC_OP_VENDORDEP,
 							handle_vendordep_pdu,
 							player);
+
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

