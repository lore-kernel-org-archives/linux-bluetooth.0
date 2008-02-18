Return-Path: <cyrus@holtmann.org>
Message-ID: <20080218143802.0sxdv3d8g4s4kk8c@www.zarb.org>
Date: Mon, 18 Feb 2008 14:38:02 +0100
From: Guillaume Bedot <littletux@zarb.org>
To: bluez-users@lists.sourceforge.net
References: <802174.10793.qm@web8410.mail.in.yahoo.com>
In-Reply-To: <802174.10793.qm@web8410.mail.in.yahoo.com>
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="=_7fqk957tz4g8"
Subject: Re: [Bluez-users] Headset not playing audio HELP PLEASE
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

--=_7fqk957tz4g8
Content-Type: text/plain;
	charset=ISO-8859-1;
	DelSp="Yes";
	format="flowed"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

Quoting pramod gurav <pramod_gurav_etc@yahoo.co.in>:
> Shall I really try Btsco way?

This patch should do fix the same issue as the previous one (you can  
revert the other one if you applied it), but using an other approach.

My headset actually accepts the synchronous connection, but as a sco  
link instead of requested esco one.

This patch makes the kernel search for both types when receiving  
"Synchronous Connection Complete" event.

> Else I replace my BT adapter?? But I have three. Two are Broadcom   
> and one is silicon wave.
> Only one is working to the maximum is the current one which is broadcom.
> Which one shall I try now?
> Sorry for too many Ques???
> Have a nice time ahead.
>
> Thanks and Best regards
> Pramod

Regards,

Guillaume B.

--=_7fqk957tz4g8
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

--=_7fqk957tz4g8
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
--=_7fqk957tz4g8
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--=_7fqk957tz4g8--
