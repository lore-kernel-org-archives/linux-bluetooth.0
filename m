Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 4/8] AVRCP: Register pass-through handler for CT
Date: Fri, 10 May 2013 14:02:03 +0300
Message-Id: <1368183727-24461-4-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1368183727-24461-1-git-send-email-luiz.dentz@gmail.com>
References: <1368183727-24461-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Register pass-through handler for CT role if version >= 1.3 and creates
callbacks to direct this commands to the active player.
---
 profiles/audio/avrcp.c | 96 ++++++++++++++++++++++++++++++++++++++++++++++++++
 profiles/audio/avrcp.h |  5 +++
 2 files changed, 101 insertions(+)

diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
index b7de051..4acf396 100644
--- a/profiles/audio/avrcp.c
+++ b/profiles/audio/avrcp.c
@@ -203,8 +203,10 @@ struct avrcp {
 	void (*init_browsing) (struct avrcp *session);
 	void (*destroy) (struct avrcp *sesion);
 
+	const struct passthrough_handler *passthrough_handlers;
 	const struct control_pdu_handler *control_handlers;
 
+	unsigned int passthrough_id;
 	unsigned int control_id;
 	unsigned int browsing_id;
 	uint16_t supported_events;
@@ -214,6 +216,11 @@ struct avrcp {
 	struct pending_pdu *pending_pdu;
 };
 
+struct passthrough_handler {
+	uint8_t op;
+	bool (*func) (struct avrcp *session);
+};
+
 struct control_pdu_handler {
 	uint8_t pdu_id;
 	uint8_t code;
@@ -1252,6 +1259,87 @@ static GList *player_list_settings(struct avrcp_player *player)
 	return player->cb->list_settings(player->user_data);
 }
 
+static bool avrcp_handle_play(struct avrcp *session)
+{
+	struct avrcp_player *player = session->player;
+
+	if (session->player == NULL)
+		return false;
+
+	return player->cb->play(player->user_data);
+}
+
+static bool avrcp_handle_stop(struct avrcp *session)
+{
+	struct avrcp_player *player = session->player;
+
+	if (session->player == NULL)
+		return false;
+
+	return player->cb->stop(player->user_data);
+}
+
+static bool avrcp_handle_pause(struct avrcp *session)
+{
+	struct avrcp_player *player = session->player;
+
+	if (session->player == NULL)
+		return false;
+
+	return player->cb->pause(player->user_data);
+}
+
+static bool avrcp_handle_next(struct avrcp *session)
+{
+	struct avrcp_player *player = session->player;
+
+	if (session->player == NULL)
+		return false;
+
+	return player->cb->next(player->user_data);
+}
+
+static bool avrcp_handle_previous(struct avrcp *session)
+{
+	struct avrcp_player *player = session->player;
+
+	if (session->player == NULL)
+		return false;
+
+	return player->cb->previous(player->user_data);
+}
+
+static const struct passthrough_handler tg_passthrough_handlers[] = {
+		{ AVC_PLAY, avrcp_handle_play },
+		{ AVC_STOP, avrcp_handle_stop },
+		{ AVC_PAUSE, avrcp_handle_pause },
+		{ AVC_FORWARD, avrcp_handle_next },
+		{ AVC_BACKWARD, avrcp_handle_previous },
+		{ },
+};
+
+static bool handle_passthrough(struct avctp *conn, uint8_t op, bool pressed,
+							void *user_data)
+{
+	struct avrcp *session = user_data;
+	const struct passthrough_handler *handler;
+
+	for (handler = session->passthrough_handlers; handler->func;
+								handler++) {
+		if (handler->op == op)
+			break;
+	}
+
+	if (handler->func == NULL)
+		return false;
+
+	/* Do not trigger handler on release */
+	if (!pressed)
+		return true;
+
+	return handler->func(session);
+}
+
 static uint8_t avrcp_handle_register_notification(struct avrcp *session,
 						struct avrcp_header *pdu,
 						uint8_t transaction)
@@ -2653,6 +2741,11 @@ static void session_tg_init_control(struct avrcp *session)
 		player->sessions = g_slist_prepend(player->sessions, session);
 	}
 
+	session->passthrough_id = avctp_register_passthrough_handler(
+							session->conn,
+							handle_passthrough,
+							session);
+	session->passthrough_handlers = tg_passthrough_handlers;
 	session->control_id = avctp_register_pdu_handler(session->conn,
 							AVC_OP_VENDORDEP,
 							handle_vendordep_pdu,
@@ -2712,6 +2805,9 @@ static void session_destroy(struct avrcp *session)
 
 	server->sessions = g_slist_remove(server->sessions, session);
 
+	if (session->passthrough_id > 0)
+		avctp_unregister_passthrough_handler(session->passthrough_id);
+
 	if (session->control_id > 0)
 		avctp_unregister_pdu_handler(session->control_id);
 
diff --git a/profiles/audio/avrcp.h b/profiles/audio/avrcp.h
index 7b6fe92..3b1963f 100644
--- a/profiles/audio/avrcp.h
+++ b/profiles/audio/avrcp.h
@@ -93,6 +93,11 @@ struct avrcp_player_cb {
 	uint32_t (*get_duration) (void *user_data);
 	void (*set_volume) (uint8_t volume, struct audio_device *dev,
 							void *user_data);
+	bool (*play) (void *user_data);
+	bool (*stop) (void *user_data);
+	bool (*pause) (void *user_data);
+	bool (*next) (void *user_data);
+	bool (*previous) (void *user_data);
 };
 
 int avrcp_target_register(struct btd_adapter *adapter, GKeyFile *config);
-- 
1.8.1.4

