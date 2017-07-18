Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH] gatt-server: Implement NegotiatedMTU property on Device1
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <C263BD82-A6D4-4325-BA01-2DD7A1F68532@sense.com>
Date: Tue, 18 Jul 2017 08:42:05 +0200
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Message-Id: <E9CF469C-80A3-4EB6-A46B-85F46BEC8D24@holtmann.org>
References: <CF389661-A1F2-4A25-96CD-0070FE33A1DE@sense.com>
 <CABBYNZKZCEQvA7fxqc5JtmBGGarqPRCntwFkRy4GZns35F1zvQ@mail.gmail.com>
 <8E72D5C7-FA44-4B06-82D7-2FCB22E26778@holtmann.org>
 <F04ADABE-DEA1-4003-9E95-E9FE8B8C94F4@sense.com>
 <1A61FCA4-F476-456F-AAAE-3C7753885BD4@holtmann.org>
 <C263BD82-A6D4-4325-BA01-2DD7A1F68532@sense.com>
To: Jonah Petri <jonah@sense.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jonah,

>>>> I think that exposing max payload is a better idea.
>>> 
>>> I am fine with the revised naming, and revising the exposed device attribute to represent the max ATT payload.  However, how can a dbus client know whether the MTU negotiation has occurred or not?  The point of the patch is to allow for clients to take advantage of a larger negotiated MTU.
>>> 
>>> The negotiation of the MTU can be a significant event to the client interacting via dbus, so how should the completion of that negotiation be exposed, if not via an attribute as I proposed above?  Some boolean "MaxPayloadNegotiationCompleted" method?
>> 
>> there will be PropertiesChanged signal once the MTU has been altered. Otherwise it will start out with 23 in case of LE or the minimum of whatever L2CAP has configured for BR/EDR. We do the same for RFCOMM btw. where it takes the minimum value from the two MTUs.
>> 
> 
> I understand.  However, there is no way for a dbus client to tell the difference between these two scenarios:
> 
> 1) The MTU has been negotiated to 23  (in the case of LE)
> 2) The MTU negotiation has not been completed
> 
> I expect many clients making use of this information will want to wait until the MTU negotiation is complete, and then begin normal operation.  A single attribute representing the current MTU seems to not be sufficient to implement such a dbus client.

the other option is to leave the property out until the MTU has been negotiated. So in case of LE and Exchange MTU has not yet happened, that property does not exist. In BR/EDR it will always exist since L2CAP has finished already.

So clients can start whenever they see the PropertiesChanged signal or get the property in the first place.

Regards

Marcel

