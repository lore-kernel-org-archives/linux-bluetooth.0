Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <Vd5Hg1KzgalysaxK8wZu5wyXhzrIeNpwpHrqD6JzDGdK6926uwNchApKq9lnhrOPr7Y6Xb0Cgzzu-vWt8lvB-JRRxXhAmSPzjikGfg5kkSc=@krauser.org>
References: <Vd5Hg1KzgalysaxK8wZu5wyXhzrIeNpwpHrqD6JzDGdK6926uwNchApKq9lnhrOPr7Y6Xb0Cgzzu-vWt8lvB-JRRxXhAmSPzjikGfg5kkSc=@krauser.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 3 Jul 2018 14:00:55 +0300
Message-ID: <CABBYNZLHGQdpgZUGxaxhtWBG309WB9MVOXQxdRBWeMW+XuARBg@mail.gmail.com>
Subject: Re: Determine ATT MTU size over DBUS
To: David Krauser <david@krauser.org>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi David,

On Tue, Jul 3, 2018 at 2:31 AM, David Krauser <david@krauser.org> wrote:
> Hi,
>
> I'm working on an application that uses the bluez D-Bus bindings to register a GATT service and characteristic, but I'm having two issues:
>
> 1. I can't figure out how to get the negotiated MTU size for reads/writes to my characteristic.
>
> I saw that the AcquireNotify and AcquireWrite calls provide an MTU in the options dictionary, but there's no MTU provided for the WriteValue or ReadValue calls.

The MTU is negotiated automatically to the maximum value possible but
it doesn't really matter with WriteValue and ReadValue since they will
fragment and reassemble the data automatically, with Acquire* you will
get a file description which you can use to read or write.

> 2. I can't figure out how to dynamically change the max MTU size to use with my service.

You are not suppose to change the MTU more than once:

BLUETOOTH SPECIFICATION Version 5.0 | Vol 3, Part G
page 2248

'4.3.1 Exchange MTU
This sub-procedure is used by the client to set the ATT_MTU to the maximum
possible value that can be supported by both devices when the client supports
a value greater than the default ATT_MTU for the Attribute Protocol. This sub-
procedure shall only be initiated once during a connection.'

> I saw that you could change the max MTU size by changing some #define's in the bluez source code, but I couldn't find a way to change it dynamically (like how you can change the ACL/SCO MTU sizes).
>
> Is there something I'm missing? If not, would you all be open to a patch that adds the negotiated MTU size to the options dictionary on calls to ReadValue and WriteValue?

We could only negotiate it once, besides exposing this to applications
may impact other profiles, so the only option I see here is to have a
setting in the main.conf saying what is the preferred MTU for
GATT/ATT, provided your system only do have a single purpose for
Bluetooth you may change without affecting anything else. Anyway I
don't think this would have the result you expect since the default is
already the maximum allowed for an attribute, but perhaps we could
allow breaking the limit but the remote would have to agree on that
(see bellow).

> Or even better, I could add a new method to the GattCharacteristic1 interface that is called during MTU negotiation. It would receive the requested MTU size as an input, and the developer could choose to use that size, or return a different size to use.

We can do it only once and it is per connection not per
characteristic/attribute, also the MTU needs to be symmetric which
means the other side has to agree on the actual MTU to be used:

BLUETOOTH SPECIFICATION Version 5.0 | Vol 3, Part F
page 2185

'1. A device's Exchange MTU Request shall contain the same MTU as the
device's Exchange MTU Response (i.e. the MTU shall be symmetric).
2. If MTU is exchanged in one direction, that is sufficient for both directions.
3. It is permitted, (but not necessary - see 2.) to exchange MTU in both
directions, but the MTUs shall be the same in each direction (see 1.)'

All these limitations just means that GATT/ATT is not really meant to
be used as a serial/socket/pipe, and in fact that is why L2CAP CoC
exists so you could have your own dedicated socket with its own MTU
without messing around with GATT/ATT, L2CAP CoC should be supported by
most OSes nowadays.

> Thanks,
>
> - dk
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Luiz Augusto von Dentz
