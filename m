Return-Path: <cyrus@holtmann.org>
From: Forrest Zhao <forrest.zhao@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: forrest.zhao@gmail.com, Forrest Zhao <forrest.zhao@intel.com>
Subject: [PATCH] in headset_init(), it's possible that hs->hfp_handle is not set, so we should not check hs->hfp_handle in headset_connect_cb()
Date: Wed,  6 May 2009 17:19:00 +0800
Message-Id: <1241601540-6540-1-git-send-email-forrest.zhao@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

We found this bug when developing the HFP plugin for telephonyd.

---
 audio/headset.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/audio/headset.c b/audio/headset.c
index 9f6b736..9b9be17 100644
--- a/audio/headset.c
+++ b/audio/headset.c
@@ -1304,8 +1304,7 @@ void headset_connect_cb(GIOChannel *chan, GError *err, gpointer user_data)
 	else
 		hs->auto_dc = FALSE;
 
-	if (server_is_enabled(&dev->src, HANDSFREE_SVCLASS_ID) &&
-			hs->hfp_handle != 0)
+	if (server_is_enabled(&dev->src, HANDSFREE_SVCLASS_ID))
 		hs->hfp_active = TRUE;
 	else
 		hs->hfp_active = FALSE;
-- 
1.5.4.5

