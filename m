Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Michal Semler <cijoml@volny.cz>
Reply-To: cijoml@volny.cz
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] FC2+BT007SV+S55 - scanning works and that's it (l2ping, rfcomm, etc. don't)
References: <20040609133040.41a92af8@pytong>
In-Reply-To: <20040609133040.41a92af8@pytong>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200406091403.41729.cijoml@volny.cz>
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
Date: Wed, 9 Jun 2004 14:03:40 +0200

Problem is follows:

Siemens mobiles wants pairing everytime - so for l2ping too

Michal

On Wednesday 09 of June 2004 13:30, Beerman wrote:
> Hi.
>
> I am using Fedora Core 2 (2.6.5)
>
> My bluez stuff is:
>
> [root@pytong bluetooth]# rpm -qa|grep bluez
> bluez-sdp-1.5-2.1
> bluez-bluefw-1.0-2
> bluez-libs-2.5-2.1
> bluez-hcidump-1.5-4
> bluez-pan-1.1-4
> bluez-utils-2.4-3
>
> Hardware is Bluetake BT007SV USB dongle and Siemens S55 mobile phone. I
> want to make rfcomm as serial link for talking with mobile modem.
>
> Running BlueZ:
>
> [root@pytong bluetooth]# service bluetooth start
> Starting Bluetooth:                                        [  OK  ]
>
> [root@pytong bluetooth]# lsmod
> Module                  Size  Used by
> rfcomm                 27164  1
> l2cap                  16004  5 rfcomm
> hci_usb                 9604  3
> bluetooth              33636  11 rfcomm,l2cap,hci_usb
> .
> ...........
>
> Scanning finds my phone:
>
> [root@pytong bluetooth]# hcitool scan
> Scanning ...
>         00:01:E3:13:CD:DA       S55
>
> but cannot ping it:
>
> [root@pytong bluetooth]# l2ping 00:01:E3:13:CD:DA
> Can't connect.: Invalid exchange
>
> I can(?) bind to rfcomm:
>
> [root@pytong bluetooth]# rfcomm
> rfcomm0: 00:01:E3:13:CD:DA channel 1 clean
>
> but cannot connect:
>
> [root@pytong bluetooth]# rfcomm connect 00:01:E3:13:CD:DA 1
> Can't connect RFCOMM socket: Host is down
>
> What can be wrong ?
>
> Thank you very much for help.
>
>
> What can be wrong ?
>
>
> -------------------------------------------------------
> This SF.Net email is sponsored by: GNOME Foundation
> Hackers Unite!  GUADEC: The world's #1 Open Source Desktop Event.
> GNOME Users and Developers European Conference, 28-30th June in Norway
> http://2004/guadec.org
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users


-------------------------------------------------------
This SF.Net email is sponsored by: GNOME Foundation
Hackers Unite!  GUADEC: The world's #1 Open Source Desktop Event.
GNOME Users and Developers European Conference, 28-30th June in Norway
http://2004/guadec.org
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
