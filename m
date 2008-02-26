Return-Path: <cyrus@holtmann.org>
From: Guillaume Bedot <littletux@zarb.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <d89ddf300802242243t9503c11ye3d5d2bc7ae1cebb@mail.gmail.com>
References: <47666E1F.2000902@mizi.com>
	<d89ddf300802242243t9503c11ye3d5d2bc7ae1cebb@mail.gmail.com>
Content-Type: multipart/mixed; boundary="=-TM82HBT0rqqRvmj49ZdY"
Date: Tue, 26 Feb 2008 20:19:38 +0100
Message-Id: <1204053578.6888.47.camel@localhost>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] forcing SCO connection patch
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


--=-TM82HBT0rqqRvmj49ZdY
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Hello,

Le dimanche 24 février 2008 à 23:43 -0700, Brad Midgley a écrit :
[...] 
> Marcel looked at this patch and came back with the comments below. Can
> you revisit it? I think some other people are seeing the same issues.
> The patch won't go upstream until Marcel likes it.
> 
> the patch you sent me is fully broken. First of all the coding style
> is wrong. Does nobody have learned this by now? I always look for that
> first before even reading the patch. Second the case where an
> ESCO_LINK returns NULL is broken and will fall over and crash.
> 
It was about the patch on the wiki (one of mine, shame on me).

Marcel is right, this patch is an awful and moreover buggy patch (and I
found nothing in the specification stating a SCO connection shall be
opened as a fallback for an eSCO one, or shall not, so I abandonned that
way).

However, I think the first patch
(force-sco-link-until-headset-features-are-known.patch), despite badly
styled and named, was correct.

Everywhere I found a eSCO feature test for the local device, I added a
test for the remote device eSCO/EV3 feature.

An eSCO connection is then used only when both the local and the remote
devices supports the feature, else a SCO connection is requested with
headsets not supporting eSCO.

The headset's features mask should be already available, as the request
is sent just after establishing the underlying ACL connection.

And it shall be known before establishing a synchronous connection with
the right packet type(s), according to the spec (maybe we should ensure
we get a response to this features request ?).

I tried to fix style issues in this new patch, let me now if some
remain.

The other patch (also-accept-sco-links-v2.patch) is not needed at all,
as the case should not occur anymore with the attached patch applied.

Best regards,

Guillaume B.

PS:
I have sometimes a hci reset after the "synchronous connection complete"
event, when playing with the two headsets alternatively (as with the
other patch) but didn't understand why yet.
I hope it was not too long.

--=-TM82HBT0rqqRvmj49ZdY
Content-Disposition: attachment; filename=also_use_headset_features.patch
Content-Type: text/x-patch; name=also_use_headset_features.patch; charset=utf-8
Content-Transfer-Encoding: 7bit

--- net/bluetooth/hci_conn.c.orig	2008-02-26 17:19:55.000000000 +0100
+++ net/bluetooth/hci_conn.c	2008-02-26 17:24:22.000000000 +0100
@@ -326,6 +326,9 @@
 	if (type == ACL_LINK)
 		return acl;
 
+	if (lmp_esco_capable(hdev) && lmp_esco_capable(acl))
+		type = ESCO_LINK;
+
 	if (!(sco = hci_conn_hash_lookup_ba(hdev, type, dst))) {
 		if (!(sco = hci_conn_add(hdev, type, dst))) {
 			hci_conn_put(acl);
@@ -340,7 +343,7 @@
 
 	if (acl->state == BT_CONNECTED &&
 			(sco->state == BT_OPEN || sco->state == BT_CLOSED)) {
-		if (lmp_esco_capable(hdev))
+		if (type == ESCO_LINK)
 			hci_setup_sync(sco, acl->handle);
 		else
 			hci_add_sco(sco, acl->handle);
--- net/bluetooth/hci_event.c.orig	2008-02-26 17:20:11.000000000 +0100
+++ net/bluetooth/hci_event.c	2008-02-26 17:24:22.000000000 +0100
@@ -720,7 +720,7 @@
 		struct hci_conn *sco = conn->link;
 		if (sco) {
 			if (!ev->status) {
-				if (lmp_esco_capable(hdev))
+				if (lmp_esco_capable(hdev) && lmp_esco_capable(conn))
 					hci_setup_sync(sco, conn->handle);
 				else
 					hci_add_sco(sco, conn->handle);
@@ -771,7 +771,7 @@
 
 		hci_dev_unlock(hdev);
 
-		if (ev->link_type == ACL_LINK || !lmp_esco_capable(hdev)) {
+		if (ev->link_type == ACL_LINK || !lmp_esco_capable(hdev) || !lmp_esco_capable(conn)) {
 			struct hci_cp_accept_conn_req cp;
 
 			bacpy(&cp.bdaddr, &ev->bdaddr);
--- net/bluetooth/sco.c.orig	2008-02-26 17:20:21.000000000 +0100
+++ net/bluetooth/sco.c	2008-02-26 17:24:22.000000000 +0100
@@ -182,7 +182,7 @@
 	struct sco_conn *conn;
 	struct hci_conn *hcon;
 	struct hci_dev  *hdev;
-	int err, type;
+	int err;
 
 	BT_DBG("%s -> %s", batostr(src), batostr(dst));
 
@@ -193,9 +193,8 @@
 
 	err = -ENOMEM;
 
-	type = lmp_esco_capable(hdev) ? ESCO_LINK : SCO_LINK;
-
-	hcon = hci_connect(hdev, type, dst);
+	/* SCO or ESCO is decided in hci_connect */
+	hcon = hci_connect(hdev, SCO_LINK, dst);
 	if (!hcon)
 		goto done;
 

--=-TM82HBT0rqqRvmj49ZdY
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
--=-TM82HBT0rqqRvmj49ZdY
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--=-TM82HBT0rqqRvmj49ZdY--
