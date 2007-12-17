Return-Path: <cyrus@holtmann.org>
Message-ID: <47666E1F.2000902@mizi.com>
Date: Mon, 17 Dec 2007 21:39:59 +0900
From: Louis JANG <louis@mizi.com>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Content-Type: multipart/mixed; boundary="------------000904040203070208080305"
Subject: [Bluez-devel] forcing SCO connection patch
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

This is a multi-part message in MIME format.
--------------000904040203070208080305
Content-Type: text/plain; charset=EUC-KR
Content-Transfer-Encoding: 7bit

Hello everybody,

I attached two patches. the first one(bluez-kernel-forcesco.patch) is to
force using HCI_OP_ADD_SCO instead of HCI_OP_SETUP_SYNC_CONN, and the
second one is to handle SCO connection complete event but its request
was ESCO.

1.
I'm developing bluetooth functions in my linux phone project, and I'm
using bluez for my job. I've tested lots of headsets, and found that I
coudn't connect SCO channel with HCI_OP_SETUP_SYNC_CONN in some old
headsets. I could connect SCO channel with HCI_OP_ADD_SCO in this case.
however, there is no api to force using SCO instead of ESCO in bluez. so
I added SCO_FORCESCO to handle this old headsets

2.
When I tried to connect SCO channel with
HCI_OP_SETUP_SYNC_CONN(LINK_TYPE_ESCO), some bluetooth headsets responds
with LINK_TYPE_SCO because it did not support ESCO. But bluez couldn't
handle this situation, and patch_hci_event.c is for this.


BRs
Louis JANG


--------------000904040203070208080305
Content-Type: text/x-patch;
 name="bluez-kernel-forcesco.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="bluez-kernel-forcesco.patch"

--- net/bluetooth/sco.c.orig	2007-12-17 18:03:14.000000000 +0900
+++ net/bluetooth/sco.c	2007-12-17 18:18:53.000000000 +0900
@@ -200,7 +200,11 @@
 
 	err = -ENOMEM;
 
-	type = lmp_esco_capable(hdev) ? ESCO_LINK : SCO_LINK;
+	if (sco_pi(sk)->force_sco) {
+	    type = SCO_LINK;
+	} else {
+	    type = lmp_esco_capable(hdev) ? ESCO_LINK : SCO_LINK;
+	}
 
 	hcon = hci_connect(hdev, type, dst);
 	if (!hcon)
@@ -660,12 +664,23 @@
 {
 	struct sock *sk = sock->sk;
 	int err = 0;
+	int len;
+	unsigned int force_sco;
 
 	BT_DBG("sk %p", sk);
 
 	lock_sock(sk);
 
 	switch (optname) {
+	case SCO_FORCESCO:
+		len = sizeof(unsigned int);
+		if (copy_from_user((char *)&force_sco, optval, len)) {
+		    err = -EFAULT;
+		    break;
+		}
+		sco_pi(sk)->force_sco = (force_sco != 0);
+		break;
+
 	default:
 		err = -ENOPROTOOPT;
 		break;
@@ -681,6 +696,7 @@
 	struct sco_options opts;
 	struct sco_conninfo cinfo;
 	int len, err = 0; 
+	unsigned int force_sco;
 
 	BT_DBG("sk %p", sk);
 
@@ -721,6 +737,14 @@
 
 		break;
 
+	case SCO_FORCESCO:
+		force_sco = sco_pi(sock)->force_sco;
+		len = sizeof(unsigned int);
+		if (copy_to_user(optval, (char *)&force_sco, len))
+			err = -EFAULT;
+
+		break;
+		
 	default:
 		err = -ENOPROTOOPT;
 		break;
--- net/bluetooth/hci_conn.c.orig	2007-11-29 15:53:15.000000000 +0900
+++ net/bluetooth/hci_conn.c	2007-12-17 18:03:28.000000000 +0900
@@ -355,7 +355,8 @@
 
 		if (acl->state == BT_CONNECTED && 
 				(sco->state == BT_OPEN || sco->state == BT_CLOSED)) {
-			if (lmp_esco_capable(hdev))
+			//if (lmp_esco_capable(hdev))
+			if (type == ESCO_LINK)
 				hci_setup_sync(sco, acl->handle);
 			else
 				hci_add_sco(sco, acl->handle);
--- include/net/bluetooth/sco.h.orig	2007-12-17 18:02:54.000000000 +0900
+++ include/net/bluetooth/sco.h	2007-12-17 18:04:17.000000000 +0900
@@ -51,6 +51,8 @@
 	__u8  dev_class[3];
 };
 
+#define SCO_FORCESCO	0x03
+
 /* ---- SCO connections ---- */
 struct sco_conn {
 	struct hci_conn	*hcon;
@@ -74,6 +76,7 @@
 	struct bt_sock	bt;
 	__u32		flags;
 	struct sco_conn	*conn;
+	unsigned int    force_sco :1;
 };
 
 #endif /* __SCO_H */

--------------000904040203070208080305
Content-Type: text/x-csrc;
 name="patch_hci_event.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch_hci_event.c"

--- ../../../kernel-2.6-bluez-patch-2.6.23-mh1/net/bluetooth/hci_event.c	2007-11-21 14:15:41.000000000 +0900
+++ hci_event.c	2007-12-05 14:39:52.000000000 +0900
@@ -1316,8 +1316,16 @@
 	hci_dev_lock(hdev);
 
 	conn = hci_conn_hash_lookup_ba(hdev, ev->link_type, &ev->bdaddr);
-	if (!conn)
-		goto unlock;
+	if (!conn) {
+	    if (ev->link_type != ACL_LINK) {
+		int t = (ev->link_type == ESCO_LINK) ? SCO_LINK : ESCO_LINK;
+		conn = hci_conn_hash_lookup_ba(hdev, t, &ev->bdaddr);
+		if (conn) 
+		    conn->type = ev->link_type;
+	    }
+	    if (!conn) 
+	    	goto unlock;
+	}
 
 	if (!ev->status) {
 		conn->handle = __le16_to_cpu(ev->handle);

--------------000904040203070208080305
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
SF.Net email is sponsored by:
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services
for just about anything Open Source.
http://ad.doubleclick.net/clk;164216239;13503038;w?http://sf.net/marketplace
--------------000904040203070208080305
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--------------000904040203070208080305--
