Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAD0=r8wfL1TYghMk2wHYrZFZ9D=sz49_1fNPVsPvgqOUVdbuCQ@mail.gmail.com>
References: <CAD0=r8wfL1TYghMk2wHYrZFZ9D=sz49_1fNPVsPvgqOUVdbuCQ@mail.gmail.com>
Date: Fri, 29 May 2015 00:32:07 +0300
Message-ID: <CABBYNZ+JoqhDtH_ZN9bVafMnDYgyjsmwKnTssA8_QFJ1js9kQA@mail.gmail.com>
Subject: Re: [RFC] Add new method to DBus API: DiscoverServiceByUUID
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Jakub Pawlowski <jpawlowski@google.com>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jakub,

On Thu, May 28, 2015 at 11:44 PM, Jakub Pawlowski <jpawlowski@google.com> wrote:
> Currently, calling org.bluez.Device1.Connect() on a new, never
> connected before device, would cause automatic discovery of all
> services.
>
> This is bad in some cases, because discovering all available services
> might take a long time. Additionally some devices, i.e. iPhone have
> built-in 0.5s delay between each "Find Information Response" packet,
> which make discovery even longer.
>
>
> I would like to propose following change:
>
> 1. Calling org.bluez.Device1.Connect() would work just like now,
> except no "Find Information Request" would be issued (that means no
> call to "device_browse_gatt").
>
> 2. Add two new methods: org.bluez.Device1.DiscoverServices(), and
> org.bluez.Device1.DiscoverServiceByUUID(uuid). First one would just
> call device_browse_gatt and make "Find Information Request" , the
> second one would issue "Find By Type Value Request" to find just one
> service.

You are just changing one problem to another, or actually many other problems:

1. Instead of just 1 method there is at least 2, but Connect depends
on what has been discovered first so you are adding a D-Bus round
trips.
2. DiscoverServiceByUUID can only discover primary services if I
remember correct, what about included? And if an application, or many,
decide to discovery one by one every single UUID defined in the spec,
how many more request that would be compared to Read by Group Type
Request?
3. We can't take advance of Service Changed Characteristic if
DiscoverServiceByUUID, so at that point one would have to start
polling if the remote server has capability to change its database.

I guess the problem number 3 is actually what you did not consider,
the whole point is that we discover only once and then let the server
tell us what has changed, so reconnection should happens very fast
because we already have the device database in cache.


-- 
Luiz Augusto von Dentz
