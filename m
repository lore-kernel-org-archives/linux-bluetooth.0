Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] pairing on x86_64
From: Marcel Holtmann <marcel@holtmann.org>
To: Volker <kokor.hekkus@gmx.de>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <200402211434.54164.kokor.hekkus@gmx.de>
References: <200402211252.15735.kokor.hekkus@gmx.de>
	 <1077365351.2716.2.camel@pegasus>  <200402211434.54164.kokor.hekkus@gmx.de>
Content-Type: multipart/mixed; boundary="=-1g7qTpncWEp12WU/bVG1"
Message-Id: <1077371771.2716.5.camel@pegasus>
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
Date: Sat, 21 Feb 2004 14:56:11 +0100


--=-1g7qTpncWEp12WU/bVG1
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi Volker,

> security.c loads the right pin at startup.
> during pairing, it enters 
> 
> gboolean io_security_event(GIOChannel *chan, GIOCondition cond, gpointer data)
> 
> and leaves the method at this point:
> 
>         if (type != HCI_EVENT_PKT) {
>                 syslog(LOG_INFO, "** type not HCI_EVENT_PKT");
>                 return TRUE;
>         }
> 
> any more points, where I should've a look at?

try the attached patch.

Regards

Marcel


--=-1g7qTpncWEp12WU/bVG1
Content-Disposition: attachment; filename=patch
Content-Type: text/x-patch; name=patch; charset=iso-8859-15
Content-Transfer-Encoding: 7bit

diff -urN utils/hcid/security.c utils-mh/hcid/security.c
--- utils/hcid/security.c	2004-02-17 19:34:30.000000000 +0100
+++ utils-mh/hcid/security.c	2004-02-21 14:54:37.000000000 +0100
@@ -367,7 +367,8 @@
 {
 	char buf[HCI_MAX_EVENT_SIZE], *ptr = buf;
 	struct hci_dev_info *di = (void *) data;
-	int len, type, dev;
+	unsigned char type;
+	int len, dev;
 	hci_event_hdr *eh;
 	GIOError err;
 

--=-1g7qTpncWEp12WU/bVG1--



-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
