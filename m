Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Content-Type: text/plain;
  charset="iso-8859-1"
From: Ronny L Nilsson <bb@arbetsmyra.dyndns.org>
To: bluez-devel@lists.sourceforge.net, Johan Hedin <sua@home.se>
Subject: Re: [Bluez-devel] HCI reset problem
References: <200507021912.29173.sua@home.se>
In-Reply-To: <200507021912.29173.sua@home.se>
MIME-Version: 1.0
Message-Id: <20050702211535.3F4B356F@arbetsmyra.dyndns.org>
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Sat, 2 Jul 2005 23:15:20 +0200


Hi
This is probably of limited use but one can see from your hciconfig 
output your dongle hit a trouble. Here's some cut'n-paste from one of 
the CSR developer manuals of the meanings:

>         Panic code:   0x16
An irrecoverable error has occurred within the Bluetooth Link 
Controller.

>         Fault code:   0x1e
Either the chip received an unrecognised RFCOMM (upper interface) 
command message from the host or the chip ran out of pool memory when 
processing the message. In either case the message has been discarded. 
Presuming the fault was issued because of an invalid RFCOMM message, 
the firmware has survived the problem. 

Since your dongle seem to do a reset it "looks" like the mem pool ran 
out. But this is only a gues of mine. Is the error reproducable when 
using MS-Windows? In that case the donge firmware might need an update.

BR
/Ronny Nilsson




--------------------------
> Hi everyone!
>
> After spending a few days googling and browsing the e-mail archives
> of bluez-devel, I need some expert help for my strange "HCI
> reset"/USB disconnect problem.
>
 .....
> My system is Fedora Core 4 (kernel 2.6.11) on a Dell Latitude X300
> with a Dell TrueMobile 300 Bluetooth built in USB dongle (CSR
> BlueCore02 chip). I'm using the latest bluez-libs, bluez-utils and
> bluez-hcidump from bluez.org and NOT the Fedora RPM:s (even though
> the problem is the same with the Fedora supplied bluez packages)
>
> hciconfig says the following:
>
> [root@x300 ~]# hciconfig -a hci0 version features revision
> hci0:   Type: USB
>         BD Address: 00:10:C6:60:34:21 ACL MTU: 192:8 SCO MTU: 64:8
>         HCI Ver: 1.2 (0x2) HCI Rev: 0x4f2 LMP Ver: 1.2 (0x2) LMP
> Subver: 0x4f2 Manufacturer: Cambridge Silicon Radio (10)
>         Features: 0xff 0xff 0x8f 0x78 0x18 0x18 0x00 0x80
>                 <3-slot packets> <5-slot packets> <encryption> <slot
> offset> <timing accuracy> <role switch> <hold mode> <sniff mode>
> <park state> <RSSI> <channel quality> <SCO link> <HV2 packets> <HV3
> packets> <u-law log> <A-law log> <CVSD> <paging scheme> <power
> control> <transparent SCO> <broadcast encrypt> <enhanced iscan>
> <interlaced iscan> <interlaced pscan> <inquiry with RSSI> <AFH cap.
> slave> <AFH class. slave> <AFH cap. master> <AFH class. master>
> <extended features> Build 1266
>         Chip version: BlueCore02-External
>         Max key size: 128 bi
>         SCO mapping:  HCI
>         Panic code:   0x16
>         Fault code:   0x1e
>


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
