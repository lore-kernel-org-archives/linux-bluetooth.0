Return-Path: <baijiaju1990@gmail.com>
From: Jia-Ju Bai <baijiaju1990@gmail.com>
To: marcel@holtmann.org,
	gustavo@padovan.org,
	johan.hedberg@gmail.com
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH] bluetooth: hci_ath: Replace mdelay with msleep in ath_wakeup_ar3k
Date: Sat, 27 Jan 2018 18:17:38 +0800
Message-Id: <1517048258-23798-1-git-send-email-baijiaju1990@gmail.com>
List-ID: <linux-bluetooth.vger.kernel.org>

ath_wakeup_ar3k() is never called from atomic context.

It is only called by ath_hci_uart_work() that is only called in 
ath_open() via INIT_WORK().
All of the above functions do not enter atomic context along the way.

Despite never getting called from atomic context, ath_wakeup_ar3k() calls
mdelay() for busy wait.
That is not necessary and can be replaced with msleep to avoid busy wait.

This is found by a static analysis tool named DCNS written by myself.

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
 drivers/bluetooth/hci_ath.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/bluetooth/hci_ath.c b/drivers/bluetooth/hci_ath.c
index 14ae7ee..d568fbd 100644
--- a/drivers/bluetooth/hci_ath.c
+++ b/drivers/bluetooth/hci_ath.c
@@ -71,12 +71,12 @@ static int ath_wakeup_ar3k(struct tty_struct *tty)
 	/* Clear RTS first */
 	tty->driver->ops->tiocmget(tty);
 	tty->driver->ops->tiocmset(tty, 0x00, TIOCM_RTS);
-	mdelay(20);
+	msleep(20);
 
 	/* Set RTS, wake up board */
 	tty->driver->ops->tiocmget(tty);
 	tty->driver->ops->tiocmset(tty, TIOCM_RTS, 0x00);
-	mdelay(20);
+	msleep(20);
 
 	status = tty->driver->ops->tiocmget(tty);
 	return status;
-- 
1.7.9.5
