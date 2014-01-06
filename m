Return-Path: <cyrus@holtmann.org>
From: Gianluca Anzolin <gianluca@sottospazio.it>
To: gustavo@padovan.org
Cc: peter@hurleysoftware.com,
	marcel@holtmann.org,
	linux-bluetooth@vger.kernel.org,
	gregkh@linuxfoundation.org,
	jslaby@suse.cz,
	stable@vger.kernel.org,
	Gianluca Anzolin <gianluca@sottospazio.it>
Subject: [PATCH v2 1/4] rfcomm: release the port when the last user closes the tty
Date: Mon,  6 Jan 2014 19:43:12 +0100
Message-Id: <1389033795-23895-2-git-send-email-gianluca@sottospazio.it>
In-Reply-To: <1389033795-23895-1-git-send-email-gianluca@sottospazio.it>
References: <1389033795-23895-1-git-send-email-gianluca@sottospazio.it>
List-ID: <linux-bluetooth.vger.kernel.org>

This patch fixes a userspace regression introduced by the commit
29cd718b.

If the rfcomm device was created with the flag RFCOMM_RELEASE_ONHUP the
user space expects that the tty_port is released as soon as the last
process closes the tty.

The current code attempts to release the port in the function
rfcomm_dev_state_change(). However it won't get a reference to the
relevant tty to send a HUP: at that point the tty is already destroyed
and therefore NULL.

This patch fixes the regression by taking over the tty refcount in the
tty install method(). This way the tty_port is automatically released as
soon as the tty is destroyed.

As a consequence the check for RFCOMM_RELEASE_ONHUP flag in the hangup()
method is now redundant. Instead we have to be careful with the reference
counting in the rfcomm_release_dev() function.

Signed-off-by: Gianluca Anzolin <gianluca@sottospazio.it>
Reported-by: Alexander Holler <holler@ahsoftware.de>
---
 net/bluetooth/rfcomm/tty.c | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/net/bluetooth/rfcomm/tty.c b/net/bluetooth/rfcomm/tty.c
index 84fcf9f..a535ef1 100644
--- a/net/bluetooth/rfcomm/tty.c
+++ b/net/bluetooth/rfcomm/tty.c
@@ -437,7 +437,8 @@ static int rfcomm_release_dev(void __user *arg)
 		tty_kref_put(tty);
 	}
 
-	if (!test_and_set_bit(RFCOMM_TTY_RELEASED, &dev->flags))
+	if (!test_bit(RFCOMM_RELEASE_ONHUP, &dev->flags) &&
+	    !test_and_set_bit(RFCOMM_TTY_RELEASED, &dev->flags))
 		tty_port_put(&dev->port);
 
 	tty_port_put(&dev->port);
@@ -670,10 +671,20 @@ static int rfcomm_tty_install(struct tty_driver *driver, struct tty_struct *tty)
 
 	/* install the tty_port */
 	err = tty_port_install(&dev->port, driver, tty);
-	if (err)
+	if (err) {
 		rfcomm_tty_cleanup(tty);
+		return err;
+	}
 
-	return err;
+	/* take over the tty_port reference if the port was created with the
+	 * flag RFCOMM_RELEASE_ONHUP. This will force the release of the port
+	 * when the last process closes the tty. The behaviour is expected by
+	 * userspace.
+	 */
+	if (test_bit(RFCOMM_RELEASE_ONHUP, &dev->flags))
+		tty_port_put(&dev->port);
+
+	return 0;
 }
 
 static int rfcomm_tty_open(struct tty_struct *tty, struct file *filp)
@@ -1010,10 +1021,6 @@ static void rfcomm_tty_hangup(struct tty_struct *tty)
 	BT_DBG("tty %p dev %p", tty, dev);
 
 	tty_port_hangup(&dev->port);
-
-	if (test_bit(RFCOMM_RELEASE_ONHUP, &dev->flags) &&
-	    !test_and_set_bit(RFCOMM_TTY_RELEASED, &dev->flags))
-		tty_port_put(&dev->port);
 }
 
 static int rfcomm_tty_tiocmget(struct tty_struct *tty)
-- 
1.8.5.2
