Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 1/4] audio/player: Fix checking wrong flag
Date: Thu, 18 Aug 2016 15:45:24 +0300
Message-Id: <1471524327-15455-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

media_player_set_searchable should check searchable flag not browsable.
---
 profiles/audio/player.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/profiles/audio/player.c b/profiles/audio/player.c
index 465bff5..9d638fc 100644
--- a/profiles/audio/player.c
+++ b/profiles/audio/player.c
@@ -1406,7 +1406,7 @@ void media_player_set_browsable(struct media_player *mp, bool enabled)
 
 void media_player_set_searchable(struct media_player *mp, bool enabled)
 {
-	if (mp->browsable == enabled)
+	if (mp->searchable == enabled)
 		return;
 
 	DBG("%s", enabled ? "true" : "false");
-- 
2.7.4

