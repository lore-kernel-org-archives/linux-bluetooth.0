Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Guylhem Aznar <bluez-devel@externe.net>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] hidp kernel panic on 2.4.25 mh15
Message-ID: <20050330163950.GA15198@externe.net>
References: <20050329182351.GA18688@externe.net> <1112129994.9016.115.camel@pegasus>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1112129994.9016.115.camel@pegasus>
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
Date: Wed, 30 Mar 2005 11:39:50 -0500

On Tuesday, 29 March 2005 at 22:59:54 (+0200), Marcel Holtmann wrote:
> > I have a strange kernel panic, only when I use hidp.
> > bnep etc. work without any problem. The kernel panic is 100%
> > reproductible.
>=20
> is it possible to reproduce it on a x86 machine?

The kernel is arm specific due to a special cross compile patch. This
means I can't compile a x86 version.

> This is a NULL pointer dereference, but I am not quite good in decoding
> the trace backs of ARM.

It is a custom kernel but that's the only bug.=20

> Maybe this has something do with it. If H:4 is out of sync and send
> weird packets to the upper layer, bad things can happen. Are similiar
> protocols like BNEP or CMTP working fine?

I never had a similar problem with bnep. Is it responding to a sdptool
browse like a charm.

This only happens when I use hidd connect. Maybe there's a bug that's
only happening on arm ? I didn't change your patch at all - with this
very patch on a different 2.4 (yet on a x86) it works fine.

(did a scan and a sdptool browse, typed the key on the keyboard - link
is ok)

# modprobe hidp
Using /lib/modules/2.4.29-guylhem/kernel/drivers/input/input.o
Using /lib/modules/2.4.29-guylhem/kernel/net/bluetooth/hidp/hidp.o
BlueZ HIDP ver 1.0
Copyright (C) 2003-2004 Marcel Holtmann <marcel@holtmann.org>
root@simpad:~# modprobe keybdev
Using /lib/modules/2.4.29-guylhem/kernel/drivers/input/keybdev.o
root@simpad:~# hidd --connect 00:03:C9:3D:80:37
root@simpad:~# Unable to handle kernel NULL pointer dereference at virtua=
l address 00000000
pgd =3D c0004000
[00000000] *pgd=3D00000000, *pmd =3D 00000000
Internal error: Oops: 0
CPU: 0
pc : [<00000000>]    lr : [<c00b29b4>]    Not tainted
sp : c7b7ff00  ip : c01830fc  fp : c7b7ff1c
r10: c7f8e814  r9 : c7518460  r8 : 00000001
r7 : c88f7464  r6 : 00000000  r5 : 0000001c  r4 : 00000000
r3 : c01b7a44  r2 : 00000000  r1 : c7b7ff03  r0 : 0000001c
Flags: Nzcv  IRQs on  FIQs on  Mode SVC_32  Segment kernel
Control: C782B17F  Table: C782B17F  DAC: 0000001D
Process khidpd_0a5c2001 (pid: 680, stack limit =3D 0xc7b7e374)
Stack: (0xc7b7ff00 to 0xc7b80000)
ff00: c88ec360 0000001c 00000001 00000038 c7b7ff3c c7b7ff20 c88f7118 c00b=
2908=20
ff20: 0000001c 0000001c 00000001 c7f63e20 c7b7ff50 c7b7ff40 c88f7200 c88f=
706c=20
ff40: c7f8e800 c7b7ff78 c7b7ff54 c88f13e0 c88f71e8 00000002 c7b45812 c7f8=
e800=20
ff60: c7608df0 c88f4f18 00000008 c7b7ffa0 c7b7ff7c c88f3558 c88f106c c7b7=
1680=20
ff80: c7518850 c7518850 c7608dc0 00000000 c7b7e000 c7b7fff4 c7b7ffa4 c88f=
3ce0=20
ffa0: c88f3448 00000064 c7518800 00000000 c7b7e000 c77b2234 c77b2234 0000=
0000=20
ffc0: c7b7e000 c73b8e14 c73b8e14 00000000 c7830000 c7f8e818 c7f8e800 c88f=
4f18=20
ffe0: c7608e14 c7831e9c 00000000 c7b7fff8 c001c030 c88f3994 00006f2e 0000=
0011=20
Backtrace:=20
Function entered at [<c00b28fc>] from [<c88f7118>]
 r6 =3D 00000038  r5 =3D 00000001  r4 =3D 0000001C=20
Function entered at [<c88f7060>] from [<c88f7200>]
 r7 =3D C7F63E20  r6 =3D 00000001  r5 =3D 0000001C  r4 =3D 0000001C
Function entered at [<c88f71dc>] from [<c88f13e0>]
 r4 =3D C7F8E800=20
Function entered at [<c88f1060>] from [<c88f3558>]
Function entered at [<c88f343c>] from [<c88f3ce0>]
Function entered at [<c88f3988>] from [<c001c030>]
Code: bad PC value.
Unable to handle kernel NULL pointer dereference at virtual address 00000=
000
pgd =3D c0004000
[00000000] *pgd=3D00000000, *pmd =3D 00000000
Internal error: Oops: 0
CPU: 0
pc : [<00000000>]    lr : [<c00b29b4>]    Not tainted
sp : c0177e2c  ip : c01830fc  fp : c0177e48
r10: c7f8e814  r9 : ffffffff  r8 : 00000001
r7 : c88f7464  r6 : 00000000  r5 : 0000001c  r4 : 00000000
r3 : c01b7a44  r2 : 00000000  r1 : c0177e2f  r0 : 0000001c
Flags: Nzcv  IRQs on  FIQs on  Mode SVC_32  Segment kernel
Control: C7CB717F  Table: C7CB717F  DAC: 0000001D
Process swapper (pid: 0, stack limit =3D 0xc0176374)
Stack: (0xc0177e2c to 0xc0178000)
7e20:                            c7b71680 0000001c 00000002 00000038 c017=
7e68=20
7e40: c0177e4c c88f7118 c00b2908 0000001c 0000001c 00000002 c7f63e20 c017=
7e7c=20
7e60: c0177e6c c88f7200 c88f706c c7f8e800 c0177ea4 c0177e80 c88f13e0 c88f=
71e8=20
7e80: c7f8e800 00000000 c0193ea0 00000000 c0178080 60000093 c0177eb8 c017=
7ea8=20
7ea0: c88f1414 c88f106c c0194abc c0177ef0 c0177ebc c003118c c88f1400 2000=
0000=20
7ec0: c0198c10 c0198c10 c0193ec0 00000000 c0193ea0 00000000 c0178080 ffff=
ffff=20
7ee0: 60000093 c0177f04 c0177ef4 c002ccd0 c0030eb8 c0193ec0 c0177f28 c017=
7f08=20
7f00: c002cba0 c002cca4 c01780a0 00000001 c0193ea0 fffffffe c01780a0 c017=
7f50=20
7f20: c0177f2c c002c870 c002cb34 c0193ea0 c0177f6c 00000001 c001ba14 6000=
0013=20
7f40: 0000001f c0177f68 c0177f54 c001b3bc c002c7fc fa050000 c0177fb4 c017=
7fd4=20
7f60: c0177f6c c001a400 c001b36c 00000000 00000000 60000093 60000013 c001=
b968=20
7f80: c0176000 c0176000 c001b968 c018c64c 6901b118 0000001f c0177fd4 c017=
7fb4=20
7fa0: c0177fb4 c001b9a8 c001ba14 60000013 ffffffff c019572c c01b8834 c018=
c678=20
7fc0: c018c674 c0178d7c c0177fe4 c0177fd8 c001a030 c001b9c8 c0177ffc c017=
7fe8=20
7fe0: c00086a8 c001a00c c018ca90 c01b8834 00000000 c0178000 c0008080 c000=
85a0=20
Backtrace:=20
Function entered at [<c00b28fc>] from [<c88f7118>]
 r6 =3D 00000038  r5 =3D 00000002  r4 =3D 0000001C=20
Function entered at [<c88f7060>] from [<c88f7200>]
 r7 =3D C7F63E20  r6 =3D 00000002  r5 =3D 0000001C  r4 =3D 0000001C
Function entered at [<c88f71dc>] from [<c88f13e0>]
 r4 =3D C7F8E800=20
Function entered at [<c88f1060>] from [<c88f1414>]
Function entered at [<c88f13f4>] from [<c003118c>]
 r4 =3D C0194ABC=20
Function entered at [<c0030eac>] from [<c002ccd0>]
Function entered at [<c002cc98>] from [<c002cba0>]
 r4 =3D C0193EC0=20
Function entered at [<c002cb28>] from [<c002c870>]
 r8 =3D C01780A0  r7 =3D FFFFFFFE  r6 =3D C0193EA0  r5 =3D 00000001
 r4 =3D C01780A0=20
Function entered at [<c002c7f0>] from [<c001b3bc>]
Function entered at [<c001b360>] from [<c001a400>]
 r5 =3D C0177FB4  r4 =3D FA050000=20
Function entered at [<c001b9bc>] from [<c001a030>]
 r8 =3D C0178D7C  r7 =3D C018C674  r6 =3D C018C678  r5 =3D C01B8834
 r4 =3D C019572C=20
Function entered at [<c001a000>] from [<c00086a8>]
Function entered at [<c0008594>] from [<c0008080>]
Code: bad PC value.
Kernel panic: Aiee, killing interrupt handler!
In interrupt handler - not syncing
<3>h4_recv: Unknown HCI packet type 08


--=20
Bien =E0 vous - Best regards,
Guylhem P. Aznar

--=20
*@externe.net                                            http://externe.n=
et
P=E9rim=E9/Deprecated:    @oeil.qc.ca, @metalab.unc.edu, @ibiblio.org, @7=
un.org
GPG: 92EB37C1 DD11C9C9 20519D01 E8FA1B11 42975AF7 http://externe.net/pubk=
ey


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
