Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAGoJ=AsOk=TPHoc3S+qs-0ukTjsf057cEA5DuMBp5zbsrz0AZg@mail.gmail.com>
References: <CAGoJ=AsOk=TPHoc3S+qs-0ukTjsf057cEA5DuMBp5zbsrz0AZg@mail.gmail.com>
Date: Fri, 26 Jul 2013 09:01:18 -0400
Message-ID: <CAJdJm_OFtRR1kT+F4zrnSYzPeC+m4SF1w-WkWa686isXF7wo6g@mail.gmail.com>
Subject: Re: Accessing information transmitted by Ble tag.
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: James Baker <j.baker@outlook.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi James,

On Thu, Jul 25, 2013 at 7:42 PM, James Baker <j.baker@outlook.com> wrote:
> As part of my summer placement, I've been introduced to some
> non-connectable Ble tags. These are effectively beacons - advertising
> and transmitting data every 250ms.
>
> Now, this is where I'm less clear:
> I am something of a bluetooth newbie as it were, but I know for sure
> they're transmitting more than just the address and name of the device
> (as displayed in hcidump when running hcitool lescan). I know this
> because the data is picked up on an iPhone app I have lying around.
>
> My question is, how would I read data from a connectionless Ble broadcaster?

You forgot to mention what you need to do with the data once you get
it at which "level" you want to program to get this data.

On Linux, you have basically two "levels" to communicate with
Bluetooth devices. At the highest level, you have a D-Bus API
(documented on doc/*-api.txt files on the BlueZ source code) that
usually is the easiest way to get information from devices, because
you don't have to worry about packet details. The Broadaster/Observer
API you found works at this level, but as you noticed, it has not
evolved yet to go upstream. It's not being actively developed at the
moment.

The second, lower level is to program using Bluetooth sockets. At this
level you talk directly to the kernel and BlueZ is not involved. It's
much like programming for TCP sockets, if you have some experience
with socket programming on Linux it will not be much different.
hcitool works at this level.

You already mentioned that with hcidump + hcitool lescan you were able
to see the data you need to access. hcidump is just a "sniffer" that
shows all the incoming/outgoing communication going through the
bluetooth adapter. My advice is to take a look at the hcitool source
code (tools/hcitool.c) and try to understand how lescan is
implemented. With some effort, you will be able to modify hcitool to
print the information you need.

Once you are able to do this, you can reuse the C code to do whatever
you need to do with that data (paying attention to the GPL license
though).

You may need to study how the data in LE advertising packets is
formatted, if you have not done this yet. Grab your copy of the Core
Specification from
https://www.bluetooth.org/docman/handlers/downloaddoc.ashx?doc_id=229737
and take a look at sections like:

* Volume 3 , Part C , Sections 9.1 "Broadcast Mode and Observation
Procedure" and 11 "Advertising and Scan Response Data Format"
* Volume 2, Part E, Sections 7.7.65 "LE Meta Event" and 7.8 "LE
Controller Commands" if you want to better understand the output from
HCI dump regarding LE related HCI packets.

There is also a book on Bluetooth 4.0, but I don't remember the name
right now (I haven't read it myself but people I know have read and
liked it).

> I was originally looking for some kind of observer-broadcaster api and
> in fact found patches on this list regarding it, and even an orphaned
> branch at http://gitorious.org/~jdelfes/bluez/jdelfes-bluez/commits/bo-new,
> but those APIs don't seem to have made it into the official
> repository.

Unfortunately, we (== the team I work with) are not actively working
on this API at the moment. Currently we are focusing on improving GATT
APIs and LE support in general in BlueZ.

Best Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
