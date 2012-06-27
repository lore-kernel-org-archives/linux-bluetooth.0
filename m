Return-Path: <cyrus@holtmann.org>
From: Michal Labedzki <michal.labedzki@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <luiz.dentz@gmail.com>, <lucas.demarchi@profusion.mob>,
	<johan.hedberg@gmail.com>,
	Michal Labedzki <michal.labedzki@tieto.com>
Subject: [PATCH v2 11/14] AVRCP: Implement setting AddressedPlayer with notifications completion
Date: Wed, 27 Jun 2012 15:27:45 +0200
Message-ID: <1340803668-31686-11-git-send-email-michal.labedzki@tieto.com>
In-Reply-To: <1340803668-31686-1-git-send-email-michal.labedzki@tieto.com>
References: <1340803668-31686-1-git-send-email-michal.labedzki@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

For AVRCP 1.4 complete notifications according to the specification
by rejecting all registered notifications with coresponding
transaction id.

For AVRCP 1.3 complete events by reusing already registered events.
This allows to change media player and notify remote controller
about metadata changed.
---
 audio/avrcp.c |   99 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 audio/avrcp.h |    1 +
 audio/media.c |    5 +++
 3 files changed, 105 insertions(+)

diff --git a/audio/avrcp.c b/audio/avrcp.c
index d011b2e..baf9de5 100644
--- a/audio/avrcp.c
+++ b/audio/avrcp.c
@@ -58,6 +58,8 @@
 #include "sdpd.h"
 #include "dbus-common.h"
 
+#define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]))
+
 #define AVRCP_REGISTER_NOTIFICATION_PARAM_LENGTH 5
 
 enum company_id {
@@ -191,6 +193,21 @@ struct avrcp_player {
 	GDestroyNotify destroy;
 };
 
+struct status_reply {
+	struct avrcp_header pdu;
+	uint8_t status;
+} __attribute__ ((packed));
+
+static const uint8_t events_to_complete[] = {
+	AVRCP_EVENT_PLAYBACK_STATUS_CHANGED,
+	AVRCP_EVENT_TRACK_CHANGED,
+	AVRCP_EVENT_TRACK_REACHED_END,
+	AVRCP_EVENT_TRACK_REACHED_START,
+	AVRCP_EVENT_PLAYBACK_POS_CHANGED,
+	AVRCP_EVENT_PLAYER_APPLICATION_SETTING_CHANGED,
+	AVRCP_EVENT_NOW_PLAYING_CONTENT_CHANGED
+};
+
 static GSList *servers = NULL;
 static unsigned int avctp_id = 0;
 
@@ -1519,3 +1536,85 @@ int avrcp_set_volume(struct audio_device *dev, uint8_t volume)
 					AVC_SUBUNIT_PANEL, buf, sizeof(buf),
 					avrcp_handle_set_volume, player);
 }
+
+static void avrcp_events_completion(struct avrcp_session *session)
+{
+	struct status_reply event;
+	unsigned int i;
+	uint8_t id;
+	int err;
+
+	memset(&event, 0, sizeof(event));
+	set_company_id(event.pdu.company_id, IEEEID_BTSIG);
+	event.pdu.pdu_id = AVRCP_REGISTER_NOTIFICATION;
+	event.pdu.params_len = htons(1);
+	event.status = STATUS_ADDRESSED_PLAYER_CHANGED;
+
+	for (i = 0; i < ARRAY_SIZE(events_to_complete); i++) {
+		id = 1 << events_to_complete[i];
+
+		if (!(session->registered_events & id))
+			continue;
+
+		err = avctp_send_vendordep(session->avctp_session,
+						session->transaction[events_to_complete[i]],
+						AVC_CTYPE_REJECTED, AVC_SUBUNIT_PANEL,
+						(uint8_t *) &event, sizeof(event));
+		if (err < 0)
+			DBG("Cannot complete event %u: %s (%d)",
+				events_to_complete[i], strerror(-err), err);
+
+		session->registered_events ^= id;
+	}
+}
+
+static void avrcp_events_reusing(struct avrcp_player *player)
+{
+	struct avrcp_player *addressed = player->server->addressed_player;
+	struct avrcp_session *session = &player->server->session;
+	uint8_t play_status;
+	uint64_t uid;
+
+	/* Reusing previously registered events for AVRCP 1.3 devices */
+
+	play_status = player->cb->get_status(player->user_data);
+	uid = player->cb->get_uid(player->user_data);
+
+	if (play_status != addressed->cb->get_status(addressed->user_data))
+		avrcp_event(session, AVRCP_EVENT_PLAYBACK_STATUS_CHANGED,
+				&play_status);
+
+	avrcp_event(session, AVRCP_EVENT_TRACK_CHANGED, &uid);
+}
+
+gboolean avrcp_set_addressed_player(struct avrcp_player *player, gboolean local)
+{
+	struct avrcp_server *server = player->server;
+	struct avrcp_session *session = &server->session;
+
+	if (player == server->addressed_player)
+		return TRUE;
+
+	/* if triggered from remote, try to complete events */
+	if (local) {
+		if (session->version_ct == AVRCP_VERSION_1_3)
+			avrcp_events_reusing(player);
+		else
+			avrcp_events_completion(session);
+	}
+
+	pending_pdu_abort(session);
+
+	player->dev = server->addressed_player->dev;
+
+	if (server->addressed_player->handler) {
+		avctp_unregister_pdu_handler(server->addressed_player->handler);
+		server->addressed_player->handler = 0;
+	}
+	player->handler = avctp_register_pdu_handler(AVC_OP_VENDORDEP,
+							handle_vendordep_pdu, player);
+
+	server->addressed_player = player;
+
+	return TRUE;
+}
diff --git a/audio/avrcp.h b/audio/avrcp.h
index 1b4a887..68e3098 100644
--- a/audio/avrcp.h
+++ b/audio/avrcp.h
@@ -121,5 +121,6 @@ void avrcp_unregister_player(struct avrcp_player *player);
 
 int avrcp_event(struct avrcp_session *session, uint8_t id, void *data);
 
+gboolean avrcp_set_addressed_player(struct avrcp_player *player, gboolean local);
 
 size_t avrcp_handle_vendor_reject(uint8_t *code, uint8_t *operands);
diff --git a/audio/media.c b/audio/media.c
index ce5822a..97bf7df 100644
--- a/audio/media.c
+++ b/audio/media.c
@@ -1803,12 +1803,17 @@ static gboolean media_set_addressed_player(struct media_adapter *adapter,
 	if (!mp)
 		return FALSE;
 
+	if (!avrcp_set_addressed_player(mp->player, local))
+		return FALSE;
+
 	if (adapter->addressed &&
 		g_strcmp0(adapter->addressed->path, DUMMY_PLAYER) == 0)
 		media_player_remove(adapter->addressed);
 
 	adapter->addressed = mp;
 
+	DBG("Set addressed player id=%u to %s", mp->id, path);
+
 	return TRUE;
 }
 
-- 
on behalf of ST-Ericsson

