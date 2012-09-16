Return-Path: <cyrus@holtmann.org>
Date: Mon, 17 Sep 2012 00:03:21 +0200
From: Antonio Ospite <ospite@studenti.unina.it>
To: David Dillow <dave@thedillows.org>
Cc: David Herrmann <dh.herrmann@googlemail.com>,
	linux-bluetooth@vger.kernel.org,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Bastien Nocera <hadess@hadess.net>
Subject: Re: [KERNEL PATCH] HID: Add support for Sony BD Remote
Message-Id: <20120917000321.0d9295808a85c3c342aaf3ab@studenti.unina.it>
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
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Sun, 16 Sep 2012 16:56:06 -0400
David Dillow <dave@thedillows.org> wrote:

> On Sun, 2012-09-16 at 21:35 +0200, David Herrmann wrote:
[...]
> > Furthermore, please CC linux-input@vger.kernel.org and jkosina@suse.cz
> > (HID maintainer) in the next patches. The patch will go through Jiri's
> > tree.
> 
> Sure, can do. I may wait a bit longer for Antonio to test it out with
> the real remote rather than the Harmony I have.
> 

I did a quick test and the driver works with the original PS3 BD
remote too, with the latest BlueZ master branch.

I am now taking a look at the code, that will take some more time.

Thanks,
   Antonio

-- 
Antonio Ospite
http://ao2.it

A: Because it messes up the order in which people normally read text.
   See http://en.wikipedia.org/wiki/Posting_style
Q: Why is top-posting such a bad thing?
