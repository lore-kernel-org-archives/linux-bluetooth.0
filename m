Return-Path: <cyrus@holtmann.org>
Message-ID: <1347625044.6145.21.camel@obelisk.thedillows.org>
Subject: Re: [KERNEL PATCH] HID: Add support for Sony BD Remote
From: David Dillow <dave@thedillows.org>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	David Herrmann <dh.herrmann@googlemail.com>,
	Bastien Nocera <hadess@hadess.net>,
	Antonio Ospite <ospite@studenti.unina.it>
Date: Fri, 14 Sep 2012 08:17:24 -0400
In-Reply-To: <CABBYNZKD9ZEOoGfJF3Mf4-=CSYL8rev+HbL_X7KdV6oMe+0ibQ@mail.gmail.com>
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
	 <CABBYNZLwXhF0gixPGKUTJY4sZ7EHynTYmHzGtiZsoRGXgeEFaw@mail.gmail.com>
	 <CANq1E4SDXVHcumBbEA-4xpeuOQ0SjDxxtL_RqAiNYRPj6ccagQ@mail.gmail.com>
	 <20120913003628.ce5babb2a66d09fe17fa15de@studenti.unina.it>
	 <1347591892.6145.14.camel@obelisk.thedillows.org>
	 <CABBYNZKD9ZEOoGfJF3Mf4-=CSYL8rev+HbL_X7KdV6oMe+0ibQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Fri, 2012-09-14 at 13:42 +0300, Luiz Augusto von Dentz wrote:
> Hi David,
> 
> On Fri, Sep 14, 2012 at 6:04 AM, David Dillow <dave@thedillows.org> wrote:
> > Antonio, if you could test this with the real remote you have, I'd be
> > very appreciative.
> >
> > David, could you point me at the controls for the 10min idle-disconnect?
> 
> I suppose we can just continue using input.conf:IdleTimeout (which
> passed via ioctl in the struct hidp_connadd_req.idle_to) or do you
> think this would be useful for other transports, at least for USB it
> does not make much sense since the cable will stay connected.

I'm agreed that it doesn't make much sense for USB. I would like to find
a way to keep the adapter running -- it seems I don't get the first key
press that the adapter woke up for. This would need to be optional, as I
see this draining the batteries on the real remote, but my adapter is
hardwired and it'd be nice to avoid the initial delay/lost press.

Of course solving the initial press would be handy for everyone,
assuming it isn't a Harmony-only issue.

> > auto-connect and idle-disconnect seem to be working on my Fedora 16 box,
> > though it looks like the Harmony adapter is initiating the disconnect --
> > this is likely an area for improvement with the Sony remote.
> 
> Btw, it would probably be a good to add a proper defines for 0x0306
> e.g. USB_DEVICE_ID_SONY_PS3_REMOTE and
> USB_DEVICE_ID_LOGITECH_HARMONY_ADAPTER

Heh, I thought you might say that. I personally prefer the numbers ala
the current style for PCI(e) drivers -- and took the prior existence of
the numbers-only entries as permission -- but I'll defer to the wishes
of the subsystem.

Thanks,
Dave

