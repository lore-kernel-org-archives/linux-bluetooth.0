Return-Path: <cyrus@holtmann.org>
From: =?utf-8?q?Jo=C3=A3o=20Paulo=20Rechi=20Vita?= <jprvita@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: =?utf-8?q?Jo=C3=A3o=20Paulo=20Rechi=20Vita?= <jprvita@gmail.com>
Subject: [PATCH] Fix small typo
Date: Fri, 19 Jun 2009 16:08:49 -0300
Message-Id: <1245438529-16211-1-git-send-email-jprvita@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 audio/manager.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/audio/manager.c b/audio/manager.c
index d094c95..b60c34e 100644
--- a/audio/manager.c
+++ b/audio/manager.c
@@ -136,7 +136,7 @@ gboolean server_is_enabled(bdaddr_t *src, uint16_t svc)
 	case HEADSET_SVCLASS_ID:
 		return enabled.headset;
 	case HEADSET_AGW_SVCLASS_ID:
-		return  FALSE;
+		return FALSE;
 	case HANDSFREE_SVCLASS_ID:
 		return enabled.headset && enabled.hfp;
 	case HANDSFREE_AGW_SVCLASS_ID:
-- 
1.6.0.4

