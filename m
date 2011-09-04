Return-Path: <cyrus@holtmann.org>
Subject: Re: Is bluetooth supported on lastest mac-mini?
From: Jurgen Kramer <gtmkramer@xs4all.nl>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: John Frankish <j-frankish@slb.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Date: Sun, 04 Sep 2011 20:24:51 +0200
In-Reply-To: <CABBYNZJ_qVo1npo2XhjA4C3d2ss66CS-hKPtsFXC0M=_Er0sww@mail.gmail.com>
References: <654DF80AD31A344E93DBCC6280BD6DEF222465B6@NL0230MBX08N1.DIR.slb.com>
	 <CABBYNZLTJQkm0jv6NpmyoFV8sPUeLbrb+8DAUEBPB2J5yGfEsA@mail.gmail.com>
	 <654DF80AD31A344E93DBCC6280BD6DEF22247990@NL0230MBX08N1.DIR.slb.com>
	 <CABBYNZJ_qVo1npo2XhjA4C3d2ss66CS-hKPtsFXC0M=_Er0sww@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <1315160697.2441.9.camel@paragon.slim>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Sun, 2011-09-04 at 21:12 +0300, Luiz Augusto von Dentz wrote:
> Hi John,
> >>
> >> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c index
> >> 91d13a9..16abfd1 100644
> >> --- a/drivers/bluetooth/btusb.c
> >> +++ b/drivers/bluetooth/btusb.c
> >> @@ -75,6 +75,9 @@ static struct usb_device_id btusb_table[] = {
> >>         /* Apple MacBookPro8,2 */
> >>         { USB_DEVICE(0x05ac, 0x821a) },
> >>
> >> +       /* Apple Mac Mini */
> >> +       { USB_DEVICE(0x05ac, 0x4500) },
> >> +
> >>         /* AVM BlueFRITZ! USB v2.0 */
> >>         { USB_DEVICE(0x057c, 0x3800) },
> >>
> >>
> > Thanks, I recompiled the 3.0.3 kernel with the patch, but my machine crashed as soon as the driver tried to load..
> 
> Maybe it needs more changes, iirc this new mac minis have BT 4.0
> controllers... Can you get any logs where it is crashing?
> 
> 
Hi,

I've sent the needed patch to the list a couple of hours ago.

Jurgen

