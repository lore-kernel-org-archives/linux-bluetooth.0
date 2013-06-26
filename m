Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] audio/player: Fix crash when current item UID is set to 0
Date: Wed, 26 Jun 2013 13:36:57 +0300
Message-Id: <1372243017-1461-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Apparently some stacks set the current UID to 0 when paused/stopped which
causes the following:

bluetoothd[23185]: profiles/audio/player.c:media_player_set_playlist_item() 0
bluetoothd[23185]: profiles/audio/player.c:media_folder_create_item() (null) type audio uid 0
process 23185: arguments to dbus_message_iter_append_basic() were incorrect, assertion "_dbus_check_is_valid_path (*string_p)" failed in file dbus-message.c line 2531.
This is normally a bug in some application using the D-Bus library.
  D-Bus not built with -rdynamic so unable to print a backtrace

UID 0 is not a valid UID according to the spec so the code should not attempt
to create any object to represent it.
---
 profiles/audio/player.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/profiles/audio/player.c b/profiles/audio/player.c
index 0834def..0c52ea9 100644
--- a/profiles/audio/player.c
+++ b/profiles/audio/player.c
@@ -1845,7 +1845,7 @@ struct media_item *media_player_set_playlist_item(struct media_player *mp,
 
 	DBG("%" PRIu64 "", uid);
 
-	if (folder == NULL)
+	if (folder == NULL || uid == 0)
 		return NULL;
 
 	item = media_folder_create_item(mp, folder, NULL,
-- 
1.8.1.4

