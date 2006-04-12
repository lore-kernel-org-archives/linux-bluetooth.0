Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <9a7305090604121148p6d72255ep71e83c409752816d@mail.gmail.com>
From: "Luis Alfonso Vega Garcia" <vegacom@gmail.com>
To: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Subject: [Bluez-users] iPAQ hx4700 file transfer problem
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Wed, 12 Apr 2006 13:48:25 -0500

Hi,

Does any body have sent a file to an  iPAQ hx4700?

I am trying to send a file thru bluetooth to an iPAQ hx4700. I use the
following commad:

gnome-obex-send /etc/fstab

-> Refresh, select iPAQ hx4700 device -> OK

it prints something like:

    Browsing 00:02:EE:6C:2F:AA ...
    Service Name: OBEX Object Push
    Service RecHandle: 0x10004
    Protocol Descriptor List:
      "L2CAP" (0x0100)
      "RFCOMM" (0x0003)
        Channel: 9
      "OBEX" (0x0008)
    Service Class ID List:
      "OBEX Object Push" (0x1105)
    ** Message: device 00:02:EE:6C:2F:AA (OBEX Object Push) port 9


There is no error message, but the file is NOT received by the ipaq.
I have successfully sent a file from a nokia6620 to the ipaq, from the
pc to the nokia6620, but not from the pc to the ipaq.

Is there an alternate command to send files? Maybe a non-GUI one?

Is it an error in my /etc/bluetooth/hcid.conf?
    # HCI daemon configuration file.
    options {
        autoinit yes;
        security auto;
        pairing multi;
        pin_helper /usr/bin/pinwrapper;
    }
    device {
        name "%h-%d";
        class 0x3e0100;
        iscan enable; pscan enable;
        lm accept;
        lp rswitch,hold,sniff,park;
    }

cat /etc/lsb-release
    DISTRIB_ID=3DUbuntu
    DISTRIB_RELEASE=3D6.06
    DISTRIB_CODENAME=3Ddapper
    DISTRIB_DESCRIPTION=3D"Ubuntu (The Dapper Drake Release) Development Br=
anch"

uname -a
    Linux kaola 2.6.15-18-686 #1 SMP PREEMPT Thu Mar 9 15:29:22 UTC
2006 i686 GNU/Linux

Thanks a lot in advance.

--
|               Luis Alfonso Vega Garc=EDa
|                luis.vega@skills-depot.com
|
|   GNU/Linux User =3D 326423 @ http://counter.li.org
|   LPI Certificate =3D LPI000053380 @ https://www.lpi.org
|   gpg-key =3D BD3479B0 @ hkp://pgp.mit.edu
*NOTA*: deseas una cuenta de correo gmail de m=E1s de 2500 MB?
click en: http://vegacom.blogspot.com/2005/09/gmail.html


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
