Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <1149885500.17091.2.camel@neutrino.cosmos.net>
References: <1149543750.14142.11.camel@neutrino.cosmos.net>
	<1149544649.7238.1.camel@localhost>
	<1149616008.9380.11.camel@neutrino.cosmos.net>
	<d23110170606061337m3ef2e630k702a7e3ef3509256@mail.gmail.com>
	<1149798394.23481.2.camel@neutrino.cosmos.net>
	<d23110170606081814m434c5e15ia7de6c74b3bf2209@mail.gmail.com>
	<1149885500.17091.2.camel@neutrino.cosmos.net>
Content-Type: multipart/mixed; boundary="=-BIZfuba3J68pFQDOTc1W"
Date: Sun, 11 Jun 2006 02:35:06 +0200
Message-Id: <1149986106.5358.27.camel@aeonflux.holtmann.net>
Mime-Version: 1.0
Subject: Re: [Bluez-users] crazy mouse
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net


--=-BIZfuba3J68pFQDOTc1W
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi Didier,

> > Hmm.. I can't see anything unusual. Only the automatic switch to sniff
> > mode feature trying to hold the connection in active mode and your
> > mouse turning it back to sniff mode. Could you give the 2.6.16-mh2 a
> > try? It doesn't contain the automatic switch to sniff mode feature and
> > we'll be able to see if that's causing your mouse problems.
> 
> Yes that's it, my mouse workd perfect with mh2 !! I don't understand but
> if you want a tester for a newer patch just ask me ! :)

please use 2.6.16-mh1 and the attached patch. That should make it work
again as expected.

Regards

Marcel


--=-BIZfuba3J68pFQDOTc1W
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

--=-BIZfuba3J68pFQDOTc1W
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--=-BIZfuba3J68pFQDOTc1W
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--=-BIZfuba3J68pFQDOTc1W--
