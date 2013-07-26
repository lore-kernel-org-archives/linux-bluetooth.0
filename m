Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] audio/player: Fix not setting playlist items as playable
Date: Fri, 26 Jul 2013 16:24:00 +0300
Message-Id: <1374845040-17563-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

All items in the playlist should have playable flag set otherwise they
cannot be part of the playlist.
---
 profiles/audio/player.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/profiles/audio/player.c b/profiles/audio/player.c
index a817b54..ce5e75b 100644
--- a/profiles/audio/player.c
+++ b/profiles/audio/player.c
@@ -1874,6 +1874,8 @@ struct media_item *media_player_set_playlist_item(struct media_player *mp,
 	if (item == NULL)
 		return NULL;
 
+	media_item_set_playable(item, true);
+
 	if (mp->track != item->metadata) {
 		g_hash_table_unref(mp->track);
 		mp->track = g_hash_table_ref(item->metadata);
-- 
1.8.3.1

