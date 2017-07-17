Return-Path: <jonah@sense.com>
From: Jonah Petri <jonah@sense.com>
Message-Id: <4F61E0A6-999F-441F-9062-8E01DC79205B@sense.com>
Content-Type: multipart/alternative;
 boundary="Apple-Mail=_CEDD1662-8606-45DB-A6F1-6F9CC38AD9EF"
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH] gatt-server: Implement NegotiatedMTU property on Device1
Date: Mon, 17 Jul 2017 11:30:41 -0400
In-Reply-To: <8E72D5C7-FA44-4B06-82D7-2FCB22E26778@holtmann.org>
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
To: Marcel Holtmann <marcel@holtmann.org>
References: <CF389661-A1F2-4A25-96CD-0070FE33A1DE@sense.com>
 <CABBYNZKZCEQvA7fxqc5JtmBGGarqPRCntwFkRy4GZns35F1zvQ@mail.gmail.com>
 <8E72D5C7-FA44-4B06-82D7-2FCB22E26778@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>


--Apple-Mail=_CEDD1662-8606-45DB-A6F1-6F9CC38AD9EF
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

Hello Marcel and Luiz,

Thanks for looking at the patch!

> On Jul 15, 2017, at 2:03 PM, Marcel Holtmann <marcel@holtmann.org> =
wrote:
>=20
>>> --- a/doc/device-api.txt
>>> +++ b/doc/device-api.txt
>>> @@ -234,3 +234,8 @@ Properties  string Address [readonly]
>>>               array{byte} AdvertisingFlags [readonly, experimental]
>>>=20
>>>                       The Advertising Data Flags of the remote =
device.
>>> +
>>> +               int16 NegotiatedMTU [readonly, optional, =
experimental]
>>> +
>>> +                       The ATT MTU negotiated with the connected =
host.
>>> +                       Available only once MTU negotiation is =
complete.
>>=20
>> Despite being odd that we start exposing transport specific details =
on
>> device interface, there maybe a chance this is useful if we can
>> properly detect BR/EDR MTU not only LE, though this means checking =
the
>> via bt_att API not bt_gatt_server. Obviously, this would have to be
>> exposed even before it is negotiated since LE start with 23 but on
>> BR/EDR this is negotiated via L2CAP signaling, and perhaps it should
>> not really be MTU that we expose but the actual payload without the
>> headers that bluetoothd takes care of adding.
>=20
> I think that exposing max payload is a better idea.

I am fine with the revised naming, and revising the exposed device =
attribute to represent the max ATT payload.  However, how can a dbus =
client know whether the MTU negotiation has occurred or not?  The point =
of the patch is to allow for clients to take advantage of a larger =
negotiated MTU.

The negotiation of the MTU can be a significant event to the client =
interacting via dbus, so how should the completion of that negotiation =
be exposed, if not via an attribute as I proposed above?  Some boolean =
"MaxPayloadNegotiationCompleted" method?

Jonah=

--Apple-Mail=_CEDD1662-8606-45DB-A6F1-6F9CC38AD9EF
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html;
	charset=us-ascii

<html><head><meta http-equiv=3D"Content-Type" content=3D"text/html =
charset=3Dus-ascii"></head><body style=3D"word-wrap: break-word; =
-webkit-nbsp-mode: space; -webkit-line-break: after-white-space;" =
class=3D"">Hello Marcel and Luiz,<div class=3D""><br class=3D""></div><div=
 class=3D"">Thanks for looking at the patch!</div><div class=3D""><br =
class=3D""><div class=3D""><div><blockquote type=3D"cite" class=3D""><div =
class=3D"">On Jul 15, 2017, at 2:03 PM, Marcel Holtmann &lt;<a =
href=3D"mailto:marcel@holtmann.org" class=3D"">marcel@holtmann.org</a>&gt;=
 wrote:</div><br class=3D"Apple-interchange-newline"><div class=3D""><div =
class=3D""><blockquote type=3D"cite" style=3D"font-family: =
Menlo-Regular; font-size: 11px; font-style: normal; font-variant-caps: =
normal; font-weight: normal; letter-spacing: normal; orphans: auto; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; widows: auto; word-spacing: 0px; -webkit-text-size-adjust: auto; =
-webkit-text-stroke-width: 0px;" class=3D""><blockquote type=3D"cite" =
class=3D"">--- a/doc/device-api.txt<br class=3D"">+++ =
b/doc/device-api.txt<br class=3D"">@@ -234,3 +234,8 @@ Properties =
&nbsp;string Address [readonly]<br =
class=3D"">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;array{byte} AdvertisingFlags [readonly, =
experimental]<br class=3D""><br =
class=3D"">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;The =
Advertising Data Flags of the remote device.<br class=3D"">+<br =
class=3D"">+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;int16 NegotiatedMTU [readonly, optional, experimental]<br =
class=3D"">+<br class=3D"">+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;The ATT MTU =
negotiated with the connected host.<br class=3D"">+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Available only =
once MTU negotiation is complete.<br class=3D""></blockquote><br =
class=3D"">Despite being odd that we start exposing transport specific =
details on<br class=3D"">device interface, there maybe a chance this is =
useful if we can<br class=3D"">properly detect BR/EDR MTU not only LE, =
though this means checking the<br class=3D"">via bt_att API not =
bt_gatt_server. Obviously, this would have to be<br class=3D"">exposed =
even before it is negotiated since LE start with 23 but on<br =
class=3D"">BR/EDR this is negotiated via L2CAP signaling, and perhaps it =
should<br class=3D"">not really be MTU that we expose but the actual =
payload without the<br class=3D"">headers that bluetoothd takes care of =
adding.<br class=3D""></blockquote><br style=3D"font-family: =
Menlo-Regular; font-size: 11px; font-style: normal; font-variant-caps: =
normal; font-weight: normal; letter-spacing: normal; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; =
word-spacing: 0px; -webkit-text-stroke-width: 0px;" class=3D""><span =
style=3D"font-family: Menlo-Regular; font-size: 11px; font-style: =
normal; font-variant-caps: normal; font-weight: normal; letter-spacing: =
normal; text-align: start; text-indent: 0px; text-transform: none; =
white-space: normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
float: none; display: inline !important;" class=3D"">I think that =
exposing max payload is a better idea.</span><br style=3D"font-family: =
Menlo-Regular; font-size: 11px; font-style: normal; font-variant-caps: =
normal; font-weight: normal; letter-spacing: normal; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; =
word-spacing: 0px; -webkit-text-stroke-width: 0px;" =
class=3D""></div></div></blockquote></div><br class=3D""><div class=3D"">I=
 am fine with the revised naming, and revising the exposed device =
attribute to represent the max ATT payload. &nbsp;However, how can a =
dbus client know whether the MTU negotiation has occurred or not? =
&nbsp;The point of the patch is to allow for clients to take advantage =
of a larger negotiated MTU.</div><div class=3D""><br class=3D""></div><div=
 class=3D"">The negotiation of the MTU can be a significant event to the =
client interacting via dbus, so how should the completion of that =
negotiation be exposed, if not via an attribute as I proposed above? =
&nbsp;Some boolean "MaxPayloadNegotiationCompleted" method?</div><div =
class=3D""><br class=3D""></div><div =
class=3D"">Jonah</div></div></div></body></html>=

--Apple-Mail=_CEDD1662-8606-45DB-A6F1-6F9CC38AD9EF--
