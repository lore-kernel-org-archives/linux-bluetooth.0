Return-Path: <geliangtang@gmail.com>
From: Geliang Tang <geliangtang@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	Gustavo Padovan <gustavo@padovan.org>,
	Johan Hedberg <johan.hedberg@gmail.com>
Cc: Geliang Tang <geliangtang@gmail.com>,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] Bluetooth: bluecard: use setup_timer
Date: Sat, 11 Mar 2017 08:46:58 +0800
Message-Id: <e0af154c08327dbf266e641b135e4ef340913feb.1489061552.git.geliangtang@gmail.com>
In-Reply-To: <3afa5498142ef68256023257dad37b9f8352e65e.1489060803.git.geliangtang@gmail.com>
References: <3afa5498142ef68256023257dad37b9f8352e65e.1489060803.git.geliangtang@gmail.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Use setup_timer() instead of init_timer() to simplify the code.

Signed-off-by: Geliang Tang <geliangtang@gmail.com>
---
 drivers/bluetooth/bluecard_cs.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/bluetooth/bluecard_cs.c b/drivers/bluetooth/bluecard_cs.c
index c0b3b55..007c0a4 100644
--- a/drivers/bluetooth/bluecard_cs.c
+++ b/drivers/bluetooth/bluecard_cs.c
@@ -695,9 +695,8 @@ static int bluecard_open(struct bluecard_info *info)
 
 	spin_lock_init(&(info->lock));
 
-	init_timer(&(info->timer));
-	info->timer.function = &bluecard_activity_led_timeout;
-	info->timer.data = (u_long)info;
+	setup_timer(&(info->timer), &bluecard_activity_led_timeout,
+		    (u_long)info);
 
 	skb_queue_head_init(&(info->txq));
 
-- 
2.9.3
