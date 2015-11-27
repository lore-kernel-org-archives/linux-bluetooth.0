Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Peter Hurley <peter@hurleysoftware.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.cz>, linux-kernel@vger.kernel.org,
	Andi Kleen <andi@firstfloor.org>,
	Peter Hurley <peter@hurleysoftware.com>,
	Marcel Holtmann <marcel@holtmann.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	linux-bluetooth@vger.kernel.org
Subject: [PATCH 03/19] bluetooth: hci_ldisc: Remove dead code
Date: Fri, 27 Nov 2015 16:39:00 -0500
Message-Id: <1448660356-6328-4-git-send-email-peter@hurleysoftware.com>
In-Reply-To: <1448660356-6328-1-git-send-email-peter@hurleysoftware.com>
References: <1448660356-6328-1-git-send-email-peter@hurleysoftware.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The N_HCI ldisc does not define a flush_buffer() ldisc method, so
the check when opening the ldisc is always false.

Cc: Marcel Holtmann <marcel@holtmann.org>
Cc: Johan Hedberg <johan.hedberg@gmail.com>
Cc: <linux-bluetooth@vger.kernel.org>
Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
---
 drivers/bluetooth/hci_ldisc.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/bluetooth/hci_ldisc.c b/drivers/bluetooth/hci_ldisc.c
index 96bcec5..c303f87 100644
--- a/drivers/bluetooth/hci_ldisc.c
+++ b/drivers/bluetooth/hci_ldisc.c
@@ -461,13 +461,7 @@ static int hci_uart_tty_open(struct tty_struct *tty)
 	INIT_WORK(&hu->init_ready, hci_uart_init_work);
 	INIT_WORK(&hu->write_work, hci_uart_write_work);
 
-	/* Flush any pending characters in the driver and line discipline. */
-
-	/* FIXME: why is this needed. Note don't use ldisc_ref here as the
-	   open path is before the ldisc is referencable */
-
-	if (tty->ldisc->ops->flush_buffer)
-		tty->ldisc->ops->flush_buffer(tty);
+	/* Flush any pending characters in the driver */
 	tty_driver_flush_buffer(tty);
 
 	return 0;
-- 
2.6.3

