Return-Path: <wim.delvaux@adaptiveplanet.com>
From: wim delvaux <wim.delvaux@adaptiveplanet.com>
To: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [Bluez-devel] 2.6.5 problems turned to 2.6.3 but also problems
Date: Mon, 12 Apr 2004 16:21:55 +0200
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
References: <200404120349.34338.wim.delvaux@adaptiveplanet.com> <200404121317.52361.wim.delvaux@adaptiveplanet.com> <1081776828.5398.109.camel@pegasus>
In-Reply-To: <1081776828.5398.109.camel@pegasus>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200404121621.56191.wim.delvaux@adaptiveplanet.com>
List-ID: <bluez-devel.lists.sourceforge.net>

On Monday 12 April 2004 15:33, Marcel Holtmann wrote:
> Hi Wim,
>
> > I have tried with that version. (Applied the 2.6.5-mh3 patch)
> > However then I get these 'bad atomic' errors
>
> where do you get them? In the hci_usb driver or in the USB subsystem?

	it scrolls by so fast that It is hardly visible on the console.
	However I can detect that the call stack is only 3 entries deep

>
> > I just retried with the 2.6.3 kernel and saw
> >
> > 'device not accepting address' messages error -110
> > And then
>
> Know problem. Some broken device which needs a longer timeout value.

	The device at hand is the Acer BT500 BT Dongle  Where can I set that
	timeout ?

>
> Bug in the hci_usb driver. Disable CONFIG_BT_HCIUSB_SCO.

	OK

	CU
	W
