Return-Path: <cyrus@holtmann.org>
Message-Id: <20140323150754.030657558@linutronix.de>
Date: Sun, 23 Mar 2014 15:09:31 -0000
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Julia Lawall <Julia.Lawall@lip6.fr>,
 Andrew Morton <akpm@linux-foundation.org>,
 Marcel Holtmann <marcel@holtmann.org>, bt <linux-bluetooth@vger.kernel.org>
Subject: [patch 13/16] bt: hci-bcsp: Use del_timer_sync() in teardown path
References: <20140323150557.288925975@linutronix.de>
List-ID: <linux-bluetooth.vger.kernel.org>

Make sure no timer callback is running before freeing the
datastructure which contains it.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Marcel Holtmann <marcel@holtmann.org>
Cc: bt <linux-bluetooth@vger.kernel.org>
---
 drivers/bluetooth/hci_bcsp.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: tip/drivers/bluetooth/hci_bcsp.c
===================================================================
--- tip.orig/drivers/bluetooth/hci_bcsp.c
+++ tip/drivers/bluetooth/hci_bcsp.c
@@ -722,7 +722,7 @@ static int bcsp_close(struct hci_uart *h
 	skb_queue_purge(&bcsp->unack);
 	skb_queue_purge(&bcsp->rel);
 	skb_queue_purge(&bcsp->unrel);
-	del_timer(&bcsp->tbcsp);
+	del_timer_sync(&bcsp->tbcsp);
 
 	kfree(bcsp);
 	return 0;
