Return-Path: <bluez-devel-admin@lists.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [Bluez-devel] [PATCH] tcsendbreak and flow control onhciattach(csrchip)
Message-ID: <39417DF3286A66428FA558987839F44F152D9C@SINTEFXCH01.sintef.no>
From: "Rognlien Dag Kristian" <Dag.K.Rognlien@sintef.no>
To: "BlueZ Mailing List" <bluez-devel@lists.sourceforge.net>
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Mon, 11 Oct 2004 15:11:05 +0200




> -----Original Message-----
> From: Marcel Holtmann [mailto:marcel@holtmann.org]=20
> Sent: 11. oktober 2004 14:30
> Subject: RE: [Bluez-devel] [PATCH] tcsendbreak and flow=20
> control onhciattach(csrchip)
>=20
>=20
> please use "diff -u".

Ok, makes sense.

Here is a more readable patch:

--- bluez-utils-2.9/tools/hciattach.c	2004-07-25 19:09:23.000000000
+0200
+++ bluez-utils-2.9-ij/tools/hciattach.c	2004-10-11
13:45:26.670694392 +0200
@@ -899,8 +899,10 @@
=20
 	tcflush(fd, TCIOFLUSH);
=20
-	if (send_break)
+	if (send_break){
 		tcsendbreak(fd, 0);
+		usleep(500000);
+	}
=20
 	if (u->init && u->init(fd, u, &ti) < 0)
 		return -1;


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
