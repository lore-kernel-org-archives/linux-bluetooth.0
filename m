Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 6/9] player: Only emit PropertiesChanged for Position if track exists
Date: Wed, 27 Feb 2013 15:15:58 +0200
Message-Id: <1361970961-14300-7-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1361970961-14300-1-git-send-email-luiz.dentz@gmail.com>
References: <1361970961-14300-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 profiles/audio/player.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/profiles/audio/player.c b/profiles/audio/player.c
index e10cf0c..b7ecae9 100644
--- a/profiles/audio/player.c
+++ b/profiles/audio/player.c
@@ -813,6 +813,10 @@ void media_player_set_position(struct media_player *mp, uint32_t position)
 {
 	DBG("%u", position);
 
+	/* Only update duration if track exists */
+	if (g_hash_table_size(mp->track) == 0)
+		return;
+
 	mp->position = position;
 	g_timer_start(mp->progress);
 
-- 
1.8.1.2

