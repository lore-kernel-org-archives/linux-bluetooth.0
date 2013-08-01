Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAJdJm_OFtRR1kT+F4zrnSYzPeC+m4SF1w-WkWa686isXF7wo6g@mail.gmail.com>
References: <CAGoJ=AsOk=TPHoc3S+qs-0ukTjsf057cEA5DuMBp5zbsrz0AZg@mail.gmail.com>
 <CAJdJm_OFtRR1kT+F4zrnSYzPeC+m4SF1w-WkWa686isXF7wo6g@mail.gmail.com>
From: James Baker <j.baker@outlook.com>
Date: Thu, 1 Aug 2013 22:53:43 +0100
Message-ID: <CAGoJ=AuESMxOBSBWr=PifaGUPqTdEcTviFefYEnLMO_3bH+zbQ@mail.gmail.com>
Subject: Re: Accessing information transmitted by Ble tag.
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On 26 July 2013 14:01, Anderson Lizardo <anderson.lizardo@openbossa.org> wrote:
> Hi James,
>
> On Thu, Jul 25, 2013 at 7:42 PM, James Baker <j.baker@outlook.com> wrote:
>> As part of my summer placement, I've been introduced to some
>> non-connectable Ble tags. These are effectively beacons - advertising
>> and transmitting data every 250ms.
>>
>> Now, this is where I'm less clear:
>> I am something of a bluetooth newbie as it were, but I know for sure
>> they're transmitting more than just the address and name of the device
>> (as displayed in hcidump when running hcitool lescan). I know this
>> because the data is picked up on an iPhone app I have lying around.
>>
>> My question is, how would I read data from a connectionless Ble broadcaster?
>
> You forgot to mention what you need to do with the data once you get
> it at which "level" you want to program to get this data.
>
> On Linux, you have basically two "levels" to communicate with
> Bluetooth devices. At the highest level, you have a D-Bus API
> (documented on doc/*-api.txt files on the BlueZ source code) that
> usually is the easiest way to get information from devices, because
> you don't have to worry about packet details. The Broadaster/Observer
> API you found works at this level, but as you noticed, it has not
> evolved yet to go upstream. It's not being actively developed at the
> moment.
>
> The second, lower level is to program using Bluetooth sockets. At this
> level you talk directly to the kernel and BlueZ is not involved. It's
> much like programming for TCP sockets, if you have some experience
> with socket programming on Linux it will not be much different.
> hcitool works at this level.
>
> You already mentioned that with hcidump + hcitool lescan you were able
> to see the data you need to access. hcidump is just a "sniffer" that
> shows all the incoming/outgoing communication going through the
> bluetooth adapter. My advice is to take a look at the hcitool source
> code (tools/hcitool.c) and try to understand how lescan is
> implemented. With some effort, you will be able to modify hcitool to
> print the information you need.
>

Hi, thank you,
Just to give an update, I have done exactly that - I've gutted hcitool
in order to give me the individual packets, which I'm now decoding on
the fly. Now just to deal with connectable devices!

All best,
James
