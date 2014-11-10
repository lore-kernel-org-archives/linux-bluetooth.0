Return-Path: <cyrus@holtmann.org>
From: Fugang Duan <b38611@freescale.com>
To: <marcel@holtmann.org>
CC: <linux-bluetooth@vger.kernel.org>, <b38611@freescale.com>
Subject: [PATCH] Bluetooth: hci-uart-ath: Correct the comments in this driver
Date: Mon, 10 Nov 2014 14:51:49 +0800
Message-ID: <1415602309-13970-1-git-send-email-b38611@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-bluetooth.vger.kernel.org>

Correct the comments in this driver. Set the CRTSCTS flag means
automatic flow control is enabled.

Signed-off-by: Fugang Duan <B38611@freescale.com>
---
 drivers/bluetooth/hci_ath.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/bluetooth/hci_ath.c b/drivers/bluetooth/hci_ath.c
index 0bc8a6a..2ff6dfd 100644
--- a/drivers/bluetooth/hci_ath.c
+++ b/drivers/bluetooth/hci_ath.c
@@ -74,7 +74,7 @@ static int ath_wakeup_ar3k(struct tty_struct *tty)
 
 	status = tty->driver->ops->tiocmget(tty);
 
-	/* Disable Automatic RTSCTS */
+	/* Enable Automatic RTSCTS */
 	ktermios.c_cflag |= CRTSCTS;
 	status = tty_set_termios(tty, &ktermios);
 
-- 
1.7.8
