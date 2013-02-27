Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 7/9] player: Only expose Track property if there is metadata
Date: Wed, 27 Feb 2013 15:15:59 +0200
Message-Id: <1361970961-14300-8-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1361970961-14300-1-git-send-email-luiz.dentz@gmail.com>
References: <1361970961-14300-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

If no metadata is set there is no point in exposing it.
---
 profiles/audio/player.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/profiles/audio/player.c b/profiles/audio/player.c
index b7ecae9..6a316ae 100644
--- a/profiles/audio/player.c
+++ b/profiles/audio/player.c
@@ -266,6 +266,13 @@ static void set_setting(const GDBusPropertyTable *property,
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
@@ -593,7 +600,7 @@ static const GDBusPropertyTable media_player_properties[] = {
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

