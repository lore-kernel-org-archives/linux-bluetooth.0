Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] AVRCP: Fix crash when MediaPlayer1 is disabled
Date: Fri, 11 Jan 2013 16:19:09 +0200
Message-Id: <1357913949-27785-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

When MediaPlayer1 is disabled we should not proceed with getting
remote capabilities but switch back to 1.0 mode.
---
 profiles/audio/avrcp.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
index d0cc346..ef324b0 100644
--- a/profiles/audio/avrcp.c
+++ b/profiles/audio/avrcp.c
@@ -2178,11 +2178,12 @@ static void session_ct_init(struct avrcp *session)
 	path = device_get_path(session->dev->btd_dev);
 
 	mp = media_player_controller_create(path);
-	if (mp != NULL) {
-		media_player_set_callbacks(mp, &ct_cbs, player);
-		player->user_data = mp;
-		player->destroy = (GDestroyNotify) media_player_destroy;
-	}
+	if (mp == NULL)
+		return;
+
+	media_player_set_callbacks(mp, &ct_cbs, player);
+	player->user_data = mp;
+	player->destroy = (GDestroyNotify) media_player_destroy;
 
 	if (session->version < 0x0103)
 		return;
-- 
1.8.0.1

