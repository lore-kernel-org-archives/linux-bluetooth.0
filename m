Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <c303508f0611181827s178b8776g57d3dbec37264691@mail.gmail.com>
References: <c303508f0611181827s178b8776g57d3dbec37264691@mail.gmail.com>
Content-Type: multipart/mixed; boundary="=-TgImzuZob3nk0ysJuFlo"
Date: Mon, 20 Nov 2006 09:28:07 +0100
Message-Id: <1164011287.28397.9.camel@localhost>
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


--=-TgImzuZob3nk0ysJuFlo
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi Axel,

> I have the following problem with Bluez/RFcomm:
> - I use a shell script that calls 'rfcomm listen rfcomm0 3' repeatedly
> to wait for a client to connect.
> - Everything works fine, except that every once in a while
> (unfortunately pretty often, like twice a day), the linux kernel
> crashes with the following message in syslog: 

so you have something to reproduce this. That is good. Please try out
the attached patch and report back if it fixes this for you.

Regards

Marcel


--=-TgImzuZob3nk0ysJuFlo
Content-Disposition: attachment; filename=patch
Content-Type: text/x-patch; name=patch; charset=utf-8
Content-Transfer-Encoding: 7bit

diff --git a/net/bluetooth/rfcomm/tty.c b/net/bluetooth/rfcomm/tty.c
index b8e3a5f..46c03f8 100644
--- a/net/bluetooth/rfcomm/tty.c
+++ b/net/bluetooth/rfcomm/tty.c
@@ -915,12 +915,14 @@ static void rfcomm_tty_unthrottle(struct
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
@@ -928,11 +930,12 @@ static int rfcomm_tty_chars_in_buffer(st
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
@@ -952,11 +955,12 @@ static void rfcomm_tty_wait_until_sent(s
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

--=-TgImzuZob3nk0ysJuFlo
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--=-TgImzuZob3nk0ysJuFlo
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--=-TgImzuZob3nk0ysJuFlo--
