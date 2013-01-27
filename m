Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] AVRCP: Fix not handling commands while browsing is connecting
Date: Sun, 27 Jan 2013 15:03:02 -0600
Message-Id: <1359320582-2568-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

With introdution of browsing channel the .init callback is called when
browsing channel connection completes, but in the meantime the remote
device can send commands over control channel.

To fix this a new callback .connect is introduced to register the PDU
handlers as soon as the control connection completes leaving .init with
only command initialization.
---
 profiles/audio/avrcp.c | 59 ++++++++++++++++++++++++++++++++------------------
 1 file changed, 38 insertions(+), 21 deletions(-)

diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
index 4965b0c..8c92968 100644
--- a/profiles/audio/avrcp.c
+++ b/profiles/audio/avrcp.c
@@ -192,6 +192,7 @@ struct avrcp {
 	int features;
 	bool initialized;
 
+	void (*connect) (struct avrcp *session);
 	void (*init) (struct avrcp *session);
 	void (*destroy) (struct avrcp *sesion);
 
@@ -2165,6 +2166,28 @@ static struct avrcp *find_session(GSList *list, struct audio_device *dev)
 	return NULL;
 }
 
+static void session_tg_connect(struct avrcp *session)
+{
+	if (session->control_id > 0)
+		return;
+
+	session->control_handlers = tg_control_handlers;
+	session->supported_events = (1 << AVRCP_EVENT_STATUS_CHANGED) |
+				(1 << AVRCP_EVENT_TRACK_CHANGED) |
+				(1 << AVRCP_EVENT_TRACK_REACHED_START) |
+				(1 << AVRCP_EVENT_TRACK_REACHED_END) |
+				(1 << AVRCP_EVENT_SETTINGS_CHANGED);
+
+	session->control_id = avctp_register_pdu_handler(session->conn,
+							AVC_OP_VENDORDEP,
+							handle_vendordep_pdu,
+							session);
+	session->browsing_id = avctp_register_browsing_pdu_handler(
+							session->conn,
+							handle_browsing_pdu,
+							session);
+}
+
 static void session_tg_init(struct avrcp *session)
 {
 	struct avrcp_server *server = session->server;
@@ -2180,25 +2203,25 @@ static void session_tg_init(struct avrcp *session)
 		player->sessions = g_slist_prepend(player->sessions, session);
 	}
 
-	session->control_handlers = tg_control_handlers;
-	session->supported_events = (1 << AVRCP_EVENT_STATUS_CHANGED) |
-				(1 << AVRCP_EVENT_TRACK_CHANGED) |
-				(1 << AVRCP_EVENT_TRACK_REACHED_START) |
-				(1 << AVRCP_EVENT_TRACK_REACHED_END) |
-				(1 << AVRCP_EVENT_SETTINGS_CHANGED);
-
 	if (session->version >= 0x0104)
 		avrcp_register_notification(session,
 						AVRCP_EVENT_VOLUME_CHANGED);
+}
+
+static void session_ct_connect(struct avrcp *session)
+{
+	if (session->control_id > 0)
+		return;
 
+	session->control_handlers = ct_control_handlers;
 	session->control_id = avctp_register_pdu_handler(session->conn,
 							AVC_OP_VENDORDEP,
 							handle_vendordep_pdu,
 							session);
-	session->browsing_id = avctp_register_browsing_pdu_handler(
-							session->conn,
-							handle_browsing_pdu,
-							session);
+	if (session->version < 0x0103)
+		return;
+
+	session->supported_events = (1 << AVRCP_EVENT_VOLUME_CHANGED);
 }
 
 static void session_ct_init(struct avrcp *session)
@@ -2207,20 +2230,10 @@ static void session_ct_init(struct avrcp *session)
 	struct media_player *mp;
 	const char *path;
 
-	session->control_handlers = ct_control_handlers;
-
-	if (session->version >= 0x0104)
-		session->supported_events = (1 << AVRCP_EVENT_VOLUME_CHANGED);
-
 	DBG("%p version 0x%04x", session, session->version);
 
 	session->initialized = true;
 
-	session->control_id = avctp_register_pdu_handler(session->conn,
-							AVC_OP_VENDORDEP,
-							handle_vendordep_pdu,
-							session);
-
 	player = g_new0(struct avrcp_player, 1);
 	player->sessions = g_slist_prepend(player->sessions, session);
 	session->player = player;
@@ -2316,10 +2329,12 @@ static struct avrcp *session_create(struct avrcp_server *server,
 		session->target = FALSE;
 
 	if (session->target) {
+		session->connect = session_tg_connect;
 		session->init = session_tg_init;
 		session->destroy = session_tg_destroy;
 		rec = btd_device_get_record(dev->btd_dev, AVRCP_REMOTE_UUID);
 	} else {
+		session->connect = session_ct_connect;
 		session->init = session_ct_init;
 		session->destroy = session_ct_destroy;
 		rec = btd_device_get_record(dev->btd_dev, AVRCP_TARGET_UUID);
@@ -2371,6 +2386,8 @@ static void state_changed(struct audio_device *dev, avctp_state_t old_state,
 		if (session == NULL || session->initialized)
 			break;
 
+		session->connect(session);
+
 		/* Initialize session if browsing cannot be used */
 		if (session->version <= 0x0103 ||
 				old_state == AVCTP_STATE_BROWSING_CONNECTING ||
-- 
1.8.1

