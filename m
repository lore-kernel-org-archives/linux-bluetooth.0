Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 07/10 v4] player: Only emit PropertiesChanged for Position if track exists
Date: Mon,  4 Mar 2013 10:06:07 +0200
Message-Id: <1362384369-20709-8-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1362384369-20709-1-git-send-email-luiz.dentz@gmail.com>
References: <1362384369-20709-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 profiles/audio/player.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/profiles/audio/player.c b/profiles/audio/player.c
index 6a73e8b..b12d6fb 100644
--- a/profiles/audio/player.c
+++ b/profiles/audio/player.c
@@ -814,6 +814,10 @@ void media_player_set_position(struct media_player *mp, uint32_t position)
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

