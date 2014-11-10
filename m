Return-Path: <cyrus@holtmann.org>
Date: Mon, 10 Nov 2014 11:56:12 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
To: Naveen Kumar Parna <pnaveenkos@gmail.com>
cc: Oliver Neukum <oneukum@suse.de>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	<linux-usb@vger.kernel.org>, <acho@suse.com>
Subject: Re: btusb_intr_complete returns -EPIPE
In-Reply-To: <CAG0bkvJCTS7s=GOV2aQ44ENCmpJWvi7yHCgtd5_o-EM7D=9kdQ@mail.gmail.com>
Message-ID: <Pine.LNX.4.44L0.1411101145350.5793-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Mon, 10 Nov 2014, Naveen Kumar Parna wrote:

> I am sorry for the late response.
> 
> I applied the patch and here is the dmesg log:
> 
> [  713.125709] ehci-pci 0000:00:1a.0: split intr info2 42821c01 token
> 80108d46 overlay token 80108d46
> [  713.125796] ehci-pci 0000:00:1a.0: split intr info2 42821c01 token
> 80108d46 overlay token 80108d46
> [  713.125853] hci4 urb ffff8800b89a7c00 status -32 count 0
> [  713.125857] hci3 urb ffff8800b7399c00 status -32 count 0

> Does it gives the reason for -32 status code?

More or less.  The last (status) byte in the "token" values is 0x46,
and the 0x04 status bit is documented in the EHCI spec as follows:

	Missed Micro-Frame. This bit is ignored unless the QH.EPS field 
	indicates a full- or low-speed endpoint and the queue head is 
	in the periodic list. This bit is set when the host controller 
	detected that a host-induced hold-off caused the host 
	controller to miss a required complete-split transaction. If the 
	host controller sets this bit to a one, then it remains a one 
	for the duration of thetransfer.

This means the host controller is telling you it was unable to carry 
out the CSPLIT part of the transaction, which means it really is a 
hardware problem (and not a bad memory chip).  Either the controller 
isn't working right or else your system is somehow overloaded.

The 0x42 bits indicate that the Queue Head was halted and a CSPLIT is
pending (which we already knew).  The "halted" status bit is the reason
why you got a -32 status code.

Alan Stern

