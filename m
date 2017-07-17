Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH] gatt-server: Implement NegotiatedMTU property on Device1
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <F04ADABE-DEA1-4003-9E95-E9FE8B8C94F4@sense.com>
Date: Mon, 17 Jul 2017 20:08:18 +0200
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Message-Id: <1A61FCA4-F476-456F-AAAE-3C7753885BD4@holtmann.org>
References: <CF389661-A1F2-4A25-96CD-0070FE33A1DE@sense.com>
 <CABBYNZKZCEQvA7fxqc5JtmBGGarqPRCntwFkRy4GZns35F1zvQ@mail.gmail.com>
 <8E72D5C7-FA44-4B06-82D7-2FCB22E26778@holtmann.org>
 <F04ADABE-DEA1-4003-9E95-E9FE8B8C94F4@sense.com>
To: Jonah Petri <jonah@sense.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jonah,

>>>> --- a/doc/device-api.txt
>>>> +++ b/doc/device-api.txt
>>>> @@ -234,3 +234,8 @@ Properties  string Address [readonly]
>>>>              array{byte} AdvertisingFlags [readonly, experimental]
>>>> 
>>>>                      The Advertising Data Flags of the remote device.
>>>> +
>>>> +               int16 NegotiatedMTU [readonly, optional, experimental]
>>>> +
>>>> +                       The ATT MTU negotiated with the connected host.
>>>> +                       Available only once MTU negotiation is complete.
>>> 
>>> Despite being odd that we start exposing transport specific details on
>>> device interface, there maybe a chance this is useful if we can
>>> properly detect BR/EDR MTU not only LE, though this means checking the
>>> via bt_att API not bt_gatt_server. Obviously, this would have to be
>>> exposed even before it is negotiated since LE start with 23 but on
>>> BR/EDR this is negotiated via L2CAP signaling, and perhaps it should
>>> not really be MTU that we expose but the actual payload without the
>>> headers that bluetoothd takes care of adding.
>> 
>> I think that exposing max payload is a better idea.
> 
> I am fine with the revised naming, and revising the exposed device attribute to represent the max ATT payload.  However, how can a dbus client know whether the MTU negotiation has occurred or not?  The point of the patch is to allow for clients to take advantage of a larger negotiated MTU.
> 
> The negotiation of the MTU can be a significant event to the client interacting via dbus, so how should the completion of that negotiation be exposed, if not via an attribute as I proposed above?  Some boolean "MaxPayloadNegotiationCompleted" method?

there will be PropertiesChanged signal once the MTU has been altered. Otherwise it will start out with 23 in case of LE or the minimum of whatever L2CAP has configured for BR/EDR. We do the same for RFCOMM btw. where it takes the minimum value from the two MTUs.

Regards

Marcel

