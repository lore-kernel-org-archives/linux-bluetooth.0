Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAKT1EBdjG_4+hOd0FCA+WbxCeHS85NEryMvZ3=+HHyPrqejk+A@mail.gmail.com>
References: <CAKON4OziwQbTUymPddfu7i_6g2oMMXJsbf8RE3kZWZPDVbcFqQ@mail.gmail.com>
	<CAKT1EBdjG_4+hOd0FCA+WbxCeHS85NEryMvZ3=+HHyPrqejk+A@mail.gmail.com>
Date: Thu, 29 Aug 2013 14:31:10 -0400
Message-ID: <CAKON4Ox2a_e5-=A3hsfR+KFZDcGkrVpHVWQT_HTt1H-rkJwQWQ@mail.gmail.com>
Subject: Re: Simultaneous BLE connections
From: "jonsmirl@gmail.com" <jonsmirl@gmail.com>
To: Claudio Takahasi <claudio.takahasi@openbossa.org>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Wed, Aug 28, 2013 at 9:52 AM, Claudio Takahasi
<claudio.takahasi@openbossa.org> wrote:
> Hi Jon:
>
> On Tue, Aug 27, 2013 at 6:04 PM, jonsmirl@gmail.com <jonsmirl@gmail.com> wrote:
>> How are multiple BLE connections implemented in Bluez? Is it a
>> function of host memory like IOS with a high limit (1000's)? I see an
>> old post saying that Bluez only supports one connection at a time.
>
> BlueZ implements General Connection establishment procedure, multiple
> connections can be active at a time. There is a plan to move the
> "core" BLE connection management to the kernel, but at the moment
> connection attempts and scanning are controlled by the user-space.

I'm still trying to work out the best solution. I'm not convinced that
a user space BLE connection implementation can do the fine grain
scheduling needed to handle multiple open connections and get the
connection events on each connection scheduled at the correct time.
That's making me lean more toward a connectionless scheme that uses
advertising.

If optimal scheduling can be achieved, a connection oriented scheme is
better for power consumption. But if everything is going to get out of
sync all of the time then the connectionless scheme is better.

Of course larger transaction actions will still use a connection, they
just won't use the BLE feature of leaving the connection open for long
periods of time.

>
> If your question is related to white-list, we don't support Selective
> or Auto Connection procedures. The controllers that I have the
> white-list size is limited to 16 to 64 entries, if you need to handle
> more than the limit your host will need to implement some logic to
> select the devices that you want to connect to. Another point is, if
> you need to resolve address the entries in the list need to be more
> dynamic.
>
>>
>> This has a large impact on host power consumption. With a connection
>> you know the windows where you have to listen for a peripheral
>> connection. If instead you use advertising to trigger the connection
>> the host has to always be scanning since you never know when the
>> peripheral is going to advertise.
>>
>> An example system might have twenty BLE sensors that send alerts when
>> they are tripped. Wouldn't it be better to have 20 long lasting
>> connections to these sensors? Now the host only has to wake up at the
>> windows where it is legal for the peripheral to transmit. And the
>> peripherals can take advantage of their ability to skip transmission
>> windows.
>
> In this case, peripheral could use the signalling channel and starts
> the Connection Update Parameter procedure.
>
> BR,
> Claudio



-- 
Jon Smirl
jonsmirl@gmail.com
