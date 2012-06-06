Return-Path: <cyrus@holtmann.org>
From: Michal Labedzki <michal.labedzki@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Michal Labedzki <michal.labedzki@tieto.com>
Subject: [PATCH 10/13] AVRCP: Implement notification ADDRESSED_PLAYER_CHANGED
Date: Wed, 6 Jun 2012 18:06:08 +0200
Message-ID: <1338998771-18683-10-git-send-email-michal.labedzki@tieto.com>
In-Reply-To: <1338998771-18683-1-git-send-email-michal.labedzki@tieto.com>
References: <1338998771-18683-1-git-send-email-michal.labedzki@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

It is triggered by local change of addressed player on TG.
---
 audio/avrcp.c |   36 +++++++++++++++++++++++++++++++++++-
 audio/avrcp.h |    2 ++
 audio/media.c |   19 ++++++++++++++++++-
 3 files changed, 55 insertions(+), 2 deletions(-)

diff --git a/audio/avrcp.c b/audio/avrcp.c
index a10b3c1..b095884 100644
--- a/audio/avrcp.c
+++ b/audio/avrcp.c
@@ -241,6 +241,11 @@ static const uint8_t events_to_complete[] = {
 	AVRCP_EVENT_NOW_PLAYING_CONTENT_CHANGED
 };
 
+struct addressed_param {
+	uint16_t player_id;
+	uint16_t uid_counter;
+} __attribute__ ((packed));
+
 static GSList *servers = NULL;
 static unsigned int avctp_id = 0;
 
@@ -477,6 +482,14 @@ int avrcp_player_event(struct avrcp_player *player, uint8_t id, void *data)
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
@@ -652,12 +665,13 @@ static uint8_t avrcp_handle_get_capabilities(struct avrcp_player *player,
 
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
@@ -981,6 +995,8 @@ static uint8_t avrcp_handle_register_notification(struct avrcp_player *player,
 {
 	uint16_t len = ntohs(pdu->params_len);
 	uint64_t uid;
+	uint16_t uid_counter;
+	uint16_t player_id;
 
 	/*
 	 * 1 byte for EventID, 4 bytes for Playback interval but the latest
@@ -1002,6 +1018,16 @@ static uint8_t avrcp_handle_register_notification(struct avrcp_player *player,
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
@@ -1600,12 +1626,20 @@ static void avrcp_events_reusing(struct avrcp_player *player)
 gboolean avrcp_set_addressed_player(struct avrcp_player *player, gboolean local)
 {
 	struct avrcp_server *server = player->server;
+	struct addressed_param parameters;
 
 	if (player == server->addressed_player)
 		return TRUE;
 
 	/* if triggered from remote, try to complete events */
 	if (local) {
+		parameters.player_id = htons(player->cb->get_player_id(player->user_data));
+		parameters.uid_counter = htons(player->cb->get_uid_counter(player->user_data));
+
+		avrcp_player_event(server->addressed_player,
+					AVRCP_EVENT_ADDRESSED_PLAYER_CHANGED,
+					&parameters);
+
 		if (server->version == AVRCP_VERSION_1_3)
 			avrcp_events_reusing(player);
 		else
diff --git a/audio/avrcp.h b/audio/avrcp.h
index 82f75d4..e83e2de 100644
--- a/audio/avrcp.h
+++ b/audio/avrcp.h
@@ -102,6 +102,8 @@ struct avrcp_player_cb {
 	uint32_t (*get_position) (void *user_data);
 	void (*set_volume) (uint8_t volume, struct audio_device *dev,
 							void *user_data);
+	uint16_t (*get_player_id) (void *user_data);
+	uint16_t (*get_uid_counter) (void *user_data);
 };
 
 int avrcp_register(DBusConnection *conn, const bdaddr_t *src, GKeyFile *config);
diff --git a/audio/media.c b/audio/media.c
index cac2378..516f12e 100644
--- a/audio/media.c
+++ b/audio/media.c
@@ -106,6 +106,7 @@ struct media_player {
 	uint32_t		position;
 	uint8_t			volume;
 	uint16_t		id;
+	uint16_t		uid_counter;
 	GTimer			*timer;
 };
 
@@ -1398,6 +1399,20 @@ static void set_volume(uint8_t volume, struct audio_device *dev, void *user_data
 	}
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
 static void media_update_players(struct media_adapter *adapter)
 {
 	char **players;
@@ -1462,7 +1477,9 @@ static struct avrcp_player_cb player_cb = {
 	.get_metadata = get_metadata,
 	.get_position = get_position,
 	.get_status = get_status,
-	.set_volume = set_volume
+	.set_volume = set_volume,
+	.get_player_id = get_player_id,
+	.get_uid_counter = get_uid_counter
 };
 
 static void media_player_exit(DBusConnection *connection, void *user_data)
-- 
on behalf of ST-Ericsson

