Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] AVRCP: Handler player features as a byte array
Date: Sun,  3 Feb 2013 22:55:10 +0200
Message-Id: <1359924910-27167-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This way we can direct match by byte which is how the spec represent
them.
---
 profiles/audio/avrcp.c  |  5 ++---
 profiles/audio/player.c | 16 ++++++++++++----
 profiles/audio/player.h |  2 +-
 3 files changed, 15 insertions(+), 8 deletions(-)

diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
index 00eeea1..20088e5 100644
--- a/profiles/audio/avrcp.c
+++ b/profiles/audio/avrcp.c
@@ -1983,7 +1983,7 @@ static void avrcp_parse_media_player_item(struct avrcp *session,
 	uint16_t id;
 	uint32_t subtype;
 	const char *curval, *strval;
-	uint64_t features[2];
+	uint8_t features[16];
 	char name[255];
 
 	if (len < 28)
@@ -2008,8 +2008,7 @@ static void avrcp_parse_media_player_item(struct avrcp *session,
 		avrcp_get_play_status(session);
 	}
 
-	features[0] = bt_get_be64(&operands[8]);
-	features[1] = bt_get_be64(&operands[16]);
+	memcpy(features, &operands[8], sizeof(features));
 
 	media_player_set_features(mp, features);
 
diff --git a/profiles/audio/player.c b/profiles/audio/player.c
index f875ee7..f1024ba 100644
--- a/profiles/audio/player.c
+++ b/profiles/audio/player.c
@@ -67,7 +67,7 @@ struct media_player {
 	char			*name;		/* Player name */
 	char			*type;		/* Player type */
 	char			*subtype;	/* Player subtype */
-	uint64_t		features[2];	/* Player features */
+	uint8_t			*features;	/* Player features */
 	struct media_folder	*folder;	/* Player currenct folder */
 	char			*path;		/* Player object path */
 	GHashTable		*settings;	/* Player settings */
@@ -644,6 +644,7 @@ void media_player_destroy(struct media_player *mp)
 	g_free(mp->subtype);
 	g_free(mp->type);
 	g_free(mp->name);
+	g_free(mp->features);
 	g_free(mp);
 }
 
@@ -870,11 +871,18 @@ void media_player_set_folder(struct media_player *mp, const char *path,
 	}
 }
 
-void media_player_set_features(struct media_player *mp, uint64_t *features)
+void media_player_set_features(struct media_player *mp, uint8_t *features)
 {
-	DBG("0x%016" PRIx64 "%016" PRIx64, features[0], features[1]);
+	DBG("0x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x"
+		"%02x", features[0], features[1], features[2], features[3],
+		features[4], features[5], features[6], features[7],
+		features[8], features[9], features[10], features[11],
+		features[12], features[13], features[14], features[15]);
 
-	memcpy(features, mp->features, sizeof(mp->features));
+	if (mp->features != NULL)
+		return;
+
+	mp->features = g_memdup(features, 16);
 }
 
 void media_player_set_callbacks(struct media_player *mp,
diff --git a/profiles/audio/player.h b/profiles/audio/player.h
index 1ac9800..efdae31 100644
--- a/profiles/audio/player.h
+++ b/profiles/audio/player.h
@@ -49,7 +49,7 @@ void media_player_set_metadata(struct media_player *mp, const char *key,
 						void *data, size_t len);
 void media_player_set_type(struct media_player *mp, const char *type);
 void media_player_set_subtype(struct media_player *mp, const char *subtype);
-void media_player_set_features(struct media_player *mp, uint64_t *features);
+void media_player_set_features(struct media_player *mp, uint8_t *features);
 void media_player_set_name(struct media_player *mp, const char *name);
 void media_player_set_folder(struct media_player *mp, const char *path,
 								uint32_t items);
-- 
1.8.1

