Return-Path: <cyrus@holtmann.org>
From: Guillaume Bedot <littletux@zarb.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <BLU140-W76F2261C8313336A0D258CB200@phx.gbl>
References: <BLU140-W76F2261C8313336A0D258CB200@phx.gbl>
Content-Type: multipart/mixed; boundary="=-CXI4s2kOBbWROH1IpC43"
Date: Mon, 18 Feb 2008 16:25:19 +0100
Message-Id: <1203348319.7074.8.camel@localhost>
Mime-Version: 1.0
Subject: Re: [Bluez-users] Connecting to a two-way headset
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


--=-CXI4s2kOBbWROH1IpC43
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Hello,

Le dimanche 17 février 2008 à 17:07 +0000, mountain rides a écrit :
> Hi,
> 
> Apologies if I'm asking a repeated question, but my search just now didn't pick up any answers.
> 
> I'm trying to get a speaker-and-microphone headset working.
> 
> More exactly . . .
> 
> I have a new Sony Ericsson HBH-PV702 Bluetooth headset - that is, a headset not with just speakers, but with both a speaker and microphone.  
> 
> I also have a Dell Inspiron 6400 with Bluetooth built-in

You're mixing a bluetooth 2.0 chip and a bluetooth 1.2 headset, you may
need, in addition of wise suggestions from Leszek, to use this kernel
patch.

Regards,

Guillaume B.


--=-CXI4s2kOBbWROH1IpC43
Content-Disposition: attachment; filename=also-accept-sco-links-v2.patch
Content-Type: text/x-patch; name=also-accept-sco-links-v2.patch; charset=utf-8
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

--=-CXI4s2kOBbWROH1IpC43
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
--=-CXI4s2kOBbWROH1IpC43
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--=-CXI4s2kOBbWROH1IpC43--
