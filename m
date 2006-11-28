Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1164687538.13955.11.camel@aeonflux.holtmann.net>
References: <c303508f0611271806t6e5f0b31u4908ee4234b5e1ad@mail.gmail.com>
	<1164687538.13955.11.camel@aeonflux.holtmann.net>
Content-Type: multipart/mixed; boundary="=-e1J8P2uzn42pzcQUTiLP"
Date: Tue, 28 Nov 2006 05:21:52 +0100
Message-Id: <1164687712.13955.13.camel@aeonflux.holtmann.net>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] Rfcomm kernel crashes (2.6.18.2)
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net


--=-e1J8P2uzn42pzcQUTiLP
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi Axel,

> > thanks again for your patch. It seems to have fixed the problem
> > partially.
> > I get a lot less frequent crashes, but unfortunately I now got this
> > new error:
> 
> try the attached one.

actually that one was wrong. Please try this one.

Regards

Marcel


--=-e1J8P2uzn42pzcQUTiLP
Content-Disposition: attachment; filename=patch
Content-Type: text/x-patch; name=patch; charset=utf-8
Content-Transfer-Encoding: 7bit

diff --git a/net/bluetooth/rfcomm/tty.c b/net/bluetooth/rfcomm/tty.c
index 1fb5d42..5d1494d 100644
--- a/net/bluetooth/rfcomm/tty.c
+++ b/net/bluetooth/rfcomm/tty.c
@@ -697,9 +697,13 @@ static int rfcomm_tty_write_room(struct tty_struct *tty)
 
 	BT_DBG("tty %p", tty);
 
+	if (!dev || !dev->dlc)
+		return 0;
+
 	room = rfcomm_room(dev->dlc) - atomic_read(&dev->wmem_alloc);
 	if (room < 0)
 		room = 0;
+
 	return room;
 }
 
@@ -915,12 +919,14 @@ static void rfcomm_tty_unthrottle(struct tty_struct *tty)
 static int rfcomm_tty_chars_in_buffer(struct tty_struct *tty)
 {
 	struct rfcomm_dev *dev = (struct rfcomm_dev *) tty->driver_data;
-	struct rfcomm_dlc *dlc = dev->dlc;
 
 	BT_DBG("tty %p dev %p", tty, dev);
 
-	if (!skb_queue_empty(&dlc->tx_queue))
-		return dlc->mtu;
+	if (!dev || !dev->dlc)
+		return 0;
+
+	if (!skb_queue_empty(&dev->dlc->tx_queue))
+		return dev->dlc->mtu;
 
 	return 0;
 }
@@ -928,11 +934,12 @@ static int rfcomm_tty_chars_in_buffer(struct tty_struct *tty)
 static void rfcomm_tty_flush_buffer(struct tty_struct *tty)
 {
 	struct rfcomm_dev *dev = (struct rfcomm_dev *) tty->driver_data;
-	if (!dev)
-		return;
 
 	BT_DBG("tty %p dev %p", tty, dev);
 
+	if (!dev || !dev->dlc)
+		return;
+
 	skb_queue_purge(&dev->dlc->tx_queue);
 
 	if (test_bit(TTY_DO_WRITE_WAKEUP, &tty->flags) && tty->ldisc.write_wakeup)
@@ -952,11 +959,12 @@ static void rfcomm_tty_wait_until_sent(struct tty_struct *tty, int timeout)
 static void rfcomm_tty_hangup(struct tty_struct *tty)
 {
 	struct rfcomm_dev *dev = (struct rfcomm_dev *) tty->driver_data;
-	if (!dev)
-		return;
 
 	BT_DBG("tty %p dev %p", tty, dev);
 
+	if (!dev)
+		return;
+
 	rfcomm_tty_flush_buffer(tty);
 
 	if (test_bit(RFCOMM_RELEASE_ONHUP, &dev->flags))

--=-e1J8P2uzn42pzcQUTiLP
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--=-e1J8P2uzn42pzcQUTiLP
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--=-e1J8P2uzn42pzcQUTiLP--
