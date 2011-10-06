Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 1/2] Fix not being able to unregister player via UnregisterPlayer
Date: Thu,  6 Oct 2011 18:35:16 +0300
Message-Id: <1317915317-2257-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 audio/media.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/audio/media.c b/audio/media.c
index 8d7b65b..a7866d2 100644
--- a/audio/media.c
+++ b/audio/media.c
@@ -855,7 +855,7 @@ static struct media_player *media_adapter_find_player(
 {
 	GSList *l;
 
-	for (l = adapter->endpoints; l; l = l->next) {
+	for (l = adapter->players; l; l = l->next) {
 		struct media_player *mp = l->data;
 
 		if (sender && g_strcmp0(mp->sender, sender) != 0)
-- 
1.7.6.4

