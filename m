Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] rfcomm stty -echo
From: Marcel Holtmann <marcel@rvs.uni-bielefeld.de>
To: "Pering, Trevor" <trevor.pering@intel.com>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: 
	<DD755978BA8283409FB0087C39132BD1023FBACD@fmsmsx404.fm.intel.com>
References: 
	<DD755978BA8283409FB0087C39132BD1023FBACD@fmsmsx404.fm.intel.com>
Message-Id: <1059559745.26914.145.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Unsubscribe: 
	<https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: 
	<http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: 30 Jul 2003 12:08:59 +0200
Content-Type: multipart/mixed; boundary="=-dwhqNJF51xmrWsgFbEqe"


--=-dwhqNJF51xmrWsgFbEqe
Content-Transfer-Encoding: 7bit
Content-Type: text/plain

Hi Trevor,

> Basically, if I connect to my BlueZ device (acting as an "rfcomm listen"
> server), it connects ok but the /dev/rfcomm0 serial port is in "stty
> echo" mode -- which means that any data sent from the remote client get
> echoed back -- which is not what I want in this case. 
> 
> To fix this, one would normally type "stty -F /dev/rfcomm0 -echo" --
> which works nicely *after* the connection has been formed. However,
> before the connection has been made, I get a "no such device" error on
> /dev/rfcomm0.  
> 
> Any thoughts on how to get around this problem?  Is there some way to
> fix this cleanly? Is this the behavior rfcomm should have? 

the problem is that we use the default termios settings for RFCOMM.
Maybe it is bad to enable echo by default. Every application which sets
their own termios is working fine, but others will get problems.

The attached patch disables echo for every terminal.

Regards

Marcel


--=-dwhqNJF51xmrWsgFbEqe
Content-Disposition: attachment; filename=patch-rfcomm-tty-no-echo
Content-Transfer-Encoding: quoted-printable
Content-Type: text/x-patch; NAME=patch-rfcomm-tty-no-echo; CHARSET=ISO-8859-15

diff -urN linux-2.4.21/net/bluetooth/rfcomm/tty.c linux-2.4.21-mh/net/bluet=
ooth/rfcomm/tty.c
--- linux-2.4.21/net/bluetooth/rfcomm/tty.c	Fri Jun 13 16:51:39 2003
+++ linux-2.4.21-mh/net/bluetooth/rfcomm/tty.c	Wed Jul 30 12:01:29 2003
@@ -905,8 +905,8 @@
=20
 	/* Register the TTY driver */
 	rfcomm_tty_driver.init_termios =3D tty_std_termios;
-	rfcomm_tty_driver.init_termios.c_cflag =3D B9600 | CS8 | CREAD | HUPCL | =
CLOCAL;
-	rfcomm_tty_driver.flags =3D TTY_DRIVER_REAL_RAW;
+	rfcomm_tty_driver.init_termios.c_cflag =3D B115200 | CS8 | CREAD | HUPCL =
| CLOCAL;
+	rfcomm_tty_driver.init_termios.c_lflag =3D 0;
=20
 	if (tty_register_driver(&rfcomm_tty_driver)) {
 		BT_ERR("Can't register RFCOMM TTY driver");

--=-dwhqNJF51xmrWsgFbEqe--
