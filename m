Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 1/3 v3] AVRCP: Fix not handling commands while browsing is connecting
Date: Sun, 27 Jan 2013 17:52:14 -0600
Message-Id: <1359330736-9190-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

With introdution of browsing channel the .init callback is called when
browsing channel connection completes, but in the meantime the remote
device can send commands over control channel.

To fix this the init callaback of control and browsing channel are now
separated into .init_control and .init_browsing so the handler can be
register as soon the respective channel connection completes.
---
v2: Separate control and browsing inits and use handler id to track if channel
has been initialized or not.
v3: Adds patches 2 and 3

 profiles/audio/avrcp.c | 73 +++++++++++++++++++++++++++++---------------------
 1 file changed, 42 insertions(+), 31 deletions(-)

diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
index 4965b0c..6b61664 100644
--- a/profiles/audio/avrcp.c
+++ b/profiles/audio/avrcp.c
@@ -190,9 +190,9 @@ struct avrcp {
 	gboolean target;
 	uint16_t version;
 	int features;
-	bool initialized;
 
-	void (*init) (struct avrcp *session);
+	void (*init_control) (struct avrcp *session);
+	void (*init_browsing) (struct avrcp *session);
 	void (*destroy) (struct avrcp *sesion);
 
 	const struct control_pdu_handler *control_handlers;
@@ -2165,14 +2165,23 @@ static struct avrcp *find_session(GSList *list, struct audio_device *dev)
 	return NULL;
 }
 
-static void session_tg_init(struct avrcp *session)
+static void session_tg_init_browsing(struct avrcp *session)
+{
+	session->browsing_id = avctp_register_browsing_pdu_handler(
+							session->conn,
+							handle_browsing_pdu,
+							session);
+}
+
+static void session_tg_init_control(struct avrcp *session)
 {
 	struct avrcp_server *server = session->server;
 	struct avrcp_player *player;
 
-	DBG("%p version 0x%04x", session, session->version);
+	if (session->version < 0x0103)
+		return;
 
-	session->initialized = true;
+	DBG("%p version 0x%04x", session, session->version);
 
 	player = g_slist_nth_data(server->players, 0);
 	if (player != NULL) {
@@ -2180,6 +2189,10 @@ static void session_tg_init(struct avrcp *session)
 		player->sessions = g_slist_prepend(player->sessions, session);
 	}
 
+	session->control_id = avctp_register_pdu_handler(session->conn,
+							AVC_OP_VENDORDEP,
+							handle_vendordep_pdu,
+							session);
 	session->control_handlers = tg_control_handlers;
 	session->supported_events = (1 << AVRCP_EVENT_STATUS_CHANGED) |
 				(1 << AVRCP_EVENT_TRACK_CHANGED) |
@@ -2190,36 +2203,31 @@ static void session_tg_init(struct avrcp *session)
 	if (session->version >= 0x0104)
 		avrcp_register_notification(session,
 						AVRCP_EVENT_VOLUME_CHANGED);
+}
 
-	session->control_id = avctp_register_pdu_handler(session->conn,
-							AVC_OP_VENDORDEP,
-							handle_vendordep_pdu,
-							session);
+static void session_ct_init_browsing(struct avrcp *session)
+{
 	session->browsing_id = avctp_register_browsing_pdu_handler(
 							session->conn,
 							handle_browsing_pdu,
 							session);
 }
 
-static void session_ct_init(struct avrcp *session)
+static void session_ct_init_control(struct avrcp *session)
 {
 	struct avrcp_player *player;
 	struct media_player *mp;
 	const char *path;
 
-	session->control_handlers = ct_control_handlers;
-
-	if (session->version >= 0x0104)
-		session->supported_events = (1 << AVRCP_EVENT_VOLUME_CHANGED);
-
 	DBG("%p version 0x%04x", session, session->version);
 
-	session->initialized = true;
-
 	session->control_id = avctp_register_pdu_handler(session->conn,
 							AVC_OP_VENDORDEP,
 							handle_vendordep_pdu,
 							session);
+	session->control_handlers = ct_control_handlers;
+	if (session->version >= 0x0104)
+		session->supported_events = (1 << AVRCP_EVENT_VOLUME_CHANGED);
 
 	player = g_new0(struct avrcp_player, 1);
 	player->sessions = g_slist_prepend(player->sessions, session);
@@ -2316,11 +2324,13 @@ static struct avrcp *session_create(struct avrcp_server *server,
 		session->target = FALSE;
 
 	if (session->target) {
-		session->init = session_tg_init;
+		session->init_control = session_tg_init_control;
+		session->init_browsing = session_tg_init_browsing;
 		session->destroy = session_tg_destroy;
 		rec = btd_device_get_record(dev->btd_dev, AVRCP_REMOTE_UUID);
 	} else {
-		session->init = session_ct_init;
+		session->init_control = session_ct_init_control;
+		session->init_browsing = session_ct_init_browsing;
 		session->destroy = session_ct_destroy;
 		rec = btd_device_get_record(dev->btd_dev, AVRCP_TARGET_UUID);
 	}
@@ -2368,26 +2378,27 @@ static void state_changed(struct audio_device *dev, avctp_state_t old_state,
 
 		break;
 	case AVCTP_STATE_CONNECTED:
-		if (session == NULL || session->initialized)
+		if (session == NULL)
 			break;
 
-		/* Initialize session if browsing cannot be used */
-		if (session->version <= 0x0103 ||
-				old_state == AVCTP_STATE_BROWSING_CONNECTING ||
-				!(session->features & AVRCP_FEATURE_BROWSING)) {
-			session->init(session);
-			break;
-		}
+		if (session->browsing_id > 0)
+			session->browsing_id = 0;
+
+		if (session->control_id > 0)
+			return;
+
+		session->init_control(session);
 
-		if (avctp_connect_browsing(session->conn) != 0)
-			session->init(session);
+		if (session->version >= 0x0104 &&
+				session->features & AVRCP_FEATURE_BROWSING)
+			avctp_connect_browsing(session->conn);
 
 		break;
 	case AVCTP_STATE_BROWSING_CONNECTED:
-		if (session == NULL || session->initialized)
+		if (session == NULL || session->browsing_id > 0)
 			break;
 
-		session->init(session);
+		session->init_browsing(session);
 		break;
 	default:
 		return;
-- 
1.8.1

