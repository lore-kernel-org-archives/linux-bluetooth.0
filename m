Return-Path: <baijiaju1990@gmail.com>
From: Jia-Ju Bai <baijiaju1990@gmail.com>
To: marcel@holtmann.org,
	gustavo@padovan.org,
	johan.hedberg@gmail.com
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH] bluecard: Fix a possible sleep-in-atomic bug in bluecard_write_wakeup
Date: Wed, 13 Dec 2017 17:28:04 +0800
Message-Id: <1513157284-13659-1-git-send-email-baijiaju1990@gmail.com>
List-ID: <linux-bluetooth.vger.kernel.org>

The driver may sleep in the interrupt handler.
The function call path is:
bluecard_interrupt (interrupt handler)
  bluecard_write_wakeup
    schedule_timeout --> may sleep

To fix it, schedule_timeout is replaced with mdelay.

This bug is found by my static analysis tool(DSAC) and checked by my code review.

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
 drivers/bluetooth/bluecard_cs.c |    8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/bluetooth/bluecard_cs.c b/drivers/bluetooth/bluecard_cs.c
index d513ef4..82437a6 100644
--- a/drivers/bluetooth/bluecard_cs.c
+++ b/drivers/bluetooth/bluecard_cs.c
@@ -302,9 +302,7 @@ static void bluecard_write_wakeup(struct bluecard_info *info)
 			}
 
 			/* Wait until the command reaches the baseband */
-			prepare_to_wait(&wq, &wait, TASK_INTERRUPTIBLE);
-			schedule_timeout(HZ/10);
-			finish_wait(&wq, &wait);
+			mdelay(100);
 
 			/* Set baud on baseband */
 			info->ctrl_reg &= ~0x03;
@@ -316,9 +314,7 @@ static void bluecard_write_wakeup(struct bluecard_info *info)
 			outb(info->ctrl_reg, iobase + REG_CONTROL);
 
 			/* Wait before the next HCI packet can be send */
-			prepare_to_wait(&wq, &wait, TASK_INTERRUPTIBLE);
-			schedule_timeout(HZ);
-			finish_wait(&wq, &wait);
+			mdelay(1000);
 		}
 
 		if (len == skb->len) {
-- 
1.7.9.5
