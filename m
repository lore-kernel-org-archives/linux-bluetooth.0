Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: "Tobias Sprafke" <webmaster@baxter-net.de>
To: "Eric Chapman" <eric@lnt.uni-saarland.de>
Cc: "BlueZ Mailing List" <bluez-devel@lists.sourceforge.net>
Subject: AW: [Bluez-devel] USB Device hangs
Message-ID: <DGELJAKAPGMFDACACGBECEJPCCAA.webmaster@baxter-net.de>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-Reply-To: <404DA19C.304@lnt.uni-saarland.de>
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
Date: Tue, 9 Mar 2004 14:10:16 +0100

Hi all.


After installing bluez on the DevBoard, I do "hciconfig -a hci0 up" and t=
hen
"hcitool scan"
and the scan find my other BT-Devices !!
(But only one time !? )

When I do "hcitool scan" again, the system freez, too
and my terminal program prints hundred of row's, like that:
-------------------------------------------------------------------------=
---
-------------
....
Warning: kfree_skb on hard IRQ c008e1bc
Scheduling in interrupt
kernel BUG at sched.c:564!
Scheduling in interrupt
kernel BUG at sched.c:564!
Scheduling in interrupt
kernel BUG at sched.c:564!
Warning: kfree_skb on hard IRQ c008e1bc
Warning: kfree_skb on hard IRQ c008e1bc
Warning: kfree_skb on hard IRQ c008e1bc
Warning: kfree_skb on hard IRQ c008e1bc
Warning: kfree_skb on hard IRQ c008e1bc
Warning: kfree_skb on hard IRQ c008e1bc
Warning: kfree_skb on hard IRQ c008e1bc
Warning: kfree_skb on hard IRQ c008e1bc
Warning: kfree_skb on hard IRQ c008e1bc
Warning: kfree_skb on hard IRQ c008e1bc
Warning: kfree_skb on hard IRQ c008e1bc
Scheduling in interrupt
...
Scheduling in interrupt
kernel BUG at sched.c:564!
kernel BUG at slab.c:971!
kernel BUG at slab.c:971!
Scheduling in interrupt
kernel BUG at sched.c:564!
Scheduling in interrupt
kernel BUG at sched.c:564!
Scheduling in interrupt
kernel BUG at sched.c:564!
Warning: kfree_skb on hard IRQ c008e1bc
Scheduling in interrupt
kernel BUG at sched.c:564!
Unable to handle kernel access at virtual address 355ee000
Kernel panic: Aiee, killing interrupt handler!
In interrupt handler - not syncing
 Oops: bitten by watchdog
IRP: c0007f64 SRP: c0007f18 DCCR: 00000424 USP: 9ffff1d8 MOF: 00000000
 r0: c01080e4  r1: c00ed150   r2: c012e4c8  r3: c0ce4000
 r4: 9ffff210  r5: 00000001   r6: 9ffffe1c  r7: 00000000
 r8: 00000002  r9: 00000000  r10: 00000000 r11: 00000000
r12: 00000000 r13: 00000000 oR10: 00000000
R_MMU_CAUSE: 355ee809
Process klogd (pid: 118, stackpage=3Dc0ce4000)

Stack from 9ffff1d8:
       Failing address 0x9ffff1d8

Call Trace: Failing address 0x9ffff1d8

Stack from c0ce5df8:
       c0008532 c0ce5e74 c005b912 c005ba70 00000000 00000000 9ffff210
c0ce4000
       c012e4c8 c00ed150 c0ce5e30 c005baf0 c01080e4 c005b7b4 00000000
00000000
       00000000 00000000 00000000 00000000 00000000 00000002 00000000
9ffffe1c
Call Trace: [<c0008532>] [<c005b912>] [<c005ba70>] [<c005baf0>] [<c005b7b=
4>]
[<c0007f18>] [<c0007f64>]
       [<c0008532>] [<c0007f18>] [<c0008532>] [<c00093a6>] [<c0008532>]
[<c005de42>] [<c0089d8a>] [<c0089f2c>]
       [<c00200d8>] [<c005dbf0>] [<c005b72a>] [<c005b670>]
Code: f1 20 7a 86 3f bd 70 aa 05 c0 b0 25 (ff) e0 0f 05 fc e1 7e be 84 e2=
 fe
0b
-------------------------------------------------------------------------=
---
-------------------------------------------

"hcitool dev", "hcitool inq" and "hcitool name bdaddr" works fine.

The effect of "hcitool info bdaddr" is a kernel panic !


I use a CSR-BT-Module, which is connected via USB, too.


Any Ideas?

Regards
Tobias Sprafke

Mobile: +49 (0) 177 64 32 313
Fon:    +49 (0) 208 75 10 123
E-Mail: tobias.sprafke@baxter-net.de

Have a lot of fun ... :-)

-----Urspr=FCngliche Nachricht-----
Von: bluez-devel-admin@lists.sourceforge.net
[mailto:bluez-devel-admin@lists.sourceforge.net]Im Auftrag von Eric
Chapman
Gesendet: Dienstag, 9. M=E4rz 2004 11:51
Cc: BlueZ Mailing List
Betreff: [Bluez-devel] USB Device hangs


Hi List,

I am currently using a Axis Developer Board (Embedded Linux), for which
I have cross-compiled parts of BlueZ. I am using 2 Bluettooth dongles,
one serial and on USB. Both have a CSR BC02 chip and are rev. 16.4.
I can "hciconfig up" and "down" them, inquire via "hcitool inq". But as
soon as I do a "hcitool scan" or a "l2ping" using the USB dongle, the
whole box freezes up. With the serial one (which I have to activate
first using "hciattach") everything works just fine. Unfortunately I
need the USB for matters of speed.

Anyone got a hint where to start lookin, or how to maybe get some
debugging info out of hcitool (for ex.) before it crashes?

Eric

--
Eric Chapman

-----------------
Lehrstuhl f=FCr Nachrichtentechnik
Universit=E4t des Saarlandes
Postfach 15 11 50
D-66041 Saarbr=FCcken
Tel: +49 681 302 3975
Fax: +49 681 302 3972
Web: www.lnt.uni-saarland.de



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id638&op=CCk
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel




-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
