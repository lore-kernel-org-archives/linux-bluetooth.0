Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] pairing on x86_64
From: Marcel Holtmann <marcel@holtmann.org>
To: Volker Fritzsch <kokor.hekkus@gmx.de>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <200402211508.47481.kokor.hekkus@gmx.de>
References: <200402211252.15735.kokor.hekkus@gmx.de>
	 <200402211434.54164.kokor.hekkus@gmx.de> <1077371771.2716.5.camel@pegasus>
	 <200402211508.47481.kokor.hekkus@gmx.de>
Content-Type: multipart/mixed; boundary="=-odsdo0U6E6zRoVv4ZyuB"
Message-Id: <1077373108.2716.8.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Sat, 21 Feb 2004 15:18:28 +0100


--=-odsdo0U6E6zRoVv4ZyuB
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi Volker,

> unfortunatly, the patch didn't fix it.

maybe this one helps.

Regards

Marcel


--=-odsdo0U6E6zRoVv4ZyuB
Content-Disposition: attachment; filename=patch
Content-Type: text/x-patch; name=patch; charset=iso-8859-15
Content-Transfer-Encoding: 7bit

diff -urN utils/hcid/security.c utils-mh/hcid/security.c
--- utils/hcid/security.c	2004-02-17 19:34:30.000000000 +0100
+++ utils-mh/hcid/security.c	2004-02-21 15:15:53.000000000 +0100
@@ -365,9 +365,9 @@
 
 gboolean io_security_event(GIOChannel *chan, GIOCondition cond, gpointer data)
 {
-	char buf[HCI_MAX_EVENT_SIZE], *ptr = buf;
+	unsigned char buf[HCI_MAX_EVENT_SIZE], *ptr = buf;
 	struct hci_dev_info *di = (void *) data;
-	int len, type, dev;
+	int len, dev;
 	hci_event_hdr *eh;
 	GIOError err;
 
@@ -385,11 +385,11 @@
 		return FALSE;
 	}
 
-	type = *ptr++;
-
-	if (type != HCI_EVENT_PKT)
+	if (buf[0] != HCI_EVENT_PKT)
 		return TRUE;
 
+	ptr++;
+
 	eh = (hci_event_hdr *) ptr;
 	ptr += HCI_EVENT_HDR_SIZE;
 

--=-odsdo0U6E6zRoVv4ZyuB--



-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
