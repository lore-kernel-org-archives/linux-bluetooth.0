Return-Path: <cyrus@holtmann.org>
Message-ID: <20080218154244.c5nqdwrvb4wcsgos@www.zarb.org>
Date: Mon, 18 Feb 2008 15:42:44 +0100
From: Guillaume Bedot <littletux@zarb.org>
To: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="=_37yk42y32jcw"
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

--=_37yk42y32jcw
Content-Type: text/plain;
	charset=ISO-8859-1;
	DelSp="Yes";
	format="flowed"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

Re,

Quoting Guillaume Bedot <littletux@zarb.org>:
> Quoting Vladimir Pouzanov <farcaller@gmail.com>:
>> Any hints?
> Please try this kernel patch and report if it fixes your problem.
>
Better try this new version...

Regards,

Guillaume B.

--=_37yk42y32jcw
Content-Type: text/x-patch; charset=utf-8;
	name="also-accept-sco-links-v2.patch"
Content-Disposition: attachment;
	filename="also-accept-sco-links-v2.patch"
Content-Transfer-Encoding: 7bit

--- net/bluetooth/hci_event.c.orig	2008-02-18 14:02:20.000000000 +0100
+++ net/bluetooth/hci_event.c	2008-02-18 15:19:04.000000000 +0100
@@ -1313,8 +1313,15 @@
 	hci_dev_lock(hdev);
 
 	conn = hci_conn_hash_lookup_ba(hdev, ev->link_type, &ev->bdaddr);
-	if (!conn)
-		goto unlock;
+	if (!conn) {
+		if (ev->link_type==SCO_LINK) {
+			conn = hci_conn_hash_lookup_ba(hdev, ESCO_LINK, &ev->bdaddr);
+			if (!conn)
+				goto unlock;
+			else
+				conn->type=SCO_LINK;
+			}
+	}
 
 	if (!ev->status) {
 		conn->handle = __le16_to_cpu(ev->handle);

--=_37yk42y32jcw
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
--=_37yk42y32jcw
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--=_37yk42y32jcw--
