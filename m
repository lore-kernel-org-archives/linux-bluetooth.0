Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <a4919190d5de8c7c3d25f1ea81772513@labapart.com>
References: <0fef8015e74a2a96af45c36e9c67dc36@labapart.com>
 <9c9da882-fd5b-dfa1-447e-a6f05b341f97@scs.ch> <a4919190d5de8c7c3d25f1ea81772513@labapart.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 11 Jul 2017 16:01:16 +0300
Message-ID: <CABBYNZLp-1gxGftHQBT_q5pdrxW_fdBoKYMQSmMOS+bZWwk=NQ@mail.gmail.com>
Subject: Re: DBUS API: Retrieve current MTU used by remote device
To: Olivier MARTIN <olivier@labapart.com>
Cc: Felix Schulthess <felix.schulthess@scs.ch>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Olivier,

On Tue, Jul 11, 2017 at 1:54 PM, Olivier MARTIN <olivier@labapart.com> wrot=
e:
> Thanks Luiz for the answer, but I am guessing WriteValue() uses Long Writ=
e.
> But it looks like not all BLE devices support Long Read/Write (including
> Bluez until recently - v5.39 - April 2016). It also seems some/all(?)
> Android devices do not support it.

I wouldn't call recently a more than one year only release and I guess
the versions that don't support, and I though Long Write is mandatory
for the server at least for the complete server:

C.4: Mandatory IF GATT 1/4 =E2=80=9CComplete GATT Server=E2=80=9D is suppor=
ted,
otherwise Optional.

or are you talking about Reliable Writes?

> I did not find this information but is a device that does not support Lon=
g
> Write; would the application still receive GATT packets sent by Long Writ=
e
> in a defragmented manner?

I guess the remaining bytes over the MTU would not be sent since that
would require Prepare Write operation which I guess fail with such
devices and since regular Write Request don't have an offset we cannot
continue sending.

> The workaround often uses is to leave the GATT server fragmenting itself =
the
> packets to send to the GATT client with an arbitrary packet length value.
> Knowing the MTU uses between the two GATT devices could improve the
> throughput.

I guess you mean the GATT server will not be able to reassemble thus
you send in chunks as big as the MTU, but this presumes there is
something in the data payload that is doing sar, so a protocol on top
of GATT.

But be aware that most OSes don't protect against multiple clients
writing to the same attribute, not to mention there can be quite big
latencies since GATT has a 30 seconds timeout for each request which
is why usually Write Without Response procedure is used with such
operations.

If you care about throughput then using D-Bus to pipe data is probably
very inefficient, L2CAP CoC would probably be the best solution to
something like a serial port emulation over LE, but sadly Android and
iOS still don't support that.

--=20
Luiz Augusto von Dentz
