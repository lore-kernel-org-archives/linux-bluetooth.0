Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAOw_LSHQupEKuNkMw3mWw5one+s_vV=baiRnEnOOosgtSdxo7g@mail.gmail.com>
References: <1438843403.19625.7.camel@dlenski-ultra> <CABBYNZL6vGkzZ-aEObSK+5YASOD_s3n+7JNoBG+p33c5F4mbgw@mail.gmail.com>
 <CAOw_LSHQupEKuNkMw3mWw5one+s_vV=baiRnEnOOosgtSdxo7g@mail.gmail.com>
From: Daniel Lenski <dlenski@gmail.com>
Date: Sun, 9 Aug 2015 19:23:05 -0700
Message-ID: <CAOw_LSHbHb81c5zooZz5e8pUx1aaEr=kLVS_NViU92UwE9fxLQ@mail.gmail.com>
Subject: Fwd: setting BLE connection interval from an unprivileged program?
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Sun, Aug 9, 2015 at 8:44 AM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>> * Is there a better way to accomplish this in an unprivileged program?
>
> It depends what you are planning to do, for GATT/ATT there is probably
> no way to share the socket since there could be other application
> trying to access other profiles. There is always the possibility to
> write a plugin to provide the settings per profile but we are still
> discussing an API to inform this to the kernel so it can select what
> settings shall be used based on the requested values.

Thanks. Trying to make sure I understand this...

Are you saying that there could be another application which depends
on the HCI socket being configured with a different connection
interval for the same peripheral? If the peripheral isn't part of a
known profile, as with this device, then I don't see how this could
possibly be true, since it's totally up to userspace to interact with
the peripheral.

>>   Is there some L2CAP socket option which I can use to set the LE
>>   connection interval parameters?
>
> Currently no, but there are people currently working on adding socket
> options for these, but then again if this is GATT/ATT socket it will
> probably be controlled by bluetoothd.

Is it already possible to configure bluetoothd to use a specific
connection interval for a specific LE device? (I couldn't find
anything in the docs.)

>> * Why does the Linux kernel default to a needlessly long minimum
>>   connection interval when creating a L2CAP socket?
>
> I guess it is the defaults from the spec, but in case the peripheral
> updates it the kernel will remember next time it connects, so I guess
> the peripheral don't bother to change anything that the central
> requests?

Yeah, the problem in my case is that the peripheral never requests a
shorter connection interval, and in fact it picks the shorter option
among those offered by the central. The peripheral's firmware is
stupid about this, since it can support a shorter interval and
transfers data much faster in that case.

I guess I'm trying to figure out the least-intrusive way for a
userspace program to demand a shorter connection interval for a device
that benefits from it, but is too stupid to ask for it itself :-)

Dan
