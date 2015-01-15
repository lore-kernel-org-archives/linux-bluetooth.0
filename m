Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <BFA6AEE2-6EBF-46D7-93BD-A74462DC93DD@holtmann.org>
References: <CABPUHrbPgbp3qgjk2+Qom6XAOARr2yh074_sjz_G=gihSW=-qA@mail.gmail.com>
	<BFA6AEE2-6EBF-46D7-93BD-A74462DC93DD@holtmann.org>
Date: Thu, 15 Jan 2015 15:40:07 -0500
Message-ID: <CABPUHrbmb12o+gTFpdpcm24v4eqLavxqjdDmwkBmtpyUywJPzg@mail.gmail.com>
Subject: Re: Bluetooth: Add support for BCM4352 combo card BCM20702A0 sub chip
From: Rick Dunn <rick@rickdunn.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: multipart/alternative; boundary=089e0122e8e092cb3e050cb6dc50
List-ID: <linux-bluetooth.vger.kernel.org>

--089e0122e8e092cb3e050cb6dc50
Content-Type: text/plain; charset=UTF-8

the ver of btusb.c doesn't have that entry you mentioned .. so it went with
the section I thought was closest match...

On Thu, Jan 15, 2015 at 2:52 PM, Marcel Holtmann <marcel@holtmann.org>
wrote:

> Hi Rick,
>
> > Please add upstream to support the sub BT chip on the combo card...
> >
> > From e5ba79b482a755f0068bd502dad0ef1492ac4c8d Mon Sep 17 00:00:00 2001
> > From: Rick Dunn <rick@rickdunn.com>
> > Date: Thu, 15 Jan 2015 13:00:19 -0500
> > Subject: [PATCH] Add 0b05:17cf line for BCM4352 combo card BCM20702A0
> chip
> >
> > ---
> > drivers/bluetooth/btusb.c | 1 +
> > 1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> > index af122e2..0725003 100644
> > --- a/drivers/bluetooth/btusb.c
> > +++ b/drivers/bluetooth/btusb.c
> > @@ -107,6 +107,7 @@ static const struct usb_device_id btusb_table[] = {
> >  { USB_DEVICE(0x0b05, 0x17cb) },
> >  { USB_DEVICE(0x04ca, 0x2003) },
> >  { USB_DEVICE(0x0489, 0xe042) },
> > + { USB_DEVICE(0x0b05, 0x17cf), .driver_info = BTUSB_BCM_PATCHRAM },
> >  { USB_DEVICE(0x13d3, 0x3388), .driver_info = BTUSB_BCM_PATCHRAM },
> >  { USB_DEVICE(0x13d3, 0x3389), .driver_info = BTUSB_BCM_PATCHRAM },
> >  { USB_DEVICE(0x413c, 0x8197), .driver_info = BTUSB_BCM_PATCHRAM },
> > --
> > 1.9.1
> >
> > /sys/kernel/debug/usb/devices
> > T:  Bus=03 Lev=01 Prnt=01 Port=06 Cnt=03 Dev#=  5 Spd=12   MxCh= 0
> > D:  Ver= 2.00 Cls=ff(vend.) Sub=01 Prot=01 MxPS=64 #Cfgs=  1
> > P:  Vendor=0b05 ProdID=17cf Rev= 1.12
> > S:  Manufacturer=Broadcom Corp
> > S:  Product=BCM20702A0
> > S:  SerialNumber=54271E3298CD
> > C:* #Ifs= 4 Cfg#= 1 Atr=e0 MxPwr=  0mA
> > I:* If#= 0 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=01 Prot=01 Driver=btusb
> > E:  Ad=81(I) Atr=03(Int.) MxPS=  16 Ivl=1ms
> > E:  Ad=82(I) Atr=02(Bulk) MxPS=  64 Ivl=0ms
> > E:  Ad=02(O) Atr=02(Bulk) MxPS=  64 Ivl=0ms
> > I:* If#= 1 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=01 Prot=01 Driver=btusb
> > E:  Ad=83(I) Atr=01(Isoc) MxPS=   0 Ivl=1ms
> > E:  Ad=03(O) Atr=01(Isoc) MxPS=   0 Ivl=1ms
> > I:  If#= 1 Alt= 1 #EPs= 2 Cls=ff(vend.) Sub=01 Prot=01 Driver=btusb
> > E:  Ad=83(I) Atr=01(Isoc) MxPS=   9 Ivl=1ms
> > E:  Ad=03(O) Atr=01(Isoc) MxPS=   9 Ivl=1ms
> > I:  If#= 1 Alt= 2 #EPs= 2 Cls=ff(vend.) Sub=01 Prot=01 Driver=btusb
> > E:  Ad=83(I) Atr=01(Isoc) MxPS=  17 Ivl=1ms
> > E:  Ad=03(O) Atr=01(Isoc) MxPS=  17 Ivl=1ms
> > I:  If#= 1 Alt= 3 #EPs= 2 Cls=ff(vend.) Sub=01 Prot=01 Driver=btusb
> > E:  Ad=83(I) Atr=01(Isoc) MxPS=  25 Ivl=1ms
> > E:  Ad=03(O) Atr=01(Isoc) MxPS=  25 Ivl=1ms
> > I:  If#= 1 Alt= 4 #EPs= 2 Cls=ff(vend.) Sub=01 Prot=01 Driver=btusb
> > E:  Ad=83(I) Atr=01(Isoc) MxPS=  33 Ivl=1ms
> > E:  Ad=03(O) Atr=01(Isoc) MxPS=  33 Ivl=1ms
> > I:  If#= 1 Alt= 5 #EPs= 2 Cls=ff(vend.) Sub=01 Prot=01 Driver=btusb
> > E:  Ad=83(I) Atr=01(Isoc) MxPS=  49 Ivl=1ms
> > E:  Ad=03(O) Atr=01(Isoc) MxPS=  49 Ivl=1ms
> > I:* If#= 2 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=ff Driver=(none)
> > E:  Ad=84(I) Atr=02(Bulk) MxPS=  32 Ivl=0ms
> > E:  Ad=04(O) Atr=02(Bulk) MxPS=  32 Ivl=0ms
> > I:* If#= 3 Alt= 0 #EPs= 0 Cls=fe(app. ) Sub=01 Prot=01 Driver=(none)
> >
> >
> > Firmware is extracted from the latest Broadcom BCM4352 WIndows driver
> > by extracting the zip and searching the .hex file names for '17cf' ..
> > the hex file must then be converted to hcd format using the hex2hcd
> > git below and named fw-0b05_17cf.hcd  fw file moved to
> > /lib/firmware/fw-0b05_17cf.hcd
> >
> > git clone https://github.com/jessesung/hex2hcd.git
>
> this information needs to be in the commit message. Including a
> Signed-off-by which git commit will automatically add unless instructed not
> to.
>
> And no need to mention that tool. BlueZ contains a version of that
> actually.
>
> Also there is a generic entry for ASUSTek devices. Just add the patchram
> entry to that one.
>
>         /* ASUSTek Computer - Broadcom based */
>         { USB_VENDOR_AND_INTERFACE_INFO(0x0b05, 0xff, 0x01, 0x01) },
>
> Most importantly however, use git format-patch and git send-email. Since
> you mail client screwed up this one. It can not be applied.
>
> Regards
>
> Marcel
>
>

--089e0122e8e092cb3e050cb6dc50
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">the ver of btusb.c doesn&#39;t have that entry you mention=
ed .. so it went with the section I thought was closest match...<br></div><=
div class=3D"gmail_extra"><br><div class=3D"gmail_quote">On Thu, Jan 15, 20=
15 at 2:52 PM, Marcel Holtmann <span dir=3D"ltr">&lt;<a href=3D"mailto:marc=
el@holtmann.org" target=3D"_blank">marcel@holtmann.org</a>&gt;</span> wrote=
:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-le=
ft:1px #ccc solid;padding-left:1ex">Hi Rick,<br>
<div><div class=3D"h5"><br>
&gt; Please add upstream to support the sub BT chip on the combo card...<br=
>
&gt;<br>
&gt; From e5ba79b482a755f0068bd502dad0ef1492ac4c8d Mon Sep 17 00:00:00 2001=
<br>
&gt; From: Rick Dunn &lt;<a href=3D"mailto:rick@rickdunn.com">rick@rickdunn=
.com</a>&gt;<br>
&gt; Date: Thu, 15 Jan 2015 13:00:19 -0500<br>
&gt; Subject: [PATCH] Add 0b05:17cf line for BCM4352 combo card BCM20702A0 =
chip<br>
&gt;<br>
&gt; ---<br>
&gt; drivers/bluetooth/btusb.c | 1 +<br>
&gt; 1 file changed, 1 insertion(+)<br>
&gt;<br>
&gt; diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c<br>
&gt; index af122e2..0725003 100644<br>
&gt; --- a/drivers/bluetooth/btusb.c<br>
&gt; +++ b/drivers/bluetooth/btusb.c<br>
&gt; @@ -107,6 +107,7 @@ static const struct usb_device_id btusb_table[] =
=3D {<br>
&gt;=C2=A0 { USB_DEVICE(0x0b05, 0x17cb) },<br>
&gt;=C2=A0 { USB_DEVICE(0x04ca, 0x2003) },<br>
&gt;=C2=A0 { USB_DEVICE(0x0489, 0xe042) },<br>
&gt; + { USB_DEVICE(0x0b05, 0x17cf), .driver_info =3D BTUSB_BCM_PATCHRAM },=
<br>
&gt;=C2=A0 { USB_DEVICE(0x13d3, 0x3388), .driver_info =3D BTUSB_BCM_PATCHRA=
M },<br>
&gt;=C2=A0 { USB_DEVICE(0x13d3, 0x3389), .driver_info =3D BTUSB_BCM_PATCHRA=
M },<br>
&gt;=C2=A0 { USB_DEVICE(0x413c, 0x8197), .driver_info =3D BTUSB_BCM_PATCHRA=
M },<br>
&gt; --<br>
&gt; 1.9.1<br>
&gt;<br>
&gt; /sys/kernel/debug/usb/devices<br>
&gt; T:=C2=A0 Bus=3D03 Lev=3D01 Prnt=3D01 Port=3D06 Cnt=3D03 Dev#=3D=C2=A0 =
5 Spd=3D12=C2=A0 =C2=A0MxCh=3D 0<br>
&gt; D:=C2=A0 Ver=3D 2.00 Cls=3Dff(vend.) Sub=3D01 Prot=3D01 MxPS=3D64 #Cfg=
s=3D=C2=A0 1<br>
&gt; P:=C2=A0 Vendor=3D0b05 ProdID=3D17cf Rev=3D 1.12<br>
&gt; S:=C2=A0 Manufacturer=3DBroadcom Corp<br>
&gt; S:=C2=A0 Product=3DBCM20702A0<br>
&gt; S:=C2=A0 SerialNumber=3D54271E3298CD<br>
&gt; C:* #Ifs=3D 4 Cfg#=3D 1 Atr=3De0 MxPwr=3D=C2=A0 0mA<br>
&gt; I:* If#=3D 0 Alt=3D 0 #EPs=3D 3 Cls=3Dff(vend.) Sub=3D01 Prot=3D01 Dri=
ver=3Dbtusb<br>
&gt; E:=C2=A0 Ad=3D81(I) Atr=3D03(Int.) MxPS=3D=C2=A0 16 Ivl=3D1ms<br>
&gt; E:=C2=A0 Ad=3D82(I) Atr=3D02(Bulk) MxPS=3D=C2=A0 64 Ivl=3D0ms<br>
&gt; E:=C2=A0 Ad=3D02(O) Atr=3D02(Bulk) MxPS=3D=C2=A0 64 Ivl=3D0ms<br>
&gt; I:* If#=3D 1 Alt=3D 0 #EPs=3D 2 Cls=3Dff(vend.) Sub=3D01 Prot=3D01 Dri=
ver=3Dbtusb<br>
&gt; E:=C2=A0 Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D=C2=A0 =C2=A00 Ivl=3D1ms<br>
&gt; E:=C2=A0 Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D=C2=A0 =C2=A00 Ivl=3D1ms<br>
&gt; I:=C2=A0 If#=3D 1 Alt=3D 1 #EPs=3D 2 Cls=3Dff(vend.) Sub=3D01 Prot=3D0=
1 Driver=3Dbtusb<br>
&gt; E:=C2=A0 Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D=C2=A0 =C2=A09 Ivl=3D1ms<br>
&gt; E:=C2=A0 Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D=C2=A0 =C2=A09 Ivl=3D1ms<br>
&gt; I:=C2=A0 If#=3D 1 Alt=3D 2 #EPs=3D 2 Cls=3Dff(vend.) Sub=3D01 Prot=3D0=
1 Driver=3Dbtusb<br>
&gt; E:=C2=A0 Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D=C2=A0 17 Ivl=3D1ms<br>
&gt; E:=C2=A0 Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D=C2=A0 17 Ivl=3D1ms<br>
&gt; I:=C2=A0 If#=3D 1 Alt=3D 3 #EPs=3D 2 Cls=3Dff(vend.) Sub=3D01 Prot=3D0=
1 Driver=3Dbtusb<br>
&gt; E:=C2=A0 Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D=C2=A0 25 Ivl=3D1ms<br>
&gt; E:=C2=A0 Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D=C2=A0 25 Ivl=3D1ms<br>
&gt; I:=C2=A0 If#=3D 1 Alt=3D 4 #EPs=3D 2 Cls=3Dff(vend.) Sub=3D01 Prot=3D0=
1 Driver=3Dbtusb<br>
&gt; E:=C2=A0 Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D=C2=A0 33 Ivl=3D1ms<br>
&gt; E:=C2=A0 Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D=C2=A0 33 Ivl=3D1ms<br>
&gt; I:=C2=A0 If#=3D 1 Alt=3D 5 #EPs=3D 2 Cls=3Dff(vend.) Sub=3D01 Prot=3D0=
1 Driver=3Dbtusb<br>
&gt; E:=C2=A0 Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D=C2=A0 49 Ivl=3D1ms<br>
&gt; E:=C2=A0 Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D=C2=A0 49 Ivl=3D1ms<br>
&gt; I:* If#=3D 2 Alt=3D 0 #EPs=3D 2 Cls=3Dff(vend.) Sub=3Dff Prot=3Dff Dri=
ver=3D(none)<br>
&gt; E:=C2=A0 Ad=3D84(I) Atr=3D02(Bulk) MxPS=3D=C2=A0 32 Ivl=3D0ms<br>
&gt; E:=C2=A0 Ad=3D04(O) Atr=3D02(Bulk) MxPS=3D=C2=A0 32 Ivl=3D0ms<br>
&gt; I:* If#=3D 3 Alt=3D 0 #EPs=3D 0 Cls=3Dfe(app. ) Sub=3D01 Prot=3D01 Dri=
ver=3D(none)<br>
&gt;<br>
&gt;<br>
&gt; Firmware is extracted from the latest Broadcom BCM4352 WIndows driver<=
br>
&gt; by extracting the zip and searching the .hex file names for &#39;17cf&=
#39; ..<br>
&gt; the hex file must then be converted to hcd format using the hex2hcd<br=
>
&gt; git below and named fw-0b05_17cf.hcd=C2=A0 fw file moved to<br>
&gt; /lib/firmware/fw-0b05_17cf.hcd<br>
&gt;<br>
&gt; git clone <a href=3D"https://github.com/jessesung/hex2hcd.git" target=
=3D"_blank">https://github.com/jessesung/hex2hcd.git</a><br>
<br>
</div></div>this information needs to be in the commit message. Including a=
 Signed-off-by which git commit will automatically add unless instructed no=
t to.<br>
<br>
And no need to mention that tool. BlueZ contains a version of that actually=
.<br>
<br>
Also there is a generic entry for ASUSTek devices. Just add the patchram en=
try to that one.<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* ASUSTek Computer - Broadcom based */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 { USB_VENDOR_AND_INTERFACE_INFO(0x0b05, 0xff, 0=
x01, 0x01) },<br>
<br>
Most importantly however, use git format-patch and git send-email. Since yo=
u mail client screwed up this one. It can not be applied.<br>
<br>
Regards<br>
<span class=3D"HOEnZb"><font color=3D"#888888"><br>
Marcel<br>
<br>
</font></span></blockquote></div><br></div>

--089e0122e8e092cb3e050cb6dc50--
