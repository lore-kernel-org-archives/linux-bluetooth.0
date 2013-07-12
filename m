Return-Path: <cyrus@holtmann.org>
From: Gianluca Anzolin <gianluca@sottospazio.it>
To: gustavo@padovan.org
Cc: linux-bluetooth@vger.kernel.org,
	peter@hurleysoftware.com,
	marcel@holtmann.org,
	Gianluca Anzolin <gianluca@sottospazio.it>
Subject: [PATCH 7/8] Avoid a circular dependency between dev and dev->dlc
Date: Fri, 12 Jul 2013 22:40:47 +0200
Message-Id: <1373661649-1385-7-git-send-email-gianluca@sottospazio.it>
In-Reply-To: <1373661649-1385-1-git-send-email-gianluca@sottospazio.it>
References: <1373661649-1385-1-git-send-email-gianluca@sottospazio.it>
List-ID: <linux-bluetooth.vger.kernel.org>

There is a circular dependency between dev and dlc: dev takes a reference to the
dlc in rfcomm_create_dev. The dlc->tx_queue has a list of skbs with references
to dev itself.

That list is purged only when the dlc is destructed, but that cannot happen
because dev acquired a reference to it and won't release it until it's
destructed.

Since we now purge the skbs in the cleanup method we can remove the call to
rfcomm_tty_flush_buffer in rfcomm_tty_hangup.

Signed-off-by: Gianluca Anzolin <gianluca@sottospazio.it>
---
 net/bluetooth/rfcomm/tty.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/rfcomm/tty.c b/net/bluetooth/rfcomm/tty.c
index 0d61d65..7bc603a 100644
--- a/net/bluetooth/rfcomm/tty.c
+++ b/net/bluetooth/rfcomm/tty.c
@@ -740,6 +740,9 @@ static void rfcomm_tty_cleanup(struct tty_struct *tty)
         tty->driver_data = NULL;
         rfcomm_dlc_unlock(dev->dlc);
 
+        /* avoid dev and dlc->tx_queue circular dependency  */
+        skb_queue_purge(&dev->dlc->tx_queue);
+
         tty_port_put(&dev->port);
 }
 
@@ -1062,8 +1065,6 @@ static void rfcomm_tty_hangup(struct tty_struct *tty)
 
 	BT_DBG("tty %p dev %p", tty, dev);
 
-	rfcomm_tty_flush_buffer(tty);
-
 	tty_port_hangup(&dev->port);
 
 	if (test_bit(RFCOMM_RELEASE_ONHUP, &dev->flags)) {
-- 
1.8.3.2
