Return-Path: <cyrus@holtmann.org>
From: Radoslaw Jablonski <radoslawjablonski@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Radoslaw Jablonski <radoslawjablonski@gmail.com>
Subject: [PATCH] audio: Use headset_shutdown in headset_setconf_cb
Date: Fri, 23 Dec 2011 12:18:00 +0100
Message-Id: <1324639080-32467-1-git-send-email-radoslawjablonski@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

If pending connection will stay after state has been changed
to HEADSET_STATE_DISCONNECTED, then crash may happen (e.g. when
hs_connect will be called quickly again after that)
To avoid that kind of problems using headset_shutdown,
which does necessary cleanup first (finalizes pending connections)
and after that changes state to HEADSET_STATE_DISCONNECTED.
---
 audio/media.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/audio/media.c b/audio/media.c
index a2ef437..a363b8e 100644
--- a/audio/media.c
+++ b/audio/media.c
@@ -197,7 +197,7 @@ static void headset_setconf_cb(struct media_endpoint *endpoint, void *ret,
 	if (ret != NULL)
 		return;
 
-	headset_set_state(dev, HEADSET_STATE_DISCONNECTED);
+	headset_shutdown(dev);
 }
 
 static void clear_configuration(struct media_endpoint *endpoint)
-- 
1.7.0.4

