Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: szymon.janc@tieto.com
Subject: [PATCH] Fix GLib assertion failure in media.c get_setting()
Date: Thu,  2 Feb 2012 23:21:19 +0100
Message-Id: <1328221279-26319-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

If get_setting is called before set_setting, mp->settings would be
NULL resulting in GLib assertion. Hashmap is now allocated in
media_player_create instead of on-demand allocation in set_setting.

external/bluetooth/bluez/audio/media.c:get_setting() Equalizer
CRITICAL **: g_hash_table_lookup: assertion `hash_table != NULL' failed
---
 audio/media.c |    5 ++---
 1 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/audio/media.c b/audio/media.c
index a363b8e..c0fd0c3 100644
--- a/audio/media.c
+++ b/audio/media.c
@@ -1371,9 +1371,6 @@ static gboolean set_property(struct media_player *mp, const char *key,
 
 	DBG("%s=%s", key, value);
 
-	if (!mp->settings)
-		mp->settings = g_hash_table_new(g_direct_hash, g_direct_equal);
-
 	g_hash_table_replace(mp->settings, GUINT_TO_POINTER(attr),
 						GUINT_TO_POINTER(val));
 
@@ -1595,6 +1592,8 @@ static struct media_player *media_player_create(struct media_adapter *adapter,
 		return NULL;
 	}
 
+	mp->settings = g_hash_table_new(g_direct_hash, g_direct_equal);
+
 	adapter->players = g_slist_append(adapter->players, mp);
 
 	info("Player registered: sender=%s path=%s", sender, path);
-- 
on behalf of ST-Ericsson


