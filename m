Return-Path: <Dag.K.Rognlien@sintef.no>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [Bluez-devel] [PATCH] tcsendbreak and flow control on hciattach(csrchip)
Date: Mon, 11 Oct 2004 14:04:02 +0200
Message-ID: <39417DF3286A66428FA558987839F44F152D9B@SINTEFXCH01.sintef.no>
From: "Rognlien Dag Kristian" <Dag.K.Rognlien@sintef.no>
To: "Marcel Holtmann" <marcel@holtmann.org>
Cc: "BlueZ Mailing List" <bluez-devel@lists.sourceforge.net>
List-ID: <bluez-devel.lists.sourceforge.net>


Hello,

This solves the problem for me, but I do not know if it is needed for
other Bluetooth chips or other hardware platforms:

This patch is against 2.9, but I believe it would be the same for 2.10.

Regards,
Dag K. W. Rognlien

*** bluez-utils-2.9/tools/hciattach.c	2004-07-25 19:09:23.000000000
+0200
--- bluez-utils-2.9-ij/tools/hciattach.c	2004-10-11
13:45:26.670694392 +0200
***************
*** 899,906 ****
 =20
  	tcflush(fd, TCIOFLUSH);
 =20
! 	if (send_break)
  		tcsendbreak(fd, 0);
 =20
  	if (u->init && u->init(fd, u, &ti) < 0)
  		return -1;
--- 899,908 ----
 =20
  	tcflush(fd, TCIOFLUSH);
 =20
! 	if (send_break){
  		tcsendbreak(fd, 0);
+ 		usleep(500000);
+ 	}
 =20
  	if (u->init && u->init(fd, u, &ti) < 0)
  		return -1;
