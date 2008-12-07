Return-Path: <cyrus@holtmann.org>
Message-ID: <BAY124-W46E88B992073AAD609A3BDA8FC0@phx.gbl>
From: Evgenios Metaxas <eumetaxas@hotmail.com>
To: <bluez-devel@lists.sourceforge.net>
Date: Sun, 7 Dec 2008 16:33:21 +0000
In-Reply-To: <1228598050.28839.47.camel@violet.holtmann.net>
References: <COL102-W12443FB0254944C58D2F2FA8020@phx.gbl>
	<e343e5940812050154i52fb8eb3x46cf6e73e5a0c8f9@mail.gmail.com>
	<BAY127-W1206CF6F607105AA558C2DA8FE0@phx.gbl>
	<89b6ba3a0812050920q1dea080i148d9c4677b6ed04@mail.gmail.com>
	<COL102-W7079DBA98D2EA5B8835568A8FF0@phx.gbl>
	<e343e5940812061301w368d0614s85e4f82938e76c3a@mail.gmail.com>
	<1228598050.28839.47.camel@violet.holtmann.net>
MIME-Version: 1.0
Subject: Re: [Bluez-devel] MA-720 does not work
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============8190582032446070598=="
Errors-To: bluez-devel-bounces@lists.sourceforge.net

--===============8190582032446070598==
Content-Type: multipart/alternative;
	boundary="_45d46692-04f4-4ea0-b3ea-e0ccb95a2144_"

--_45d46692-04f4-4ea0-b3ea-e0ccb95a2144_
Content-Type: text/plain; charset="iso-8859-7"
Content-Transfer-Encoding: quoted-printable


Thank you both for your help and time!

modinfo hci_usb  gives

filename:       /lib/modules/2.6.24-22-generic/kernel/drivers/bluetooth/hci=
_usb.ko
license:        GPL
version:        2.9
description:    Bluetooth HCI USB driver ver 2.9
author:         Maxim Krasnyansky <maxk@qualcomm.com>=2C Marcel Holtmann <m=
arcel@holtmann.org>
srcversion:     73F4DE14B5B4CED40F4236A
alias:          usb:v0C10p0000d*dc*dsc*dp*ic*isc*ip*
alias:          usb:v0BDBp1002d*dc*dsc*dp*ic*isc*ip*
alias:          usb:v044Ep3002d*dc*dsc*dp*ic*isc*ip*
alias:          usb:v044Ep3001d*dc*dsc*dp*ic*isc*ip*
alias:          usb:v04BFp030Ad*dc*dsc*dp*ic*isc*ip*
alias:          usb:v057Cp3800d*dc*dsc*dp*ic*isc*ip*
alias:          usb:v*p*d*dcE0dsc01dp01ic*isc*ip*
depends:        usbcore=2Cbluetooth
vermagic:       2.6.24-22-generic SMP mod_unload 586=20
parm:           ignore:Ignore devices from the matching table (bool)
parm:           ignore_dga:Ignore devices with id 08fd:0001 (bool)
parm:           ignore_csr:Ignore devices with id 0a12:0001 (bool)
parm:           ignore_sniffer:Ignore devices with id 0a12:0002 (bool)
parm:           disable_scofix:Disable fixup of wrong SCO buffer size (bool=
)
parm:           force_scofix:Force fixup of wrong SCO buffers size (bool)
parm:           reset:Send HCI reset command on initialization (bool)
parm:           isoc:Set isochronous transfers for SCO over HCI support (in=
t)


and after mounting /proc/bus/usb/devices using  "sudo mount -t usbfs usbfs =
/proc/bus/usb"

T:  Bus=3D02 Lev=3D01 Prnt=3D01 Port=3D01 Cnt=3D02 Dev#=3D  3 Spd=3D1.5 MxC=
h=3D 0
D:  Ver=3D 1.00 Cls=3Dff(vend.) Sub=3Dff Prot=3D00 MxPS=3D 8 #Cfgs=3D  1
P:  Vendor=3D0df7 ProdID=3D0722 Rev=3D 0.00
S:  Manufacturer=3DMobileAction Technology Inc.
S:  Product=3DBluetooth Dongle
C:* #Ifs=3D 1 Cfg#=3D 1 Atr=3D80 MxPwr=3D100mA
I:* If#=3D 0 Alt=3D 0 #EPs=3D 2 Cls=3Dff(vend.) Sub=3Dff Prot=3Dff Driver=
=3D(none)
E:  Ad=3D81(I) Atr=3D03(Int.) MxPS=3D   8 Ivl=3D10ms
E:  Ad=3D02(O) Atr=3D03(Int.) MxPS=3D   8 Ivl=3D10ms

Regarding btusb driver i am on Ubuntu 8.04. It was not in Synaptic and Goog=
ling found  a file "btusb-kmp-0.1-2.1.src.rpm"
and installed it using alien.  modprobe btusb or modprobe btusb-kmp returne=
d errors that module could not be found.

Regards

Eugene


> From: marcel@holtmann.org
> To: bluez-devel@lists.sourceforge.net
> Date: Sat=2C 6 Dec 2008 22:14:10 +0100
> Subject: Re: [Bluez-devel] MA-720 does not work
>=20
> Hi Yuriy=2C
>=20
> > in this line there is only one module hci_usb. the other words are
> > parameters for this module.
> > but i  don't  know exactly if we can use those parameters.=20
> > I tried to help you in this way because early  I did like this for
> > module 'usbserial'. so I supposed it would be helpful
>=20
> are you still trying to debug this. Check modinfo hci_usb (or better
> actually use the btusb driver). You can only use the module parameters
> listed there. Period. There have never been any vendor or product module
> parameters for any of these drivers. That is just pure uslpbserial crap
> and shouldn't even been there. We can use sysfs to bind/unbind drivers.
>=20
> I wanna see "cat /proc/bus/usb/devices" from your device. And if that is
> not mounted then check Google on how to mount it.
>=20
> Regards
>=20
> Marcel
>=20
>=20
>=20
> -------------------------------------------------------------------------=
-----
> SF.Net email is Sponsored by MIX09=2C March 18-20=2C 2009 in Las Vegas=2C=
 Nevada.
> The future of the web can't happen without you.  Join us at MIX09 to help
> pave the way to the Next Web now. Learn more and register at
> http://ad.doubleclick.net/clk=3B208669438=3B13503038=3Bi?http://2009.visi=
tmix.com/
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel

_________________________________________________________________
Connect to the next generation of MSN Messenger=A0
http://imagine-msn.com/messenger/launch80/default.aspx?locale=3Den-us&sourc=
e=3Dwlmailtagline=

--_45d46692-04f4-4ea0-b3ea-e0ccb95a2144_
Content-Type: text/html; charset="iso-8859-7"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<style>
.hmmessage P
{
margin:0px=3B
padding:0px
}
body.hmmessage
{
font-size: 10pt=3B
font-family:Verdana
}
</style>
</head>
<body class=3D'hmmessage'>
Thank you both for your help and time!<br><br>modinfo hci_usb&nbsp=3B gives=
<br><br>filename:&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B /lib/modu=
les/2.6.24-22-generic/kernel/drivers/bluetooth/hci_usb.ko<br>license:&nbsp=
=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B GPL<br>version:&nbsp=3B=
&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B 2.9<br>description:&nbsp=
=3B&nbsp=3B&nbsp=3B Bluetooth HCI USB driver ver 2.9<br>author:&nbsp=3B&nbs=
p=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B Maxim Krasnyansky &lt=
=3Bmaxk@qualcomm.com&gt=3B=2C Marcel Holtmann &lt=3Bmarcel@holtmann.org&gt=
=3B<br>srcversion:&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B 73F4DE14B5B4CED40F4236A<=
br>alias:&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&n=
bsp=3B usb:v0C10p0000d*dc*dsc*dp*ic*isc*ip*<br>alias:&nbsp=3B&nbsp=3B&nbsp=
=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B usb:v0BDBp1002d*dc*dsc*=
dp*ic*isc*ip*<br>alias:&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbs=
p=3B&nbsp=3B&nbsp=3B usb:v044Ep3002d*dc*dsc*dp*ic*isc*ip*<br>alias:&nbsp=3B=
&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B usb:v044Ep=
3001d*dc*dsc*dp*ic*isc*ip*<br>alias:&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=
=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B usb:v04BFp030Ad*dc*dsc*dp*ic*isc*ip*<br=
>alias:&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbs=
p=3B usb:v057Cp3800d*dc*dsc*dp*ic*isc*ip*<br>alias:&nbsp=3B&nbsp=3B&nbsp=3B=
&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B usb:v*p*d*dcE0dsc01dp01ic*=
isc*ip*<br>depends:&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B=
 usbcore=2Cbluetooth<br>vermagic:&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&n=
bsp=3B 2.6.24-22-generic SMP mod_unload 586 <br>parm:&nbsp=3B&nbsp=3B&nbsp=
=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B ignore:Ignore d=
evices from the matching table (bool)<br>parm:&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=
=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B ignore_dga:Ignore devic=
es with id 08fd:0001 (bool)<br>parm:&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=
=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B ignore_csr:Ignore devices with =
id 0a12:0001 (bool)<br>parm:&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=
=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B ignore_sniffer:Ignore devices with id 0=
a12:0002 (bool)<br>parm:&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nb=
sp=3B&nbsp=3B&nbsp=3B&nbsp=3B disable_scofix:Disable fixup of wrong SCO buf=
fer size (bool)<br>parm:&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nb=
sp=3B&nbsp=3B&nbsp=3B&nbsp=3B force_scofix:Force fixup of wrong SCO buffers=
 size (bool)<br>parm:&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=
=3B&nbsp=3B&nbsp=3B&nbsp=3B reset:Send HCI reset command on initialization =
(bool)<br>parm:&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbs=
p=3B&nbsp=3B&nbsp=3B isoc:Set isochronous transfers for SCO over HCI suppor=
t (int)<br><br><br>and after mounting /proc/bus/usb/devices using&nbsp=3B "=
sudo mount -t usbfs usbfs /proc/bus/usb"<br><br>T:&nbsp=3B Bus=3D02 Lev=3D0=
1 Prnt=3D01 Port=3D01 Cnt=3D02 Dev#=3D&nbsp=3B 3 Spd=3D1.5 MxCh=3D 0<br>D:&=
nbsp=3B Ver=3D 1.00 Cls=3Dff(vend.) Sub=3Dff Prot=3D00 MxPS=3D 8 #Cfgs=3D&n=
bsp=3B 1<br>P:&nbsp=3B Vendor=3D0df7 ProdID=3D0722 Rev=3D 0.00<br>S:&nbsp=
=3B Manufacturer=3DMobileAction Technology Inc.<br>S:&nbsp=3B Product=3DBlu=
etooth Dongle<br>C:* #Ifs=3D 1 Cfg#=3D 1 Atr=3D80 MxPwr=3D100mA<br>I:* If#=
=3D 0 Alt=3D 0 #EPs=3D 2 Cls=3Dff(vend.) Sub=3Dff Prot=3Dff Driver=3D(none)=
<br>E:&nbsp=3B Ad=3D81(I) Atr=3D03(Int.) MxPS=3D&nbsp=3B&nbsp=3B 8 Ivl=3D10=
ms<br>E:&nbsp=3B Ad=3D02(O) Atr=3D03(Int.) MxPS=3D&nbsp=3B&nbsp=3B 8 Ivl=3D=
10ms<br><br>Regarding btusb driver i am on Ubuntu 8.04. It was not in Synap=
tic and Googling found&nbsp=3B a file "btusb-kmp-0.1-2.1.src.rpm"<br>and in=
stalled it using alien.&nbsp=3B modprobe btusb or modprobe btusb-kmp return=
ed errors that module could not be found.<br><br>Regards<br><br>Eugene<br><=
br><br>&gt=3B From: marcel@holtmann.org<br>&gt=3B To: bluez-devel@lists.sou=
rceforge.net<br>&gt=3B Date: Sat=2C 6 Dec 2008 22:14:10 +0100<br>&gt=3B Sub=
ject: Re: [Bluez-devel] MA-720 does not work<br>&gt=3B <br>&gt=3B Hi Yuriy=
=2C<br>&gt=3B <br>&gt=3B &gt=3B in this line there is only one module hci_u=
sb. the other words are<br>&gt=3B &gt=3B parameters for this module.<br>&gt=
=3B &gt=3B but i  don't  know exactly if we can use those parameters. <br>&=
gt=3B &gt=3B I tried to help you in this way because early  I did like this=
 for<br>&gt=3B &gt=3B module 'usbserial'. so I supposed it would be helpful=
<br>&gt=3B <br>&gt=3B are you still trying to debug this. Check modinfo hci=
_usb (or better<br>&gt=3B actually use the btusb driver). You can only use =
the module parameters<br>&gt=3B listed there. Period. There have never been=
 any vendor or product module<br>&gt=3B parameters for any of these drivers=
. That is just pure uslpbserial crap<br>&gt=3B and shouldn't even been ther=
e. We can use sysfs to bind/unbind drivers.<br>&gt=3B <br>&gt=3B I wanna se=
e "cat /proc/bus/usb/devices" from your device. And if that is<br>&gt=3B no=
t mounted then check Google on how to mount it.<br>&gt=3B <br>&gt=3B Regard=
s<br>&gt=3B <br>&gt=3B Marcel<br>&gt=3B <br>&gt=3B <br>&gt=3B <br>&gt=3B --=
---------------------------------------------------------------------------=
-<br>&gt=3B SF.Net email is Sponsored by MIX09=2C March 18-20=2C 2009 in La=
s Vegas=2C Nevada.<br>&gt=3B The future of the web can't happen without you=
.  Join us at MIX09 to help<br>&gt=3B pave the way to the Next Web now. Lea=
rn more and register at<br>&gt=3B http://ad.doubleclick.net/clk=3B208669438=
=3B13503038=3Bi?http://2009.visitmix.com/<br>&gt=3B _______________________=
________________________<br>&gt=3B Bluez-devel mailing list<br>&gt=3B Bluez=
-devel@lists.sourceforge.net<br>&gt=3B https://lists.sourceforge.net/lists/=
listinfo/bluez-devel<br><br /><hr />Connect to the next generation of MSN M=
essenger=A0  <a href=3D'http://imagine-msn.com/messenger/launch80/default.a=
spx?locale=3Den-us&source=3Dwlmailtagline' target=3D'_new'>Get it now! </a>=
</body>
</html>=

--_45d46692-04f4-4ea0-b3ea-e0ccb95a2144_--


--===============8190582032446070598==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
SF.Net email is Sponsored by MIX09, March 18-20, 2009 in Las Vegas, Nevada.
The future of the web can't happen without you.  Join us at MIX09 to help
pave the way to the Next Web now. Learn more and register at
http://ad.doubleclick.net/clk;208669438;13503038;i?http://2009.visitmix.com/
--===============8190582032446070598==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============8190582032446070598==--
