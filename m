Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <B79CAA63-93A0-4BD6-88A8-1287B377296D@holtmann.org>
References: <CAE1tnCy4qcTmwxj_rnpxC3yFFgU2bOPA94WJeuvatNjWU-wu8A@mail.gmail.com>
 <B79CAA63-93A0-4BD6-88A8-1287B377296D@holtmann.org>
From: mike mike <majormail999@gmail.com>
Date: Mon, 23 May 2016 10:49:18 -0700
Message-ID: <CAE1tnCzFzg9U_B+=fDubL0i6_rTi7BsHiE2rpE6MR2ngvur-cQ@mail.gmail.com>
Subject: Re: Disabling passive scanning for LE connections
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Thank you, Marcel.

I was not aware of the HCI User Channel.  It looks like it may be the
way I have to eventually go.  The code currently uses L2CAP sockets
for BLE GATT data and it looks like this would mean I need to write my
own replacement.  I have not looked into writing and L2CAP socket
replacement, but assume this will be a major task.  Any other
suggestions or recommendations on where to start for the L2CAP socket
replacement?

On Fri, May 20, 2016 at 12:14 AM, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi Mike,
>
>>> All LE connections are now triggered through a preceding passive scan
>>> and waiting for a connectable advertising report. This means we've got
>>> the best possible guarantee that the device is within range and should
>>> be able to request the controller to perform continuous scanning. This
>>> way we minimize the risk that we miss out on any advertising packets.
>>
>> My code manages 100's of BLE devices with long advertising periods.
>> I need to connect to devices (sometime multiples devices at the same
>> time) as quickly as possible.  My current implementation usually catches
>> and connects to the first advertising event (average connect time is < 7
>> seconds)
>>
>> I have my own code using the HCI interface for doing this.  This code
>> has worked well for a while, but since the passive LE scanning was
>> added as part of the kernel connection processes (kernel 4.4.4?) I
>> have a problems with the process:
>>
>> - occasionally conflicting with my access to the whitelist
>> - occasionally deleting all entries in my whitelist.
>>
>> Is it possible to disable passive scanning, or will I need a kludge to
>> catch and work around these events?
>
> use HCI User Channel to gain exclusive HCI access. Otherwise the kernel owns the HCI control and not you. You would be injecting commands from user space with no guarantee that the kernel will overwrite it.
>
> Regards
>
> Marcel
>
