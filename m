Return-Path: <honwchong@gmail.com>
MIME-Version: 1.0
References: <20171111174326.9243-1-Larry.Finger@lwfinger.net>
 <82ACB0CF-DD2F-4A44-A2F0-75D1C1B3DA9C@holtmann.org> <a2c8efa7-6acb-fc97-8401-87bbc9e3d618@lwfinger.net>
In-Reply-To: <a2c8efa7-6acb-fc97-8401-87bbc9e3d618@lwfinger.net>
From: Hon Weng Chong <honwchong@gmail.com>
Date: Tue, 14 Nov 2017 23:03:50 +0000
Message-ID: <CANCjmFLmwdjJsbcB8d5=bHUUBEFOsuQsjMtfJ-=o=4VQNX0r4Q@mail.gmail.com>
Subject: Re: [PATCH] bluetooth: btusb: Add device ID for RTL8822BE
To: Larry Finger <Larry.Finger@lwfinger.net>
Cc: Marcel Holtmann <marcel@holtmann.org>, "Gustavo F. Padovan" <gustavo@padovan.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-bluetooth@vger.kernel.org
Content-Type: multipart/alternative; boundary="001a1140ac7018d01e055df9679f"
List-ID: <linux-bluetooth.vger.kernel.org>

--001a1140ac7018d01e055df9679f
Content-Type: text/plain; charset="UTF-8"

Hi all,

Apologies for the delayed reply. Here's the data for the Realtek Bluetooth
Device:

T:  Bus=01 Lev=01 Prnt=01 Port=13 Cnt=07 Dev#= 14 Spd=12   MxCh= 0
D:  Ver= 1.10 Cls=e0(wlcon) Sub=01 Prot=01 MxPS=64 #Cfgs=  1
P:  Vendor=0b05 ProdID=185c Rev= 1.10
S:  Manufacturer=Realtek
S:  Product=Bluetooth Radio
S:  SerialNumber=00e04c000001
C:* #Ifs= 2 Cfg#= 1 Atr=e0 MxPwr=500mA
I:* If#= 0 Alt= 0 #EPs= 3 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=81(I) Atr=03(Int.) MxPS=  16 Ivl=1ms
E:  Ad=02(O) Atr=02(Bulk) MxPS=  64 Ivl=0ms
E:  Ad=82(I) Atr=02(Bulk) MxPS=  64 Ivl=0ms
I:* If#= 1 Alt= 0 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=03(O) Atr=01(Isoc) MxPS=   0 Ivl=1ms
E:  Ad=83(I) Atr=01(Isoc) MxPS=   0 Ivl=1ms
I:  If#= 1 Alt= 1 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=03(O) Atr=01(Isoc) MxPS=   9 Ivl=1ms
E:  Ad=83(I) Atr=01(Isoc) MxPS=   9 Ivl=1ms
I:  If#= 1 Alt= 2 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=03(O) Atr=01(Isoc) MxPS=  17 Ivl=1ms
E:  Ad=83(I) Atr=01(Isoc) MxPS=  17 Ivl=1ms
I:  If#= 1 Alt= 3 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=03(O) Atr=01(Isoc) MxPS=  25 Ivl=1ms
E:  Ad=83(I) Atr=01(Isoc) MxPS=  25 Ivl=1ms
I:  If#= 1 Alt= 4 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=03(O) Atr=01(Isoc) MxPS=  33 Ivl=1ms
E:  Ad=83(I) Atr=01(Isoc) MxPS=  33 Ivl=1ms
I:  If#= 1 Alt= 5 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=03(O) Atr=01(Isoc) MxPS=  49 Ivl=1ms
E:  Ad=83(I) Atr=01(Isoc) MxPS=  49 Ivl=1ms


On Sun, 12 Nov 2017 at 06:10 Larry Finger <Larry.Finger@lwfinger.net> wrote:

> On 11/11/2017 12:51 PM, Marcel Holtmann wrote:
> > Hi Larry,
> >
> >> The Asus Z370-I contains a Realtek RTL8822BE device with an associated
> >> BT chip using a USB ID of 0b05:185c. This device is added to the driver.
> >>
> >> Signed-off-by: Hon Weng Chong <honwchong@gmail.com>
> >> Signed-off-by: Larry Finger <Larry.Finger@lwfinger.net>
> >> ---
> >> drivers/bluetooth/btusb.c | 3 +++
> >> 1 file changed, 3 insertions(+)
> >>
> >> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> >> index 7a5c06aaa181..c265ef63cab7 100644
> >> --- a/drivers/bluetooth/btusb.c
> >> +++ b/drivers/bluetooth/btusb.c
> >> @@ -373,6 +373,9 @@ static const struct usb_device_id blacklist_table[]
> = {
> >>      { USB_DEVICE(0x13d3, 0x3461), .driver_info = BTUSB_REALTEK },
> >>      { USB_DEVICE(0x13d3, 0x3462), .driver_info = BTUSB_REALTEK },
> >>
> >> +    /* Additional Realtek 8822BE Bluetooth devices */
> >> +    { USB_DEVICE(0x0b05, 0x1185c), .driver_info = BTUSB_REALTEK },
> >> +
> >
> > I prefer to have /sys/kernel/debug/usb/devices for the device included
> in the commit message.
> >
> > Regards
> >
> > Marcel
> >
> >
> Hon,
>
> Please provide the data.
>
> Larry
>
>

--001a1140ac7018d01e055df9679f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi all,<div><br></div><div>Apologies for the delayed reply=
. Here&#39;s the data for the Realtek Bluetooth Device:</div><div><br></div=
><div><div>T:=C2=A0 Bus=3D01 Lev=3D01 Prnt=3D01 Port=3D13 Cnt=3D07 Dev#=3D =
14 Spd=3D12=C2=A0 =C2=A0MxCh=3D 0</div><div>D:=C2=A0 Ver=3D 1.10 Cls=3De0(w=
lcon) Sub=3D01 Prot=3D01 MxPS=3D64 #Cfgs=3D=C2=A0 1</div><div>P:=C2=A0 Vend=
or=3D0b05 ProdID=3D185c Rev=3D 1.10</div><div>S:=C2=A0 Manufacturer=3DRealt=
ek=C2=A0</div><div>S:=C2=A0 Product=3DBluetooth Radio=C2=A0</div><div>S:=C2=
=A0 SerialNumber=3D00e04c000001</div><div>C:* #Ifs=3D 2 Cfg#=3D 1 Atr=3De0 =
MxPwr=3D500mA</div><div>I:* If#=3D 0 Alt=3D 0 #EPs=3D 3 Cls=3De0(wlcon) Sub=
=3D01 Prot=3D01 Driver=3Dbtusb</div><div>E:=C2=A0 Ad=3D81(I) Atr=3D03(Int.)=
 MxPS=3D=C2=A0 16 Ivl=3D1ms</div><div>E:=C2=A0 Ad=3D02(O) Atr=3D02(Bulk) Mx=
PS=3D=C2=A0 64 Ivl=3D0ms</div><div>E:=C2=A0 Ad=3D82(I) Atr=3D02(Bulk) MxPS=
=3D=C2=A0 64 Ivl=3D0ms</div><div>I:* If#=3D 1 Alt=3D 0 #EPs=3D 2 Cls=3De0(w=
lcon) Sub=3D01 Prot=3D01 Driver=3Dbtusb</div><div>E:=C2=A0 Ad=3D03(O) Atr=
=3D01(Isoc) MxPS=3D=C2=A0 =C2=A00 Ivl=3D1ms</div><div>E:=C2=A0 Ad=3D83(I) A=
tr=3D01(Isoc) MxPS=3D=C2=A0 =C2=A00 Ivl=3D1ms</div><div>I:=C2=A0 If#=3D 1 A=
lt=3D 1 #EPs=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Driver=3Dbtusb</div><d=
iv>E:=C2=A0 Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D=C2=A0 =C2=A09 Ivl=3D1ms</div>=
<div>E:=C2=A0 Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D=C2=A0 =C2=A09 Ivl=3D1ms</di=
v><div>I:=C2=A0 If#=3D 1 Alt=3D 2 #EPs=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=
=3D01 Driver=3Dbtusb</div><div>E:=C2=A0 Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D=
=C2=A0 17 Ivl=3D1ms</div><div>E:=C2=A0 Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D=C2=
=A0 17 Ivl=3D1ms</div><div>I:=C2=A0 If#=3D 1 Alt=3D 3 #EPs=3D 2 Cls=3De0(wl=
con) Sub=3D01 Prot=3D01 Driver=3Dbtusb</div><div>E:=C2=A0 Ad=3D03(O) Atr=3D=
01(Isoc) MxPS=3D=C2=A0 25 Ivl=3D1ms</div><div>E:=C2=A0 Ad=3D83(I) Atr=3D01(=
Isoc) MxPS=3D=C2=A0 25 Ivl=3D1ms</div><div>I:=C2=A0 If#=3D 1 Alt=3D 4 #EPs=
=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Driver=3Dbtusb</div><div>E:=C2=A0 =
Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D=C2=A0 33 Ivl=3D1ms</div><div>E:=C2=A0 Ad=
=3D83(I) Atr=3D01(Isoc) MxPS=3D=C2=A0 33 Ivl=3D1ms</div><div>I:=C2=A0 If#=
=3D 1 Alt=3D 5 #EPs=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Driver=3Dbtusb<=
/div><div>E:=C2=A0 Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D=C2=A0 49 Ivl=3D1ms</di=
v><div>E:=C2=A0 Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D=C2=A0 49 Ivl=3D1ms</div><=
div><br></div><br><div class=3D"gmail_quote"><div dir=3D"ltr">On Sun, 12 No=
v 2017 at 06:10 Larry Finger &lt;<a href=3D"mailto:Larry.Finger@lwfinger.ne=
t">Larry.Finger@lwfinger.net</a>&gt; wrote:<br></div><blockquote class=3D"g=
mail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-l=
eft:1ex">On 11/11/2017 12:51 PM, Marcel Holtmann wrote:<br>
&gt; Hi Larry,<br>
&gt;<br>
&gt;&gt; The Asus Z370-I contains a Realtek RTL8822BE device with an associ=
ated<br>
&gt;&gt; BT chip using a USB ID of 0b05:185c. This device is added to the d=
river.<br>
&gt;&gt;<br>
&gt;&gt; Signed-off-by: Hon Weng Chong &lt;<a href=3D"mailto:honwchong@gmai=
l.com" target=3D"_blank">honwchong@gmail.com</a>&gt;<br>
&gt;&gt; Signed-off-by: Larry Finger &lt;<a href=3D"mailto:Larry.Finger@lwf=
inger.net" target=3D"_blank">Larry.Finger@lwfinger.net</a>&gt;<br>
&gt;&gt; ---<br>
&gt;&gt; drivers/bluetooth/btusb.c | 3 +++<br>
&gt;&gt; 1 file changed, 3 insertions(+)<br>
&gt;&gt;<br>
&gt;&gt; diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c=
<br>
&gt;&gt; index 7a5c06aaa181..c265ef63cab7 100644<br>
&gt;&gt; --- a/drivers/bluetooth/btusb.c<br>
&gt;&gt; +++ b/drivers/bluetooth/btusb.c<br>
&gt;&gt; @@ -373,6 +373,9 @@ static const struct usb_device_id blacklist_ta=
ble[] =3D {<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 { USB_DEVICE(0x13d3, 0x3461), .driver_info =3D=
 BTUSB_REALTEK },<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 { USB_DEVICE(0x13d3, 0x3462), .driver_info =3D=
 BTUSB_REALTEK },<br>
&gt;&gt;<br>
&gt;&gt; +=C2=A0 =C2=A0 /* Additional Realtek 8822BE Bluetooth devices */<b=
r>
&gt;&gt; +=C2=A0 =C2=A0 { USB_DEVICE(0x0b05, 0x1185c), .driver_info =3D BTU=
SB_REALTEK },<br>
&gt;&gt; +<br>
&gt;<br>
&gt; I prefer to have /sys/kernel/debug/usb/devices for the device included=
 in the commit message.<br>
&gt;<br>
&gt; Regards<br>
&gt;<br>
&gt; Marcel<br>
&gt;<br>
&gt;<br>
Hon,<br>
<br>
Please provide the data.<br>
<br>
Larry<br>
<br>
</blockquote></div></div></div>

--001a1140ac7018d01e055df9679f--
