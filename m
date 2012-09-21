Return-Path: <cyrus@holtmann.org>
From: Joohi RASTOGI <joohi.rastogi@stericsson.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Joohi RASTOGI <joohi.rastogi@stericsson.com>
Date: Fri, 21 Sep 2012 07:22:36 +0200
Subject: [PATCH BlueZ V7 5/5] AVRCP: Add handler for browsing pdu
Message-ID: <3176460F0F455A44B2E93431E34FC86C228F881F35@EXDCVYMBSTM005.EQ1STM.local>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

>From e6ee4cec1e2eac5f343cad4fdcd05c2462b76282 Mon Sep 17 00:00:00 2001
From: Joohi Rastogi <joohi.rastogi@stericsson.com>
Date: Fri, 21 Sep 2012 10:40:35 +0530
Subject: [PATCH BlueZ V7 5/5] Implement generic handling of browsing PDU IDs

---
 audio/avctp.c |   24 ++++++++++++++++++-
 audio/avrcp.c |   70 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 91 insertions(+), 3 deletions(-)
 mode change 100755 => 100644 audio/avrcp.c

diff --git a/audio/avctp.c b/audio/avctp.c
index fb5689e..146a0ce 100644
--- a/audio/avctp.c
+++ b/audio/avctp.c
@@ -481,9 +481,9 @@ static gboolean session_browsing_cb(GIOChannel *chan, GIOCondition cond,
 				gpointer data)
 {
 	struct avctp *session = data;
-	uint8_t  *buf;
+	uint8_t  *buf, *operands;
 	struct avctp_header *avctp;
-	int ret;
+	int ret, packet_size, operand_count, sock;
 
 	buf = avctp_read_data(&ret, session->browsing_mtu,
 						session->browsing_io);
@@ -495,9 +495,29 @@ static gboolean session_browsing_cb(GIOChannel *chan, GIOCondition cond,
 		goto failed;
 
 	avctp = (struct avctp_header *) buf;
+	DBG("AVCTP transaction %u, packet type %u, C/R %u, IPID %u, "
+				"PID 0x%04X",
+				avctp->transaction, avctp->packet_type,
+				avctp->cr, avctp->ipid, ntohs(avctp->pid));
 
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
+						operands, operand_count, browsing_handler->user_data);
+
+	if (packet_size != 0) {
+		sock = g_io_channel_unix_get_fd(session->browsing_io);
+		ret = write(sock, buf, packet_size);
+		if (ret != packet_size)
+			goto failed;
+	}
 
 	g_free(buf);
 	return TRUE;
diff --git a/audio/avrcp.c b/audio/avrcp.c
old mode 100755
new mode 100644
index 8259183..8c88d5d
--- a/audio/avrcp.c
+++ b/audio/avrcp.c
@@ -95,6 +95,9 @@
 #define AVRCP_ABORT_CONTINUING		0x41
 #define AVRCP_SET_ABSOLUTE_VOLUME	0x50
 
+#define AVRCP_INVALID_BROWSING_PDU		0x00
+#define AVRCP_GENERAL_REJECT 			0xA0
+
 /* Capabilities for AVRCP_GET_CAPABILITIES pdu */
 #define CAP_COMPANY_ID		0x02
 #define CAP_EVENTS_SUPPORTED	0x03
@@ -145,6 +148,12 @@ struct avrcp_header {
 #define AVRCP_MTU	(AVC_MTU - AVC_HEADER_LENGTH)
 #define AVRCP_PDU_MTU	(AVRCP_MTU - AVRCP_HEADER_LENGTH)
 
+struct avrcp_browsing_header {
+	uint8_t browsing_pdu;
+	uint16_t param_len;
+} __attribute__ ((packed));
+#define AVRCP_BROWSING_HEADER_LENGTH 3
+
 struct avrcp_server {
 	bdaddr_t src;
 	uint32_t tg_record_id;
@@ -165,7 +174,9 @@ struct avrcp_player {
 	struct audio_device *dev;
 
 	unsigned int control_handler;
+	unsigned int browsing_handler;
 	uint16_t registered_events;
+	uint8_t transaction;
 	uint8_t transaction_events[AVRCP_EVENT_LAST + 1];
 	struct pending_pdu *pending_pdu;
 
@@ -1080,6 +1091,14 @@ static struct control_pdu_handler {
 		{ },
 };
 
+static struct pdu_browsing_handler {
+	uint8_t browsing_pdu;
+	void (*func) (struct avrcp_player *player,
+						struct avrcp_browsing_header *pdu);
+	} browsing_handlers[] = {
+					{ AVRCP_INVALID_BROWSING_PDU, NULL },
+};
+
 /* handle vendordep pdu inside an avctp packet */
 static size_t handle_vendordep_pdu(struct avctp *session, uint8_t transaction,
 					uint8_t *code, uint8_t *subunit,
@@ -1139,6 +1158,47 @@ err_metadata:
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
+	if (!b_handler) {
+		avrcp_browsing->browsing_pdu = AVRCP_GENERAL_REJECT;
+		status = AVRCP_STATUS_INVALID_COMMAND;
+		goto err;
+	}
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
+	err:
+	avrcp_browsing->param_len = htons(sizeof(status));
+	memcpy(&operands[AVRCP_BROWSING_HEADER_LENGTH], &status,
+							(sizeof(status)));
+	return AVRCP_BROWSING_HEADER_LENGTH + sizeof(status);
+}
+
 size_t avrcp_handle_vendor_reject(uint8_t *code, uint8_t *operands)
 {
 	struct avrcp_header *pdu = (void *) operands;
@@ -1238,7 +1298,10 @@ static void state_changed(struct audio_device *dev, avctp_state_t old_state,
 			avctp_unregister_pdu_handler(player->control_handler);
 			player->control_handler = 0;
 		}
-
+		if (player->browsing_handler) {
+			avctp_unregister_browsing_pdu_handler();
+			player->browsing_handler = 0;
+		}
 		break;
 	case AVCTP_STATE_CONNECTING:
 		player->session = avctp_connect(&dev->src, &dev->dst);
@@ -1249,6 +1312,11 @@ static void state_changed(struct audio_device *dev, avctp_state_t old_state,
 							AVC_OP_VENDORDEP,
 							handle_vendordep_pdu,
 							player);
+		if (!player->browsing_handler)
+			player->browsing_handler =
+							avctp_register_browsing_pdu_handler(
+							handle_browsing_pdu,
+							player);
 		break;
 	case AVCTP_STATE_CONNECTED:
 		rec = btd_device_get_record(dev->btd_dev, AVRCP_TARGET_UUID);
-- 
1.7.5.4

Regards
Joohi
