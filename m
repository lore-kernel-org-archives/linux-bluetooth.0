Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/9] player: Add media_player_create_item
Date: Wed, 27 Feb 2013 15:15:54 +0200
Message-Id: <1361970961-14300-3-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1361970961-14300-1-git-send-email-luiz.dentz@gmail.com>
References: <1361970961-14300-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Items are not only folders so this split the item creation from
media_player_create_folder.
---
 profiles/audio/player.c | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/profiles/audio/player.c b/profiles/audio/player.c
index b222643..8401e19 100644
--- a/profiles/audio/player.c
+++ b/profiles/audio/player.c
@@ -1092,11 +1092,15 @@ static const GDBusPropertyTable media_item_properties[] = {
 	{ }
 };
 
-int media_player_create_folder(struct media_player *mp, const char *name)
+static struct media_item *media_player_create_item(struct media_player *mp,
+							const char *name,
+							bool folder,
+							bool playable)
 {
 	struct media_item *item;
 
-	DBG("%s", name);
+	DBG("%s folder %s playable %s", name, folder ? "true" : "false",
+						playable ? "true" : "false");
 
 	item = g_new0(struct media_item, 1);
 	item->player = mp;
@@ -1113,9 +1117,20 @@ int media_player_create_folder(struct media_player *mp, const char *name)
 		error("D-Bus failed to register %s on %s path",
 					MEDIA_ITEM_INTERFACE, item->path);
 		media_item_destroy(item);
-		return -EINVAL;
+		return NULL;
 	}
 
+	return item;
+}
+
+int media_player_create_folder(struct media_player *mp, const char *name)
+{
+	struct media_item *item;
+
+	item = media_player_create_item(mp, name, true, false);
+	if (item == NULL)
+		return -EINVAL;
+
 	if (mp->folder == NULL)
 		media_player_set_folder_item(mp, item, 0);
 
-- 
1.8.1.2

