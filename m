Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] TDK Firmware Upgrade Procedure....
From: Marcel Holtmann <marcel@rvs.uni-bielefeld.de>
To: Stephen Crane <steve.crane@rococosoft.com>
Cc: Super Smart <alwaysgone@seznam.cz>, BlueZ Mailing List <bluez-users@lists.sourceforge.net>, samlee@ptl.com.tw
In-Reply-To: <1053622053.1771.40.camel@baroque.rococosoft.com>
References: <32124.50542-5451-1424036798-1053591000@seznam.cz>
	<1053621298.17765.137.camel@pegasus>
	<1053622053.1771.40.camel@baroque.rococosoft.com>
Content-Type: text/plain
Message-Id: <1053622480.17764.144.camel@pegasus>
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
Date: 22 May 2003 18:54:29 +0200

Hi Stephen,

> I was unable to get this installed on our Win2k machines. hciconfig
> currently reports: 
> 
> hci0:   Type: USB
>         BD Address: 00:80:98:24:4E:8A ACL MTU: 192:8  SCO MTU: 64:8
>         UP RUNNING PSCAN ISCAN
>         RX bytes:2514 acl:37 sco:0 events:149 errors:0
>         TX bytes:1355 acl:35 sco:0 commands:53 errors:0
>         Features: 0xff 0xff 0x0d 0x00
>         Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
>         Link policy: RSWITCH HOLD SNIFF PARK
>         Link mode: SLAVE ACCEPT
>         Name: 'bluez-server'
>         Class: 0x000100
>         Service Classes: Unspecified
>         Device Class: Computer, Uncategorized
>         HCI Ver: 1.1 (0x1) HCI Rev: 0x86 LMP Ver: 1.1 (0x1) LMP Subver:
> 0x86
>         Manufacturer: Cambridge Silicon Radio (10)

this is exactly what I have in my list. It is a CSR BlueCore01b chip
with HCI 12.3 firmware. If the update will bring it up to HCI 16.4 it is
the first BlueCore01b based device with limited scatternet capability
that I have seen.

Regards

Marcel




-------------------------------------------------------
This SF.net email is sponsored by: ObjectStore.
If flattening out C++ or Java code to make your application fit in a
relational database is painful, don't do it! Check out ObjectStore.
Now part of Progress Software. http://www.objectstore.net/sourceforge
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
