Return-Path: <cyrus@holtmann.org>
Subject: patch "tty: Remove external interface for tty_set_termios()" added to tty-next
To: peter@hurleysoftware.com,gregkh@linuxfoundation.org,johan.hedberg@gmail.com,linux-bluetooth@vger.kernel.org,marcel@holtmann.org
From: <gregkh@linuxfoundation.org>
Date: Mon, 02 Feb 2015 10:44:46 -0800
Message-ID: <142290268618519@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
List-ID: <linux-bluetooth.vger.kernel.org>


This is a note to let you know that I've just added the patch titled

    tty: Remove external interface for tty_set_termios()

to my tty git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git
in the tty-next branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will also be merged in the next major kernel release
during the merge window.

If you have any questions about this process, please let me know.


>From 632f32e2107d37598e3f6816dcf00c7cab4081ca Mon Sep 17 00:00:00 2001
From: Peter Hurley <peter@hurleysoftware.com>
Date: Sun, 25 Jan 2015 14:44:54 -0500
Subject: tty: Remove external interface for tty_set_termios()

tty_set_termios() is an internal helper intended for file scope use.

UART drivers which are capable of driving the RTS pin must
properly handle the tiocmset() method, regardless of termios settings.
A failure to do so is a UART driver bug and should be fixed there.
Do not use this interface to workaround UART driver bugs.

Cc: Johan Hedberg <johan.hedberg@gmail.com>
Cc: <linux-bluetooth@vger.kernel.org>
Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
Acked-by: Marcel Holtmann <marcel@holtmann.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/bluetooth/hci_ath.c | 15 ++-------------
 drivers/tty/tty_ioctl.c     |  3 +--
 include/linux/tty.h         |  1 -
 3 files changed, 3 insertions(+), 16 deletions(-)

diff --git a/drivers/bluetooth/hci_ath.c b/drivers/bluetooth/hci_ath.c
index 2ff6dfd2d3f0..9c4dcf4c62ea 100644
--- a/drivers/bluetooth/hci_ath.c
+++ b/drivers/bluetooth/hci_ath.c
@@ -51,33 +51,22 @@ struct ath_struct {
 
 static int ath_wakeup_ar3k(struct tty_struct *tty)
 {
-	struct ktermios ktermios;
 	int status = tty->driver->ops->tiocmget(tty);
 
 	if (status & TIOCM_CTS)
 		return status;
 
-	/* Disable Automatic RTSCTS */
-	ktermios = tty->termios;
-	ktermios.c_cflag &= ~CRTSCTS;
-	tty_set_termios(tty, &ktermios);
-
 	/* Clear RTS first */
-	status = tty->driver->ops->tiocmget(tty);
+	tty->driver->ops->tiocmget(tty);
 	tty->driver->ops->tiocmset(tty, 0x00, TIOCM_RTS);
 	mdelay(20);
 
 	/* Set RTS, wake up board */
-	status = tty->driver->ops->tiocmget(tty);
+	tty->driver->ops->tiocmget(tty);
 	tty->driver->ops->tiocmset(tty, TIOCM_RTS, 0x00);
 	mdelay(20);
 
 	status = tty->driver->ops->tiocmget(tty);
-
-	/* Enable Automatic RTSCTS */
-	ktermios.c_cflag |= CRTSCTS;
-	status = tty_set_termios(tty, &ktermios);
-
 	return status;
 }
 
diff --git a/drivers/tty/tty_ioctl.c b/drivers/tty/tty_ioctl.c
index 1787fa4d9448..a5cf253b2544 100644
--- a/drivers/tty/tty_ioctl.c
+++ b/drivers/tty/tty_ioctl.c
@@ -530,7 +530,7 @@ EXPORT_SYMBOL(tty_termios_hw_change);
  *	Locking: termios_rwsem
  */
 
-int tty_set_termios(struct tty_struct *tty, struct ktermios *new_termios)
+static int tty_set_termios(struct tty_struct *tty, struct ktermios *new_termios)
 {
 	struct ktermios old_termios;
 	struct tty_ldisc *ld;
@@ -563,7 +563,6 @@ int tty_set_termios(struct tty_struct *tty, struct ktermios *new_termios)
 	up_write(&tty->termios_rwsem);
 	return 0;
 }
-EXPORT_SYMBOL_GPL(tty_set_termios);
 
 /**
  *	set_termios		-	set termios values for a tty
diff --git a/include/linux/tty.h b/include/linux/tty.h
index fe5623c9af71..358a337af598 100644
--- a/include/linux/tty.h
+++ b/include/linux/tty.h
@@ -491,7 +491,6 @@ static inline speed_t tty_get_baud_rate(struct tty_struct *tty)
 
 extern void tty_termios_copy_hw(struct ktermios *new, struct ktermios *old);
 extern int tty_termios_hw_change(struct ktermios *a, struct ktermios *b);
-extern int tty_set_termios(struct tty_struct *tty, struct ktermios *kt);
 
 extern struct tty_ldisc *tty_ldisc_ref(struct tty_struct *);
 extern void tty_ldisc_deref(struct tty_ldisc *);
-- 
2.2.2
