Return-Path: <jonah@sense.com>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH] gatt-server: Implement NegotiatedMTU property on Device1
From: Jonah Petri <jonah@sense.com>
In-Reply-To: <E9CF469C-80A3-4EB6-A46B-85F46BEC8D24@holtmann.org>
Date: Tue, 18 Jul 2017 08:41:47 -0400
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Message-Id: <F84CC9C9-0C8A-4F19-9B36-8A771C02842C@sense.com>
References: <CF389661-A1F2-4A25-96CD-0070FE33A1DE@sense.com>
 <CABBYNZKZCEQvA7fxqc5JtmBGGarqPRCntwFkRy4GZns35F1zvQ@mail.gmail.com>
 <8E72D5C7-FA44-4B06-82D7-2FCB22E26778@holtmann.org>
 <F04ADABE-DEA1-4003-9E95-E9FE8B8C94F4@sense.com>
 <1A61FCA4-F476-456F-AAAE-3C7753885BD4@holtmann.org>
 <C263BD82-A6D4-4325-BA01-2DD7A1F68532@sense.com>
 <E9CF469C-80A3-4EB6-A46B-85F46BEC8D24@holtmann.org>
To: Marcel Holtmann <marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

> On Jul 18, 2017, at 2:42 AM, Marcel Holtmann <marcel@holtmann.org> =
wrote:
>=20
>>>> The negotiation of the MTU can be a significant event to the client =
interacting via dbus, so how should the completion of that negotiation =
be exposed, if not via an attribute as I proposed above?  Some boolean =
"MaxPayloadNegotiationCompleted" method?
>>>=20
>>> there will be PropertiesChanged signal once the MTU has been =
altered. Otherwise it will start out with 23 in case of LE or the =
minimum of whatever L2CAP has configured for BR/EDR. We do the same for =
RFCOMM btw. where it takes the minimum value from the two MTUs.
>>>=20
>>=20
>> I understand.  However, there is no way for a dbus client to tell the =
difference between these two scenarios:
>>=20
>> 1) The MTU has been negotiated to 23  (in the case of LE)
>> 2) The MTU negotiation has not been completed
>>=20
>> I expect many clients making use of this information will want to =
wait until the MTU negotiation is complete, and then begin normal =
operation.  A single attribute representing the current MTU seems to not =
be sufficient to implement such a dbus client.
>=20
> the other option is to leave the property out until the MTU has been =
negotiated. So in case of LE and Exchange MTU has not yet happened, that =
property does not exist. In BR/EDR it will always exist since L2CAP has =
finished already.
>=20
> So clients can start whenever they see the PropertiesChanged signal or =
get the property in the first place.
>=20

This seems fine to me.  Thanks for the feedback.  I will submit a new =
patch.

Jonah
