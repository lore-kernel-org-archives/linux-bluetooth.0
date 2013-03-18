Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/4] player: Check if values really changed before emitting signals
Date: Mon, 18 Mar 2013 10:14:38 -0300
Message-Id: <1363612480-8330-2-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1363612480-8330-1-git-send-email-luiz.dentz@gmail.com>
References: <1363612480-8330-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 profiles/audio/player.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/profiles/audio/player.c b/profiles/audio/player.c
index ece33cc..e08e373 100644
--- a/profiles/audio/player.c
+++ b/profiles/audio/player.c
@@ -938,6 +938,9 @@ void media_player_set_metadata(struct media_player *mp, const char *key,
 
 void media_player_set_type(struct media_player *mp, const char *type)
 {
+	if (g_strcmp0(mp->type, type) == 0)
+		return;
+
 	DBG("%s", type);
 
 	mp->type = g_strdup(type);
@@ -949,6 +952,9 @@ void media_player_set_type(struct media_player *mp, const char *type)
 
 void media_player_set_subtype(struct media_player *mp, const char *subtype)
 {
+	if (g_strcmp0(mp->subtype, subtype) == 0)
+		return;
+
 	DBG("%s", subtype);
 
 	mp->subtype = g_strdup(subtype);
@@ -960,6 +966,9 @@ void media_player_set_subtype(struct media_player *mp, const char *subtype)
 
 void media_player_set_name(struct media_player *mp, const char *name)
 {
+	if (g_strcmp0(mp->name, name) == 0)
+		return;
+
 	DBG("%s", name);
 
 	mp->name = g_strdup(name);
@@ -971,6 +980,9 @@ void media_player_set_name(struct media_player *mp, const char *name)
 
 void media_player_set_browsable(struct media_player *mp, bool enabled)
 {
+	if (mp->browsable == enabled)
+		return;
+
 	DBG("%s", enabled ? "true" : "false");
 
 	mp->browsable = enabled;
@@ -982,6 +994,9 @@ void media_player_set_browsable(struct media_player *mp, bool enabled)
 
 void media_player_set_searchable(struct media_player *mp, bool enabled)
 {
+	if (mp->browsable == enabled)
+		return;
+
 	DBG("%s", enabled ? "true" : "false");
 
 	mp->searchable = enabled;
@@ -1262,6 +1277,10 @@ int media_player_create_folder(struct media_player *mp, const char *name,
 {
 	struct media_item *item;
 
+	item = media_player_find_folder(mp, name);
+	if (item != NULL)
+		return 0;
+
 	item = media_player_create_item(mp, name,
 					PLAYER_ITEM_TYPE_FOLDER);
 	if (item == NULL)
-- 
1.8.1.4

