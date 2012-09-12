Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CABBYNZLwXhF0gixPGKUTJY4sZ7EHynTYmHzGtiZsoRGXgeEFaw@mail.gmail.com>
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
Date: Wed, 12 Sep 2012 22:26:04 +0200
Message-ID: <CANq1E4SDXVHcumBbEA-4xpeuOQ0SjDxxtL_RqAiNYRPj6ccagQ@mail.gmail.com>
Subject: Re: [PATCH] Add support for Logitech Harmony Adapter for PS3
From: David Herrmann <dh.herrmann@googlemail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Bastien Nocera <hadess@hadess.net>,
	David Dillow <dave@thedillows.org>,
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi all

On Wed, Sep 12, 2012 at 4:32 PM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> Hi Bastien
>
> Getting the device does not seems to be a problem and we have a
> similar driver already in the kernel, so Im really optimistic that it
> will not take long to have this implemented in the kernel.

Please, just redirect me to the information of the device protocols.
It is pretty simple to make the kernel drivers work with these kinds
of HID devices. There is no need to look at the wiimote driver as this
one is pretty complex and does something totally different than normal
HID drivers.

I am willing to write the kernel drivers, but I need a short
introduction or some pointers on how these devices work. I cannot
afford buying these (yeah, not even 30$...) so I also need people
willing to test these. This should be pretty easy, though.

Also Jiri Kosina (the HID maintainer) is willing to accept any weird
quirks we need for these devices. But please stop using fakehid. The
idea is wrong and hidraw should be used to write userspace HID
drivers. (uhid is only for transport side! So cannot be used here).
The kernel HID community is also very active and helps a lot on
maintaining the drivers.

So if the devices only need some short setup-command during
initialization and then they send HID reports whenever a button is
pressed, then everything should be very easy to get working. Even
auto-reconnect and 10min idle-disconnect are _very_ easy to get
working in the kernel with the current HID infrastructure.

Thanks!
David
