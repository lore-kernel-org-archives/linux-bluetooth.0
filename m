Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <e1effdeb0509190435395f777e@mail.gmail.com>
From: Claudio Takahasi <cktakahasi@gmail.com>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] hcid crashes with "buffer overflow detected" when pairing
In-Reply-To: <1126981781.14893.27.camel@yeti>
Mime-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_3377_3294453.1127129714167"
References: <1126981781.14893.27.camel@yeti>
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
Date: Mon, 19 Sep 2005 08:35:14 -0300

------=_Part_3377_3294453.1127129714167
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi Fredrik,

Use the latest CVS version. Probably this problem is related with the wrong=
=20
error handling=20
in the function reply_handler_function.=20

If you are using dbus pin helper, check if the service is=20
running(registered) and if the PinAgent=20
d-bus configuration file(bluez.conf) is in the system d-bus configuration=
=20
directory(/etc/dbus-1/system.d/) .

Regards,
Claudio


 9/17/05, Fredrik Noring <noring@nocrew.org> wrote:
>=20
> Hi,
>=20
> I'm trying out the following packages on Fedora Core 4, x86_64:
>=20
> bluez-pin-0.24-2
> bluez-libs-2.20-1
> bluez-utils-2.20-1
> dbus-0.33-3
>=20
> Unfortunately hcid crashes with "buffer overflow detected" when pairing.
> Is this a known problem?
>=20
> Marcel, I'm happy you decided on moving to ASCII based storage. Is there
> any documentation on this? Perhaps I can update the man pages if I can
> get this working.
>=20
> Thanks,
> Fredrik
>=20
> # hcid -n
> hcid[17889]: Bluetooth HCI daemon
> hcid[17889]: Starting security manager 0
> hcid[17889]: pin_code_request (sba=3D00:10:DC:E9:EF:20,=20
> dba=3D00:0E:07:D5:1B:39)
> *** buffer overflow detected ***: hcid: processing events terminated
> =3D=3D=3D=3D=3D=3D=3D Backtrace: =3D=3D=3D=3D=3D=3D=3D=3D=3D
> /lib64/libc.so.6(__chk_fail+0x2f)[0x2aaaaaf19b6f]
> hcid: processing events[0x55555555cdae]
> /usr/lib64/libdbus-1.so.1[0x2aaaaabd3037]
> /usr/lib64/libdbus-1.so.1(dbus_connection_dispatch+0x1b9)[0x2aaaaabd74e3]
> hcid: processing events[0x55555555c9e8]
> hcid: processing events[0x55555555c514]
> hcid: processing events(main+0x440)[0x5555555582fc]
> /lib64/libc.so.6(__libc_start_main+0xef)[0x2aaaaae593cf]
> hcid: processing events[0x555555557539]
> =3D=3D=3D=3D=3D=3D=3D Memory map: =3D=3D=3D=3D=3D=3D=3D=3D
> 2aaaaaaab000-2aaaaaac5000 r-xp 00000000 09:00 2538489 /lib64/ld-2.3.5.so<=
http://2.3.5.so>
> 2aaaaaac5000-2aaaaaac6000 rw-p 2aaaaaac5000 00:00 0
> 2aaaaaae0000-2aaaaaae1000 rw-p 2aaaaaae0000 00:00 0
> 2aaaaabc4000-2aaaaabc5000 r--p 00019000 09:00 2538489 /lib64/ld-2.3.5.so<=
http://2.3.5.so>
> 2aaaaabc5000-2aaaaabc6000 rw-p 0001a000 09:00 2538489 /lib64/ld-2.3.5.so<=
http://2.3.5.so>
> 2aaaaabc6000-2aaaaac25000 r-xp 00000000 09:00 1800977 /usr/lib64/libdbus-
> 1.so.1.0.0
> 2aaaaac25000-2aaaaad25000 ---p 0005f000 09:00 1800977 /usr/lib64/libdbus-
> 1.so.1.0.0
> 2aaaaad25000-2aaaaad2c000 rw-p 0005f000 09:00 1800977 /usr/lib64/libdbus-
> 1.so.1.0.0
> 2aaaaad2c000-2aaaaad3c000 r-xp 00000000 09:00 1795784=20
> /usr/lib64/libbluetooth.so.1.0.20
> 2aaaaad3c000-2aaaaae3b000 ---p 00010000 09:00 1795784=20
> /usr/lib64/libbluetooth.so.1.0.20
> 2aaaaae3b000-2aaaaae3d000 rw-p 0000f000 09:00 1795784=20
> /usr/lib64/libbluetooth.so.1.0.20
> 2aaaaae3d000-2aaaaaf6a000 r-xp 00000000 09:00 2538576 /lib64/libc-2.3.5.s=
o<http://2.3.5.so>
> 2aaaaaf6a000-2aaaab069000 ---p 0012d000 09:00 2538576 /lib64/libc-2.3.5.s=
o<http://2.3.5.so>
> 2aaaab069000-2aaaab06d000 r--p 0012c000 09:00 2538576 /lib64/libc-2.3.5.s=
o<http://2.3.5.so>
> 2aaaab06d000-2aaaab06f000 rw-p 00130000 09:00 2538576 /lib64/libc-2.3.5.s=
o<http://2.3.5.so>
> 2aaaab06f000-2aaaab074000 rw-p 2aaaab06f000 00:00 0
> 2aaaab074000-2aaaab088000 r-xp 00000000 09:00 2538723 /lib64/libnsl-
> 2.3.5.so <http://2.3.5.so>
> 2aaaab088000-2aaaab187000 ---p 00014000 09:00 2538723 /lib64/libnsl-
> 2.3.5.so <http://2.3.5.so>
> 2aaaab187000-2aaaab188000 r--p 00013000 09:00 2538723 /lib64/libnsl-
> 2.3.5.so <http://2.3.5.so>
> 2aaaab188000-2aaaab189000 rw-p 00014000 09:00 2538723 /lib64/libnsl-
> 2.3.5.so <http://2.3.5.so>
> 2aaaab189000-2aaaab18c000 rw-p 2aaaab189000 00:00 0
> 2aaaab18c000-2aaaab199000 r-xp 00000000 09:00 2540351 /lib64/libgcc_s-
> 4.0.1-20050727.so.1
> 2aaaab199000-2aaaab298000 ---p 0000d000 09:00 2540351 /lib64/libgcc_s-
> 4.0.1-20050727.so.1
> 2aaaab298000-2aaaab299000 rw-p 0000c000 09:00 2540351 /lib64/libgcc_s-
> 4.0.1-20050727.so.1
> 555555554000-555555561000 r-xp 00000000 09:00 1798444 /usr/sbin/hcid
> 555555660000-555555661000 rw-p 0000c000 09:00 1798444 /usr/sbin/hcid
> 555555661000-555555682000 rw-p 555555661000 00:00 0 [heap]
> 7fffffc92000-7fffffca7000 rw-p 7fffffc92000 00:00 0 [stack]
> ffffffffff600000-ffffffffffe00000 ---p 00000000 00:00 0 [vdso]
> Avbruten (SIGABRT)
>=20
>=20
>=20
>=20
> -------------------------------------------------------
> SF.Net email is sponsored by:
> Tame your development challenges with Apache's Geronimo App Server.
> Download it for free - -and be entered to win a 42" plasma tv or your ver=
y
> own Sony(tm)PSP. Click here to play: http://sourceforge.net/geronimo.php
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel
>

------=_Part_3377_3294453.1127129714167
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi Fredrik,<br>
<br>
Use the latest <span id=3D"st" name=3D"st" class=3D"st0">CVS</span> version=
. Probably this problem is related with the wrong error handling <br>
in the function reply_handler_function. <br>
<br>
If you are using dbus pin helper, check if the service is running(registere=
d) and if the PinAgent <br>
d-bus configuration file(bluez.conf) is in the system d-bus configuration d=
irectory(/etc/dbus-1/system.d/) .<br>
<br>
Regards,<br>
Claudio<br>
<br>
<br>
<div><span class=3D"gmail_quote">&nbsp;9/17/05, <b class=3D"gmail_sendernam=
e">Fredrik Noring</b> &lt;<a href=3D"mailto:noring@nocrew.org">noring@nocre=
w.org</a>&gt; wrote:</span><blockquote class=3D"gmail_quote" style=3D"borde=
r-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-le=
ft: 1ex;">
Hi,<br><br>I'm trying out the following packages on Fedora Core 4, x86_64:<=
br><br>&nbsp;&nbsp;&nbsp;&nbsp;bluez-pin-0.24-2<br>&nbsp;&nbsp;&nbsp;&nbsp;=
bluez-libs-2.20-1<br>&nbsp;&nbsp;&nbsp;&nbsp;bluez-utils-2.20-1<br>&nbsp;&n=
bsp;&nbsp;&nbsp;dbus-0.33-3<br><br>Unfortunately hcid crashes with &quot;bu=
ffer overflow detected&quot; when pairing.
<br>Is this a known problem?<br><br>Marcel, I'm happy you decided on moving=
 to ASCII based storage. Is there<br>any documentation on this? Perhaps I c=
an update the man pages if I can<br>get this working.<br><br>Thanks,<br>
Fredrik<br><br># hcid -n<br>hcid[17889]: Bluetooth HCI daemon<br>hcid[17889=
]: Starting security manager 0<br>hcid[17889]: pin_code_request (sba=3D00:1=
0:DC:E9:EF:20, dba=3D00:0E:07:D5:1B:39)<br>*** buffer overflow detected ***=
: hcid: processing events terminated
<br>=3D=3D=3D=3D=3D=3D=3D Backtrace: =3D=3D=3D=3D=3D=3D=3D=3D=3D<br>/lib64/=
libc.so.6(__chk_fail+0x2f)[0x2aaaaaf19b6f]<br>hcid: processing events[0x555=
55555cdae]<br>/usr/lib64/libdbus-1.so.1[0x2aaaaabd3037]<br>/usr/lib64/libdb=
us-1.so.1(dbus_connection_dispatch+0x1b9)[0x2aaaaabd74e3]
<br>hcid: processing events[0x55555555c9e8]<br>hcid: processing events[0x55=
555555c514]<br>hcid: processing events(main+0x440)[0x5555555582fc]<br>/lib6=
4/libc.so.6(__libc_start_main+0xef)[0x2aaaaae593cf]<br>hcid: processing eve=
nts[0x555555557539]
<br>=3D=3D=3D=3D=3D=3D=3D Memory map: =3D=3D=3D=3D=3D=3D=3D=3D<br>2aaaaaaab=
000-2aaaaaac5000
r-xp 00000000 09:00
2538489&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;/lib64/ld-<a href=3D"ht=
tp://2.3.5.so">2.3.5.so</a><br>2aaaaaac5000-2aaaaaac6000 rw-p 2aaaaaac5000 =
00:00 0<br>2aaaaaae0000-2aaaaaae1000 rw-p 2aaaaaae0000 00:00 0<br>2aaaaabc4=
000-2aaaaabc5000
r--p 00019000 09:00
2538489&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;/lib64/ld-<a href=3D"ht=
tp://2.3.5.so">2.3.5.so</a><br>2aaaaabc5000-2aaaaabc6000
rw-p 0001a000 09:00
2538489&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;/lib64/ld-<a href=3D"ht=
tp://2.3.5.so">2.3.5.so</a><br>2aaaaabc6000-2aaaaac25000
r-xp 00000000 09:00
1800977&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;/usr/lib64/libdbus-1.so=
.1.0.0<br>2aaaaac25000-2aaaaad25000
---p 0005f000 09:00
1800977&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;/usr/lib64/libdbus-1.so=
.1.0.0<br>2aaaaad25000-2aaaaad2c000
rw-p 0005f000 09:00
1800977&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;/usr/lib64/libdbus-1.so=
.1.0.0<br>2aaaaad2c000-2aaaaad3c000
r-xp 00000000 09:00
1795784&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;/usr/lib64/libbluetooth=
.so.1.0.20<br>2aaaaad3c000-2aaaaae3b000
---p 00010000 09:00
1795784&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;/usr/lib64/libbluetooth=
.so.1.0.20<br>2aaaaae3b000-2aaaaae3d000
rw-p 0000f000 09:00
1795784&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;/usr/lib64/libbluetooth=
.so.1.0.20<br>2aaaaae3d000-2aaaaaf6a000
r-xp 00000000 09:00
2538576&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;/lib64/libc-<a href=3D"=
http://2.3.5.so">2.3.5.so</a><br>2aaaaaf6a000-2aaaab069000
---p 0012d000 09:00
2538576&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;/lib64/libc-<a href=3D"=
http://2.3.5.so">2.3.5.so</a><br>2aaaab069000-2aaaab06d000
r--p 0012c000 09:00
2538576&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;/lib64/libc-<a href=3D"=
http://2.3.5.so">2.3.5.so</a><br>2aaaab06d000-2aaaab06f000
rw-p 00130000 09:00
2538576&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;/lib64/libc-<a href=3D"=
http://2.3.5.so">2.3.5.so</a><br>2aaaab06f000-2aaaab074000 rw-p 2aaaab06f00=
0 00:00 0<br>2aaaab074000-2aaaab088000
r-xp 00000000 09:00
2538723&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;/lib64/libnsl-<a href=
=3D"http://2.3.5.so">2.3.5.so</a><br>2aaaab088000-2aaaab187000
---p 00014000 09:00
2538723&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;/lib64/libnsl-<a href=
=3D"http://2.3.5.so">2.3.5.so</a><br>2aaaab187000-2aaaab188000
r--p 00013000 09:00
2538723&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;/lib64/libnsl-<a href=
=3D"http://2.3.5.so">2.3.5.so</a><br>2aaaab188000-2aaaab189000
rw-p 00014000 09:00
2538723&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;/lib64/libnsl-<a href=
=3D"http://2.3.5.so">2.3.5.so</a><br>2aaaab189000-2aaaab18c000 rw-p 2aaaab1=
89000 00:00 0<br>2aaaab18c000-2aaaab199000
r-xp 00000000 09:00
2540351&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;/lib64/libgcc_s-4.0.1-2=
0050727.so.1<br>2aaaab199000-2aaaab298000
---p 0000d000 09:00
2540351&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;/lib64/libgcc_s-4.0.1-2=
0050727.so.1<br>2aaaab298000-2aaaab299000
rw-p 0000c000 09:00
2540351&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;/lib64/libgcc_s-4.0.1-2=
0050727.so.1<br>555555554000-555555561000
r-xp 00000000 09:00
1798444&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;/usr/sbin/hcid<br>55555=
5660000-555555661000
rw-p 0000c000 09:00
1798444&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;/usr/sbin/hcid<br>55555=
5661000-555555682000
rw-p 555555661000 00:00
0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[heap]<br>7fffffc=
92000-7fffffca7000
rw-p 7fffffc92000 00:00
0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[stack]<br>ffffff=
ffff600000-ffffffffffe00000
---p 00000000 00:00
0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[vdso]<br>Avbruten (SIGABRT)<br><br><br><=
br><br>-------------------------------------------------------<br>SF.Net em=
ail is sponsored by:<br>Tame your development challenges with Apache's Gero=
nimo App Server.
<br>Download it for free - -and be entered to win a 42&quot; plasma tv or y=
our very<br>own Sony(tm)PSP.&nbsp;&nbsp;Click here to play: <a href=3D"http=
://sourceforge.net/geronimo.php">http://sourceforge.net/geronimo.php</a><br=
>_______________________________________________
<br>Bluez-devel mailing list<br><a href=3D"mailto:Bluez-devel@lists.sourcef=
orge.net">Bluez-devel@lists.sourceforge.net</a><br><a href=3D"https://lists=
.sourceforge.net/lists/listinfo/bluez-devel">https://lists.sourceforge.net/=
lists/listinfo/bluez-devel
</a><br></blockquote></div><br>

------=_Part_3377_3294453.1127129714167--


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
