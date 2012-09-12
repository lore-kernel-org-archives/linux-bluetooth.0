Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1347456657.23874.29.camel@sirocco.hadess.net>
References: <1346378760.7976.2.camel@obelisk.thedillows.org>
	<20120907124559.GA16092@x220>
	<CABBYNZ+5E+BC-+9fj0e7iUpEDFJrJBQo8aoMZj8ZEkmiuB=QLA@mail.gmail.com>
	<1347284864.3532.1.camel@sirocco.hadess.net>
	<CABBYNZJpHkt8CGDsfVwirZ=vecb-fhbpPbrVFKt1UR_rA25mSw@mail.gmail.com>
	<CABBYNZ+n9obON7iNcv66x2ZVQCeTs_JoJUDXZFwxJJ6C4cb4YQ@mail.gmail.com>
	<CABBYNZKggzJ7bzQWVmWi30kxOUR8bVCyMLL=SM1=Oe74YPwvKg@mail.gmail.com>
	<1347394656.1606.10.camel@sirocco.hadess.net>
	<CABBYNZ+gpheC9sNeTp2uvDFBV-yPs+cY4PUR2omPt_kLTCafKw@mail.gmail.com>
	<1347456657.23874.29.camel@sirocco.hadess.net>
Date: Wed, 12 Sep 2012 17:32:22 +0300
Message-ID: <CABBYNZLwXhF0gixPGKUTJY4sZ7EHynTYmHzGtiZsoRGXgeEFaw@mail.gmail.com>
Subject: Re: [PATCH] Add support for Logitech Harmony Adapter for PS3
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Bastien Nocera <hadess@hadess.net>
Cc: David Dillow <dave@thedillows.org>, linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Bastien,

On Wed, Sep 12, 2012 at 4:30 PM, Bastien Nocera <hadess@hadess.net> wrote:
> Em Wed, 2012-09-12 às 13:56 +0300, Luiz Augusto von Dentz escreveu:
>> Hi Bastien,
>>
>> On Tue, Sep 11, 2012 at 11:17 PM, Bastien Nocera <hadess@hadess.net> wrote:
>> > Em Tue, 2012-09-11 às 17:21 +0300, Luiz Augusto von Dentz escreveu:
>> >> Hi Bastien,
>> >>
>> >> On Mon, Sep 10, 2012 at 10:03 PM, Luiz Augusto von Dentz
>> >> <luiz.dentz@gmail.com> wrote:
>> >> > Hi Bastien,
>> >> >
>> >> > On Mon, Sep 10, 2012 at 4:58 PM, Luiz Augusto von Dentz
>> >> > <luiz.dentz@gmail.com> wrote:
>> >> >> Hi Bastien,
>> >> >>
>> >> >> On Mon, Sep 10, 2012 at 4:47 PM, Bastien Nocera <hadess@hadess.net> wrote:
>> >> >>> Em Mon, 2012-09-10 às 16:11 +0300, Luiz Augusto von Dentz escreveu:
>> >> >>>> Hi David, Bastien,
>> >> >>>>
>> >> >>>> So we are plannin to rid of the fakehid.c in favor of implementing it
>> >> >>>> properly inside the kernel similarly to what was done to wiimote, so
>> >> >>>> is there any obstacle for doing that?
>> >> >>>>
>> >> >>>> The kernel seems to already have some support for sixaxis in
>> >> >>>> drivers/hid/hid-sony.c, so I suppose the following would enable us to
>> >> >>>> use it:
>> >> >>>
>> >> >>> It won't. They're not the same hardware.
>> >> >>
>> >> >> What hardware is that then? And why wouldn't the kernel be able to
>> >> >> support even if it is a different driver?
>> >> >
>> >> > So what exactly are the difference between 0x0268 and 0x0306? And why
>> >> > sixpair.c save as 0x0268 while fakeinput.c uses 0x0306?
>> >> >
>> >> > Also, after fixing sixpair.c to be able to compile it does add to the
>> >> > storage but it does not create any object until bluetoothd is
>> >> > restarted and even after restart it does not allow the device to
>> >> > connect because it does has the record (although this can be fixed by
>> >> > automatically add the UUID once we find out it is attempt to connect).
>> >>
>> >> So apparently the 0x0306 device is the br remote controller, not the
>> >> sixaxis joystick, sorry about the confusion.
>> >
>> > Completely different protocols for the devices, indeed.
>> >
>> >> Anyway regardless of
>> >> being a different device I thing we should move this code to kernel as
>> >> it was done for wiimote.
>> >
>> > Certainly, but until somebody writes the code (I already have at least 3
>> > drivers to submit to the kernel that I've not had time to handle,
>> > include one Bluetooth device), I think it would be nice not to drop
>> > support for the existing hardware. The cost of David's patch is close to
>> > none.
>>
>> Do you have any code already?
>
> Why would I? I don't have time to handle the 3 other drivers, and my BD
> remote is now in a shipping container.
>
>>  Anyway it is now removed from upstream,
>
> Why would you want to do that when we don't have a replacement in the
> kernel yet? I just spent time getting that timeout patch upstreamed,
> Johan even merged up David's patch, and 3 days after you remove the
> whole functionality.

Actually it wasn't me who removed:

commit 2e16cbf32569d834750f47107ee9c19954dd28bf
Author: Johan Hedberg <johan.hedberg@intel.com>
Date:   Mon Sep 10 15:51:23 2012 +0300

    input: Remove fakhid functionality

    The HSP code conflicts with a real HSP implementation and the PS3
    support should be done through the kernel.

So Johan supports the decision as well.

>> I will try to get one of these devices myself and start writing some
>> code if you don't have it done already.
>
> Around $20:
> http://www.amazon.com/Media-Blu-ray-Remote-Control-Playstation-3/dp/B0050SX9I2/
>
> Really not happy we're removing the functionality without having
> adequate replacement. That's not something you do with hardware
> enablement. I'm ready to take bets on the length of time where there's
> no support for the remote in distributions because it was removed in
> bluez, and not supported in the kernel.

In one way or the other the changes wouldn't be perfectly aligned, but
we need to move ahead with 5.0 release which probably has higher
priority than just 1 or 2 devices. Now don't get me wrong, I do think
having support for as many devices as possible is great but there is a
much bigger effort in doing the necessary changes for 5.0 and the
fakeinput was in the way of that so we had to make the decision to
remove it since the kernel driver we can do in parallel. Im not sure
how would you do it differently, if we had to wait until the kernel
has the driver we would have to test it against patched BlueZ which is
not that great either.

Getting the device does not seems to be a problem and we have a
similar driver already in the kernel, so Im really optimistic that it
will not take long to have this implemented in the kernel.

-- 
Luiz Augusto von Dentz
