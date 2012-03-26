Return-Path: <cyrus@holtmann.org>
From: Vani-dineshbhai PATEL X <vani.patel@stericsson.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Date: Mon, 26 Mar 2012 15:31:21 +0200
Subject: RFC:[PATCH Bluez 3/3] Support for handling Browsing commands added
Message-ID: <747C1E83C744F44E9ACFB89FAEEC2C7B21A7973F2B@EXDCVYMBSTM005.EQ1STM.local>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds support for Handling Browsing commands from CT.

>From 78ed0bc53d99ba68a25f3a0ddb0f273f6e57e3b3 Mon Sep 17 00:00:00 2001
From: Vani Patel <vani.patel@stericsson.com>
Date: Mon, 26 Mar 2012 18:45:42 +0530
Subject: [PATCH Bluez 3/3] Support for handling Browsing commands added

---
 audio/avctp.c |   89 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 audio/avctp.h |    7 ++++
 audio/avrcp.c |   58 +++++++++++++++++++++++++++++++++++++
 audio/avrcp.h |    2 +
 4 files changed, 156 insertions(+), 0 deletions(-)

diff --git a/audio/avctp.c b/audio/avctp.c
index ff4aa30..03b3020 100755
--- a/audio/avctp.c
+++ b/audio/avctp.c
@@ -68,6 +68,8 @@
 #define AVCTP_PACKET_CONTINUE	2
 #define AVCTP_PACKET_END	3
 
+#define E_INVALID_COMMAND	0x00
+
 #if __BYTE_ORDER == __LITTLE_ENDIAN
 
 struct avctp_header {
@@ -155,6 +157,28 @@ struct avctp_browsing_pdu_handler {
 	unsigned int id;
 };
 
+struct browsed_player_param {
+        uint8_t status;
+        uint16_t uid_counter;
+        uint32_t no_of_items;
+        uint16_t cs_id;
+        uint8_t folder_depth;
+        uint8_t folders[];
+} __attribute__ ((packed));
+
+struct avrcp_browsing_frame {
+        struct {
+                struct avctp_header avctp_hdr;
+                struct avrcp_browsing_header avrcp_pdu;
+        } __attribute__ ((packed)) hdr;
+        union {
+                uint8_t status;
+                struct browsed_player_param brws_player_param;
+                uint8_t *param;
+        } pdu;
+} __attribute__ ((packed));
+
+
 static struct {
 	const char *name;
 	uint8_t avc;
@@ -1196,6 +1220,25 @@ unsigned int avctp_register_pdu_handler(uint8_t opcode, avctp_pdu_cb cb,
 	return handler->id;
 }
 
+unsigned int avctp_register_browsing_pdu_handler(avctp_browsing_pdu_cb cb,
+							void *user_data)
+{
+	struct avctp_browsing_pdu_handler *b_handler;
+	static unsigned int id = 0;
+
+	b_handler = find_browsing_handler(browsing_handlers);
+	if (b_handler)
+		return 0;
+
+	b_handler = g_new(struct avctp_browsing_pdu_handler, 1);
+	b_handler->cb = cb;
+	b_handler->user_data = user_data;
+	b_handler->id = ++id;
+
+	browsing_handlers = g_slist_append(browsing_handlers, b_handler);
+
+	return b_handler->id;
+}
 gboolean avctp_unregister_pdu_handler(unsigned int id)
 {
 	GSList *l;
@@ -1213,6 +1256,23 @@ gboolean avctp_unregister_pdu_handler(unsigned int id)
 	return FALSE;
 }
 
+gboolean avctp_unregister_browsing_pdu_handler(unsigned int id)
+{
+	GSList *l;
+
+	for (l = browsing_handlers; l != NULL; l = l->next) {
+		struct avctp_browsing_pdu_handler *b_handler = l->data;
+
+		if (b_handler->id == id) {
+			browsing_handlers = g_slist_remove(browsing_handlers, b_handler);
+			g_free(b_handler);
+			return TRUE;
+		}
+	}
+
+	return FALSE;
+}
+
 struct avctp *avctp_connect(const bdaddr_t *src, const bdaddr_t *dst)
 {
 	struct avctp *session;
@@ -1257,3 +1317,32 @@ struct avctp *avctp_get(const bdaddr_t *src, const bdaddr_t *dst)
 {
 	return avctp_get_internal(src, dst);
 }
+
+void avctp_browsing_rej_rsp(struct avctp *session, uint8_t transaction,
+                                uint8_t pdu_id, uint8_t status_code)
+{
+	struct avrcp_browsing_frame resp;
+	uint8_t length=0;
+	int sock;
+
+	resp.hdr.avctp_hdr.cr = AVCTP_RESPONSE;
+	resp.hdr.avctp_hdr.ipid = FALSE;
+	resp.hdr.avctp_hdr.packet_type = AVCTP_PACKET_SINGLE;
+	resp.hdr.avctp_hdr.pid = htons(AV_REMOTE_PROFILE_ID);
+	resp.hdr.avctp_hdr.transaction = transaction;
+	resp.hdr.avrcp_pdu.pdu_id = pdu_id;
+	resp.pdu.status = status_code;
+
+	length = sizeof(resp.pdu.status);
+	resp.hdr.avrcp_pdu.param_len = htons(length);
+	resp.pdu.status = status_code;
+
+	length += sizeof(resp.hdr);
+	
+	sock = g_io_channel_unix_get_fd(session->b_io);
+	int ret = write(sock, &resp, length);
+	if (ret < 0)
+		DBG ("Write failed \n");
+
+}
+
diff --git a/audio/avctp.h b/audio/avctp.h
index a97fec5..dd586f7 100755
--- a/audio/avctp.h
+++ b/audio/avctp.h
@@ -63,6 +63,7 @@
 #define BACKWARD_OP			0x4c
 
 struct avctp;
+struct avrcp_browsing_frame;
 
 typedef enum {
 	AVCTP_STATE_DISCONNECTED = 0,
@@ -97,7 +98,13 @@ unsigned int avctp_register_pdu_handler(uint8_t opcode, avctp_pdu_cb cb,
 							void *user_data);
 gboolean avctp_unregister_pdu_handler(unsigned int id);
 
+unsigned int avctp_register_browsing_pdu_handler(avctp_browsing_pdu_cb cb,
+							void *user_data);
+
+gboolean avctp_unregister_browsing_pdu_handler(unsigned int id);
 int avctp_send_passthrough(struct avctp *session, uint8_t op);
 int avctp_send_vendordep(struct avctp *session, uint8_t transaction,
 				uint8_t code, uint8_t subunit,
 				uint8_t *operands, size_t operand_count);
+void avctp_rej_response(struct avctp *session, uint8_t transaction,
+				uint8_t pdu_id, uint8_t status_code);
diff --git a/audio/avrcp.c b/audio/avrcp.c
index 4219572..ede25c5 100755
--- a/audio/avrcp.c
+++ b/audio/avrcp.c
@@ -63,6 +63,7 @@
 #define E_INVALID_PARAM		0x01
 #define E_PARAM_NOT_FOUND	0x02
 #define E_INTERNAL		0x03
+#define E_NO_ERR		0x04
 
 /* Packet types */
 #define AVRCP_PACKET_TYPE_SINGLE	0x00
@@ -149,6 +150,7 @@ struct avrcp_player {
 	struct audio_device *dev;
 
 	unsigned int handler;
+	unsigned int browsing_handler;
 	uint16_t registered_events;
 	uint8_t transaction_events[AVRCP_EVENT_LAST + 1];
 	struct pending_pdu *pending_pdu;
@@ -1052,6 +1054,14 @@ static struct pdu_handler {
 		{ },
 };
 
+static struct pdu_browsing_handler {
+	uint8_t pdu_id;
+	uint8_t (*func) (struct avrcp_player *player,
+					struct avrcp_browsing_header *pdu);
+	} browsing_handlers[] = {
+		{},
+};
+
 /* handle vendordep pdu inside an avctp packet */
 static size_t handle_vendordep_pdu(struct avctp *session, uint8_t transaction,
 					uint8_t *code, uint8_t *subunit,
@@ -1111,6 +1121,44 @@ err_metadata:
 	return AVRCP_HEADER_LENGTH + 1;
 }
 
+static size_t handle_browsing_pdu(struct avctp *session, uint8_t transaction,
+					uint8_t *operands, size_t operand_count,
+					void *user_data)
+{
+	struct avrcp_player *player = user_data;
+	struct pdu_browsing_handler *b_handler;
+	struct avrcp_browsing_header *avrcp_browsing = (void *) operands;
+	int status = E_NO_ERR;
+	
+	player->session = session;
+	
+	for (b_handler = browsing_handlers; b_handler; b_handler++) {
+		if (b_handler->pdu_id == avrcp_browsing->pdu_id)
+			break;
+	}
+
+	if (!b_handler) {
+		status = E_INVALID_COMMAND;
+		goto err;
+	}
+
+	if (!b_handler->func) {
+		status = E_INVALID_PARAM;
+		goto err;
+	}
+	
+	player->transaction_events[0] = transaction;
+
+	if(!b_handler->func(player, avrcp_browsing)) 
+		return 0;
+	else 
+		return AVRCP_BROWSING_HEADER_LENGTH + ntohs(avrcp_browsing->param_len);
+	
+err:
+	avctp_browsing_rej_rsp(session, player->transaction_events[0], b_handler->pdu_id, status);
+	return 0;
+}
+
 size_t avrcp_handle_vendor_reject(uint8_t *code, uint8_t *operands)
 {
     struct avrcp_header *pdu = (void *) operands;
@@ -1161,16 +1209,26 @@ static void state_changed(struct audio_device *dev, avctp_state_t old_state,
 			avctp_unregister_pdu_handler(player->handler);
 			player->handler = 0;
 		}
+		if (player->browsing_handler) {
+			avctp_unregister_browsing_pdu_handler(player->browsing_handler);
+			player->browsing_handler = 0;
+		}
 
 		break;
 	case AVCTP_STATE_CONNECTING:
 		player->session = avctp_connect(&dev->src, &dev->dst);
+		if (!player->dev) 
+			player->dev = dev;
 
 		if (!player->handler)
 			player->handler = avctp_register_pdu_handler(
 							AVC_OP_VENDORDEP,
 							handle_vendordep_pdu,
 							player);
+		if(!player->browsing_handler)
+			player->browsing_handler = avctp_register_browsing_pdu_handler(
+							handle_browsing_pdu,
+							player);
 		break;
 	default:
 		return;
diff --git a/audio/avrcp.h b/audio/avrcp.h
index 2aeec7d..db49ff9 100755
--- a/audio/avrcp.h
+++ b/audio/avrcp.h
@@ -79,6 +79,8 @@ struct avrcp_browsing_header {
 	uint8_t pdu_id;
 	uint16_t param_len;
 } __attribute__ ((packed));
+#define AVRCP_BROWSING_HEADER_LENGTH 3
+
 struct avrcp_player_cb {
 	int (*get_setting) (uint8_t attr, void *user_data);
 	int (*set_setting) (uint8_t attr, uint8_t value, void *user_data);
-- 
1.7.5.4

