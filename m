Return-Path: <cyrus@holtmann.org>
From: Michal Labedzki <michal.labedzki@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <luiz.dentz@gmail.com>, <lucas.demarchi@profusion.mob>,
	<johan.hedberg@gmail.com>,
	Michal Labedzki <michal.labedzki@tieto.com>
Subject: [PATCH v2 14/14] AVRCP: Handle SetAddressedPlayer command from remote controller
Date: Wed, 27 Jun 2012 15:27:48 +0200
Message-ID: <1340803668-31686-14-git-send-email-michal.labedzki@tieto.com>
In-Reply-To: <1340803668-31686-1-git-send-email-michal.labedzki@tieto.com>
References: <1340803668-31686-1-git-send-email-michal.labedzki@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Set player selected by controller as addressed player.
---
 audio/avrcp.c |   33 +++++++++++++++++++++++++++++++++
 audio/avrcp.h |    1 +
 audio/media.c |   19 ++++++++++++++++++-
 3 files changed, 52 insertions(+), 1 deletion(-)

diff --git a/audio/avrcp.c b/audio/avrcp.c
index 7b2d6e0..9a1c8e1 100644
--- a/audio/avrcp.c
+++ b/audio/avrcp.c
@@ -1088,6 +1088,37 @@ err:
 	return AVC_CTYPE_REJECTED;
 }
 
+static uint8_t avrcp_handle_set_addressed_player(struct avrcp_player *player,
+							struct avrcp_header *pdu,
+							uint8_t transaction)
+{
+	uint16_t len = ntohs(pdu->params_len);
+	uint16_t player_id;
+
+	if (len != sizeof(player_id)) {
+		pdu->params[0] = STATUS_INVALID_PARAMETER;
+		return AVC_CTYPE_REJECTED;
+	}
+
+	player_id = bt_get_be16(pdu->params);
+
+	DBG("Remote controller set addressed player id=%u", player_id);
+
+	pdu->params_len = htons(1);
+
+	if (!player->cb->set_addressed_player(player_id, player->user_data)) {
+		if (g_slist_length(player->server->players) == 0)
+			pdu->params[0] = STATUS_NO_AVAILABLE_PLAYERS;
+		else
+			pdu->params[0] = STATUS_INVALID_PLAYER_ID;
+
+		return AVC_CTYPE_REJECTED;
+	}
+
+	pdu->params[0] = STATUS_OK;
+	return AVC_CTYPE_ACCEPTED;
+}
+
 static struct pdu_handler {
 	uint8_t pdu_id;
 	uint8_t code;
@@ -1123,6 +1154,8 @@ static struct pdu_handler {
 					avrcp_handle_request_continuing },
 		{ AVRCP_ABORT_CONTINUING, AVC_CTYPE_CONTROL,
 					avrcp_handle_abort_continuing },
+		{ AVRCP_SET_ADDRESSED_PLAYER, AVC_CTYPE_CONTROL,
+					avrcp_handle_set_addressed_player },
 		{ },
 };
 
diff --git a/audio/avrcp.h b/audio/avrcp.h
index 83e8563..04fbe5a 100644
--- a/audio/avrcp.h
+++ b/audio/avrcp.h
@@ -104,6 +104,7 @@ struct avrcp_player_cb {
 	gboolean (*is_dummy_player) (void *user_data);
 	uint16_t (*get_player_id) (void *user_data);
 	uint16_t (*get_uid_counter) (void *user_data);
+	gboolean (*set_addressed_player) (uint16_t player_id, void *user_data);
 };
 
 struct avrcp_player *player;
diff --git a/audio/media.c b/audio/media.c
index c99cde6..ee55a6b 100644
--- a/audio/media.c
+++ b/audio/media.c
@@ -120,6 +120,10 @@ struct metadata_value {
 
 static GSList *adapters = NULL;
 
+static gboolean media_set_addressed_player(struct media_adapter *adapter,
+					   const char *sender, const char *path,
+					   gboolean local);
+
 static void endpoint_request_free(struct endpoint_request *request)
 {
 	if (request->call)
@@ -1418,6 +1422,18 @@ static uint16_t get_uid_counter(void *user_data)
 	return mp->uid_counter;
 }
 
+static gboolean set_addressed_player(uint16_t player_id, void *user_data)
+{
+	struct media_player *player = user_data;
+	struct media_player *mp;
+
+	mp = media_adapter_find_player_by_id(player->adapter, NULL, player_id);
+	if (!mp)
+		return FALSE;
+
+	return media_set_addressed_player(player->adapter, player->sender, mp->path, FALSE);
+}
+
 static struct avrcp_player_cb player_cb = {
 	.get_setting = get_setting,
 	.set_setting = set_setting,
@@ -1429,7 +1445,8 @@ static struct avrcp_player_cb player_cb = {
 	.set_volume = set_volume,
 	.is_dummy_player = is_dummy_player,
 	.get_player_id = get_player_id,
-	.get_uid_counter = get_uid_counter
+	.get_uid_counter = get_uid_counter,
+	.set_addressed_player = set_addressed_player
 };
 
 static void media_player_exit(DBusConnection *connection, void *user_data)
-- 
on behalf of ST-Ericsson

