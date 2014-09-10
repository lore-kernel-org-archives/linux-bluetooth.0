Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 1/2] core: Fix storing connection parameters without store hint set
Date: Wed, 10 Sep 2014 22:13:06 +0200
Message-Id: <1410379987-4265-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

If store hint is not set those should not be stored persistently.
---

I've decided to leave storing in adapter.c to keep it similar to new
keys events. Memebers in device.c were used only for storing anyway.

 src/adapter.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index 2192e90..92ee1a0 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -6308,10 +6308,8 @@ static void new_conn_param(uint16_t index, uint16_t length,
 		return;
 	}
 
-	if (!ev->store_hint) {
-		device_set_conn_param(dev, min, max, latency, timeout);
+	if (!ev->store_hint)
 		return;
-	}
 
 	store_conn_param(adapter, &ev->addr.bdaddr, ev->addr.type,
 					ev->min_interval, ev->max_interval,
-- 
1.9.3

