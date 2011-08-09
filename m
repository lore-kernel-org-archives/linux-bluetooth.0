Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH] [RFC] BTUSB: be quiet on device disconnect
From: Paul Bolle <pebolle@tiscali.nl>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Marcel Holtmann <marcel@holtmann.org>, "Gustavo F. Padovan"
	 <padovan@profusion.mobi>, Greg Kroah-Hartman <gregkh@suse.de>,
	linux-bluetooth@vger.kernel.org, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Date: Tue, 09 Aug 2011 22:26:08 +0200
In-Reply-To: <Pine.LNX.4.44L0.1108091159050.1949-100000@iolanthe.rowland.org>
References: <Pine.LNX.4.44L0.1108091159050.1949-100000@iolanthe.rowland.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <1312921583.30382.12.camel@t41.thuisdomein>
Mime-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>

On Tue, 2011-08-09 at 12:00 -0400, Alan Stern wrote:
> On Tue, 9 Aug 2011, Paul Bolle wrote:
> > 1) I added Greg and linux-usb@vger.kernel.org because usb_submit_urb()
> > doesn't specify the meaning of its negative return values. I traced
> 
> In fact, many of these values are documented in 
> Documentation/usb/error-codes.txt.

0) Thanks. I hadn't found that, obviously.

1) Would it make sense to add links to that file in the documentation
for usb_submit_urb() and other core usb functions? (Does the kernel-doc
syntax have a notation for links?) I only do hit-and-run patches in the
usb subsystem, and any other subsystem, for that matter, so I'm not sure
that what I like to see is what's actually needed.


Paul Bolle
