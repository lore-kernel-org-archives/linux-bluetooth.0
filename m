Return-Path: <cyrus@holtmann.org>
Date: Thu, 13 Sep 2012 00:36:28 +0200
From: Antonio Ospite <ospite@studenti.unina.it>
To: David Herrmann <dh.herrmann@googlemail.com>
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Bastien Nocera <hadess@hadess.net>,
	David Dillow <dave@thedillows.org>,
	linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Add support for Logitech Harmony Adapter for PS3
Message-Id: <20120913003628.ce5babb2a66d09fe17fa15de@studenti.unina.it>
In-Reply-To: <CANq1E4SDXVHcumBbEA-4xpeuOQ0SjDxxtL_RqAiNYRPj6ccagQ@mail.gmail.com>
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
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Wed, 12 Sep 2012 22:26:04 +0200
David Herrmann <dh.herrmann@googlemail.com> wrote:

> Hi all
> 
> On Wed, Sep 12, 2012 at 4:32 PM, Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
> > Hi Bastien
> >
> > Getting the device does not seems to be a problem and we have a
> > similar driver already in the kernel, so Im really optimistic that it
> > will not take long to have this implemented in the kernel.
> 
> Please, just redirect me to the information of the device protocols.
> It is pretty simple to make the kernel drivers work with these kinds
> of HID devices. There is no need to look at the wiimote driver as this
> one is pretty complex and does something totally different than normal
> HID drivers.
> 
> I am willing to write the kernel drivers, but I need a short
> introduction or some pointers on how these devices work. I cannot
> afford buying these (yeah, not even 30$...) so I also need people
> willing to test these. This should be pretty easy, though.
> 
> Also Jiri Kosina (the HID maintainer) is willing to accept any weird
> quirks we need for these devices. But please stop using fakehid. The
> idea is wrong and hidraw should be used to write userspace HID
> drivers. (uhid is only for transport side! So cannot be used here).
> The kernel HID community is also very active and helps a lot on
> maintaining the drivers.
> 
> So if the devices only need some short setup-command during
> initialization and then they send HID reports whenever a button is
> pressed, then everything should be very easy to get working. Even
> auto-reconnect and 10min idle-disconnect are _very_ easy to get
> working in the kernel with the current HID infrastructure.
> 

I too will take a look during the week-end about writing a kernel
driver, if it's not that much of an effort I might take the project
(no promises yet). I have a PS3 BD remote Bastien donated.

David AFAICS from profiles/input/fakehid.c[1], a custom report has to be
decoded and appropriate input events have to be sent.

Regards,
   Antonio

[1]
http://git.kernel.org/?p=bluetooth/bluez.git;a=blob;f=profiles/input/fakehid.c;h=05f5894c7bd537d78a010b3905af9f98c0364002;hb=96f60e1411514fb4b0d8690aca1c02b3c6b32b9c

-- 
Antonio Ospite
http://ao2.it

A: Because it messes up the order in which people normally read text.
   See http://en.wikipedia.org/wiki/Posting_style
Q: Why is top-posting such a bad thing?
