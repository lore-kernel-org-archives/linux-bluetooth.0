Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 4/9] player: Fix not emitting PropertiesChanged for Browsable and Searchable
Date: Wed, 27 Feb 2013 15:15:56 +0200
Message-Id: <1361970961-14300-5-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1361970961-14300-1-git-send-email-luiz.dentz@gmail.com>
References: <1361970961-14300-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Browsable and Searchable should emit PropertiesChanged when their values
changes.
---
 profiles/audio/player.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/profiles/audio/player.c b/profiles/audio/player.c
index f026a51..44452ac 100644
--- a/profiles/audio/player.c
+++ b/profiles/audio/player.c
@@ -958,6 +958,10 @@ void media_player_set_browsable(struct media_player *mp, bool enabled)
 	DBG("%s", enabled ? "true" : "false");
 
 	mp->browsable = enabled;
+
+	g_dbus_emit_property_changed(btd_get_dbus_connection(),
+					mp->path, MEDIA_PLAYER_INTERFACE,
+					"Browsable");
 }
 
 void media_player_set_searchable(struct media_player *mp, bool enabled)
@@ -965,6 +969,10 @@ void media_player_set_searchable(struct media_player *mp, bool enabled)
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

