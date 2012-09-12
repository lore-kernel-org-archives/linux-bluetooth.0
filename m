Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1347394656.1606.10.camel@sirocco.hadess.net>
References: <1346378760.7976.2.camel@obelisk.thedillows.org>
	<20120907124559.GA16092@x220>
	<CABBYNZ+5E+BC-+9fj0e7iUpEDFJrJBQo8aoMZj8ZEkmiuB=QLA@mail.gmail.com>
	<1347284864.3532.1.camel@sirocco.hadess.net>
	<CABBYNZJpHkt8CGDsfVwirZ=vecb-fhbpPbrVFKt1UR_rA25mSw@mail.gmail.com>
	<CABBYNZ+n9obON7iNcv66x2ZVQCeTs_JoJUDXZFwxJJ6C4cb4YQ@mail.gmail.com>
	<CABBYNZKggzJ7bzQWVmWi30kxOUR8bVCyMLL=SM1=Oe74YPwvKg@mail.gmail.com>
	<1347394656.1606.10.camel@sirocco.hadess.net>
Date: Wed, 12 Sep 2012 13:56:36 +0300
Message-ID: <CABBYNZ+gpheC9sNeTp2uvDFBV-yPs+cY4PUR2omPt_kLTCafKw@mail.gmail.com>
Subject: Re: [PATCH] Add support for Logitech Harmony Adapter for PS3
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Bastien Nocera <hadess@hadess.net>
Cc: David Dillow <dave@thedillows.org>, linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Bastien,

On Tue, Sep 11, 2012 at 11:17 PM, Bastien Nocera <hadess@hadess.net> wrote:
> Em Tue, 2012-09-11 às 17:21 +0300, Luiz Augusto von Dentz escreveu:
>> Hi Bastien,
>>
>> On Mon, Sep 10, 2012 at 10:03 PM, Luiz Augusto von Dentz
>> <luiz.dentz@gmail.com> wrote:
>> > Hi Bastien,
>> >
>> > On Mon, Sep 10, 2012 at 4:58 PM, Luiz Augusto von Dentz
>> > <luiz.dentz@gmail.com> wrote:
>> >> Hi Bastien,
>> >>
>> >> On Mon, Sep 10, 2012 at 4:47 PM, Bastien Nocera <hadess@hadess.net> wrote:
>> >>> Em Mon, 2012-09-10 às 16:11 +0300, Luiz Augusto von Dentz escreveu:
>> >>>> Hi David, Bastien,
>> >>>>
>> >>>> So we are plannin to rid of the fakehid.c in favor of implementing it
>> >>>> properly inside the kernel similarly to what was done to wiimote, so
>> >>>> is there any obstacle for doing that?
>> >>>>
>> >>>> The kernel seems to already have some support for sixaxis in
>> >>>> drivers/hid/hid-sony.c, so I suppose the following would enable us to
>> >>>> use it:
>> >>>
>> >>> It won't. They're not the same hardware.
>> >>
>> >> What hardware is that then? And why wouldn't the kernel be able to
>> >> support even if it is a different driver?
>> >
>> > So what exactly are the difference between 0x0268 and 0x0306? And why
>> > sixpair.c save as 0x0268 while fakeinput.c uses 0x0306?
>> >
>> > Also, after fixing sixpair.c to be able to compile it does add to the
>> > storage but it does not create any object until bluetoothd is
>> > restarted and even after restart it does not allow the device to
>> > connect because it does has the record (although this can be fixed by
>> > automatically add the UUID once we find out it is attempt to connect).
>>
>> So apparently the 0x0306 device is the br remote controller, not the
>> sixaxis joystick, sorry about the confusion.
>
> Completely different protocols for the devices, indeed.
>
>> Anyway regardless of
>> being a different device I thing we should move this code to kernel as
>> it was done for wiimote.
>
> Certainly, but until somebody writes the code (I already have at least 3
> drivers to submit to the kernel that I've not had time to handle,
> include one Bluetooth device), I think it would be nice not to drop
> support for the existing hardware. The cost of David's patch is close to
> none.

Do you have any code already? Anyway it is now removed from upstream,
I will try to get one of these devices myself and start writing some
code if you don't have it done already.

> There's also a bunch of features that I'm not sure how you'd handle,
> like forcing a disconnect timeout for the device (a patch which Johan
> merged a couple of days ago).

We can extend the ioctl and pass the idle timeout to the kernel,
actually if you take a closer look it already does have support for
that in hidp_connadd_req.idle_to. The other option is to use uhid like
we do with low energy and handle this in userspace but then we might
need device drivers matching vendor/product like the kernel does to do
the key mapping and will probably cause more latency.

-- 
Luiz Augusto von Dentz
