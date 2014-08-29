Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] android/health: Fix incorrect check
Date: Fri, 29 Aug 2014 14:24:21 +0300
Message-Id: <1409311461-21935-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

"!create_mdl(channel) < 0" is always false since it returns bool
---
 android/health.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/android/health.c b/android/health.c
index abf01b4..fb2a1e3 100644
--- a/android/health.c
+++ b/android/health.c
@@ -1949,7 +1949,7 @@ static void bt_health_connect_channel(const void *buf, uint16_t len)
 			goto fail;
 
 		/* create mdl if it does not exists */
-		if (!channel->mdl && !create_mdl(channel) < 0)
+		if (!channel->mdl && !create_mdl(channel))
 			goto fail;
 
 		/* reconnect mdl if it exists */
-- 
1.9.1

