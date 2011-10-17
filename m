Return-Path: <cyrus@holtmann.org>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [PATCH v2 4/5] AVRCP: Implement AbortContinuingResponse PDU
Date: Mon, 17 Oct 2011 18:34:30 -0200
Message-Id: <1318883671-10932-5-git-send-email-lucas.demarchi@profusion.mobi>
In-Reply-To: <1318883671-10932-1-git-send-email-lucas.demarchi@profusion.mobi>
References: <1318883671-10932-1-git-send-email-lucas.demarchi@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 audio/avrcp.c |   55 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 55 insertions(+), 0 deletions(-)

diff --git a/audio/avrcp.c b/audio/avrcp.c
index 5f8277c..585b095 100644
--- a/audio/avrcp.c
+++ b/audio/avrcp.c
@@ -77,6 +77,7 @@
 #define AVRCP_GET_ELEMENT_ATTRIBUTES	0x20
 #define AVRCP_GET_PLAY_STATUS		0x30
 #define AVRCP_REGISTER_NOTIFICATION	0x31
+#define AVRCP_ABORT_CONTINUING		0x41
 
 /* Capabilities for AVRCP_GET_CAPABILITIES pdu */
 #define CAP_COMPANY_ID		0x02
@@ -129,6 +130,12 @@ struct avrcp_server {
 	struct avrcp_player *active_player;
 };
 
+struct pending_pdu {
+	uint8_t pdu_id;
+	GList *attr_ids;
+	uint16_t offset;
+};
+
 struct avrcp_player {
 	struct avrcp_server *server;
 	struct avctp *session;
@@ -137,6 +144,7 @@ struct avrcp_player {
 	unsigned int handler;
 	uint16_t registered_events;
 	uint8_t transaction_events[AVRCP_EVENT_LAST + 1];
+	struct pending_pdu *pending_pdu;
 
 	struct avrcp_player_cb *cb;
 	void *user_data;
@@ -462,6 +470,18 @@ done:
 	return sizeof(struct media_info_elem) + len;
 }
 
+static gboolean player_abort_pending_pdu(struct avrcp_player *player)
+{
+	if (player->pending_pdu == NULL)
+		return FALSE;
+
+	g_list_free(player->pending_pdu->attr_ids);
+	g_free(player->pending_pdu);
+	player->pending_pdu = NULL;
+
+	return TRUE;
+}
+
 static int player_set_attribute(struct avrcp_player *player,
 						uint8_t attr, uint8_t val)
 {
@@ -872,6 +892,33 @@ err:
 	return AVC_CTYPE_REJECTED;
 }
 
+static uint8_t avrcp_handle_abort_continuing(struct avrcp_player *player,
+						struct avrcp_header *pdu,
+						uint8_t transaction)
+{
+	uint16_t len = ntohs(pdu->params_len);
+	struct pending_pdu *pending;
+
+	if (len != 1 || player->pending_pdu == NULL)
+		goto err;
+
+	pending = player->pending_pdu;
+
+	if (pending->pdu_id != pdu->params[0])
+		goto err;
+
+	player_abort_pending_pdu(player);
+	pdu->params_len = 0;
+
+	return AVC_CTYPE_STABLE;
+
+err:
+	pdu->params_len = htons(1);
+	pdu->params[0] = E_INVALID_PARAM;
+	return AVC_CTYPE_REJECTED;
+}
+
+
 static struct pdu_handler {
 	uint8_t pdu_id;
 	uint8_t code;
@@ -903,6 +950,8 @@ static struct pdu_handler {
 					avrcp_handle_get_play_status },
 		{ AVRCP_REGISTER_NOTIFICATION, AVC_CTYPE_NOTIFY,
 					avrcp_handle_register_notification },
+		{ AVRCP_ABORT_CONTINUING, AVC_CTYPE_CONTROL,
+					avrcp_handle_abort_continuing },
 		{ },
 };
 
@@ -950,6 +999,10 @@ static size_t handle_vendordep_pdu(struct avctp *session, uint8_t transaction,
 
 	*code = handler->func(player, pdu, transaction);
 
+	if (*code != AVC_CTYPE_REJECTED &&
+				pdu->pdu_id != AVRCP_ABORT_CONTINUING)
+		player_abort_pending_pdu(player);
+
 	return AVRCP_HEADER_LENGTH + ntohs(pdu->params_len);
 
 err_metadata:
@@ -1103,6 +1156,8 @@ static void player_destroy(gpointer data)
 	if (player->destroy)
 		player->destroy(player->user_data);
 
+	player_abort_pending_pdu(player);
+
 	if (player->handler)
 		avctp_unregister_pdu_handler(player->handler);
 
-- 
1.7.7

