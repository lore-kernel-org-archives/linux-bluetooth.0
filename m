Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] FC2+BT007SV+S55 - scanning works and that's it
	(l2ping, rfcomm, etc. don't)
From: Marcel Holtmann <marcel@holtmann.org>
To: Beerman <beerman@piwo.ws>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <20040609133040.41a92af8@pytong>
References: <20040609133040.41a92af8@pytong>
Content-Type: text/plain
Message-Id: <1086781430.5040.91.camel@pegasus>
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
Date: Wed, 09 Jun 2004 13:43:50 +0200

Hi,

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
> Hardware is Bluetake BT007SV USB dongle and Siemens S55 mobile phone. I want to make rfcomm as serial link for talking with mobile modem.
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

show us the "hcidump -x" as root. Looks like the PIN helper problem.

> I can(?) bind to rfcomm:
> 
> [root@pytong bluetooth]# rfcomm
> rfcomm0: 00:01:E3:13:CD:DA channel 1 clean

Of course you can. No connection will be made at this point. If you open
/dev/rfcomm0 the system tries to connect to your phone. May you wanna
try something like "cat /dev/rfcomm0".

> but cannot connect:
> 
> [root@pytong bluetooth]# rfcomm connect 00:01:E3:13:CD:DA 1
> Can't connect RFCOMM socket: Host is down

Your command syntax is wrong. Look at the manpage ;)

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by: GNOME Foundation
Hackers Unite!  GUADEC: The world's #1 Open Source Desktop Event.
GNOME Users and Developers European Conference, 28-30th June in Norway
http://2004/guadec.org
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
