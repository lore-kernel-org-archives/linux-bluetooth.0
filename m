Return-Path: <cyrus@holtmann.org>
Message-Id: <20140323150754.149547016@linutronix.de>
Date: Sun, 23 Mar 2014 15:09:32 -0000
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Julia Lawall <Julia.Lawall@lip6.fr>,
 Andrew Morton <akpm@linux-foundation.org>,
 Marcel Holtmann <marcel@holtmann.org>, bt <linux-bluetooth@vger.kernel.org>
Subject: [patch 14/16] bt: hci-h5: Use del_timer_sync() in exit path
References: <20140323150557.288925975@linutronix.de>
List-ID: <linux-bluetooth.vger.kernel.org>

Make sure no timer callback is running before releasing the
datastructure which contains it.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Marcel Holtmann <marcel@holtmann.org>
Cc: bt <linux-bluetooth@vger.kernel.org>
---
 drivers/bluetooth/hci_h5.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: tip/drivers/bluetooth/hci_h5.c
===================================================================
--- tip.orig/drivers/bluetooth/hci_h5.c
+++ tip/drivers/bluetooth/hci_h5.c
@@ -210,7 +210,7 @@ static int h5_close(struct hci_uart *hu)
 	skb_queue_purge(&h5->rel);
 	skb_queue_purge(&h5->unrel);
 
-	del_timer(&h5->timer);
+	del_timer_sync(&h5->timer);
 
 	kfree(h5);
 
