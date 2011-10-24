Return-Path: <cyrus@holtmann.org>
From: David Herrmann <dh.herrmann@googlemail.com>
To: linux-bluetooth@vger.kernel.org
Cc: padovan@profusion.mobi, David Herrmann <dh.herrmann@googlemail.com>
Subject: [PATCH 2/2] Bluetooth: Replace rfcomm tty tasklet by workqueue
Date: Mon, 24 Oct 2011 15:30:58 +0200
Message-Id: <1319463058-29311-2-git-send-email-dh.herrmann@googlemail.com>
In-Reply-To: <1319463058-29311-1-git-send-email-dh.herrmann@googlemail.com>
References: <1319463058-29311-1-git-send-email-dh.herrmann@googlemail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Remove old tasklets and replace by workqueue. To avoid reentrancy (which
tasklets always avoid) we use the system_nrt_wq.

Signed-off-by: David Herrmann <dh.herrmann@googlemail.com>
---
 net/bluetooth/rfcomm/tty.c |   16 +++++++++-------
 1 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/net/bluetooth/rfcomm/tty.c b/net/bluetooth/rfcomm/tty.c
index 2b753a3..947f1b3 100644
--- a/net/bluetooth/rfcomm/tty.c
+++ b/net/bluetooth/rfcomm/tty.c
@@ -34,6 +34,7 @@
 #include <linux/capability.h>
 #include <linux/slab.h>
 #include <linux/skbuff.h>
+#include <linux/workqueue.h>
 
 #include <net/bluetooth/bluetooth.h>
 #include <net/bluetooth/hci_core.h>
@@ -65,7 +66,7 @@ struct rfcomm_dev {
 	struct rfcomm_dlc	*dlc;
 	struct tty_struct	*tty;
 	wait_queue_head_t       wait;
-	struct tasklet_struct   wakeup_task;
+	struct work_struct	wakeup_task;
 
 	struct device		*tty_dev;
 
@@ -81,7 +82,7 @@ static void rfcomm_dev_data_ready(struct rfcomm_dlc *dlc, struct sk_buff *skb);
 static void rfcomm_dev_state_change(struct rfcomm_dlc *dlc, int err);
 static void rfcomm_dev_modem_status(struct rfcomm_dlc *dlc, u8 v24_sig);
 
-static void rfcomm_tty_wakeup(unsigned long arg);
+static void rfcomm_tty_wakeup(struct work_struct *work);
 
 /* ---- Device functions ---- */
 static void rfcomm_dev_destruct(struct rfcomm_dev *dev)
@@ -257,7 +258,7 @@ static int rfcomm_dev_add(struct rfcomm_dev_req *req, struct rfcomm_dlc *dlc)
 	atomic_set(&dev->opened, 0);
 
 	init_waitqueue_head(&dev->wait);
-	tasklet_init(&dev->wakeup_task, rfcomm_tty_wakeup, (unsigned long) dev);
+	INIT_WORK(&dev->wakeup_task, rfcomm_tty_wakeup);
 
 	skb_queue_head_init(&dev->pending);
 
@@ -351,7 +352,7 @@ static void rfcomm_wfree(struct sk_buff *skb)
 	struct rfcomm_dev *dev = (void *) skb->sk;
 	atomic_sub(skb->truesize, &dev->wmem_alloc);
 	if (test_bit(RFCOMM_TTY_ATTACHED, &dev->flags))
-		tasklet_schedule(&dev->wakeup_task);
+		queue_work(system_nrt_wq, &dev->wakeup_task);
 	rfcomm_dev_put(dev);
 }
 
@@ -635,9 +636,10 @@ static void rfcomm_dev_modem_status(struct rfcomm_dlc *dlc, u8 v24_sig)
 }
 
 /* ---- TTY functions ---- */
-static void rfcomm_tty_wakeup(unsigned long arg)
+static void rfcomm_tty_wakeup(struct work_struct *work)
 {
-	struct rfcomm_dev *dev = (void *) arg;
+	struct rfcomm_dev *dev = container_of(work, struct rfcomm_dev,
+								wakeup_task);
 	struct tty_struct *tty = dev->tty;
 	if (!tty)
 		return;
@@ -762,7 +764,7 @@ static void rfcomm_tty_close(struct tty_struct *tty, struct file *filp)
 		rfcomm_dlc_close(dev->dlc, 0);
 
 		clear_bit(RFCOMM_TTY_ATTACHED, &dev->flags);
-		tasklet_kill(&dev->wakeup_task);
+		cancel_work_sync(&dev->wakeup_task);
 
 		rfcomm_dlc_lock(dev->dlc);
 		tty->driver_data = NULL;
-- 
1.7.7

