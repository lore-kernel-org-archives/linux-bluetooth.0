Return-Path: <cyrus@holtmann.org>
Date: Sat, 2 Aug 2008 19:47:50 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
To: Marcel Holtmann <marcel@holtmann.org>
cc: Oliver Neukum <oliver@neukum.org>,  <linux-bluetooth@vger.kernel.org>,
     <linux-usb@vger.kernel.org>
Subject: Re: [rfc]btusb with SCO support
In-Reply-To: <1217612547.7819.3.camel@californication>
Message-ID: <Pine.LNX.4.44L0.0808021946340.18555-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-ID: <linux-bluetooth.vger.kernel.org>

On Fri, 1 Aug 2008, Marcel Holtmann wrote:

> Question is if selecting the 2nd alternate setting and not submitting
> the URBs for it is a good idea or if that will still consume bandwidth
> and power. And thus it would be better to use the first alternate
> setting that is meant for the case with no SCO connections.

Installing the second altsetting and not submitting URBs will not
consume bandwidth.  It may consume a little power, but probably not
much more than just using the first altsetting.

Alan Stern
