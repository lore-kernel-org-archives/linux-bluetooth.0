Return-Path: <cyrus@holtmann.org>
From: Denis KENZIOR <denis.kenzior@trolltech.com>
To: bluez-devel@lists.sourceforge.net
Date: Fri, 20 Jun 2008 16:09:56 +1000
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_0m0WINVvcbA2fYm"
Message-Id: <200806201609.56106.denis.kenzior@trolltech.com>
Subject: [Bluez-devel] [PATCH] Keep rfcomm tty modem status
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

--Boundary-00=_0m0WINVvcbA2fYm
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Keep the modem status around in case the tty really needs it.

Signed-off-by: Denis Kenzior <denis.kenzior@trolltech.com>

--Boundary-00=_0m0WINVvcbA2fYm
Content-Type: text/x-diff; charset="us-ascii";
	name="rfcomm-tty-keep-modem-status.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="rfcomm-tty-keep-modem-status.patch"

diff --git a/include/net/bluetooth/rfcomm.h b/include/net/bluetooth/rfcomm.h
index 98ec7a3..d74094d 100644
--- a/include/net/bluetooth/rfcomm.h
+++ b/include/net/bluetooth/rfcomm.h
@@ -180,6 +180,7 @@ struct rfcomm_dlc {
 	u8            addr;
 	u8            priority;
 	u8            v24_sig;
+	u8            remote_v24_sig;
 	u8            mscex;
 
 	u32           link_mode;
diff --git a/net/bluetooth/rfcomm/core.c b/net/bluetooth/rfcomm/core.c
index 0c2c937..2e37bb0 100644
--- a/net/bluetooth/rfcomm/core.c
+++ b/net/bluetooth/rfcomm/core.c
@@ -1459,6 +1459,7 @@ static int rfcomm_recv_msc(struct rfcomm_session *s, int cr, struct sk_buff *skb
 			clear_bit(RFCOMM_TX_THROTTLED, &d->flags);
 
 		rfcomm_dlc_lock(d);
+		d->remote_v24_sig = msc->v24_sig;
 		if (d->modem_status)
 			d->modem_status(d, msc->v24_sig);
 		rfcomm_dlc_unlock(d);
diff --git a/net/bluetooth/rfcomm/tty.c b/net/bluetooth/rfcomm/tty.c
index 2488027..8fcca08 100644
--- a/net/bluetooth/rfcomm/tty.c
+++ b/net/bluetooth/rfcomm/tty.c
@@ -271,6 +271,9 @@ static int rfcomm_dev_add(struct rfcomm_dev_req *req, struct rfcomm_dlc *dlc)
 
 	dlc->owner = dev;
 	dev->dlc   = dlc;
+
+	rfcomm_dev_modem_status(dlc, dlc->remote_v24_sig);
+
 	rfcomm_dlc_unlock(dlc);
 
 	/* It's safe to call __module_get() here because socket already

--Boundary-00=_0m0WINVvcbA2fYm
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://sourceforge.net/services/buy/index.php
--Boundary-00=_0m0WINVvcbA2fYm
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--Boundary-00=_0m0WINVvcbA2fYm--
