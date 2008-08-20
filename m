Return-Path: <cyrus@holtmann.org>
Date: Wed, 20 Aug 2008 09:50:53 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
To: Dave Higton <DAVE.HIGTON@nice.com>
cc: Marcel Holtmann <marcel@holtmann.org>,
	Oliver Neukum <oliver@neukum.org>,
	<linux-bluetooth@vger.kernel.org>, <linux-usb@vger.kernel.org>
Subject: RE: [rfc]btusb with SCO support
In-Reply-To: <B710AFF518DE29459D5752E7B15256D7D08101@souexc02.eu.nice.com>
Message-ID: <Pine.LNX.4.44L0.0808200942280.2463-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Wed, 20 Aug 2008, Dave Higton wrote:

> > Since these are isoc URBs anyway, shouldn't you simply drop them until
> > the new altsetting is ready?  That's a lot easier than trying to keep
> > track of them and deferring them (which doesn't make much sense for
> > Isochronous data).
> 
> If they were scheduled before an altsetting change, they must be plain
> wrong for the new altsetting - and indeed the new altsetting could be
> 0, in which case they wouldn't be sent anyway.  So it seems to me that
> they should be dropped.

That's not a good description of the situation.  The URBs were
scheduled _after_ an altsetting change was requested but _before_ the
change took place.  Therefore the URBs are designed for the new
altsetting and so are wrong for the altsetting in effect at the time of
submission.  (Indeed, the old altsetting might be 0, in which case
submission would fail anyway.)  So they should be dropped.

> The only difference it makes, from the POV of the outside world, is an
> ever so slight change in the time the stream is switched off.

No.  Since the submission or transmission of those URBs would have 
failed anyway (if they were submitted before the altsetting change 
occurred), they wouldn't get delivered in either case.  The length of 
time the stream is off is the time required to switch altsettings -- 
and that simply is unavoidable.

The other possibility suggested was to delay submitting the URBs until
after the new altsetting was in place.  That is a bad idea because it
means delaying the delivery of isoc data, which makes no sense -- the
whole idea of an isochronous stream is that the information should be
delivered as quickly as possible and it doesn't much matter if some of
it gets lost.

Alan Stern

