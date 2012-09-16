Return-Path: <cyrus@holtmann.org>
Message-ID: <1347829936.6762.16.camel@obelisk.thedillows.org>
Subject: Re: [KERNEL PATCH] HID: Add support for Sony BD Remote
From: David Dillow <dave@thedillows.org>
To: David Herrmann <dh.herrmann@googlemail.com>
Cc: linux-bluetooth@vger.kernel.org,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Bastien Nocera <hadess@hadess.net>,
	Antonio Ospite <ospite@studenti.unina.it>
Date: Sun, 16 Sep 2012 17:12:16 -0400
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
> > Is there a reason for this weird order? I guess it's copied unchanged
> > from userspace? (Or maybe I am just not getting the semantic order
> > here) But I think most entries can be changed to be ascending indexes.
> > Makes adding new ones much easier.
> 
> It's copied directly from userspace; looking at the functions
> implemented, I suspect it is somewhat ordered by keys on the physical
> remote. I don't think it's very likely that we'll be adding new entries,
> but sure, I can sort it numerically.

Actually, looking again at a picture of the PS3 BD remote, I think I'd
rather leave the ordering as-is -- it makes testing the mapping easier,
since it is currently ordered by general proximity. I'll add a comment
to this effect.


