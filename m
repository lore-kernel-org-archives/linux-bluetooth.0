Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] audio/player: Fix overflowing position
Date: Wed, 31 Jul 2013 14:27:52 +0300
Message-Id: <1375270072-13140-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

The position should stop at UINT32_MAX after that the progress can no
longer be calculated, this should also prevent the position to change
when the remote stack doesn't support it which is also indicated with
UINT32_MAX which apparently is the case of Spotify on Android 4.3:

[CHG] Player /org/bluez/hci0/dev_XX_XX_XX_XX_XX_XX/player0 Position: 0xffffffff
[CHG] Player /org/bluez/hci0/dev_XX_XX_XX_XX_XX_XX/player0 Status: playing
[CHG] Player /org/bluez/hci0/dev_XX_XX_XX_XX_XX_XX/player0 Position: 0x000000
---
 profiles/audio/player.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/profiles/audio/player.c b/profiles/audio/player.c
index ce5e75b..6150c8a 100644
--- a/profiles/audio/player.c
+++ b/profiles/audio/player.c
@@ -151,7 +151,8 @@ static uint32_t media_player_get_position(struct media_player *mp)
 	double timedelta;
 	uint32_t sec, msec;
 
-	if (g_strcmp0(mp->status, "playing") != 0)
+	if (g_strcmp0(mp->status, "playing") != 0 ||
+						mp->position == UINT32_MAX)
 		return mp->position;
 
 	timedelta = g_timer_elapsed(mp->progress, NULL);
-- 
1.8.3.1

