Return-Path: <cyrus@holtmann.org>
Message-ID: <20080218144611.2wk26m1k0ko8kc04@www.zarb.org>
Date: Mon, 18 Feb 2008 14:46:11 +0100
From: Guillaume Bedot <littletux@zarb.org>
To: bluez-users@lists.sourceforge.net
References: <200802161950.38151.farcaller@gmail.com>
In-Reply-To: <200802161950.38151.farcaller@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="=_6h8kf3dmszcw"
Subject: Re: [Bluez-users] BT headset doesn't work: SCO packet for
	unknown	connection
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

This message is in MIME format.

--=_6h8kf3dmszcw
Content-Type: text/plain;
	charset=ISO-8859-1;
	DelSp="Yes";
	format="flowed"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

Quoting Vladimir Pouzanov <farcaller@gmail.com>:

> I've got 2.6.24 with bluez libs/utils 3.25
Same as me when i started to have these issues.

> I have successfully paired my headset and PC, I can l2ping it and get info.
[...]
  hci_scodata_packet: hci0 SCO packet for unknown
> connection handle 45
> hci_scodata_packet: hci0 SCO packet for unknown
> connection handle 45
> hci_scodata_packet: hci0 SCO packet for unknown
> connection handle 45
> ........
>
> force_scofix=1 doesn't help.
You may have to keep the option, or not...


> Any hints?
Please try this kernel patch and report if it fixes your problem.


Regards,

Guillaume B.


--=_6h8kf3dmszcw
Content-Type: text/x-patch; charset=UTF-8; name="also-accept-sco-links.patch"
Content-Disposition: attachment;
	filename="also-accept-sco-links.patch"
Content-Transfer-Encoding: 7bit

--- net/bluetooth/hci_event.c.orig	2008-02-18 14:02:20.000000000 +0100
+++ net/bluetooth/hci_event.c	2008-02-18 14:04:44.000000000 +0100
@@ -1313,8 +1313,14 @@
 	hci_dev_lock(hdev);
 
 	conn = hci_conn_hash_lookup_ba(hdev, ev->link_type, &ev->bdaddr);
-	if (!conn)
-		goto unlock;
+	if (!conn) {
+		if (ev->link_type==SCO_LINK)
+			conn = hci_conn_hash_lookup_ba(hdev, ESCO_LINK, &ev->bdaddr);
+			if (!conn)
+				goto unlock;
+			else
+				conn->type=SCO_LINK;
+	}
 
 	if (!ev->status) {
 		conn->handle = __le16_to_cpu(ev->handle);

--=_6h8kf3dmszcw
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
--=_6h8kf3dmszcw
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--=_6h8kf3dmszcw--
