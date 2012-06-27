Return-Path: <cyrus@holtmann.org>
From: Michal Labedzki <michal.labedzki@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <luiz.dentz@gmail.com>, <lucas.demarchi@profusion.mob>,
	<johan.hedberg@gmail.com>,
	Michal Labedzki <michal.labedzki@tieto.com>
Subject: [PATCH v2 04/14] AVRCP: Use name "addressed" instead of "active"
Date: Wed, 27 Jun 2012 15:27:38 +0200
Message-ID: <1340803668-31686-4-git-send-email-michal.labedzki@tieto.com>
In-Reply-To: <1340803668-31686-1-git-send-email-michal.labedzki@tieto.com>
References: <1340803668-31686-1-git-send-email-michal.labedzki@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

AVRCP 1.4 named currently controlled player as "addressed", so use
this name instead of "active". In future there where be more "browsing"
player that will be active, but not addressed.
---
 audio/avrcp.c |   12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/audio/avrcp.c b/audio/avrcp.c
index da102b2..adcf30d 100644
--- a/audio/avrcp.c
+++ b/audio/avrcp.c
@@ -163,7 +163,7 @@ struct avrcp_server {
 	uint32_t tg_record_id;
 	uint32_t ct_record_id;
 	GSList *players;
-	struct avrcp_player *active_player;
+	struct avrcp_player *addressed_player;
 };
 
 struct pending_pdu {
@@ -1217,7 +1217,7 @@ static void state_changed(struct audio_device *dev, avctp_state_t old_state,
 	if (!server)
 		return;
 
-	player = server->active_player;
+	player = server->addressed_player;
 	if (!player)
 		return;
 
@@ -1410,7 +1410,7 @@ struct avrcp_player *avrcp_register_player(const bdaddr_t *src,
 	player->destroy = destroy;
 
 	if (!server->players)
-		server->active_player = player;
+		server->addressed_player = player;
 
 	if (!avctp_id)
 		avctp_id = avctp_add_state_cb(state_changed, NULL);
@@ -1426,8 +1426,8 @@ void avrcp_unregister_player(struct avrcp_player *player)
 
 	server->players = g_slist_remove(server->players, player);
 
-	if (server->active_player == player)
-		server->active_player = g_slist_nth_data(server->players, 0);
+	if (server->addressed_player == player)
+		server->addressed_player = g_slist_nth_data(server->players, 0);
 
 	player_destroy(player);
 }
@@ -1462,7 +1462,7 @@ int avrcp_set_volume(struct audio_device *dev, uint8_t volume)
 	if (server == NULL)
 		return -EINVAL;
 
-	player = server->active_player;
+	player = server->addressed_player;
 	if (player == NULL)
 		return -ENOTSUP;
 
-- 
on behalf of ST-Ericsson

