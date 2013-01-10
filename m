Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 7/8 v2] player: Remove experimental flag from MediaPlayer1
Date: Thu, 10 Jan 2013 15:24:36 +0200
Message-Id: <1357824283-19233-9-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1357824283-19233-1-git-send-email-luiz.dentz@gmail.com>
References: <1357824283-19233-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 doc/media-api.txt       |  2 +-
 profiles/audio/player.c | 21 +++++++--------------
 2 files changed, 8 insertions(+), 15 deletions(-)

diff --git a/doc/media-api.txt b/doc/media-api.txt
index 5a6b68c..12a2d7a 100644
--- a/doc/media-api.txt
+++ b/doc/media-api.txt
@@ -179,7 +179,7 @@ MediaPlayer1 hierarchy
 ======================
 
 Service		org.bluez (Controller role)
-Interface	org.bluez.MediaPlayer1 [Experimental]
+Interface	org.bluez.MediaPlayer1
 Object path	[variable prefix]/{hci0,hci1,...}/dev_XX_XX_XX_XX_XX_XX/playerX
 
 Methods		void Play()
diff --git a/profiles/audio/player.c b/profiles/audio/player.c
index 0b69912..81bb7fe 100644
--- a/profiles/audio/player.c
+++ b/profiles/audio/player.c
@@ -410,20 +410,13 @@ static const GDBusSignalTable media_player_signals[] = {
 };
 
 static const GDBusPropertyTable media_player_properties[] = {
-	{ "Position", "u", get_position, NULL, NULL,
-					G_DBUS_PROPERTY_FLAG_EXPERIMENTAL },
-	{ "Status", "s", get_status, NULL, status_exists,
-					G_DBUS_PROPERTY_FLAG_EXPERIMENTAL },
-	{ "Equalizer", "s", get_setting, set_setting, setting_exists,
-					G_DBUS_PROPERTY_FLAG_EXPERIMENTAL },
-	{ "Repeat", "s", get_setting, set_setting, setting_exists,
-					G_DBUS_PROPERTY_FLAG_EXPERIMENTAL },
-	{ "Shuffle", "s", get_setting, set_setting, setting_exists,
-					G_DBUS_PROPERTY_FLAG_EXPERIMENTAL },
-	{ "Scan", "s", get_setting, set_setting, setting_exists,
-					G_DBUS_PROPERTY_FLAG_EXPERIMENTAL },
-	{ "Track", "a{sv}", get_track, NULL, NULL,
-					G_DBUS_PROPERTY_FLAG_EXPERIMENTAL },
+	{ "Position", "u", get_position, NULL, NULL },
+	{ "Status", "s", get_status, NULL, status_exists },
+	{ "Equalizer", "s", get_setting, set_setting, setting_exists },
+	{ "Repeat", "s", get_setting, set_setting, setting_exists },
+	{ "Shuffle", "s", get_setting, set_setting, setting_exists },
+	{ "Scan", "s", get_setting, set_setting, setting_exists },
+	{ "Track", "a{sv}", get_track, NULL, NULL },
 	{ }
 };
 
-- 
1.8.0.1

