Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 4/9 v2] player: Fix not emitting PropertiesChanged for Browsable and Searchable
Date: Thu, 28 Feb 2013 14:22:03 +0200
Message-Id: <1362054128-20569-5-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1362054128-20569-1-git-send-email-luiz.dentz@gmail.com>
References: <1362054128-20569-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Browsable and Searchable should emit PropertiesChanged when their values
changes.
---
 profiles/audio/player.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/profiles/audio/player.c b/profiles/audio/player.c
index a8d18c1..c446cca 100644
--- a/profiles/audio/player.c
+++ b/profiles/audio/player.c
@@ -961,6 +961,10 @@ void media_player_set_browsable(struct media_player *mp, bool enabled)
 	DBG("%s", enabled ? "true" : "false");
 
 	mp->browsable = enabled;
+
+	g_dbus_emit_property_changed(btd_get_dbus_connection(),
+					mp->path, MEDIA_PLAYER_INTERFACE,
+					"Browsable");
 }
 
 void media_player_set_searchable(struct media_player *mp, bool enabled)
@@ -968,6 +972,10 @@ void media_player_set_searchable(struct media_player *mp, bool enabled)
 	DBG("%s", enabled ? "true" : "false");
 
 	mp->searchable = enabled;
+
+	g_dbus_emit_property_changed(btd_get_dbus_connection(),
+					mp->path, MEDIA_PLAYER_INTERFACE,
+					"Searchable");
 }
 
 static void media_player_set_folder_item(struct media_player *mp,
-- 
1.8.1.2

