Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <8EF40417-2881-482A-834C-B6FA7C63D176@holtmann.org>
References: <1421827196-25277-1-git-send-email-jesse.sung@canonical.com>
	<1421827196-25277-3-git-send-email-jesse.sung@canonical.com>
	<8EF40417-2881-482A-834C-B6FA7C63D176@holtmann.org>
Date: Thu, 22 Jan 2015 11:50:32 +0800
Message-ID: <CABkzJoaLfnBSjpuzRiqgArCuf20+x+QFZL0=Jt=9MTx6sKS6bQ@mail.gmail.com>
Subject: Re: [PATCH resend 3/5] Bluetooth: Add support for Broadcom 413c:8143
From: Jesse Sung <jesse.sung@canonical.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org, Gavin Guo <gavin.guo@canonical.com>
Content-Type: multipart/alternative; boundary=001a1140f89ee648b4050d3592b8
List-ID: <linux-bluetooth.vger.kernel.org>

--001a1140f89ee648b4050d3592b8
Content-Type: text/plain; charset=UTF-8

Hi Marcel,

On Wed, Jan 21, 2015 at 4:26 PM, Marcel Holtmann <marcel@holtmann.org>
wrote:

> Hi Wein-chien,
>
> > From: Gavin Guo <gavin.guo@canonical.com>
> >
> > The device require external patchram firmware to work and need to
> > add corresponding id in the btusb.c.
> >
> > T:  Bus=03 Lev=01 Prnt=01 Port=08 Cnt=03 Dev#=  2 Spd=12  MxCh= 0
> > D:  Ver= 2.00 Cls=ff(vend.) Sub=01 Prot=01 MxPS=64 #Cfgs=  1
> > P:  Vendor=413c ProdID=8143 Rev=01.12
> > S:  Manufacturer=Broadcom Corp
> > S:  Product=BCM20702A0
> > S:  SerialNumber=20689D1FAF94
> > C:  #Ifs= 4 Cfg#= 1 Atr=e0 MxPwr=0mA
> > I:  If#= 0 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=01 Prot=01 Driver=btusb
> > I:  If#= 1 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=01 Prot=01 Driver=btusb
> > I:  If#= 2 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=ff Driver=(none)
> > I:  If#= 3 Alt= 0 #EPs= 0 Cls=fe(app. ) Sub=01 Prot=01 Driver=(none)
> >
> > Signed-off-by: Gavin Guo <gavin.guo@canonical.com>
> > Signed-off-by: Wen-chien Jesse Sung <jesse.sung@canonical.com>
> > ---
> > drivers/bluetooth/btusb.c | 2 ++
> > 1 file changed, 2 insertions(+)
> >
> > diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> > index cde222b..83cc221 100644
> > --- a/drivers/bluetooth/btusb.c
> > +++ b/drivers/bluetooth/btusb.c
> > @@ -107,6 +107,8 @@ static const struct usb_device_id btusb_table[] = {
> >       { USB_DEVICE(0x0b05, 0x17cb) },
> >       { USB_DEVICE(0x413c, 0x8197),
> >         .driver_info = BTUSB_BCM_PATCHRAM },
> > +     { USB_DEVICE(0x413c, 0x8143),
> > +       .driver_info = BTUSB_BCM_PATCHRAM },
>
> please stop doing line-breaks here. This can fit easily on a single line.
>

Will fix this and send again.


> And I really prefer the section from /sys/kernel/debug/usb/devices instead
> of the usb-devices script.
>

Humm... Since these patches are generated a while ago, I may not have
access to these modules now.
Is it okay to go with usb-devices info for this time?


Thanks,
Jesse

--001a1140f89ee648b4050d3592b8
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi Marcel,<br><div class=3D"gmail_extra"><br><div class=3D=
"gmail_quote">On Wed, Jan 21, 2015 at 4:26 PM, Marcel Holtmann <span dir=3D=
"ltr">&lt;<a href=3D"mailto:marcel@holtmann.org" target=3D"_blank">marcel@h=
oltmann.org</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" styl=
e=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">Hi Wein=
-chien,<br>
<div><div class=3D"h5"><br>
&gt; From: Gavin Guo &lt;<a href=3D"mailto:gavin.guo@canonical.com">gavin.g=
uo@canonical.com</a>&gt;<br>
&gt;<br>
&gt; The device require external patchram firmware to work and need to<br>
&gt; add corresponding id in the btusb.c.<br>
&gt;<br>
&gt; T:=C2=A0 Bus=3D03 Lev=3D01 Prnt=3D01 Port=3D08 Cnt=3D03 Dev#=3D=C2=A0 =
2 Spd=3D12=C2=A0 MxCh=3D 0<br>
&gt; D:=C2=A0 Ver=3D 2.00 Cls=3Dff(vend.) Sub=3D01 Prot=3D01 MxPS=3D64 #Cfg=
s=3D=C2=A0 1<br>
&gt; P:=C2=A0 Vendor=3D413c ProdID=3D8143 Rev=3D01.12<br>
&gt; S:=C2=A0 Manufacturer=3DBroadcom Corp<br>
&gt; S:=C2=A0 Product=3DBCM20702A0<br>
&gt; S:=C2=A0 SerialNumber=3D20689D1FAF94<br>
&gt; C:=C2=A0 #Ifs=3D 4 Cfg#=3D 1 Atr=3De0 MxPwr=3D0mA<br>
&gt; I:=C2=A0 If#=3D 0 Alt=3D 0 #EPs=3D 3 Cls=3Dff(vend.) Sub=3D01 Prot=3D0=
1 Driver=3Dbtusb<br>
&gt; I:=C2=A0 If#=3D 1 Alt=3D 0 #EPs=3D 2 Cls=3Dff(vend.) Sub=3D01 Prot=3D0=
1 Driver=3Dbtusb<br>
&gt; I:=C2=A0 If#=3D 2 Alt=3D 0 #EPs=3D 2 Cls=3Dff(vend.) Sub=3Dff Prot=3Df=
f Driver=3D(none)<br>
&gt; I:=C2=A0 If#=3D 3 Alt=3D 0 #EPs=3D 0 Cls=3Dfe(app. ) Sub=3D01 Prot=3D0=
1 Driver=3D(none)<br>
&gt;<br>
&gt; Signed-off-by: Gavin Guo &lt;<a href=3D"mailto:gavin.guo@canonical.com=
">gavin.guo@canonical.com</a>&gt;<br>
&gt; Signed-off-by: Wen-chien Jesse Sung &lt;<a href=3D"mailto:jesse.sung@c=
anonical.com">jesse.sung@canonical.com</a>&gt;<br>
&gt; ---<br>
&gt; drivers/bluetooth/btusb.c | 2 ++<br>
&gt; 1 file changed, 2 insertions(+)<br>
&gt;<br>
&gt; diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c<br>
&gt; index cde222b..83cc221 100644<br>
&gt; --- a/drivers/bluetooth/btusb.c<br>
&gt; +++ b/drivers/bluetooth/btusb.c<br>
&gt; @@ -107,6 +107,8 @@ static const struct usb_device_id btusb_table[] =
=3D {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0{ USB_DEVICE(0x0b05, 0x17cb) },<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0{ USB_DEVICE(0x413c, 0x8197),<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.driver_info =3D BTUSB_BCM_PATCHRAM }=
,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0{ USB_DEVICE(0x413c, 0x8143),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0.driver_info =3D BTUSB_BCM_PATCHRAM },<br>
<br>
</div></div>please stop doing line-breaks here. This can fit easily on a si=
ngle line.<br></blockquote><div><br></div><div>Will fix this and send again=
.<br></div><div>=C2=A0<br></div><blockquote class=3D"gmail_quote" style=3D"=
margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
And I really prefer the section from /sys/kernel/debug/usb/devices instead =
of the usb-devices script.<br></blockquote><div><br></div><div>Humm... Sinc=
e these patches are generated a while ago, I may not have access to these m=
odules now.<br></div>Is it okay to go with usb-devices info for this time?<=
br><br><br></div><div class=3D"gmail_quote">Thanks,<br></div><div class=3D"=
gmail_quote">Jesse<br></div></div></div>

--001a1140f89ee648b4050d3592b8--
