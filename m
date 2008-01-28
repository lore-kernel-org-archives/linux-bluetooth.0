Return-Path: <cyrus@holtmann.org>
From: Guillaume Bedot <littletux@zarb.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1201531946.7254.17.camel@localhost>
References: <1201336771.22866.7.camel@littletux>
	<1201338089.22866.14.camel@littletux>
	<1201341845.7769.11.camel@localhost>
	<1201509807.7254.7.camel@localhost>
	<1201531946.7254.17.camel@localhost>
Content-Type: multipart/mixed; boundary="=-+KOi676DhicA7Yc/skF9"
Date: Mon, 28 Jan 2008 18:26:18 +0100
Message-Id: <1201541178.7254.22.camel@localhost>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] [PATCH] HT820, capture and  eSCO
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


--=-+KOi676DhicA7Yc/skF9
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Re,

I'm really sorry, I forgot a part of the patch....

Here is a full version.

Regards,

Guillaume B.



--=-+KOi676DhicA7Yc/skF9
Content-Disposition: attachment;
	filename=kernel-2.6.24-check-both-ends-for-esco-feature-v3.patch
Content-Type: text/x-patch;
	name=kernel-2.6.24-check-both-ends-for-esco-feature-v3.patch;
	charset=utf-8
Content-Transfer-Encoding: 7bit

--- net/bluetooth/hci_conn.c.orig	2008-01-28 09:15:50.000000000 +0100
+++ net/bluetooth/hci_conn.c	2008-01-28 18:21:45.000000000 +0100
@@ -332,6 +332,8 @@
 	if (type == ACL_LINK)
 		return acl;
 
+	if (lmp_esco_capable(hdev) && lmp_esco_capable(acl))
+		type=ESCO_LINK;
 	if (!(sco = hci_conn_hash_lookup_ba(hdev, type, dst))) {
 		if (!(sco = hci_conn_add(hdev, type, dst))) {
 			hci_conn_put(acl);
@@ -346,7 +349,7 @@
 
 	if (acl->state == BT_CONNECTED &&
 			(sco->state == BT_OPEN || sco->state == BT_CLOSED)) {
-		if (lmp_esco_capable(hdev))
+		if (type==ESCO_LINK)
 			hci_setup_sync(sco, acl->handle);
 		else
 			hci_add_sco(sco, acl->handle);
--- net/bluetooth/sco.c.orig	2008-01-28 09:15:14.000000000 +0100
+++ net/bluetooth/sco.c	2008-01-28 09:21:00.000000000 +0100
@@ -189,7 +189,7 @@
 	struct sco_conn *conn;
 	struct hci_conn *hcon;
 	struct hci_dev  *hdev;
-	int err, type;
+	int err;
 
 	BT_DBG("%s -> %s", batostr(src), batostr(dst));
 
@@ -200,9 +200,7 @@
 
 	err = -ENOMEM;
 
-	type = lmp_esco_capable(hdev) ? ESCO_LINK : SCO_LINK;
-
-	hcon = hci_connect(hdev, type, dst);
+	hcon = hci_connect(hdev, SCO_LINK, dst);
 	if (!hcon)
 		goto done;
 
--- net/bluetooth/hci_event.c.orig	2008-01-28 09:15:31.000000000 +0100
+++ net/bluetooth/hci_event.c	2008-01-28 18:17:16.000000000 +0100
@@ -720,7 +720,7 @@
 		struct hci_conn *sco = conn->link;
 		if (sco) {
 			if (!ev->status) {
-				if (lmp_esco_capable(hdev))
+				if (lmp_esco_capable(hdev) && lmp_esco_capable(conn))
 					hci_setup_sync(sco, conn->handle);
 				else
 					hci_add_sco(sco, conn->handle);


--=-+KOi676DhicA7Yc/skF9
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
--=-+KOi676DhicA7Yc/skF9
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--=-+KOi676DhicA7Yc/skF9--
