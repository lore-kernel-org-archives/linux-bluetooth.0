Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 1/3] audio/media: Fix notifying settings changed incorrectly
Date: Sun, 16 Jun 2013 20:01:23 +0300
Message-Id: <1371402085-30762-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

We should notify only the setting that has changed not all of them.
---
 profiles/audio/media.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/profiles/audio/media.c b/profiles/audio/media.c
index eb5ea81..69139a7 100644
--- a/profiles/audio/media.c
+++ b/profiles/audio/media.c
@@ -1480,7 +1480,7 @@ static gboolean set_property(struct media_player *mp, const char *key,
 
 	g_hash_table_replace(mp->settings, g_strdup(key), g_strdup(value));
 
-	settings = list_settings(mp);
+	settings = g_list_prepend(NULL, (char *) key);
 
 	avrcp_player_event(mp->player, AVRCP_EVENT_SETTINGS_CHANGED, settings);
 
-- 
1.8.1.4

