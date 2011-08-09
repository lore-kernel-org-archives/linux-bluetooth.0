Return-Path: <cyrus@holtmann.org>
Date: Tue, 9 Aug 2011 12:00:28 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
To: Paul Bolle <pebolle@tiscali.nl>
cc: Marcel Holtmann <marcel@holtmann.org>,
    "Gustavo F. Padovan" <padovan@profusion.mobi>,
    Greg Kroah-Hartman <gregkh@suse.de>,  <linux-bluetooth@vger.kernel.org>,
     <linux-usb@vger.kernel.org>,  <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] [RFC] BTUSB: be quiet on device disconnect
In-Reply-To: <1312902988.1853.24.camel@x61.thuisdomein>
Message-ID: <Pine.LNX.4.44L0.1108091159050.1949-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-ID: <linux-bluetooth.vger.kernel.org>

On Tue, 9 Aug 2011, Paul Bolle wrote:

> 1) I added Greg and linux-usb@vger.kernel.org because usb_submit_urb()
> doesn't specify the meaning of its negative return values. I traced

In fact, many of these values are documented in 
Documentation/usb/error-codes.txt.

> -EPERM to usb_hcd_link_urb_to_ep(). That returns -EPERM if the urb is
> "being killed". Did I trace the calls made by usb_submit_urb()
> correctly? I also just assumed that -ENODEV always means device got
> disconnected or something comparable. Is that correct too?

Yes, those are both correct.

Alan Stern
