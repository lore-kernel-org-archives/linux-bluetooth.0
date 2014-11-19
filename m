Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <546C3CCE.400@gmail.com>
References: <CANoib0HW2umPpzzerYNq1fMMnkYxOa78o5X90-K=eNEnTGSO1w@mail.gmail.com>
 <F01422F2-5F7C-406A-A06B-2C2CE96B9E3A@holtmann.org> <546C3CCE.400@gmail.com>
From: Michel Memeteau - EKIMIA <contact@ekimia.fr>
Date: Wed, 19 Nov 2014 10:37:10 +0100
Message-ID: <CAKxAHQ4intUoy2qv9ftTJL_c2JN3kYn8bC_Jk9=93rvvXNE80Q@mail.gmail.com>
Subject: Re: [PATCH v3] ath3k: Add support of MCI 13d3:3408 bt device
To: Dmitry Tunin <hanipouspilot@gmail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
	"larry.finger" <Larry.Finger@lwfinger.net>
Content-Type: multipart/alternative; boundary=001a11c3508696f8a1050832f50c
List-ID: <linux-bluetooth.vger.kernel.org>

--001a11c3508696f8a1050832f50c
Content-Type: text/plain; charset=UTF-8

Hi,

I tried to understand why this "0x13d3, 0x3408" device support  wouldn't go
in btusb as it's really close to IMC BT chip found in Realtek Wifi devices
which is on the path to go in btusb [1]

then I guess there is a lot of code that could be shared to support all IMC
usb devices in the btusb module.

Regards.

[1] https://github.com/lwfinger/rtl8723au_bt/tree/new

<------------------------------------------------------------------------------------------------------------------>
Michel Memeteau  - Directeur.
<http://shop.ekimia.fr/>

Notre Boutique Ordinateurs GNU/Linux : http://shop.ekimia.fr
49 chemin de l'union 13720 La Bouilladisse - France.
Fixe :  +33 (0) 972308334   Mobile : +33(0) 624808051
<------------------------------------------------------------------------------------------------------------------>

2014-11-19 7:46 GMT+01:00 Dmitry Tunin <hanipouspilot@gmail.com>:

> Hi Marcel,
>
> Here is information from /sys/kernel/debug/usb/devices
>
> T:  Bus=01 Lev=02 Prnt=03 Port=00 Cnt=01 Dev#= 20 Spd=12 MxCh= 0
> D:  Ver= 1.10 Cls=e0(wlcon) Sub=01 Prot=01 MxPS=64 #Cfgs= 1
> P:  Vendor=13d3 ProdID=3408 Rev= 0.02
> C:* #Ifs= 2 Cfg#= 1 Atr=e0 MxPwr=100mA
> A:  FirstIf#= 0 IfCount= 2 Cls=e0(wlcon) Sub=01 Prot=01
> I:* If#= 0 Alt= 0 #EPs= 3 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> E:  Ad=81(I) Atr=03(Int.) MxPS=  16 Ivl=1ms
> E:  Ad=82(I) Atr=02(Bulk) MxPS=  64 Ivl=0ms
> E:  Ad=02(O) Atr=02(Bulk) MxPS=  64 Ivl=0ms
> I:* If#= 1 Alt= 0 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> E:  Ad=83(I) Atr=01(Isoc) MxPS=   0 Ivl=1ms
> E:  Ad=03(O) Atr=01(Isoc) MxPS=   0 Ivl=1ms
> I:  If#= 1 Alt= 1 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> E:  Ad=83(I) Atr=01(Isoc) MxPS=   9 Ivl=1ms
> E:  Ad=03(O) Atr=01(Isoc) MxPS=   9 Ivl=1ms
> I:  If#= 1 Alt= 2 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> E:  Ad=83(I) Atr=01(Isoc) MxPS=  17 Ivl=1ms
> E:  Ad=03(O) Atr=01(Isoc) MxPS=  17 Ivl=1ms
> I:  If#= 1 Alt= 3 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> E:  Ad=83(I) Atr=01(Isoc) MxPS=  25 Ivl=1ms
> E:  Ad=03(O) Atr=01(Isoc) MxPS=  25 Ivl=1ms
> I:  If#= 1 Alt= 4 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> E:  Ad=83(I) Atr=01(Isoc) MxPS=  33 Ivl=1ms
> E:  Ad=03(O) Atr=01(Isoc) MxPS=  33 Ivl=1ms
> I:  If#= 1 Alt= 5 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> E:  Ad=83(I) Atr=01(Isoc) MxPS=  49 Ivl=1ms
> E:  Ad=03(O) Atr=01(Isoc) MxPS=  49 Ivl=1ms
>
>
> I hope this mail client is OK now.
>
> Add support for bluetooth MCI WB335 (AR9565) Wi-Fi+bt module.
> It is AR3011 device according to iProduct == 0.
> So btusb should be blacklisted
> I submitted a wrong patch before asif  it was an AR3012 device,
> but it works both ways. This is the right one.
>
> Signed-off-by: Dmitry Tunin<hanipouspilot@gmail.com>
>
> ---
>
> diff --git a/drivers/bluetooth/ath3k.c b/drivers/bluetooth/ath3k.c
> index d85ced2..3b53116 100644
> --- a/drivers/bluetooth/ath3k.c
> +++ b/drivers/bluetooth/ath3k.c
> @@ -69,6 +69,7 @@ static const struct usb_device_id ath3k_table[] = {
>      { USB_DEVICE(0x0CF3, 0x3002) },
>      { USB_DEVICE(0x0CF3, 0xE019) },
>      { USB_DEVICE(0x13d3, 0x3304) },
> +    { USB_DEVICE(0x13d3, 0x3408) },
>
>      /* Atheros AR9285 Malbec with sflash firmware */
>      { USB_DEVICE(0x03F0, 0x311D) },
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index edfc17b..bbf5c1c 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -146,6 +146,7 @@ static const struct usb_device_id blacklist_table[] = {
>      { USB_DEVICE(0x0cf3, 0x3002), .driver_info = BTUSB_IGNORE },
>      { USB_DEVICE(0x0cf3, 0xe019), .driver_info = BTUSB_IGNORE },
>      { USB_DEVICE(0x13d3, 0x3304), .driver_info = BTUSB_IGNORE },
> +    { USB_DEVICE(0x13d3, 0x3408), .driver_info = BTUSB_IGNORE },
>
>      /* Atheros AR9285 Malbec with sflash firmware */
>      { USB_DEVICE(0x03f0, 0x311d), .driver_info = BTUSB_IGNORE },
>
>
> 19.11.2014 01:56, Marcel Holtmann wrote:
>
>> Hi Dmitry,
>>
>>  Add support for bluetooth MCI WB335 (AR9565) Wi-Fi+bt module.
>>> It is AR3011 device according to iProduct == 0.
>>> So btusb should be blacklisted
>>> I submitted a wrong patch before asif  it was an AR3012 device,
>>> but it works both ways. This is the right one.
>>>
>> include the device details from /sys/kernel/debug/usb/devices.
>>
>>  Signed-off-by: Dmitry Tunin <hanipouspilot@gmail.com>
>>> are */
>>>
>> No idea what this are */ is.
>>
>>  ---
>>>
>>> diff --git a/drivers/bluetooth/ath3k.c b/drivers/bluetooth/ath3k.c
>>> index d85ced2..3b53116 100644
>>> --- a/drivers/bluetooth/ath3k.c
>>> +++ b/drivers/bluetooth/ath3k.c
>>> @@ -69,6 +69,7 @@ static const struct usb_device_id ath3k_table[] = {
>>>   { USB_DEVICE(0x0CF3, 0x3002) },
>>>   { USB_DEVICE(0x0CF3, 0xE019) },
>>>   { USB_DEVICE(0x13d3, 0x3304) },
>>> + { USB_DEVICE(0x13d3, 0x3408) },
>>>
>>>   /* Atheros AR9285 Malbec with sflash firmware */
>>>   { USB_DEVICE(0x03F0, 0x311D) },
>>> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
>>> index edfc17b..bbf5c1c 100644
>>> --- a/drivers/bluetooth/btusb.c
>>> +++ b/drivers/bluetooth/btusb.c
>>> @@ -146,6 +146,7 @@ static const struct usb_device_id blacklist_table[]
>>> = {
>>>   { USB_DEVICE(0x0cf3, 0x3002), .driver_info = BTUSB_IGNORE },
>>>   { USB_DEVICE(0x0cf3, 0xe019), .driver_info = BTUSB_IGNORE },
>>>   { USB_DEVICE(0x13d3, 0x3304), .driver_info = BTUSB_IGNORE },
>>> + { USB_DEVICE(0x13d3, 0x3408), .driver_info = BTUSB_IGNORE },
>>>
>> Fix whitespace here or use a proper mail client.
>>
>> Regards
>>
>> Marcel
>>
>>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth"
> in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

--001a11c3508696f8a1050832f50c
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi,=C2=A0<div><br></div><div>I tried to understand why thi=
s &quot;<span style=3D"font-family:arial,sans-serif;font-size:12.8000001907=
349px">0x13d3, 0x3408&quot; device support =C2=A0wouldn&#39;t go in btusb a=
s it&#39;s really close to IMC BT chip found in Realtek Wifi devices which =
is on the path to go in btusb [1]</span></div><div><span style=3D"font-fami=
ly:arial,sans-serif;font-size:12.8000001907349px"><br></span></div><div><sp=
an style=3D"font-family:arial,sans-serif;font-size:12.8000001907349px">then=
 I guess there is a lot of code that could be shared to support all IMC usb=
 devices in the btusb module.</span></div><div><span style=3D"font-family:a=
rial,sans-serif;font-size:12.8000001907349px"><br></span></div><div><span s=
tyle=3D"font-family:arial,sans-serif;font-size:12.8000001907349px">Regards.=
</span></div><div><span style=3D"font-family:arial,sans-serif;font-size:12.=
8000001907349px"><br></span></div><div><span style=3D"font-family:arial,san=
s-serif;font-size:12.8000001907349px">[1]=C2=A0</span><font face=3D"arial, =
sans-serif"><span style=3D"font-size:12.8000001907349px"><a href=3D"https:/=
/github.com/lwfinger/rtl8723au_bt/tree/new">https://github.com/lwfinger/rtl=
8723au_bt/tree/new</a></span></font></div></div><div class=3D"gmail_extra">=
<br clear=3D"all"><div><div class=3D"gmail_signature"><div dir=3D"ltr">&lt;=
---------------------------------------------------------------------------=
---------------------------------------&gt;<div>Michel Memeteau =C2=A0- Dir=
ecteur.</div><div><a href=3D"http://shop.ekimia.fr/" target=3D"_blank"><img=
 src=3D"http://shop.ekimia.fr/img/logo.jpg" width=3D"200" height=3D"54"></a=
><br></div><div><br>Notre Boutique Ordinateurs GNU/Linux :=C2=A0<a href=3D"=
http://shop.ekimia.fr/" target=3D"_blank">http://shop.ekimia.fr</a><br><div=
>49 chemin de l&#39;union 13720 La Bouilladisse - France.</div><div>Fixe : =
=C2=A0+33 (0) 972308334 =C2=A0 Mobile : +33(0) 624808051</div>&lt;---------=
---------------------------------------------------------------------------=
------------------------------&gt;=C2=A0</div></div></div></div>
<br><div class=3D"gmail_quote">2014-11-19 7:46 GMT+01:00 Dmitry Tunin <span=
 dir=3D"ltr">&lt;<a href=3D"mailto:hanipouspilot@gmail.com" target=3D"_blan=
k">hanipouspilot@gmail.com</a>&gt;</span>:<br><blockquote class=3D"gmail_qu=
ote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex=
">Hi Marcel,<br>
<br>
Here is information from /sys/kernel/debug/usb/devices<br>
<br>
T:=C2=A0 Bus=3D01 Lev=3D02 Prnt=3D03 Port=3D00 Cnt=3D01 Dev#=3D 20 Spd=3D12=
 MxCh=3D 0<br>
D:=C2=A0 Ver=3D 1.10 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 MxPS=3D64 #Cfgs=3D =
1<br>
P:=C2=A0 Vendor=3D13d3 ProdID=3D3408 Rev=3D 0.02<br>
C:* #Ifs=3D 2 Cfg#=3D 1 Atr=3De0 MxPwr=3D100mA<br>
A:=C2=A0 FirstIf#=3D 0 IfCount=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D01<br>
I:* If#=3D 0 Alt=3D 0 #EPs=3D 3 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Driver=
=3Dbtusb<br>
E:=C2=A0 Ad=3D81(I) Atr=3D03(Int.) MxPS=3D=C2=A0 16 Ivl=3D1ms<br>
E:=C2=A0 Ad=3D82(I) Atr=3D02(Bulk) MxPS=3D=C2=A0 64 Ivl=3D0ms<br>
E:=C2=A0 Ad=3D02(O) Atr=3D02(Bulk) MxPS=3D=C2=A0 64 Ivl=3D0ms<br>
I:* If#=3D 1 Alt=3D 0 #EPs=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Driver=
=3Dbtusb<br>
E:=C2=A0 Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D=C2=A0 =C2=A00 Ivl=3D1ms<br>
E:=C2=A0 Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D=C2=A0 =C2=A00 Ivl=3D1ms<br>
I:=C2=A0 If#=3D 1 Alt=3D 1 #EPs=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Dri=
ver=3Dbtusb<br>
E:=C2=A0 Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D=C2=A0 =C2=A09 Ivl=3D1ms<br>
E:=C2=A0 Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D=C2=A0 =C2=A09 Ivl=3D1ms<br>
I:=C2=A0 If#=3D 1 Alt=3D 2 #EPs=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Dri=
ver=3Dbtusb<br>
E:=C2=A0 Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D=C2=A0 17 Ivl=3D1ms<br>
E:=C2=A0 Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D=C2=A0 17 Ivl=3D1ms<br>
I:=C2=A0 If#=3D 1 Alt=3D 3 #EPs=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Dri=
ver=3Dbtusb<br>
E:=C2=A0 Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D=C2=A0 25 Ivl=3D1ms<br>
E:=C2=A0 Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D=C2=A0 25 Ivl=3D1ms<br>
I:=C2=A0 If#=3D 1 Alt=3D 4 #EPs=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Dri=
ver=3Dbtusb<br>
E:=C2=A0 Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D=C2=A0 33 Ivl=3D1ms<br>
E:=C2=A0 Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D=C2=A0 33 Ivl=3D1ms<br>
I:=C2=A0 If#=3D 1 Alt=3D 5 #EPs=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Dri=
ver=3Dbtusb<br>
E:=C2=A0 Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D=C2=A0 49 Ivl=3D1ms<br>
E:=C2=A0 Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D=C2=A0 49 Ivl=3D1ms<br>
<br>
<br>
I hope this mail client is OK now.<span class=3D""><br>
<br>
Add support for bluetooth MCI WB335 (AR9565) Wi-Fi+bt module.<br>
It is AR3011 device according to iProduct =3D=3D 0.<br>
So btusb should be blacklisted<br>
I submitted a wrong patch before asif=C2=A0 it was an AR3012 device,<br>
but it works both ways. This is the right one.<br>
<br></span>
Signed-off-by: Dmitry Tunin&lt;<a href=3D"mailto:hanipouspilot@gmail.com" t=
arget=3D"_blank">hanipouspilot@gmail.com</a>&gt;<span class=3D"im HOEnZb"><=
br>
<br>
---<br>
<br>
diff --git a/drivers/bluetooth/ath3k.c b/drivers/bluetooth/ath3k.c<br>
index d85ced2..3b53116 100644<br>
--- a/drivers/bluetooth/ath3k.c<br>
+++ b/drivers/bluetooth/ath3k.c<br>
@@ -69,6 +69,7 @@ static const struct usb_device_id ath3k_table[] =3D {<br>
=C2=A0 =C2=A0 =C2=A0{ USB_DEVICE(0x0CF3, 0x3002) },<br>
=C2=A0 =C2=A0 =C2=A0{ USB_DEVICE(0x0CF3, 0xE019) },<br>
=C2=A0 =C2=A0 =C2=A0{ USB_DEVICE(0x13d3, 0x3304) },<br>
+=C2=A0 =C2=A0 { USB_DEVICE(0x13d3, 0x3408) },<br>
<br>
=C2=A0 =C2=A0 =C2=A0/* Atheros AR9285 Malbec with sflash firmware */<br>
=C2=A0 =C2=A0 =C2=A0{ USB_DEVICE(0x03F0, 0x311D) },<br>
diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c<br>
index edfc17b..bbf5c1c 100644<br>
--- a/drivers/bluetooth/btusb.c<br>
+++ b/drivers/bluetooth/btusb.c<br>
@@ -146,6 +146,7 @@ static const struct usb_device_id blacklist_table[] =3D=
 {<br>
=C2=A0 =C2=A0 =C2=A0{ USB_DEVICE(0x0cf3, 0x3002), .driver_info =3D BTUSB_IG=
NORE },<br>
=C2=A0 =C2=A0 =C2=A0{ USB_DEVICE(0x0cf3, 0xe019), .driver_info =3D BTUSB_IG=
NORE },<br>
=C2=A0 =C2=A0 =C2=A0{ USB_DEVICE(0x13d3, 0x3304), .driver_info =3D BTUSB_IG=
NORE },<br>
+=C2=A0 =C2=A0 { USB_DEVICE(0x13d3, 0x3408), .driver_info =3D BTUSB_IGNORE =
},<br>
<br>
=C2=A0 =C2=A0 =C2=A0/* Atheros AR9285 Malbec with sflash firmware */<br></s=
pan><span class=3D"im HOEnZb">
=C2=A0 =C2=A0 =C2=A0{ USB_DEVICE(0x03f0, 0x311d), .driver_info =3D BTUSB_IG=
NORE },<br>
<br>
<br></span><div class=3D"HOEnZb"><div class=3D"h5">
19.11.2014 01:56, Marcel Holtmann wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
Hi Dmitry,<br>
<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
Add support for bluetooth MCI WB335 (AR9565) Wi-Fi+bt module.<br>
It is AR3011 device according to iProduct =3D=3D 0.<br>
So btusb should be blacklisted<br>
I submitted a wrong patch before asif=C2=A0 it was an AR3012 device,<br>
but it works both ways. This is the right one.<br>
</blockquote>
include the device details from /sys/kernel/debug/usb/devices.<br>
<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
Signed-off-by: Dmitry Tunin &lt;<a href=3D"mailto:hanipouspilot@gmail.com" =
target=3D"_blank">hanipouspilot@gmail.com</a>&gt;<br>
are */<br>
</blockquote>
No idea what this are */ is.<br>
<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
---<br>
<br>
diff --git a/drivers/bluetooth/ath3k.c b/drivers/bluetooth/ath3k.c<br>
index d85ced2..3b53116 100644<br>
--- a/drivers/bluetooth/ath3k.c<br>
+++ b/drivers/bluetooth/ath3k.c<br>
@@ -69,6 +69,7 @@ static const struct usb_device_id ath3k_table[] =3D {<br>
=C2=A0 { USB_DEVICE(0x0CF3, 0x3002) },<br>
=C2=A0 { USB_DEVICE(0x0CF3, 0xE019) },<br>
=C2=A0 { USB_DEVICE(0x13d3, 0x3304) },<br>
+ { USB_DEVICE(0x13d3, 0x3408) },<br>
<br>
=C2=A0 /* Atheros AR9285 Malbec with sflash firmware */<br>
=C2=A0 { USB_DEVICE(0x03F0, 0x311D) },<br>
diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c<br>
index edfc17b..bbf5c1c 100644<br>
--- a/drivers/bluetooth/btusb.c<br>
+++ b/drivers/bluetooth/btusb.c<br>
@@ -146,6 +146,7 @@ static const struct usb_device_id blacklist_table[] =3D=
 {<br>
=C2=A0 { USB_DEVICE(0x0cf3, 0x3002), .driver_info =3D BTUSB_IGNORE },<br>
=C2=A0 { USB_DEVICE(0x0cf3, 0xe019), .driver_info =3D BTUSB_IGNORE },<br>
=C2=A0 { USB_DEVICE(0x13d3, 0x3304), .driver_info =3D BTUSB_IGNORE },<br>
+ { USB_DEVICE(0x13d3, 0x3408), .driver_info =3D BTUSB_IGNORE },<br>
</blockquote>
Fix whitespace here or use a proper mail client.<br>
<br>
Regards<br>
<br>
Marcel<br>
<br>
</blockquote>
<br>
--<br>
To unsubscribe from this list: send the line &quot;unsubscribe linux-blueto=
oth&quot; in<br>
the body of a message to <a href=3D"mailto:majordomo@vger.kernel.org" targe=
t=3D"_blank">majordomo@vger.kernel.org</a><br>
More majordomo info at=C2=A0 <a href=3D"http://vger.kernel.org/majordomo-in=
fo.html" target=3D"_blank">http://vger.kernel.org/<u></u>majordomo-info.htm=
l</a><br>
</div></div></blockquote></div><br></div>

--001a11c3508696f8a1050832f50c--
