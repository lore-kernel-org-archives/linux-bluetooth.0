Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 7/9 v2] player: Only expose Track property if there is metadata
Date: Thu, 28 Feb 2013 14:22:06 +0200
Message-Id: <1362054128-20569-8-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1362054128-20569-1-git-send-email-luiz.dentz@gmail.com>
References: <1362054128-20569-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

If no metadata is set there is no point in exposing it.
---
 profiles/audio/player.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/profiles/audio/player.c b/profiles/audio/player.c
index 9d0d5d7..66ad538 100644
--- a/profiles/audio/player.c
+++ b/profiles/audio/player.c
@@ -267,6 +267,13 @@ static void set_setting(const GDBusPropertyTable *property,
 	player_set_setting(mp, id, property->name, value);
 }
 
+static gboolean track_exists(const GDBusPropertyTable *property, void *data)
+{
+	struct media_player *mp = data;
+
+	return g_hash_table_size(mp->track) != 0;
+}
+
 static gboolean get_track(const GDBusPropertyTable *property,
 					DBusMessageIter *iter, void *data)
 {
@@ -594,7 +601,7 @@ static const GDBusPropertyTable media_player_properties[] = {
 					G_DBUS_PROPERTY_FLAG_EXPERIMENTAL },
 	{ "Scan", "s", get_setting, set_setting, setting_exists,
 					G_DBUS_PROPERTY_FLAG_EXPERIMENTAL },
-	{ "Track", "a{sv}", get_track, NULL, NULL,
+	{ "Track", "a{sv}", get_track, NULL, track_exists,
 					G_DBUS_PROPERTY_FLAG_EXPERIMENTAL },
 	{ "Device", "o", get_device, NULL, NULL,
 					G_DBUS_PROPERTY_FLAG_EXPERIMENTAL },
-- 
1.8.1.2

