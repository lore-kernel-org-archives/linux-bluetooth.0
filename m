Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 4/7] AVRCP: Move features to avrcp.c
Date: Fri, 15 Feb 2013 16:02:49 +0200
Message-Id: <1360936972-12952-4-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1360936972-12952-1-git-send-email-luiz.dentz@gmail.com>
References: <1360936972-12952-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

avrcp.c should be responsible for specifics of AVRCP not player.c which
is more high level abstraction.
---
 profiles/audio/avrcp.c  | 4 ++++
 profiles/audio/player.c | 8 --------
 profiles/audio/player.h | 1 -
 3 files changed, 4 insertions(+), 9 deletions(-)

diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
index cabe2ee..55887bc 100644
--- a/profiles/audio/avrcp.c
+++ b/profiles/audio/avrcp.c
@@ -180,6 +180,7 @@ struct avrcp_player {
 	GSList *sessions;
 	uint16_t id;
 	uint16_t uid_counter;
+	uint8_t *features;
 
 	struct avrcp_player_cb *cb;
 	void *user_data;
@@ -1981,6 +1982,8 @@ static void avrcp_player_parse_features(struct avrcp_player *player,
 {
 	struct media_player *mp = player->user_data;
 
+	player->features = g_memdup(features, 16);
+
 	if (features[7] & 0x08)
 		media_player_set_browsable(mp, true);
 
@@ -2553,6 +2556,7 @@ static void player_destroy(gpointer data)
 		player->destroy(player->user_data);
 
 	g_slist_free(player->sessions);
+	g_free(player->features);
 	g_free(player);
 }
 
diff --git a/profiles/audio/player.c b/profiles/audio/player.c
index 7879193..07fd457 100644
--- a/profiles/audio/player.c
+++ b/profiles/audio/player.c
@@ -69,7 +69,6 @@ struct media_player {
 	char			*subtype;	/* Player subtype */
 	bool			browsable;	/* Player browsing feature */
 	bool			searchable;	/* Player searching feature */
-	uint8_t			*features;	/* Player features */
 	struct media_folder	*folder;	/* Player currenct folder */
 	char			*path;		/* Player object path */
 	GHashTable		*settings;	/* Player settings */
@@ -941,13 +940,6 @@ void media_player_set_folder(struct media_player *mp, const char *path,
 	}
 }
 
-void media_player_set_features(struct media_player *mp, uint64_t *features)
-{
-	DBG("0x%016" PRIx64 "%016" PRIx64, features[0], features[1]);
-
-	memcpy(features, mp->features, sizeof(mp->features));
-}
-
 void media_player_set_callbacks(struct media_player *mp,
 				const struct media_player_callback *cbs,
 				void *user_data)
diff --git a/profiles/audio/player.h b/profiles/audio/player.h
index e9a7d1c..9109b1f 100644
--- a/profiles/audio/player.h
+++ b/profiles/audio/player.h
@@ -49,7 +49,6 @@ void media_player_set_metadata(struct media_player *mp, const char *key,
 						void *data, size_t len);
 void media_player_set_type(struct media_player *mp, const char *type);
 void media_player_set_subtype(struct media_player *mp, const char *subtype);
-void media_player_set_features(struct media_player *mp, uint64_t *features);
 void media_player_set_name(struct media_player *mp, const char *name);
 void media_player_set_browsable(struct media_player *mp, bool enabled);
 void media_player_set_searchable(struct media_player *mp, bool enabled);
-- 
1.8.1.2

