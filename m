Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <BAY112-F3AC4DC4F58B3D4E665F1BF03F0@phx.gbl>
From: "Lamarque Souza" <lamarque_souza@hotmail.com>
To: bluez-devel@lists.sf.net
Date: Sun, 13 May 2007 21:15:03 +0000
Mime-Version: 1.0
Subject: [Bluez-devel] Laggy bluetooth mouse after upgrading to 2.6.21-rc3
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hi all,

I have an Acer Ferrari 4005wlmi notebook that came with a bluetooth mouse, =

/proc/bus/input/devices returns this for it:

I: Bus=3D0005 Vendor=3D0458 Product=3D0058 Version=3D010d
N: Name=3D"Bluetooth HID Boot Protocol Device"
P: Phys=3D
S: Sysfs=3D/class/input/input14
H: Handlers=3Dmouse1 event8
B: EV=3D7
B: KEY=3D1f0000 0 0 0 0
B: REL=3D103

It used to work fine until I upgraded to kernel 2.6.21, then it became very =

laggy, the touchpad and my USB keyboard still work fine. I tracked the =

problem down to kernel 2.6.21-rc3, the mouse works ok with kernel =

2.6.21-rc2. I use Gentoo 2007.0 in my notebook, I am also a programmer and =

tried to figure what is causing the problem. When I enabled HID Debuggin =

support I got these messages in /var/log/messages even when I do not move =

the mouse:

May 10 01:16:28 evolucao kernel: [   81.339341] Mapping: Button.0001 ---> =

Key.LeftBtn
May 10 01:16:28 evolucao kernel: [   81.339430] Mapping: Button.0002 ---> =

Key.RightBtn
May 10 01:16:28 evolucao kernel: [   81.339505] Mapping: Button.0003 ---> =

Key.MiddleBtn
May 10 01:16:28 evolucao kernel: [   81.339579] Mapping: GenericDesktop.X =

---> Relative.X
May 10 01:16:28 evolucao kernel: [   81.339739] Mapping: GenericDesktop.Y =

---> Relative.Y
May 10 01:16:28 evolucao kernel: [   81.339812] Mapping: =

GenericDesktop.Wheel ---> Relative.Wheel
May 10 01:16:28 evolucao kernel: [   81.339885] Mapping: ff00.fe01 ---> =

IGNORED
May 10 01:16:28 evolucao kernel: [   81.339958] Mapping: =

Consumer.HorizontalWheel ---> Relative.HWheel
May 10 01:16:28 evolucao kernel: [   81.340031] Mapping: 0006.0020 ---> =

Absolute.Misc
May 10 01:16:28 evolucao kernel: [   81.340105] Mapping: 0006.0020 ---> =

Absolute.?
May 10 01:16:28 evolucao kernel: [   81.340178] Mapping: 0006.0020 ---> =

Absolute.?
May 10 01:16:28 evolucao kernel: [   81.340251] Mapping: 0006.0020 ---> =

Absolute.?
May 10 01:16:28 evolucao kernel: [   81.340325] Mapping: 0006.0020 ---> =

Absolute.?
May 10 01:16:28 evolucao kernel: [   81.340398] Mapping: 0006.0020 ---> =

Absolute.?
May 10 01:16:28 evolucao kernel: [   81.340472] Mapping: 0006.0020 ---> =

Absolute.?
May 10 01:16:28 evolucao kernel: [   81.340545] Mapping: 0006.0020 ---> =

Absolute.?
May 10 01:16:28 evolucao kernel: [   81.341291] drivers/hid/hid-core.c: =

report (size 9) (numbered)
May 10 01:16:28 evolucao kernel: [   81.341295] drivers/hid/hid-core.c: =

report 5 (size 8) =3D  ff 6e 6f 54 c6 10 00 02
May 10 01:16:28 evolucao kernel: [   81.341316] drivers/hid/hid-core.c: =

report (size 9) (numbered)
May 10 01:16:28 evolucao kernel: [   81.341319] drivers/hid/hid-core.c: =

report 5 (size 8) =3D  ff 6e 6f 54 c6 10 00 02
May 10 01:16:28 evolucao kernel: [   81.341325] drivers/hid/hid-core.c: =

report (size 9) (numbered)
May 10 01:16:28 evolucao kernel: [   81.341327] drivers/hid/hid-core.c: =

report 5 (size 8) =3D  ff 6e 6f 54 c6 10 00 03
May 10 01:16:28 evolucao kernel: [   81.344517] drivers/hid/hid-core.c: =

report (size 9) (numbered)
May 10 01:16:28 evolucao kernel: [   81.344522] drivers/hid/hid-core.c: =

report 5 (size 8) =3D  ff 6e 6f 54 c6 10 00 02
May 10 01:16:28 evolucao kernel: [   81.348500] drivers/hid/hid-core.c: =

report (size 9) (numbered)
May 10 01:16:28 evolucao kernel: [   81.348503] drivers/hid/hid-core.c: =

report 5 (size 8) =3D  ff 6e 6f 54 c6 10 00 02
May 10 01:16:28 evolucao kernel: [   81.351495] drivers/hid/hid-core.c: =

report (size 9) (numbered)
May 10 01:16:28 evolucao kernel: [   81.351498] drivers/hid/hid-core.c: =

report 5 (size 8) =3D  ff 6e 6f 54 c6 10 00 03
May 10 01:16:28 evolucao kernel: [   81.353493] drivers/hid/hid-core.c: =

report (size 9) (numbered)

Those messages only stop when I disconnect the mouse. I think they are =

causing the laggy in my mouse. I made same changes to drivers/hid/hid-core.=
c =

  and net/bluetooth/hidp/core.c but nothing helped. Can you help me fix =

this?

-----
Lamarque V. Souza
http://www.geographicguide.com/brazil.htm
Linux User #57137 - http://counter.li.org/

_________________________________________________________________
Verificador de Seguran=E7a do Windows Live OneCare: combata j=E1 v=EDrus e =
outras =

amea=E7as! http://onecare.live.com/site/pt-br/default.htm


-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
