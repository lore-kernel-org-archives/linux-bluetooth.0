Return-Path: <cyrus@holtmann.org>
Message-ID: <1347929527.29391.9.camel@obelisk.thedillows.org>
Subject: Re: [KERNEL PATCH] HID: Add support for Sony BD Remote
From: David Dillow <dave@thedillows.org>
To: Antonio Ospite <ospite@studenti.unina.it>
Cc: linux-bluetooth@vger.kernel.org,
	David Herrmann <dh.herrmann@googlemail.com>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Bastien Nocera <hadess@hadess.net>
Date: Mon, 17 Sep 2012 20:52:07 -0400
In-Reply-To: <20120917120441.a164d2e10bb02aa9a1e8d523@studenti.unina.it>
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
	 <20120917120441.a164d2e10bb02aa9a1e8d523@studenti.unina.it>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Mon, 2012-09-17 at 12:04 +0200, Antonio Ospite wrote:
> On Thu, 13 Sep 2012 23:04:52 -0400
> David Dillow <dave@thedillows.org> wrote:
> > Antonio, if you could test this with the real remote you have, I'd be
> > very appreciative.
> >
> 
> Works here as well with original PS3 BR remote, thanks David D.
> 
> About multiple key-presses, when I hold two _different_ keys at the same
> time, I get the message:
> 
> ps3_remote 0005:054C:0306.0004: Incoherent report, 000000 000000 ff 16
> 01
> 
> I just tried a couple of combinations tho.

I found a typo in the custom report descriptor which could cause this --
where it says REPORT COUNT (11), I have 0x95, 0x01 as values in the
array. Those should be 0x95, 0x0b instead. This would prevent it from
looking at any more than the first key reported. Could you fix that up
and retest?

Looking at this gave me an idea that would avoid needing a raw event
handler; I've got a version built and will test in a bit, once the kids
are down. I'll send it along after that.

If both fail, it would be useful to see the output
from /sys/kernel/debug/hid/0005:*:0306:*/event while you are pressing
both single and multiple buttons.

> What about adding a note about the association maneuver? I mean the one
> when we press Start+Enter for a few second when we add the BD remote as
> a new BT device. I forget about it every time I associate the BD
> remote with a new system; I know kernel code is not the most
> user-friendly spot for this documentation but having it here wouldn't
> hurt.
> 
> Now I noted it on the back of the battery cover too :)

Indeed; I don't have one of the real remotes -- could you provide text?


> > +static int ps3remote_event(struct hid_device *hdev, struct hid_report *report,
> > +			   u8 *raw_data, int size)
> > +{
> > +	struct ps3remote_data *data = hid_get_drvdata(hdev);
> > +	u32 mask, changed;
> > +	u8 key, pressed;
> 
> The preferred kernel style for declarations is to have one per line, no
> commas, but that's up to you.

I've seen it both ways, so I'll stick with the less vertical space. If
they were initialized here, I'd be more inclined to change.

> > +	if (size != 12) {
> > +		hid_dbg(hdev, "unsupported report size\n");
> > +		return 1;
> 
> The raw_event callback should return negative on error, is there a
> reason why 1 is returned here?

I was just eating the event rather than passing it on. It probably makes
more sense to return an error, but I didn't investigate how the rest of
the stack handled that.

I'll likely change this if I need to keep the raw event handler.

Thank you for the review, I've incorporated your other comments into the
driver before I started working on the simpler version.

Dave

