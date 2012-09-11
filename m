Return-Path: <cyrus@holtmann.org>
Message-ID: <1347394656.1606.10.camel@sirocco.hadess.net>
Subject: Re: [PATCH] Add support for Logitech Harmony Adapter for PS3
From: Bastien Nocera <hadess@hadess.net>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: David Dillow <dave@thedillows.org>, linux-bluetooth@vger.kernel.org
Date: Tue, 11 Sep 2012 21:17:36 +0100
In-Reply-To: <CABBYNZKggzJ7bzQWVmWi30kxOUR8bVCyMLL=SM1=Oe74YPwvKg@mail.gmail.com>
References: <1346378760.7976.2.camel@obelisk.thedillows.org>
	 <20120907124559.GA16092@x220>
	 <CABBYNZ+5E+BC-+9fj0e7iUpEDFJrJBQo8aoMZj8ZEkmiuB=QLA@mail.gmail.com>
	 <1347284864.3532.1.camel@sirocco.hadess.net>
	 <CABBYNZJpHkt8CGDsfVwirZ=vecb-fhbpPbrVFKt1UR_rA25mSw@mail.gmail.com>
	 <CABBYNZ+n9obON7iNcv66x2ZVQCeTs_JoJUDXZFwxJJ6C4cb4YQ@mail.gmail.com>
	 <CABBYNZKggzJ7bzQWVmWi30kxOUR8bVCyMLL=SM1=Oe74YPwvKg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Em Tue, 2012-09-11 às 17:21 +0300, Luiz Augusto von Dentz escreveu:
> Hi Bastien,
> 
> On Mon, Sep 10, 2012 at 10:03 PM, Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
> > Hi Bastien,
> >
> > On Mon, Sep 10, 2012 at 4:58 PM, Luiz Augusto von Dentz
> > <luiz.dentz@gmail.com> wrote:
> >> Hi Bastien,
> >>
> >> On Mon, Sep 10, 2012 at 4:47 PM, Bastien Nocera <hadess@hadess.net> wrote:
> >>> Em Mon, 2012-09-10 às 16:11 +0300, Luiz Augusto von Dentz escreveu:
> >>>> Hi David, Bastien,
> >>>>
> >>>> So we are plannin to rid of the fakehid.c in favor of implementing it
> >>>> properly inside the kernel similarly to what was done to wiimote, so
> >>>> is there any obstacle for doing that?
> >>>>
> >>>> The kernel seems to already have some support for sixaxis in
> >>>> drivers/hid/hid-sony.c, so I suppose the following would enable us to
> >>>> use it:
> >>>
> >>> It won't. They're not the same hardware.
> >>
> >> What hardware is that then? And why wouldn't the kernel be able to
> >> support even if it is a different driver?
> >
> > So what exactly are the difference between 0x0268 and 0x0306? And why
> > sixpair.c save as 0x0268 while fakeinput.c uses 0x0306?
> >
> > Also, after fixing sixpair.c to be able to compile it does add to the
> > storage but it does not create any object until bluetoothd is
> > restarted and even after restart it does not allow the device to
> > connect because it does has the record (although this can be fixed by
> > automatically add the UUID once we find out it is attempt to connect).
> 
> So apparently the 0x0306 device is the br remote controller, not the
> sixaxis joystick, sorry about the confusion.

Completely different protocols for the devices, indeed.

> Anyway regardless of
> being a different device I thing we should move this code to kernel as
> it was done for wiimote.

Certainly, but until somebody writes the code (I already have at least 3
drivers to submit to the kernel that I've not had time to handle,
include one Bluetooth device), I think it would be nice not to drop
support for the existing hardware. The cost of David's patch is close to
none.

There's also a bunch of features that I'm not sure how you'd handle,
like forcing a disconnect timeout for the device (a patch which Johan
merged a couple of days ago).

Cheers

