Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] hidp kernel panic on 2.4.25 mh15
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <20050329182351.GA18688@externe.net>
References: <20050329182351.GA18688@externe.net>
Content-Type: text/plain
Message-Id: <1112129994.9016.115.camel@pegasus>
Mime-Version: 1.0
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
Date: Tue, 29 Mar 2005 22:59:54 +0200

Hi Guylhem,

> I'm using patch mh15 on a kernel 2.4.25 for a Simpad (strongarm 255
> Mhz) which has a custom build bluetooth module, using a Mitsumi WML
> AHR C09 on /dev/ttySA1 (externe.net/temp/simpad-bluetooth.gif)
> 
> I have a strange kernel panic, only when I use hidp.
> bnep etc. work without any problem. The kernel panic is 100%
> reproductible.

is it possible to reproduce it on a x86 machine?

> Here is what happens:
> root@simpad:~# cat bt-on.sh
> #!/bin/sh
> echo "0xd51a" >/proc/cs3
> sleep 1
> echo "0xd51a" >/proc/cs3
> modprobe hci_uart
> hciattach /dev/ttySA1 csr 115200
> sleep 1
> hciconfig hci0 up
> hcid -f /etc/bluetooth/hcid.conf
> sdpd
> root@simpad:~# cat bt-kb.sh
> #!/bin/sh
> modprobe hidp
> modprobe keybdev
> hidd --connect 00:03:C9:3D:80:37
> root@simpad:~# ./bt-on.sh
> Using
> /lib/modules/2.4.25-vrs2-pxa1-jpm1/kernel/drivers/bluetooth/hci_uart.o
> BlueZ HCI UART driver ver 2.1 Copyright (C) 2000,2001 Qualcomm Inc
> Written 2000,2001 by Maxim Krasnyansky <maxk@qualcomm.com>
> CSR build ID 0x01-0x75
> root@simpad:~# ./bt-kb.sh
> root@simpad:~# Unable to handle kernel NULL pointer dereference at
> virtual address 00000000
> pgd = c0004000
> [00000000] *pgd=00000000, *pmd = 00000000
> Internal error: Oops: 0
> CPU: 0
> pc : [<00000000>]    lr : [<c00b46f8>]    Not tainted
> sp : c766ff00  ip : c01830ac  fp : c766ff1c
> r10: c7bd8814  r9 : c74d3a60  r8 : 00000001
> r7 : c88f4464  r6 : 00000000  r5 : 000000e0  r4 : 00000000
> r3 : c01b7cc4  r2 : 00000000  r1 : c766ff03  r0 : 000000e0
> Flags: Nzcv  IRQs on  FIQs on  Mode SVC_32  Segment kernel
> Control: C7D7B17F  Table: C7D7B17F  DAC: 0000001D
> Process khidpd_0a5c2001 (pid: 699, stack limit = 0xc766e374)
> Stack: (0xc766ff00 to 0xc7670000)
> ff00: c88e9360 000000c1 00000001 00000182 c766ff3c c766ff20 c88f4108 c00b464c
> ff20: 000000c1 000000c1 00000001 c7eacca0 c766ff50 c766ff40 c88f4200 c88f406c
> ff40: c7bd8800 c766ff78 c766ff54 c88ee3e0 c88f41e8 00000002 c7a25012 c7bd8800
> ff60: c726fd70 c88f1f18 00000008 c766ffa0 c766ff7c c88f0558 c88ee06c c7a32800
> ff80: c72ec0d0 c72ec0d0 c726fd40 00000000 c766e000 c766fff4 c766ffa4 c88f0ce0
> ffa0: c88f0448 00000064 c72ec080 00000000 c766e000 c76ba3f4 c76ba3f4 00000000
> ffc0: c766e000 c76f2dd4 c76f2dd4 00000000 c7a3e000 c7bd8818 c7bd8800 c88f1f18
> ffe0: c726fd94 c7a3fe9c 00000000 c766fff8 c001eeb0 c88f0994 00000001 00000001
> Backtrace:
> Function entered at [<c00b4640>] from [<c88f4108>]
>  r6 = 00000182  r5 = 00000001  r4 = 000000C1
> Function entered at [<c88f4060>] from [<c88f4200>]
>  r7 = C7EACCA0  r6 = 00000001  r5 = 000000C1  r4 = 000000C1
> Function entered at [<c88f41dc>] from [<c88ee3e0>]
>  r4 = C7BD8800
> Function entered at [<c88ee060>] from [<c88f0558>]
> Function entered at [<c88f043c>] from [<c88f0ce0>]
> Function entered at [<c88f0988>] from [<c001eeb0>]
> Code: bad PC value.
> Unable to handle kernel NULL pointer dereference at virtual address
> 00000000
> pgd = c0004000
> [00000000] *pgd=00000000, *pmd = 00000000
> Internal error: Oops: 0
> CPU: 0
> pc : [<00000000>]    lr : [<c00b46f8>]    Not tainted
> sp : c0177e28  ip : c01830ac  fp : c0177e44
> r10: c7bd8814  r9 : ffffffff  r8 : 00000001
> r7 : c88f4464  r6 : 00000000  r5 : 000000e0  r4 : 00000000
> r3 : c01b7cc4  r2 : 00000000  r1 : c0177e2b  r0 : 000000e0
> Flags: Nzcv  IRQs on  FIQs on  Mode SVC_32  Segment kernel
> Control: C7C4F17F  Table: C7C4F17F  DAC: 0000001D
> Process swapper (pid: 0, stack limit = 0xc0176374)
> Stack: (0xc0177e28 to 0xc0178000)
> 7e20:                   c0022000 000000c1 00000002 00000182 c0177e64 c0177e48
> 7e40: c88f4108 c00b464c 000000c1 000000c1 00000002 c7eacca0 c0177e78 c0177e68
> 7e60: c88f4200 c88f406c c7bd8800 c0177ea0 c0177e7c c88ee3e0 c88f41e8 c7bd8800
> 7e80: 00000000 c0193fe0 00000000 c0178080 60000093 c0177eb4 c0177ea4 c88ee414
> 7ea0: c88ee06c c0194bfc c0177eec c0177eb8 c0033ef8 c88ee400 20000000 c0177ebc
> 7ec0: c0177ebc c0194000 00000000 c0193fe0 00000000 c0178080 ffffffff 60000093
> 7ee0: c0177f00 c0177ef0 c002fa4c c0033c24 c0194000 c0177f24 c0177f04 c002f91c
> 7f00: c002fa20 c01780a0 00000001 c0193fe0 fffffffe c01780a0 c0177f4c c0177f28
> 7f20: c002f5ec c002f8b0 c0193fe0 c0177f68 00000001 c001e894 60000013 0000001f
> 7f40: c0177f64 c0177f50 c001e23c c002f578 fa050000 c0177fb0 c0177fd0 c0177f68
> 7f60: c001d280 c001e1ec 00000000 00000000 60000093 60000013 c001e7e8 c0176000
> 7f80: c0176000 c001e7e8 c018c790 6901b118 0000001f c0177fd0 c0177fb0 c0177fb0
> 7fa0: c001e828 c001e894 60000013 ffffffff c019586c c01afbf0 c018c7bc c018c7b8
> 7fc0: c0178d84 c0177fe0 c0177fd4 c001b030 c001e848 c0177ffc c0177fe4 c00086dc
> 7fe0: c001b00c c018cbd4 c01b8ab4 c01b8ab4 00000000 c0178000 c0008080 c0008594
> Backtrace:
> Function entered at [<c00b4640>] from [<c88f4108>]
>  r6 = 00000182  r5 = 00000002  r4 = 000000C1
> Function entered at [<c88f4060>] from [<c88f4200>]
>  r7 = C7EACCA0  r6 = 00000002  r5 = 000000C1  r4 = 000000C1
> Function entered at [<c88f41dc>] from [<c88ee3e0>]
>  r4 = C7BD8800
> Function entered at [<c88ee060>] from [<c88ee414>]
> Function entered at [<c88ee3f4>] from [<c0033ef8>]
>  r4 = C0194BFC
> Function entered at [<c0033c18>] from [<c002fa4c>]
> Function entered at [<c002fa14>] from [<c002f91c>]
>  r4 = C0194000
> Function entered at [<c002f8a4>] from [<c002f5ec>]
>  r8 = C01780A0  r7 = FFFFFFFE  r6 = C0193FE0  r5 = 00000001
>  r4 = C01780A0
> Function entered at [<c002f56c>] from [<c001e23c>]
> Function entered at [<c001e1e0>] from [<c001d280>]
>  r5 = C0177FB0  r4 = FA050000
> Function entered at [<c001e83c>] from [<c001b030>]
>  r8 = C0178D84  r7 = C018C7B8  r6 = C018C7BC  r5 = C01AFBF0
>  r4 = C019586C
> Function entered at [<c001b000>] from [<c00086dc>]
> Function entered at [<c0008588>] from [<c0008080>]
> Code: bad PC value.
> Kernel panic: Aiee, killing interrupt handler!
> In interrupt handler - not syncing
>  <3>ide0: unexpected interrupt, status=0x04, count=1

This is a NULL pointer dereference, but I am not quite good in decoding
the trace backs of ARM.

> Usually I have the following messages too:
> Code: bad PC value.
> Kernel panic: Aiee, killing interrupt handler!
> In interrupt handler - not syncing
>  <3>h4_recv: Unknown HCI packet type 00
> h4_recv: Unknown HCI packet type 41
> h4_recv: Unknown HCI packet type 00
> h4_recv: Unknown HCI packet type a1
> h4_recv: Unknown HCI packet type 01
> h4_recv: Unknown HCI packet type 00
> h4_recv: Unknown HCI packet type 00
> h4_recv: Unknown HCI packet type 27
> h4_recv: Unknown HCI packet type 72
> h4_recv: Unknown HCI packet type 00
> h4_recv: Unknown HCI packet type 00
> h4_recv: Unknown HCI packet type 00
> h4_recv: Unknown HCI packet type 00

Maybe this has something do with it. If H:4 is out of sync and send
weird packets to the upper layer, bad things can happen. Are similiar
protocols like BNEP or CMTP working fine?

Regards

Marcel




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
