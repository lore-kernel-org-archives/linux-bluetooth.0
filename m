Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: Philip Langdale <philipl@mail.utexas.edu>
In-Reply-To: <448A4385.4020809@mail.utexas.edu>
References: <44867199.2000409@mail.utexas.edu>
	<1149664531.22472.4.camel@localhost> <4486EE2D.3010507@mail.utexas.edu>
	<1149714318.22472.59.camel@localhost>
	<4487B00F.7070204@mail.utexas.edu>
	<1149803817.4219.61.camel@localhost> <448A4385.4020809@mail.utexas.edu>
Content-Type: multipart/mixed; boundary="=-M74/dpcyWrx0Hs6Fc/Ix"
Date: Sun, 11 Jun 2006 02:33:59 +0200
Message-Id: <1149986039.5358.25.camel@aeonflux.holtmann.net>
Mime-Version: 1.0
Cc: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] Latest 2.6.16-mh1 patch.
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


--=-M74/dpcyWrx0Hs6Fc/Ix
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi Philip,

> > okay. I released patch-2.6.16-mh2 with doesn't contain the automatic
> > sniff mode feature anymore. Please check if your mouse is now working as
> > expected. 
> 
> Yep, that did the trick, but I hope you can get the two to play well
> together.

the attached patch on top of 2.6.16-mh1 should do the trick.

Regards

Marcel


--=-M74/dpcyWrx0Hs6Fc/Ix
Content-Disposition: attachment; filename=patch
Content-Type: text/x-patch; name=patch; charset=utf-8
Content-Transfer-Encoding: 7bit

diff -u b/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
--- b/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -154,6 +154,7 @@
 	__u16            interval;
 	__u16            link_policy;
 	__u32		 link_mode;
+	__u8             power_save;
 	unsigned long	 pend;
 
 	unsigned int	 sent;
diff -u b/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
--- b/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -158,6 +158,8 @@
 	conn->mode   = HCI_CM_ACTIVE;
 	conn->state  = BT_OPEN;
 
+	conn->power_save = 1;
+
 	skb_queue_head_init(&conn->data_q);
 
 	init_timer(&conn->disc_timer);
@@ -387,7 +389,7 @@
 	if (test_bit(HCI_RAW, &hdev->flags))
 		return;
 
-	if (conn->mode != HCI_CM_SNIFF)
+	if (conn->mode != HCI_CM_SNIFF || !conn->power_save)
 		goto timer;
 
 	if (!test_and_set_bit(HCI_CONN_MODE_CHANGE_PEND, &conn->pend)) {
diff -u b/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
--- b/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -881,7 +881,12 @@
 		conn->mode = ev->mode;
 		conn->interval = __le16_to_cpu(ev->interval);
 
-		clear_bit(HCI_CONN_MODE_CHANGE_PEND, &conn->pend);
+		if (!test_and_clear_bit(HCI_CONN_MODE_CHANGE_PEND, &conn->pend)) {
+			if (conn->mode == HCI_CM_ACTIVE)
+				conn->power_save = 1;
+			else
+				conn->power_save = 0;
+		}
 	}
 
 	hci_dev_unlock(hdev);

--=-M74/dpcyWrx0Hs6Fc/Ix
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--=-M74/dpcyWrx0Hs6Fc/Ix
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--=-M74/dpcyWrx0Hs6Fc/Ix--
