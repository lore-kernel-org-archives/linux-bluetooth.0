Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Prepare patch bluez for the CoD in hci_conn
From: Chen Bin <binch@mobilesoft.com.cn>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <1102317505.8510.66.camel@pegasus>
References: <1102340081.653.6.camel@debian>
	 <1102315236.8510.55.camel@pegasus>  <1102345868.2011.2.camel@debian>
	 <1102317505.8510.66.camel@pegasus>
Content-Type: multipart/mixed; boundary="=-VW/RdfNqzQsEnq3nPAXa"
Message-Id: <1102348405.3281.4.camel@debian>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Mon, 06 Dec 2004 23:53:25 +0800


--=-VW/RdfNqzQsEnq3nPAXa
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: quoted-printable

The attachment is my patch, the comments and the debug info can be
removed as soon as this patch is tested fully.

Chen
=D4=DA 2004-12-06=D2=BB=B5=C4 08:18 +0100=A3=ACMarcel Holtmann=D0=B4=B5=C0=
=A3=BA
> Hi Chen,
>=20
> > I have done this. I searched the BT spec and find two places which wi=
ll
> > let us know the CoD value, and I simply test it, it works find.
> >=20
> > Ok, next step is to make an interface(maybe ioctl) to let the user ge=
t
> > the CoD value, is it needed(if there has been a interface which can g=
et
> > the entire hci_conn structure)? If it is not needed, I will send you =
the
> > patch now.
>=20
> step by step. Send your patch now and don't forget the Signed-off-by
> statement.
>=20
> Regards
>=20
> Marcel
>=20
>=20
>=20
>=20
> -------------------------------------------------------
> SF email is sponsored by - The IT Product Guide
> Read honest & candid reviews on hundreds of IT Products from real users=
.
> Discover which products truly live up to the hype. Start reading now.=20
> http://productguide.itmanagersjournal.com/
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel

--=-VW/RdfNqzQsEnq3nPAXa
Content-Disposition: attachment; filename=patch-2.6.9-CoD
Content-Type: text/x-patch; name=patch-2.6.9-CoD; charset=gbk
Content-Transfer-Encoding: 7bit

diff -ruN linux-2.6.9/include/net/bluetooth/hci_core.h linux-2.6.9-my/include/net/bluetooth/hci_core.h
--- linux-2.6.9/include/net/bluetooth/hci_core.h	Tue Oct 19 05:54:30 2004
+++ linux-2.6.9-my/include/net/bluetooth/hci_core.h	Mon Dec  6 23:39:24 2004
@@ -20,6 +20,9 @@
    ALL LIABILITY, INCLUDING LIABILITY FOR INFRINGEMENT OF ANY PATENTS, 
    COPYRIGHTS, TRADEMARKS OR OTHER RIGHTS, RELATING TO USE OF THIS 
    SOFTWARE IS DISCLAIMED.
+
+ * Add some code for CoD value, 06/12/04, Chen Bin 
+ *     binch@mobilesoft.com.cn
 */
 
 #ifndef __HCI_CORE_H
@@ -143,6 +146,11 @@
 	__u8		 out;
 	__u32		 link_mode;
 	unsigned long	 pend;
+
+	/* 
+	 * added by Chen Bin.
+	 */
+	__u8     dev_class[3];
 	
 	unsigned int	 sent;
 	
diff -ruN linux-2.6.9/net/bluetooth/hci_conn.c linux-2.6.9-my/net/bluetooth/hci_conn.c
--- linux-2.6.9/net/bluetooth/hci_conn.c	Tue Oct 19 05:55:29 2004
+++ linux-2.6.9-my/net/bluetooth/hci_conn.c	Mon Dec  6 23:14:59 2004
@@ -20,6 +20,9 @@
    ALL LIABILITY, INCLUDING LIABILITY FOR INFRINGEMENT OF ANY PATENTS, 
    COPYRIGHTS, TRADEMARKS OR OTHER RIGHTS, RELATING TO USE OF THIS 
    SOFTWARE IS DISCLAIMED.
+
+ * Add some code for CoD value, 06/12/04, Chen Bin 
+ *     binch@mobilesoft.com.cn
 */
 
 /* Bluetooth HCI connection handling. */
@@ -143,6 +146,7 @@
 struct hci_conn *hci_conn_add(struct hci_dev *hdev, int type, bdaddr_t *dst)
 {
 	struct hci_conn *conn;
+	struct inquiry_entry *ie;
 
 	BT_DBG("%s dst %s", hdev->name, batostr(dst));
 
@@ -154,6 +158,31 @@
 	conn->type   = type;
 	conn->hdev   = hdev;
 	conn->state  = BT_OPEN;
+
+	/*
+	 * added by Chen Bin for CoD value.
+	 */
+
+	if ((ie = hci_inquiry_cache_lookup(hdev, dst)) &&
+			inquiry_entry_age(ie) <= INQUIRY_ENTRY_AGE_MAX) {
+		/*
+		 * Found a valid entry
+		 * copy the CoD value to the hci_conn
+		 */
+		conn->dev_class[0] = ie->info.dev_class[0];
+		conn->dev_class[1] = ie->info.dev_class[1];
+		conn->dev_class[2] = ie->info.dev_class[2];
+
+	} else {
+		conn->dev_class[0] = 0x00;
+		conn->dev_class[1] = 0x00;
+		conn->dev_class[2] = 0x00; 
+	}
+	
+	printk("hci_conn_add: the dev_class = %x %x %x\n", conn->dev_class[0], conn->dev_class[1], conn->dev_class[2]);
+
+	//---------------------------------------------------------
+
 
 	skb_queue_head_init(&conn->data_q);
 	hci_conn_init_timer(conn);
diff -ruN linux-2.6.9/net/bluetooth/hci_event.c linux-2.6.9-my/net/bluetooth/hci_event.c
--- linux-2.6.9/net/bluetooth/hci_event.c	Tue Oct 19 05:53:06 2004
+++ linux-2.6.9-my/net/bluetooth/hci_event.c	Mon Dec  6 23:15:06 2004
@@ -20,6 +20,9 @@
    ALL LIABILITY, INCLUDING LIABILITY FOR INFRINGEMENT OF ANY PATENTS, 
    COPYRIGHTS, TRADEMARKS OR OTHER RIGHTS, RELATING TO USE OF THIS 
    SOFTWARE IS DISCLAIMED.
+
+ * Add some code for CoD value, 06/12/04, Chen Bin 
+ *     binch@mobilesoft.com.cn
 */
 
 /* Bluetooth HCI event handling. */
@@ -539,6 +542,15 @@
 			}
 		}
 		conn->state = BT_CONNECT;
+		/*
+		 * added by Chen Bin
+		 * if the remote ba address is in the cache, hci_conn_add will add the
+		 * dev_class field in conn.
+		 * So the following two lines is useless.
+		 */
+		memcpy(conn->dev_class, &ev->dev_class, 3);
+		printk("hci_conn_request_evt:the dev_class = %x %x %x\n", conn->dev_class[0], conn->dev_class[1], conn->dev_class[2]);
+		//--------------------------------------------------------
 		hci_dev_unlock(hdev);
 
 		bacpy(&cp.bdaddr, &ev->bdaddr);

--=-VW/RdfNqzQsEnq3nPAXa--



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
