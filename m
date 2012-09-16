Return-Path: <cyrus@holtmann.org>
Message-ID: <1347828966.6762.14.camel@obelisk.thedillows.org>
Subject: Re: [KERNEL PATCH] HID: Add support for Sony BD Remote
From: David Dillow <dave@thedillows.org>
To: David Herrmann <dh.herrmann@googlemail.com>
Cc: linux-bluetooth@vger.kernel.org,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Bastien Nocera <hadess@hadess.net>,
	Antonio Ospite <ospite@studenti.unina.it>
Date: Sun, 16 Sep 2012 16:56:06 -0400
In-Reply-To: <CANq1E4TptZt60phRu=yzGoeBF+v5vqoM=erkUPEj43v0f58xGQ@mail.gmail.com>
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
	 <CANq1E4TptZt60phRu=yzGoeBF+v5vqoM=erkUPEj43v0f58xGQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Sun, 2012-09-16 at 21:35 +0200, David Herrmann wrote:
> Hi David
> 
> On Fri, Sep 14, 2012 at 5:04 AM, David Dillow <dave@thedillows.org> wrote:
> > We also gain support for the Logitech Harmony Adapter for PS3.
> 
> Could you actually mention that this is based on the user-space BlueZ
> code here? I know your comment below includes it but I think the
> commit message could actually include some links/information on why we
> do this.

Will do.

> > +config HID_PS3REMOTE
> > +       tristate "Sony PS3 Bluetooth BD Remote"
> > +       depends on BT_HIDP
> > +       ---help---
> > +       Support for Sony PS3 Bluetooth BD Remote and Logitech Harmony Adapter
> > +       for PS3.
> > +
> 
> Maybe we can add a link to HID_SONY that the USB PS3 remotes are
> implemented there. And similar HID_SONY could include a link to
> HID_PS3REMOTE that it implements the BT PS3 drivers.

It's not so much PS3 remotes as PS3 controllers/gamepads that are
implemented there. If it makes sense to add the pointer to the help
text, I'm fine with it, but I'd want someone with knowledge of the HW
that HID_SONY supports to vet my text.

> Is there a reason for this weird order? I guess it's copied unchanged
> from userspace? (Or maybe I am just not getting the semantic order
> here) But I think most entries can be changed to be ascending indexes.
> Makes adding new ones much easier.

It's copied directly from userspace; looking at the functions
implemented, I suspect it is somewhat ordered by keys on the physical
remote. I don't think it's very likely that we'll be adding new entries,
but sure, I can sort it numerically.

> Looks all good to me.
> Regarding the lost keypresses during connection establishment: All HID
> drivers loose them. Any input data is actually lost as long as no
> driver is fully loaded. It's actually not that easy to change that
> (feel free to have a look at hid-core.c) but I also don't understand
> why you actually care about them so much? There is driver rebinding,
> delayed driver loading and similar. So even if you fix it, it can
> happen that your driver is loaded after a lot of communication has
> already been done.
> Could you explain why you actually need these?

If it were only the first time after the driver is loaded, that's one
thing, but it seems like it's loosing the first button press on each
connection (ie, after an idle period of about 10 minutes.) The idle
periods are important for the battery life of the remote, but it's
really annoying to have to hit pause, wait a second, then hit pause
again when you are watching a TV show or movie...

I'll double check that this behavior was on each re-connection and not
just the first time we load the module. I suspect it was each
connection, though.

> The hidp_connadd_req.idle_to can be used for the automatic timeout.
> It's Bluetooth only so USB devices won't even notice it.

Ok, and this is controlled by bluetoothd when adding the device,
correct? In any event, it seems that it's my Harmony adapter that is
initiating the disconnect, so this may be a bit moot.

> Furthermore, please CC linux-input@vger.kernel.org and jkosina@suse.cz
> (HID maintainer) in the next patches. The patch will go through Jiri's
> tree.

Sure, can do. I may wait a bit longer for Antonio to test it out with
the real remote rather than the Harmony I have.

Thanks for the review,
Dave

