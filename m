Return-Path: <cyrus@holtmann.org>
Date: Tue, 19 Aug 2008 14:57:23 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
To: Marcel Holtmann <marcel@holtmann.org>
cc: Oliver Neukum <oliver@neukum.org>,  <linux-bluetooth@vger.kernel.org>,
     <linux-usb@vger.kernel.org>
Subject: Re: [rfc]btusb with SCO support
In-Reply-To: <1219169986.7591.169.camel@violet.holtmann.net>
Message-ID: <Pine.LNX.4.44L0.0808191453440.3391-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-ID: <linux-bluetooth.vger.kernel.org>

On Tue, 19 Aug 2008, Marcel Holtmann wrote:

> Our problem is only that we are using a workqueue and can't make any
> assumption when we get scheduled. This is obviously not perfect, but it
> seems there is nothing much that can be done.
> 
> I think the specification is simply bad and we have to live with it.

I guess so.

Since these are isoc URBs anyway, shouldn't you simply drop them until
the new altsetting is ready?  That's a lot easier than trying to keep
track of them and deferring them (which doesn't make much sense for
Isochronous data).

Alan Stern
