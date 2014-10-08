Return-Path: <cyrus@holtmann.org>
Date: Wed, 8 Oct 2014 10:46:32 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
To: Oliver Neukum <oneukum@suse.de>
cc: Naveen Kumar Parna <pnaveenkos@gmail.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	<linux-usb@vger.kernel.org>, <acho@suse.com>
Subject: Re: btusb_intr_complete returns -EPIPE
In-Reply-To: <1412774247.1629.4.camel@linux-0dmf.site>
Message-ID: <Pine.LNX.4.44L0.1410081045250.1633-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Wed, 8 Oct 2014, Oliver Neukum wrote:

> On Wed, 2014-10-08 at 18:31 +0530, Naveen Kumar Parna wrote:
> > Later connected third device(hci2) and after 2mins observed –EPIPE for
> > hci2(hci2 urb ffff880124f11cc0 status -32 count 0)
> 
> This points to a problem in the USB HC driver.
> Can you enable debugging in that driver.

It could also be a bug in the hub that the BT devices are plugged into.  
I have seen a report of a hub that sends STALL when a bunch of devices 
are plugged in, even though the devices themselves did not send a 
STALL.

Alan Stern

