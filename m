Return-Path: <cyrus@holtmann.org>
Message-Id: <20140323150753.911346180@linutronix.de>
Date: Sun, 23 Mar 2014 15:09:31 -0000
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Julia Lawall <Julia.Lawall@lip6.fr>,
 Andrew Morton <akpm@linux-foundation.org>,
 Marcel Holtmann <marcel@holtmann.org>, bt <linux-bluetooth@vger.kernel.org>
Subject: [patch 12/16] bt: bluecard: Use del_timer_sync() in teardown path
References: <20140323150557.288925975@linutronix.de>
List-ID: <linux-bluetooth.vger.kernel.org>

Make sure no timer callback is running before releasing the
datastructure which contains it.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Marcel Holtmann <marcel@holtmann.org>
Cc: bt <linux-bluetooth@vger.kernel.org>
---
 drivers/bluetooth/bluecard_cs.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: tip/drivers/bluetooth/bluecard_cs.c
===================================================================
--- tip.orig/drivers/bluetooth/bluecard_cs.c
+++ tip/drivers/bluetooth/bluecard_cs.c
@@ -898,7 +898,7 @@ static void bluecard_release(struct pcmc
 
 	bluecard_close(info);
 
-	del_timer(&(info->timer));
+	del_timer_sync(&(info->timer));
 
 	pcmcia_disable_device(link);
 }
