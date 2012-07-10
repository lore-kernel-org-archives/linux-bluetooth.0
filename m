Return-Path: <cyrus@holtmann.org>
From: Vani-dineshbhai PATEL <vani.patel@stericsson.com>
To: User Name <linux-bluetooth@vger.kernel.org>,
	Luiz Augusto <luiz.dentz@gmail.com>,
	Lucas De Marchi <lucas.demarchi@profusion.mobi>
Cc: Vani <vani.patel@stericsson.com>,
	Joohi <Joohi.rastogi@stericsson.com>, Vani <vani273@gmail.com>
Subject: [PATCH BlueZ 5/5] AVRCP: Add handler for browsing pdu
Date: Tue, 10 Jul 2012 15:07:35 +0530
Message-ID: <1341913055-19754-1-git-send-email-vani.patel@stericsson.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Vani Patel <vani.patel@stericsson.com>

Implement generic handling of browsing
PDU IDs
---
 audio/avctp.c |   40 +++++++++++++++++++++++++++--
 audio/avctp.h |    2 +
 audio/avrcp.c |   77 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 audio/avrcp.h |    2 +
 4 files changed, 118 insertions(+), 3 deletions(-)

diff --git a/audio/avctp.c b/audio/avctp.c
index 0f6188d..24945b4 100644
--- a/audio/avctp.c
+++ b/audio/avctp.c
@@ -461,9 +461,9 @@ static gboolean session_browsing_cb(GIOChannel *chan, GIOCondition cond,
 				gpointer data)
 {
 	struct avctp *session = data;
-	uint8_t  *buf;
+	uint8_t *operands, *buf;
 	struct avctp_header *avctp;
-	int ret, sock;
+	int ret, operand_count, sock;
 
 	buf = (uint8_t *)malloc(session->browsing_mtu);
 	if (!(cond & G_IO_IN))
@@ -481,10 +481,17 @@ static gboolean session_browsing_cb(GIOChannel *chan, GIOCondition cond,
 	}
 
 	avctp = (struct avctp_header *) buf;
-
 	if (avctp->packet_type != AVCTP_PACKET_SINGLE)
 		return FALSE;
 
+	operands = buf + AVCTP_HEADER_LENGTH;
+	ret -= AVCTP_HEADER_LENGTH;
+	ret -= AVRCP_BROWSING_HEADER_LENGTH;
+	operand_count = ret;
+
+	if (browsing_handler)
+		browsing_handler->cb(session, avctp->transaction, operands,
+				operand_count, browsing_handler->user_data);
 
 	return TRUE;
 }
@@ -1353,3 +1360,30 @@ struct avctp *avctp_get(const bdaddr_t *src, const bdaddr_t *dst)
 {
 	return avctp_get_internal(src, dst);
 }
+
+void avctp_send_browsing(struct avctp *session, uint8_t transaction,
+					uint8_t *operands, size_t operand_count)
+{
+	struct avctp_header *avctp_header;
+	uint8_t *buf;
+	uint16_t length = 0;
+	int sock;
+
+	length = AVCTP_HEADER_LENGTH + operand_count;
+	buf = g_malloc0(length);
+
+	avctp_header = (void *) buf;
+
+	avctp_header->cr = AVCTP_RESPONSE;
+	avctp_header->ipid = FALSE;
+	avctp_header->packet_type = AVCTP_PACKET_SINGLE;
+	avctp_header->pid = htons(AV_REMOTE_PROFILE_ID);
+	avctp_header->transaction = transaction;
+
+	memcpy(&buf[AVCTP_HEADER_LENGTH], operands,
+							operand_count);
+
+	sock = g_io_channel_unix_get_fd(session->browsing_io);
+	if (write(sock, buf, length) < 0)
+		DBG("Write failed\n");
+}
diff --git a/audio/avctp.h b/audio/avctp.h
index fa6eebf..cb4cde2 100644
--- a/audio/avctp.h
+++ b/audio/avctp.h
@@ -114,3 +114,5 @@ int avctp_send_vendordep_req(struct avctp *session, uint8_t code,
 					uint8_t subunit, uint8_t *operands,
 					size_t operand_count,
 					avctp_rsp_cb func, void *user_data);
+void avctp_send_browsing(struct avctp *session, uint8_t transaction,
+					uint8_t *operands, size_t operand_count);
diff --git a/audio/avrcp.c b/audio/avrcp.c
index 9d29073..6dedcfd 100644
--- a/audio/avrcp.c
+++ b/audio/avrcp.c
@@ -94,6 +94,14 @@
 #define AVRCP_ABORT_CONTINUING		0x41
 #define AVRCP_SET_ABSOLUTE_VOLUME	0x50
 
+/* Browsing Command PDU ID */
+#define AVRCP_SET_BROWSED_PLAYER		0x70
+#define AVRCP_GET_FOLDER_ITEMS			0x71
+#define AVRCP_CHANGE_PATH			0x72
+#define AVRCP_GET_ITEM_ATTRIBUTES		0x73
+
+#define AVRCP_GENERAL_REJECT			0xA0
+
 /* Capabilities for AVRCP_GET_CAPABILITIES pdu */
 #define CAP_COMPANY_ID		0x02
 #define CAP_EVENTS_SUPPORTED	0x03
@@ -140,6 +148,12 @@ struct avrcp_header {
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
 
@@ -163,7 +177,9 @@ struct avrcp_player {
 	struct audio_device *dev;
 
 	unsigned int control_handler;
+	unsigned int browsing_handler;
 	uint16_t registered_events;
+	uint8_t transaction;
 	uint8_t transaction_events[AVRCP_EVENT_LAST + 1];
 	struct pending_pdu *pending_pdu;
 
@@ -1075,6 +1091,14 @@ static struct control_pdu_handler {
 		{ },
 };
 
+static struct pdu_browsing_handler {
+	uint8_t browsing_pdu;
+	void (*func) (struct avrcp_player *player,
+					struct avrcp_browsing_header *pdu);
+	} browsing_handlers[] = {
+		{},
+};
+
 /* handle vendordep pdu inside an avctp packet */
 static size_t handle_vendordep_pdu(struct avctp *session, uint8_t transaction,
 					uint8_t *code, uint8_t *subunit,
@@ -1134,6 +1158,48 @@ err_metadata:
 	return AVRCP_HEADER_LENGTH + 1;
 }
 
+static void handle_browsing_pdu(struct avctp *session, uint8_t transaction,
+					uint8_t *operands, size_t operand_count,
+					void *user_data)
+{
+	struct avrcp_player *player = user_data;
+	struct pdu_browsing_handler *b_handler;
+	struct avrcp_browsing_header *avrcp_browsing = (void *) operands;
+	uint8_t status, length;
+
+	if ((avrcp_browsing->browsing_pdu != AVRCP_SET_BROWSED_PLAYER) &&
+			(avrcp_browsing->browsing_pdu != AVRCP_GET_FOLDER_ITEMS) &&
+			(avrcp_browsing->browsing_pdu != AVRCP_CHANGE_PATH) &&
+			(avrcp_browsing->browsing_pdu != AVRCP_GET_ITEM_ATTRIBUTES)) {
+
+		avrcp_browsing->browsing_pdu = AVRCP_GENERAL_REJECT;
+		status = AVRCP_STATUS_INVALID_COMMAND;
+		goto err;
+	}
+	for (b_handler = browsing_handlers; b_handler; b_handler++) {
+		if (b_handler->browsing_pdu == avrcp_browsing->browsing_pdu)
+			break;
+	}
+
+
+	if (!b_handler->func) {
+		status = AVRCP_STATUS_INVALID_PARAM;
+		goto err;
+	}
+
+	player->transaction = transaction;
+	b_handler->func(player, avrcp_browsing);
+	return;
+
+err:
+	avrcp_browsing->param_len = htons(sizeof(status));
+	length = AVRCP_BROWSING_HEADER_LENGTH + sizeof(status);
+	memcpy(&operands[AVRCP_BROWSING_HEADER_LENGTH], &status,
+						sizeof(status));
+	avctp_send_browsing(session, player->transaction, operands,
+									length);
+}
+
 size_t avrcp_handle_vendor_reject(uint8_t *code, uint8_t *operands)
 {
 	struct avrcp_header *pdu = (void *) operands;
@@ -1233,6 +1299,11 @@ static void state_changed(struct audio_device *dev, avctp_state_t old_state,
 			avctp_unregister_pdu_handler(player->control_handler);
 			player->control_handler = 0;
 		}
+		if (player->browsing_handler) {
+			avctp_unregister_browsing_pdu_handler(
+						player->browsing_handler);
+			player->browsing_handler = 0;
+		}
 
 		break;
 	case AVCTP_STATE_CONNECTING:
@@ -1244,6 +1315,12 @@ static void state_changed(struct audio_device *dev, avctp_state_t old_state,
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
diff --git a/audio/avrcp.h b/audio/avrcp.h
index bf11a6c..7e2f018 100644
--- a/audio/avrcp.h
+++ b/audio/avrcp.h
@@ -75,6 +75,8 @@
 #define AVRCP_EVENT_TRACK_REACHED_START	0x04
 #define AVRCP_EVENT_VOLUME_CHANGED	0x0d
 #define AVRCP_EVENT_LAST		AVRCP_EVENT_VOLUME_CHANGED
+struct avrcp_browsing_header;
+#define AVRCP_BROWSING_HEADER_LENGTH 3
 
 struct avrcp_player_cb {
 	int (*get_setting) (uint8_t attr, void *user_data);
-- 
1.7.5.4

Regards,
Vani Patel

