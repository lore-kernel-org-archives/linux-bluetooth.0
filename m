Return-Path: <cyrus@holtmann.org>
From: Guillaume Bedot <littletux@zarb.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <841732.94094.qm@web8405.mail.in.yahoo.com>
References: <841732.94094.qm@web8405.mail.in.yahoo.com>
Content-Type: multipart/mixed; boundary="=-jllVLR+WOPNqXAxjsdIo"
Date: Thu, 14 Feb 2008 11:17:44 +0100
Message-Id: <1202984264.7948.41.camel@localhost>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] Fw: [Bluez-users] Headset not playing audio
	HELP	PLEASE
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


--=-jllVLR+WOPNqXAxjsdIo
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Hello,

Le mercredi 13 février 2008 à 10:58 +0530, pramod gurav a écrit :

> Feb 13 09:52:43 localhost kernel: hci_scodata_packet: hci0 SCO packet
> for unknown connection handle 1
> 
> Feb 13 09:52:43 localhost kernel: hci_scodata_packet: hci0 SCO packet
> for unknown connection handle 1

Which kernel do you use now ?

You may have the same issue as me with the Motorola HT820 headset.

I have exactly the same type of messages, at the same time.

> [root@localhost Pramod]# /usr/local/sbin/hciconfig -a 
> hci0:   Type: USB
>         BD Address: 00:02:72:CE:5B:80 ACL MTU: 1017:8 SCO MTU: 64:0
>         UP RUNNING PSCAN ISCAN
>         RX bytes:5974443 acl:279 sco:116978 events:188 errors:0
>         TX bytes:4222 acl:168 sco:0 commands:90 errors:0
>         Features: 0xff 0xff 0x8d 

> 0xfe 
It seems like me, your bluetooth dongle supports eSCO, but not your
headset.

(from http://support.zenwalk.org/index.php?topic=2060.0;wap2)
   Device Name: HBH-600
     LMP Version: 1.1 (0x1) LMP Subversion: 0x9240
     Manufacturer: Philips Semiconductors (37)
     Features: 0xbc 0x28 0x01 0x00 0x00 0x00 0x00 0x00
          <encryption> <slot offset> <timing accuracy> <role switch>
          <sniff mode> <SCO link> <HV3 packets> <CVSD>

First, you can try a old bluetooth dongle =< 1.2 and not patch anything
if you have one.

Alternatively, you can try a slightly older kernel or patch your kernel
to revert "patch-2.6.23-mh1", that will remove eSCO support, but also a
lot of other things.
I have an older kernel without this patch included ( 2.6.22.18 from
mandriva ) that works fine with both of my headsets.

Or if you feel adventurous, you can try the attached patch of mine (you
have to know i am not a kernel dev but just a bluez user), which may
solve your problem with *this headset*.

Unfortunately, it will probably cause others with eSCO capable headsets,
because a SCO link is always used the first time the headset connects
itself, as the headset features are not known yet (mine, PROF PBH-6W,
works only since the second try with this patch).

Regards,

Guillaume B.

--=-jllVLR+WOPNqXAxjsdIo
Content-Disposition: attachment;
	filename=force-sco-link-until-headset-features-are-known.patch
Content-Type: text/x-patch;
	name=force-sco-link-until-headset-features-are-known.patch;
	charset=utf-8
Content-Transfer-Encoding: 7bit

--- net/bluetooth/hci_conn.c.orig	2008-01-28 09:15:50.000000000 +0100
+++ net/bluetooth/hci_conn.c	2008-02-14 10:34:09.000000000 +0100
@@ -332,6 +332,9 @@
 	if (type == ACL_LINK)
 		return acl;
 
+	if (lmp_esco_capable(hdev) && lmp_esco_capable(acl))
+		type=ESCO_LINK;
+
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
--- net/bluetooth/hci_event.c.orig	2008-01-28 09:15:31.000000000 +0100
+++ net/bluetooth/hci_event.c	2008-02-14 10:26:35.000000000 +0100
@@ -720,7 +720,7 @@
 		struct hci_conn *sco = conn->link;
 		if (sco) {
 			if (!ev->status) {
-				if (lmp_esco_capable(hdev))
+				if (lmp_esco_capable(hdev) && lmp_esco_capable(conn))
 					hci_setup_sync(sco, conn->handle);
 				else
 					hci_add_sco(sco, conn->handle);
@@ -771,7 +771,8 @@
 
 		hci_dev_unlock(hdev);
 
-		if (ev->link_type == ACL_LINK || !lmp_esco_capable(hdev)) {
+		if (ev->link_type == ACL_LINK || !lmp_esco_capable(hdev) 
+				|| !lmp_esco_capable(conn)) {
 			struct hci_cp_accept_conn_req cp;
 
 			bacpy(&cp.bdaddr, &ev->bdaddr);
--- net/bluetooth/sco.c.orig	2008-01-28 09:15:14.000000000 +0100
+++ net/bluetooth/sco.c	2008-02-14 10:36:54.000000000 +0100
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
 


--=-jllVLR+WOPNqXAxjsdIo
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
--=-jllVLR+WOPNqXAxjsdIo
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--=-jllVLR+WOPNqXAxjsdIo--
