Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <41CB47B5.7010301@dark-reality.de>
From: Lars Grunewaldt <lgw@dark-reality.de>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] compiling hciconfig for ARM
References: <BAY104-F3387CCB50D8B5E0CA2C7DAC1A50@phx.gbl>
In-Reply-To: <BAY104-F3387CCB50D8B5E0CA2C7DAC1A50@phx.gbl>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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
Date: Thu, 23 Dec 2004 23:33:25 +0100

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi there,

I don't know much about ARM CPUs or hciconfig stuff, but an alignment
exception usually means that the CPU tried to access a value that is not
in the correct "place" for the CPU to access.

On Palm devices for example the CPUs had a 16 bit alignment for data
access, so you can directly access i.e.

(short int*)[12]

but not

(char*(short int*))[1]

while

(char*(short int*))[0]

would work again (short ints are always on the boundary, but char[1] is
not at a 16 bit b=F3undary of the cpu, while char[0] is. This depends als=
o
on endian style of course.

For your problem it seems that a short int or int array is accessed like
a byte array, thus leading to an alignment exception when the code tries
to read the second byte (at [1]). Maybe something is not handled
correctly here for ARM.

Just guessing though, it might also be a totally wierd thing :)

regards,
~  Lars

blookk - wrote:
| I have compiled the Bluez Utils and Libs 2.11 for a ARM platform,
| concretly for the CPU ARM7TDMI.
| I have done the compilation with uClibc-0.9.19 and in "hciconfig" tool =
I
| have a problem when I make"hciconfig -a" or "hciconfig hci0 name" or
| "hciconfig hci0 class" and other.
| All this problems occurs in file "hci.c", in function "int
| hci_send_req(int dd, struct hci_request *r, int to)".
| In this function when the program execute "n =3D poll(&p, 1, to)" I obt=
ain
| a kernel panic like this (executing hciconfig -a):
|
| ......
|
| Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
| Link policy: RSWITCH HOLD SNIFF PARK
| Link mode: SLAVE ACCEPT
|
| Unhandled fault: alignment exception (93) at 0x00000001
|
| fault-common.c(97): start_code=3D0xeb000040, start_stack=3D0xe1a00004)
|
| Internal error: Oops: 0
|
| CPU: 0
|
| pc : [<00007294>] lr : [<00030001>] Not tainted
|
| sp : 00147dac ip : 00000004 fp : 00147e40
|
| r10: 00148080 r9 : 60000013 r8 : 001d8404
|
| r7 : 00f44b40 r6 : 00000000 r5 : e1dc30b3 r4 : 60000013
|
| r3 : 00000000 r2 : 0014602c r1 : 00147dac r0 : 00000004
|
| Flags: nzCv IRQs off FIQs on Mode SVC_32 Segment kernel
|
| Control: 0
|
| Process swapper (pid:
| 0, stackpage=3D00147000)
|
| Stack:
|
| 00147d80: 00030
|
| 00147da0: 00007294 20000093 ffffffff 00000004 00000000 00030001
00000005 00147
|
| 00147dc0: 00147dcc 000a32e0 001112f0 c0f44a00 00000000 00147e14
00147de4 00f44
|
| 00147de0: 00f44a00 00b18000 00147e0c 00147df8 000a820c 0001d6f8
00f44a00 00f44
|
| 00147e00: 00147e20 00147e10 000a8224 000a8168 00000000 00000000
001d8400 00b18
|
| 00147e20: 001d8404 001d8570 00147e58 e1dc30b3 00147e78 00147eac
00147e44 00007
|
| 00147e40: 00007264 0000000e 000000c0 00000c14 00000006 00000040
00acc040 00000
|
| 00147e60: 00f44b40 001d8404 60000093 00148080 00147eac 00d4800c
00147e8c 00acc
|
| 00147e80: 000f5968 60000013 ffffffff 00f44b40 001d8404 00000000
001d849c 00000
|
| 00147ea0: 00147ecc 00147eb0 000f3344 000f58d4 001d8474 00000000
00000000 00148
|
| 00147ec0: 00147eec 00147ed0 000102b4 000f32d4 00148098 00000001
fffffff6 0016a
|
| 00147ee0: 00147f18 00147ef0 0000fff0 00010244 00000000 00000000
04000000 00163
|
| 00147f00: 001633a0 0016a9e0 00147f58 00147f28 00147f1c 000100a8
0000ff48 00147
|
| 00147f20: 00147f2c 000035fc 000100a4 00147f8c 00002ab0 00003aa0
000041bc 60000
|
| 00147f40: ffffffff 001637ac 00147fac 00147f58 00002980 000034e0
001e0000 00163
|
| 00147f60: 00000000 00000000 00004194 00146000 00146000 00146000
00004194 00163
|
| 00147f80: 001637ac 00147fac 00147fb0 00147fa0 00003aa0 000041bc
60000013 fffff
|
| 00147fa0: 00147fd4 00147fb0 00003aa0 000041a4 0016c274 00148000
001637d8 162d3
|
| 00147fc0: 0018d1c0 fbda068c 00147fe4 00147fd8 00002034 00003a54
00147ffc 00147
|
| 00147fe0: 001564cc 00002010 0014a99c ffb00000 00000000 00148000
00001644 00156
|
| Backtrace:
|
| Function entered at [<00007254>] from [<00007f98>]
|
| r5 =3D 00147E78 r4 =3D E1DC30B3
|
| Function entered at [<000f58c4>] from [<000f3344>]
|
| r8 =3D 00000000 r7 =3D 001D849C r6 =3D 00000000 r5 =3D 001D8404
|
| r4 =3D 00F44B40
|
| Function entered at [<000f32c4>] from [<000102b4>]
|
| r7 =3D 00148040 r6 =3D 00000000 r5 =3D 00000000 r4 =3D 001D8474
|
| Function entered at [<00010234>] from [<0000fff0>]
|
| r7 =3D 0016A9E0 r6 =3D FFFFFFF6 r5 =3D 00000001 r4 =3D 00148098
|
| Function entered at
| [<0000ff38>] from [<000100a8>]
|
| Function entered at [<00010094>] from [<000035fc>]
|
| Function entered at [<000034d0>] from [<00002980>]
|
| Function entered at [<00004194>] from [<00003aa0>]
|
| Function entered at [<00003a44>] from [<00002034>]
|
| Function entered at [<00002000>] from [<001564cc>]
|
| Function entered at [<001563c0>] from [<00001644>]
|
| r4 =3D FFB00000
|
| Code: e50be08c e3cd2d7f (e594303c) e3c2203f e50b3088
|
| Kernel panic: Aiee, killing interrupt handler
|
| In interrupt handler - not syncing
|
| -----
|
| What can I do for solve this problem?
|
| thanks.
|
| ------------------------------------------------------- SF email is
| sponsored by - The IT Product Guide Read honest & candid reviews on
| hundreds of IT Products from real users. Discover which products truly
| live up to the hype. Start reading now.
| http://productguide.itmanagersjournal.com/
| _______________________________________________ Bluez-devel mailing lis=
t
| Bluez-devel@lists.sourceforge.net
| https://lists.sourceforge.net/lists/listinfo/bluez-devel

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBy0e0QWC6DTWkDAoRAiu5AJ9eFTXXZY/+jomtOOLhS6TsJ4j0gwCdE09Q
iTUP5iu6zdWKK8bG52gPbzs=3D
=3D6AGp
-----END PGP SIGNATURE-----


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
