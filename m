Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] MyCom dongle with Broadcom ID 0a5c:2009 works now
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <1109194045.3700.8.camel@archer.roalt.com>
References: <1109194045.3700.8.camel@archer.roalt.com>
Content-Type: text/plain
Message-Id: <1109242656.5645.21.camel@notepaq>
Mime-Version: 1.0
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
Date: Thu, 24 Feb 2005 11:57:36 +0100

Hi Roalt,

> After some of the message in the devel-mailing list, I tried to get my
> Bluetooth USB dongle, bought at a dutch computer store 'mycom', working
> again. (In december it was not yet supported). This dongle is probably
> the same inside as the recent iogear 311 usb dongle discussed in bluez-
> devel
> 
> With Marcel Hotmann's patch 2.6.10-mh4 applied on a Fedora Core 3's
> 2.6.10-1.766_FC3 kernel sources, it works! So maybe it can be added to
> the supported hardware list (Marcel?).

I sent an announcement to the mailing list that I got it working. It is
another special init sequence for switch HID to HCI mode.

Send me "hciconfig -a" and the content of /proc/bus/usb/devices.

> I'm not sure why, but the hciconfig -a command does a segmentation dump
> at the end. Here is the trace when I run it from gdb:
> 
> (gdb) run -a
> Starting program: /usr/sbin/hciconfig -a
> (no debugging symbols found)...(no debugging symbols found)...(no
> debugging symb ols found)...(no debugging symbols found)...hci0:
> Type: USB
>         BD Address: 00:02:72:C0:23:70 ACL MTU: 377:10  SCO MTU: 16:0
>         UP RUNNING PSCAN ISCAN
>         RX bytes:381671 acl:11367 sco:0 events:6509 errors:0
>         TX bytes:2103547 acl:10988 sco:0 commands:91 errors:0
>         Features: 0xff 0xff 0x0d 0x38 0x08 0x08 0x00 0x00
>         Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
>         Link policy: RSWITCH HOLD SNIFF PARK
>         Link mode: SLAVE ACCEPT
>         Name: 'archer.roalt.com-0'
>         Class: 0x120104
> 
> Program received signal SIGSEGV, Segmentation fault.
> 0x0000002a957d3b6c in __find_specmb () from /lib64/tls/libc.so.6
> (gdb) bt
> #0  0x0000002a957d3b6c in __find_specmb () from /lib64/tls/libc.so.6
> #1  0x0000002a957ba6d2 in vfprintf () from /lib64/tls/libc.so.6
> #2  0x0000002a957c3048 in printf () from /lib64/tls/libc.so.6
> #3  0x000000552aaaee88 in ?? () from /usr/sbin/hciconfig
> #4  0x000000552aaaf8a9 in ?? () from /usr/sbin/hciconfig
> #5  0x000000552aaaf959 in ?? () from /usr/sbin/hciconfig
> #6  0x000000552aaafbfd in main () from /usr/sbin/hciconfig
> 
> Oh, by the way, as you can see, I run 64-bit linux on an Athlon 64
> system.

Are these the latest libs and utils? It should be fixed, but I have no
access to a AMD64 machine for checking these.

Regards

Marcel




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
