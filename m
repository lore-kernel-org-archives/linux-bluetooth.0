Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Timeout message from kernel
From: Marcel Holtmann <marcel@holtmann.org>
To: Jeff Sutherland <jeffs@fairwayacademy.org>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <200402140859.36255.jeffs@fairwayacademy.org>
References: <200402121636.02074.jeffs@fairwayacademy.org>
	 <200402132310.53881.jeffs@fairwayacademy.org>
	 <1076748792.18588.152.camel@pegasus>
	 <200402140859.36255.jeffs@fairwayacademy.org>
Content-Type: multipart/mixed; boundary="=-ZrzH0b+F+63JsQHT6mUW"
Message-Id: <1076770958.14758.5.camel@pegasus>
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
Date: Sat, 14 Feb 2004 16:02:39 +0100


--=-ZrzH0b+F+63JsQHT6mUW
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi Jeff,

> > maybe we really have some endian problems here and also in hcitool. The
> > pkt_type for create_connection is for example uint16 and this explains
> > why "hcitool info ..." fails. I don't have access to a machine with big
> > endian, so most of the userspace tools are not fully tested.
> 
>  I'll have access to this machine for a little while, so if you have something 
> you'd like to try just send patches this way :-)

try this one to solve the problem with "hcitool info ...".

Regards

Marcel


--=-ZrzH0b+F+63JsQHT6mUW
Content-Disposition: attachment; filename=patch
Content-Type: text/x-patch; name=patch; charset=iso-8859-15
Content-Transfer-Encoding: 7bit

Index: hcitool.c
===================================================================
RCS file: /cvsroot/bluez/utils/tools/hcitool.c,v
retrieving revision 1.35
diff -u -r1.35 hcitool.c
--- hcitool.c	21 Dec 2003 16:08:25 -0000	1.35
+++ hcitool.c	14 Feb 2004 14:56:52 -0000
@@ -436,7 +436,7 @@
 	bacpy(&cr->bdaddr, &bdaddr);
 	cr->type = ACL_LINK;
 	if (ioctl(dd, HCIGETCONNINFO, (unsigned long) cr) < 0) {
-		if (hci_create_connection(dd, &bdaddr, HCI_DM1 | HCI_DH1, 0, 0, &handle, 25000) < 0) {
+		if (hci_create_connection(dd, &bdaddr, htobs(HCI_DM1 | HCI_DH1), 0, 0, &handle, 25000) < 0) {
 			perror("Can't create connection");
 			close(dd);
 			exit(1);
@@ -653,7 +653,7 @@
 		exit(1);
 	}
 
-	if (hci_create_connection(dd, &bdaddr, ptype, 0, role, &handle, 1000) < 0)
+	if (hci_create_connection(dd, &bdaddr, htobs(ptype), 0, role, &handle, 1000) < 0)
 		perror("Can't create connection");
 	hci_close_dev(dd);
 }

--=-ZrzH0b+F+63JsQHT6mUW--



-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
