Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1347591892.6145.14.camel@obelisk.thedillows.org>
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
Date: Fri, 14 Sep 2012 13:42:48 +0300
Message-ID: <CABBYNZKD9ZEOoGfJF3Mf4-=CSYL8rev+HbL_X7KdV6oMe+0ibQ@mail.gmail.com>
Subject: Re: [KERNEL PATCH] HID: Add support for Sony BD Remote
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: David Dillow <dave@thedillows.org>
Cc: linux-bluetooth@vger.kernel.org,
	David Herrmann <dh.herrmann@googlemail.com>,
	Bastien Nocera <hadess@hadess.net>,
	Antonio Ospite <ospite@studenti.unina.it>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi David,

On Fri, Sep 14, 2012 at 6:04 AM, David Dillow <dave@thedillows.org> wrote:
> We also gain support for the Logitech Harmony Adapter for PS3.
>
> Signed-off-by: David Dillow <dave@thedillows.org>
> --
>  drivers/hid/Kconfig         |    7 +
>  drivers/hid/Makefile        |    1 +
>  drivers/hid/hid-core.c      |    2 +
>  drivers/hid/hid-ps3remote.c |  325 +++++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 335 insertions(+), 0 deletions(-)
>
> On Thu, 2012-09-13 at 00:36 +0200, Antonio Ospite wrote:
> On Wed, 12 Sep 2012 22:26:04 +0200 David Herrmann wrote:
>> > So if the devices only need some short setup-command during
>> > initialization and then they send HID reports whenever a button is
>> > pressed, then everything should be very easy to get working. Even
>> > auto-reconnect and 10min idle-disconnect are _very_ easy to get
>> > working in the kernel with the current HID infrastructure.
>>
>> I too will take a look during the week-end about writing a kernel
>> driver, if it's not that much of an effort I might take the project
>> (no promises yet). I have a PS3 BD remote Bastien donated.
>
> Here's a first pass at a kernel driver to support the BD remote and
> Harmony PS adapter. I've tested it on Fedora 16 with single keypresses
> only, as I cannot send multiple simultaneous keypresses with the
> Harmony. This patch is against kernel.org's bluetooth.git as of an hour
> ago, but should apply to other versions without much fuss.

Great that you are looking into it.

> Antonio, if you could test this with the real remote you have, I'd be
> very appreciative.
>
> David, could you point me at the controls for the 10min idle-disconnect?

I suppose we can just continue using input.conf:IdleTimeout (which
passed via ioctl in the struct hidp_connadd_req.idle_to) or do you
think this would be useful for other transports, at least for USB it
does not make much sense since the cable will stay connected.

> auto-connect and idle-disconnect seem to be working on my Fedora 16 box,
> though it looks like the Harmony adapter is initiating the disconnect --
> this is likely an area for improvement with the Sony remote.

Btw, it would probably be a good to add a proper defines for 0x0306
e.g. USB_DEVICE_ID_SONY_PS3_REMOTE and
USB_DEVICE_ID_LOGITECH_HARMONY_ADAPTER

-- 
Luiz Augusto von Dentz
