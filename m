Return-Path: <cyrus@holtmann.org>
From: Nicholas Krause <xerofoify@gmail.com>
To: marcel@holtmann.org
Cc: gustavo@padovan.org,
	johan.hedberg@gmail.com,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] drivers:bluetooth:Remove unneeded code in the function,hci_uart_tty_open for the file,hci_ldisc.c
Date: Sat, 27 Dec 2014 20:47:00 -0500
Message-Id: <1419731220-27629-1-git-send-email-xerofoify@gmail.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Removes the unneeded code that flushs the buffer if ldisc is setup. This  if statement is 
not needed and flushing of the ldisc buffer on this tty is no needed due to ldisc not being 
setup at this point in the file,hci_ldisc.c.
Signed-off-by: Nicholas Krause <xerofoify@gmail.com>
---
 drivers/bluetooth/hci_ldisc.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/bluetooth/hci_ldisc.c b/drivers/bluetooth/hci_ldisc.c
index dc487b5..356f5fb 100644
--- a/drivers/bluetooth/hci_ldisc.c
+++ b/drivers/bluetooth/hci_ldisc.c
@@ -299,11 +299,6 @@ static int hci_uart_tty_open(struct tty_struct *tty)
 
 	/* Flush any pending characters in the driver and line discipline. */
 
-	/* FIXME: why is this needed. Note don't use ldisc_ref here as the
-	   open path is before the ldisc is referencable */
-
-	if (tty->ldisc->ops->flush_buffer)
-		tty->ldisc->ops->flush_buffer(tty);
 	tty_driver_flush_buffer(tty);
 
 	return 0;
-- 
2.1.0
