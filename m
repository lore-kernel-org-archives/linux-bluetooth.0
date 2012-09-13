Return-Path: <cyrus@holtmann.org>
Message-ID: <1347542812.2373.6.camel@obelisk.thedillows.org>
Subject: Re: [PATCH] Add support for Logitech Harmony Adapter for PS3
From: David Dillow <dave@thedillows.org>
To: Antonio Ospite <ospite@studenti.unina.it>
Cc: David Herrmann <dh.herrmann@googlemail.com>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Bastien Nocera <hadess@hadess.net>,
	linux-bluetooth@vger.kernel.org
Date: Thu, 13 Sep 2012 09:26:52 -0400
In-Reply-To: <20120913003628.ce5babb2a66d09fe17fa15de@studenti.unina.it>
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
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Thu, 2012-09-13 at 00:36 +0200, Antonio Ospite wrote:
> I too will take a look during the week-end about writing a kernel
> driver, if it's not that much of an effort I might take the project
> (no promises yet). I have a PS3 BD remote Bastien donated.
> 
> David AFAICS from profiles/input/fakehid.c[1], a custom report has to be
> decoded and appropriate input events have to be sent.

I spent some time last night, and have made some progress in
understanding the HID layer. I'm fixing up the report descriptor and
massaging the raw packets to match in an effort to use the common input
code. evtest isn't showing output yet, but I think I'm close.

I only have the Logitech adapter, which does not seem to need the
bitmask handling in fakehid.c -- could you
watch /sys/kernel/debug/hid/0005:*/events while pressing the buttons
that are listed in the ps3remote_bits list -- looks like back/circle,
cross, triangle (options), etc. I'm guessing those are needed for some
devices, but the Harmony adapter just sends the codes needed in
ps3remote_keymap, so it doesn't seem I need to care about the bitmap,
except I'm sure it was done for a reason...

Thanks,
Dave

