Return-Path: <cyrus@holtmann.org>
Message-ID: <1347849502.6762.30.camel@obelisk.thedillows.org>
Subject: Re: [KERNEL PATCH] HID: Add support for Sony BD Remote
From: David Dillow <dave@thedillows.org>
To: David Herrmann <dh.herrmann@googlemail.com>
Cc: linux-bluetooth@vger.kernel.org,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Bastien Nocera <hadess@hadess.net>,
	Antonio Ospite <ospite@studenti.unina.it>
Date: Sun, 16 Sep 2012 22:38:22 -0400
In-Reply-To: <1347828966.6762.14.camel@obelisk.thedillows.org>
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
	 <1347828966.6762.14.camel@obelisk.thedillows.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Sun, 2012-09-16 at 16:56 -0400, David Dillow wrote:
> On Sun, 2012-09-16 at 21:35 +0200, David Herrmann wrote:
> > Regarding the lost keypresses during connection establishment: All HID
> > drivers loose them. Any input data is actually lost as long as no
> > driver is fully loaded. It's actually not that easy to change that
> > (feel free to have a look at hid-core.c) but I also don't understand
> > why you actually care about them so much? There is driver rebinding,
> > delayed driver loading and similar. So even if you fix it, it can
> > happen that your driver is loaded after a lot of communication has
> > already been done.
> > Could you explain why you actually need these?
> 
> If it were only the first time after the driver is loaded, that's one
> thing, but it seems like it's loosing the first button press on each
> connection (ie, after an idle period of about 10 minutes.) The idle
> periods are important for the battery life of the remote, but it's
> really annoying to have to hit pause, wait a second, then hit pause
> again when you are watching a TV show or movie...
> 
> I'll double check that this behavior was on each re-connection and not
> just the first time we load the module. I suspect it was each
> connection, though.

Adding some debug statements shows me that this is unlikely to be a
bluetooth or HID issue -- I get the reports just fine. I suspect it is a
timing issue, such that the event gets delivered to the input system
before udev processing has finished informing X or eventlircd etc that a
new device has appeared and they open /dev/input/eventX.

Unfortunately, there doesn't seem to be a way to say "queue the first
few events for a short while" when creating the input device, nor am I
convinced that would be a good fix -- so much would need to change to
use it, and I suspect it is the wrong interface.

It seems like a bit of a hackish solution, but one could avoid the
problem by having the hidp core keep (some) session information alive
after a disconnect -- if requested by user space -- and reuse the HID
devices if the BT device re-connects before the cached information
expires. This would limit the race to once during the closed session
expiration timeout, which I think would be acceptable -- users could
configure the timeout to be weeks for their home entertainment centers.
Would this approach be worth exploring to see if I can find a clean
implementation?

