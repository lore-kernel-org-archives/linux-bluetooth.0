Return-Path: <cyrus@holtmann.org>
From: Michal Labedzki <michal.labedzki@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <luiz.dentz@gmail.com>, <lucas.demarchi@profusion.mob>,
	<johan.hedberg@gmail.com>,
	Michal Labedzki <michal.labedzki@tieto.com>
Subject: [PATCH v2 13/14] AVRCP: Implement notification ADDRESSED_PLAYER_CHANGED
Date: Wed, 27 Jun 2012 15:27:47 +0200
Message-ID: <1340803668-31686-13-git-send-email-michal.labedzki@tieto.com>
In-Reply-To: <1340803668-31686-1-git-send-email-michal.labedzki@tieto.com>
References: <1340803668-31686-1-git-send-email-michal.labedzki@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

It is triggered by local change of addressed player on TG while
unregistering currently addressed player.
---
 audio/avrcp.c |   35 ++++++++++++++++++++++++++++++++++-
 audio/avrcp.h |    2 ++
 audio/media.c |   19 ++++++++++++++++++-
 3 files changed, 54 insertions(+), 2 deletions(-)

diff --git a/audio/avrcp.c b/audio/avrcp.c
index a725142..7b2d6e0 100644
--- a/audio/avrcp.c
+++ b/audio/avrcp.c
@@ -208,6 +208,11 @@ static const uint8_t events_to_complete[] = {
 	AVRCP_EVENT_NOW_PLAYING_CONTENT_CHANGED
 };
 
+struct addressed_param {
+	uint16_t player_id;
+	uint16_t uid_counter;
+} __attribute__ ((packed));
+
 static GSList *servers = NULL;
 static unsigned int avctp_id = 0;
 
@@ -444,6 +449,14 @@ int avrcp_event(struct avrcp_session *session, uint8_t id, void *data)
 		memcpy(&pdu->params[1], data, sizeof(uint64_t));
 
 		break;
+	case AVRCP_EVENT_ADDRESSED_PLAYER_CHANGED:
+		size = 5;
+		/* player id */
+		memcpy(&pdu->params[1], data, sizeof(uint16_t));
+		/* uid counter */
+		memcpy(&pdu->params[3], data + 2, sizeof(uint16_t));
+
+		break;
 	case AVRCP_EVENT_TRACK_REACHED_END:
 	case AVRCP_EVENT_TRACK_REACHED_START:
 	case AVRCP_EVENT_AVAILABLE_PLAYERS_CHANGED:
@@ -618,12 +631,13 @@ static uint8_t avrcp_handle_get_capabilities(struct avrcp_player *player,
 
 		return AVC_CTYPE_STABLE;
 	case CAP_EVENTS_SUPPORTED:
-		pdu->params[1] = 5;
+		pdu->params[1] = 6;
 		pdu->params[2] = AVRCP_EVENT_PLAYBACK_STATUS_CHANGED;
 		pdu->params[3] = AVRCP_EVENT_TRACK_CHANGED;
 		pdu->params[4] = AVRCP_EVENT_TRACK_REACHED_START;
 		pdu->params[5] = AVRCP_EVENT_TRACK_REACHED_END;
 		pdu->params[6] = AVRCP_EVENT_AVAILABLE_PLAYERS_CHANGED;
+		pdu->params[7] = AVRCP_EVENT_ADDRESSED_PLAYER_CHANGED;
 
 		pdu->params_len = htons(2 + pdu->params[1]);
 		return AVC_CTYPE_STABLE;
@@ -949,6 +963,8 @@ static uint8_t avrcp_handle_register_notification(struct avrcp_player *player,
 	struct avrcp_session *session = &player->server->session;
 	uint16_t len = ntohs(pdu->params_len);
 	uint64_t uid;
+	uint16_t uid_counter;
+	uint16_t player_id;
 
 	/*
 	 * 1 byte for EventID, 4 bytes for Playback interval but the latest
@@ -970,6 +986,16 @@ static uint8_t avrcp_handle_register_notification(struct avrcp_player *player,
 		memcpy(&pdu->params[1], &uid, sizeof(uint64_t));
 
 		break;
+	case AVRCP_EVENT_ADDRESSED_PLAYER_CHANGED:
+		len = 5;
+
+		player_id = htons(player->cb->get_player_id(player->user_data));
+		memcpy(&pdu->params[1], &player_id, sizeof(player_id));
+
+		uid_counter = htons(player->cb->get_uid_counter(player->user_data));
+		memcpy(&pdu->params[3], &uid_counter, sizeof(uid_counter));
+
+		break;
 	case AVRCP_EVENT_TRACK_REACHED_END:
 	case AVRCP_EVENT_TRACK_REACHED_START:
 	case AVRCP_EVENT_AVAILABLE_PLAYERS_CHANGED:
@@ -1635,12 +1661,19 @@ gboolean avrcp_set_addressed_player(struct avrcp_player *player, gboolean local)
 {
 	struct avrcp_server *server = player->server;
 	struct avrcp_session *session = &server->session;
+	struct addressed_param parameters;
 
 	if (player == server->addressed_player)
 		return TRUE;
 
 	/* if triggered from remote, try to complete events */
 	if (local) {
+		parameters.player_id = htons(player->cb->get_player_id(player->user_data));
+		parameters.uid_counter = htons(player->cb->get_uid_counter(player->user_data));
+
+		avrcp_event(session, AVRCP_EVENT_ADDRESSED_PLAYER_CHANGED,
+				&parameters);
+
 		if (session->version_ct == AVRCP_VERSION_1_3)
 			avrcp_events_reusing(player);
 		else
diff --git a/audio/avrcp.h b/audio/avrcp.h
index 148dc0e..83e8563 100644
--- a/audio/avrcp.h
+++ b/audio/avrcp.h
@@ -102,6 +102,8 @@ struct avrcp_player_cb {
 	void (*set_volume) (uint8_t volume, struct audio_device *dev,
 							void *user_data);
 	gboolean (*is_dummy_player) (void *user_data);
+	uint16_t (*get_player_id) (void *user_data);
+	uint16_t (*get_uid_counter) (void *user_data);
 };
 
 struct avrcp_player *player;
diff --git a/audio/media.c b/audio/media.c
index 0c11cf0..c99cde6 100644
--- a/audio/media.c
+++ b/audio/media.c
@@ -106,6 +106,7 @@ struct media_player {
 	uint32_t		position;
 	uint8_t			volume;
 	uint16_t		id;
+	uint16_t		uid_counter;
 	GTimer			*timer;
 };
 
@@ -1403,6 +1404,20 @@ static gboolean is_dummy_player(void *user_data)
 	return FALSE;
 }
 
+static uint16_t get_player_id(void *user_data)
+{
+	struct media_player *mp = user_data;
+
+	return mp->id;
+}
+
+static uint16_t get_uid_counter(void *user_data)
+{
+	struct media_player *mp = user_data;
+
+	return mp->uid_counter;
+}
+
 static struct avrcp_player_cb player_cb = {
 	.get_setting = get_setting,
 	.set_setting = set_setting,
@@ -1412,7 +1427,9 @@ static struct avrcp_player_cb player_cb = {
 	.get_position = get_position,
 	.get_status = get_status,
 	.set_volume = set_volume,
-	.is_dummy_player = is_dummy_player
+	.is_dummy_player = is_dummy_player,
+	.get_player_id = get_player_id,
+	.get_uid_counter = get_uid_counter
 };
 
 static void media_player_exit(DBusConnection *connection, void *user_data)
-- 
on behalf of ST-Ericsson

