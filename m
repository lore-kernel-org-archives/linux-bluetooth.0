Return-Path: <cyrus@holtmann.org>
From: Guillaume Bedot <littletux@zarb.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <9B6FD5D3-CFDE-4F5F-91A7-3A64B653DD78@holtmann.org>
References: <47666E1F.2000902@mizi.com>
	<d89ddf300802242243t9503c11ye3d5d2bc7ae1cebb@mail.gmail.com>
	<1204053578.6888.47.camel@localhost>
	<9B6FD5D3-CFDE-4F5F-91A7-3A64B653DD78@holtmann.org>
Content-Type: multipart/mixed; boundary="=-D0w6THeDhcoEAoC4deCk"
Date: Tue, 26 Feb 2008 22:05:24 +0100
Message-Id: <1204059924.6870.10.camel@localhost>
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


--=-D0w6THeDhcoEAoC4deCk
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Re,

Le mardi 26 février 2008 à 20:28 +0100, Marcel Holtmann a écrit :
> No. That is wrong. Using sync setup commands apply to SCO and eSCO.
> No  
> need to force anything here. Let the Bluetooth firmware inside the  
> chip do the right thing.

So I have to assume LM=device firmware and Host=device driver, the
separation between the two finally makes sense.

Here is a corrected version of the other patch.

Regards,

Guillaume B.

--=-D0w6THeDhcoEAoC4deCk
Content-Disposition: attachment; filename=also-accept-sco-links-v3.patch
Content-Type: text/x-patch; name=also-accept-sco-links-v3.patch; charset=utf-8
Content-Transfer-Encoding: 7bit

--- net/bluetooth/hci_event.c.orig	2008-02-26 17:20:11.000000000 +0100
+++ net/bluetooth/hci_event.c	2008-02-26 21:19:04.000000000 +0100
@@ -1313,6 +1313,11 @@
 	hci_dev_lock(hdev);
 
 	conn = hci_conn_hash_lookup_ba(hdev, ev->link_type, &ev->bdaddr);
+	if (!conn && ev->link_type==SCO_LINK) {
+		conn = hci_conn_hash_lookup_ba(hdev, ESCO_LINK, &ev->bdaddr);
+		if (conn)
+			conn->type=SCO_LINK;
+	}
 	if (!conn)
 		goto unlock;
 

--=-D0w6THeDhcoEAoC4deCk
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
--=-D0w6THeDhcoEAoC4deCk
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--=-D0w6THeDhcoEAoC4deCk--
