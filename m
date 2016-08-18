Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 3/4] audio/avrcp: Don't send SetBrowsedPlayer if player is not browsable
Date: Thu, 18 Aug 2016 15:45:26 +0300
Message-Id: <1471524327-15455-3-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1471524327-15455-1-git-send-email-luiz.dentz@gmail.com>
References: <1471524327-15455-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

If player is not browsable the code should skip sending SetBrowsedPlayer.
---
 profiles/audio/avrcp.c  | 20 ++++++++++++++++++--
 profiles/audio/player.c |  5 +++++
 profiles/audio/player.h |  1 +
 3 files changed, 24 insertions(+), 2 deletions(-)

diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
index 90faa1d..21acee3 100644
--- a/profiles/audio/avrcp.c
+++ b/profiles/audio/avrcp.c
@@ -3194,14 +3194,30 @@ static const struct media_player_callback ct_cbs = {
 	.total_items = ct_get_total_numberofitems,
 };
 
+static void set_browsed_player(struct avrcp *session,
+					struct avrcp_player *player)
+{
+	if (!player || !player->id || player->browsed)
+		return;
+
+	if (media_player_get_browsable(player->user_data))
+		avrcp_set_browsed_player(session, player);
+}
+
 static void set_ct_player(struct avrcp *session, struct avrcp_player *player)
 {
 	struct btd_service *service;
 
+	if (session->controller->player == player)
+		goto done;
+
 	session->controller->player = player;
 	service = btd_device_get_service(session->dev, AVRCP_TARGET_UUID);
 	control_set_player(service, player ?
 			media_player_get_path(player->user_data) : NULL);
+
+done:
+	set_browsed_player(session, player);
 }
 
 static struct avrcp_player *create_ct_player(struct avrcp *session,
@@ -3304,8 +3320,8 @@ avrcp_parse_media_player_item(struct avrcp *session, uint8_t *operands,
 		media_player_set_name(mp, name);
 	}
 
-	if (session->controller->player == player && !player->browsed)
-		avrcp_set_browsed_player(session, player);
+	if (player->addressed)
+		set_browsed_player(session, player);
 
 	return player;
 }
diff --git a/profiles/audio/player.c b/profiles/audio/player.c
index 9d638fc..f1bd9de 100644
--- a/profiles/audio/player.c
+++ b/profiles/audio/player.c
@@ -1404,6 +1404,11 @@ void media_player_set_browsable(struct media_player *mp, bool enabled)
 					"Browsable");
 }
 
+bool media_player_get_browsable(struct media_player *mp)
+{
+	return mp->browsable;
+}
+
 void media_player_set_searchable(struct media_player *mp, bool enabled)
 {
 	if (mp->searchable == enabled)
diff --git a/profiles/audio/player.h b/profiles/audio/player.h
index 4ad8bfe..54e395a 100644
--- a/profiles/audio/player.h
+++ b/profiles/audio/player.h
@@ -85,6 +85,7 @@ void media_player_set_type(struct media_player *mp, const char *type);
 void media_player_set_subtype(struct media_player *mp, const char *subtype);
 void media_player_set_name(struct media_player *mp, const char *name);
 void media_player_set_browsable(struct media_player *mp, bool enabled);
+bool media_player_get_browsable(struct media_player *mp);
 void media_player_set_searchable(struct media_player *mp, bool enabled);
 void media_player_set_folder(struct media_player *mp, const char *path,
 								uint32_t items);
-- 
2.7.4

