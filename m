Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <5234EF82-463D-4521-ABDB-C68132933BD7@sense.com>
References: <9B25967D-16B8-4335-BE03-8FFD02D400FB@sense.com>
 <CAO1O6sdd9KxagrbboW+9gpc+OBmsJo6S6g09imAoNxRv5tyA3Q@mail.gmail.com>
 <CABBYNZLfbhXfEsb=DY-1mzQdiZVmJ9Ka3GjdGiGYgoaqKhkB+A@mail.gmail.com> <5234EF82-463D-4521-ABDB-C68132933BD7@sense.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 6 Sep 2017 17:14:58 +0300
Message-ID: <CABBYNZJ3eJBDCv-ZiVw_0WPRKGyHJzH4hE-gGkHXo+pxhU3cZw@mail.gmail.com>
Subject: Re: [PATCH v2] gatt-server: Implement NegotiatedMTU property on Device1
To: Jonah Petri <jonah@sense.com>
Cc: Emil Lenngren <emil.lenngren@gmail.com>,
        Bluez mailing list <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jonah,

On Wed, Sep 6, 2017 at 4:55 PM, Jonah Petri <jonah@sense.com> wrote:
> Hi Luiz and Emil,
>
> Thanks for your comments!
>
>> On Sep 6, 2017, at 9:01 AM, Luiz Augusto von Dentz <luiz.dentz@gmail.com=
> wrote:
>>
>>> I know there were some discussions regarding if it should be called
>>> max attribute size or mtu.
>>> Maybe I'm a bit late but in my opinion I think mtu is a better option.
>>>
>>> "The maximum supported byte size of attributes, as negotiated between
>>> this host and the remote device" is a bit misleading/wrong since the
>>> BLE spec allows up to 512 byte attribute values no matter of the MTU.
>>
>> Note that the MTU can be in fact even bigger than 512 bytes since it
>> can be used by things like discover, etc, which is not bound to a
>> single attribute, though for practical reasons BlueZ will always
>> request 512 bytes since buffer size is usually not a concern in
>> systems running Linux.
>>
>>> You can still perform a Long Write where the attribute value is larger
>>> than the MTU for example.
>>> Also, the max value size for transfer is different depending on
>>> method. Max value size for a notification/indication or normal write
>>> is ATT_MTU-3 while max value size for a normal read is ATT_MTU-1.
>>
>> Yep, we can't really use the same value for read/write since the
>> actual payload changes depending on the opcode.
>>
>>> With the current patch it's not clear (by only looking at the
>>> documentation) which value "max attribute size" really means. If it's
>>> called MTU it's on the other hand very clear what it is (like it is
>>> called in Android's implementation). Even if there is a difference
>>> between BD/EDR and LE MTU negotiation, the packet format for ATT and
>>> the meaning of MTU is still the same.
>>
>> The fundamental part missing here is that over BR/EDR the MTU can be
>> asymmetric meaning we need the MTU value for input and output to be
>> separated.
>
> Hm.  BR/EDR isn't even the intended use case here, and (as you point out)=
 complicates the API greatly.  And in general, I agree with Emil that the M=
TU is really what many clients of this API are interested in.
>
> What if I reformulate the API as LE-specific, and instead of making the A=
PI about Maximum Attribute Size, I return to simply making the MTU availabl=
e to dbus clients.  That's all I really want for my use case, and I'll make=
 an effort to make the documentation sufficiently educational that develope=
rs should be able to do the right thing.  What about this?

Your implementation is not really LE specific, in fact it will cause
the clients to believe they connected over LE if the MTU appears,
besides with cross transport pairing and dual mode topology this has
to work either way or then we have to disable GATT completely on
BR/EDR.

Also, the AcquireWrite and AcquireNotify should fulfil most of the use
cases where GATT is used just as transport to another protocol, is
that what you are intending to do?

Having an API just for a very specific use case that in the future may
actually disappear with OSes adopting L2CAP CoC is not very nice.

> +               int16 LENegotiatedATTMTU [readonly,
> +                                         optional,
> +                                         experimental]
> +
> +                       The Maximum Transmission Unit of the ATT protocol=
,
> +                       as negotiated with this device by bluetoothd.  Th=
is
> +                       property is only available for devices connected =
via
> +                       BTLE, and only after MTU negotiation is complete.
> +                       If this property is not available, clients may
> +                       only assume a MTU of 23 bytes, as required by the
> +                       Bluetooth specification.
> +                       The maximum GATT attribute data is MTU - 3, altho=
ugh
> +                       some devices may support Long Read and Long Write
> +                       commands, allowing for larger attribute data size=
s.
> +
>
> Best,
>
> Jonah
>
>



--=20
Luiz Augusto von Dentz
