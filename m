Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 01/10 v3] player: Fix property Device type
Date: Thu, 28 Feb 2013 16:47:02 +0200
Message-Id: <1362062830-24549-2-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1362062830-24549-1-git-send-email-luiz.dentz@gmail.com>
References: <1362062830-24549-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Device property should be an objecy path not a string.
---
 profiles/audio/player.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/profiles/audio/player.c b/profiles/audio/player.c
index 466b44a..b222643 100644
--- a/profiles/audio/player.c
+++ b/profiles/audio/player.c
@@ -290,7 +290,8 @@ static gboolean get_device(const GDBusPropertyTable *property,
 {
 	struct media_player *mp = data;
 
-	dbus_message_iter_append_basic(iter, DBUS_TYPE_STRING, &mp->device);
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_OBJECT_PATH,
+								&mp->device);
 
 	return TRUE;
 }
@@ -570,7 +571,7 @@ static const GDBusPropertyTable media_player_properties[] = {
 					G_DBUS_PROPERTY_FLAG_EXPERIMENTAL },
 	{ "Track", "a{sv}", get_track, NULL, NULL,
 					G_DBUS_PROPERTY_FLAG_EXPERIMENTAL },
-	{ "Device", "s", get_device, NULL, NULL,
+	{ "Device", "o", get_device, NULL, NULL,
 					G_DBUS_PROPERTY_FLAG_EXPERIMENTAL },
 	{ "Browsable", "b", get_browsable, NULL, browsable_exists,
 					G_DBUS_PROPERTY_FLAG_EXPERIMENTAL },
-- 
1.8.1.2

