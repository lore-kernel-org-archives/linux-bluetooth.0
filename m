Return-Path: <nacc@us.ibm.com>
Date: Mon, 28 Feb 2005 10:58:34 -0800
From: Nishanth Aravamudan <nacc@us.ibm.com>
To: marcel@holtmann.org, maxk@qualcomm.com
Cc: bluez-devel@lists.sourceforge.net, kernel-janitors@lists.osdl.org
Subject: [PATCH] bluetooth/bluecard_cs: remove interruptible_sleep_on_timeout() usage
Message-ID: <20050228185834.GB3261@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-ID: <bluez-devel.lists.sourceforge.net>

Hello,

This patch should not have the oops problems that the original did.
Marcel, please test when you get the chance.

Thanks,
Nish



Description: Remove deprecated interruptible_sleep_on_timeout() function calls
and replace with direct wait-queue usage. Some naming conflicts occurred, which
I tried to resolve appropriately. Patch is compile-tested.

Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>

--- 2.6.11-rc5-v/drivers/bluetooth/bluecard_cs.c	2005-02-28 10:26:08.000000000 -0800
+++ 2.6.11-rc5/drivers/bluetooth/bluecard_cs.c	2005-02-28 10:56:32.000000000 -0800
@@ -35,6 +35,7 @@
 #include <linux/ioport.h>
 #include <linux/spinlock.h>
 #include <linux/moduleparam.h>
+#include <linux/wait.h>
 
 #include <linux/skbuff.h>
 #include <asm/io.h>
@@ -289,8 +290,9 @@ static void bluecard_write_wakeup(blueca
 		clear_bit(ready_bit, &(info->tx_state));
 
 		if (skb->pkt_type & 0x80) {
+			DECLARE_WAIT_QUEUE_HEAD(wq);
+			DEFINE_WAIT(wait);
 
-			wait_queue_head_t wait;
 			unsigned char baud_reg;
 
 			switch (skb->pkt_type) {
@@ -311,8 +313,9 @@ static void bluecard_write_wakeup(blueca
 			}
 
 			/* Wait until the command reaches the baseband */
-			init_waitqueue_head(&wait);
-			interruptible_sleep_on_timeout(&wait, HZ / 10);
+			prepare_to_wait(&wq, &wait, TASK_INTERRUPTIBLE);
+			schedule_timeout(HZ/10);
+			finish_wait(&wq, &wait);
 
 			/* Set baud on baseband */
 			info->ctrl_reg &= ~0x03;
@@ -324,8 +327,9 @@ static void bluecard_write_wakeup(blueca
 			outb(info->ctrl_reg, iobase + REG_CONTROL);
 
 			/* Wait before the next HCI packet can be send */
-			interruptible_sleep_on_timeout(&wait, HZ);
-
+			prepare_to_wait(&wq, &wait, TASK_INTERRUPTIBLE);
+			schedule_timeout(HZ);
+			finish_wait(&wq, &wait);
 		}
 
 		if (len == skb->len) {
