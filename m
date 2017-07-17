Return-Path: <jonah@sense.com>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH] gatt-server: Implement NegotiatedMTU property on Device1
From: Jonah Petri <jonah@sense.com>
In-Reply-To: <8E72D5C7-FA44-4B06-82D7-2FCB22E26778@holtmann.org>
Date: Mon, 17 Jul 2017 11:30:56 -0400
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Message-Id: <F04ADABE-DEA1-4003-9E95-E9FE8B8C94F4@sense.com>
References: <CF389661-A1F2-4A25-96CD-0070FE33A1DE@sense.com>
 <CABBYNZKZCEQvA7fxqc5JtmBGGarqPRCntwFkRy4GZns35F1zvQ@mail.gmail.com>
 <8E72D5C7-FA44-4B06-82D7-2FCB22E26778@holtmann.org>
To: Marcel Holtmann <marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

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
