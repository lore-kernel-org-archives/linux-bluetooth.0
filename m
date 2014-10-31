Return-Path: <cyrus@holtmann.org>
Date: Fri, 31 Oct 2014 16:51:11 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
To: Naveen Kumar Parna <pnaveenkos@gmail.com>
cc: Oliver Neukum <oneukum@suse.de>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	<linux-usb@vger.kernel.org>, <acho@suse.com>
Subject: Re: btusb_intr_complete returns -EPIPE
In-Reply-To: <CAG0bkvL-qy+Wvp7q39TOaQ1dZDd0PKyoXHjO=5TrJvdC8byr8A@mail.gmail.com>
Message-ID: <Pine.LNX.4.44L0.1410311637550.1833-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Wed, 29 Oct 2014, Naveen Kumar Parna wrote:

> Split packet transactions are hidden. I could see them by clicking on
> the (Show/Hide Split transactions) button. For INT IN, I could see
> only Start Split packet.
> 
> I attached([2014-10-28 session 144012] Trace0003.rar) complete log for
> this scenario.

How come the log doesn't contain any SOF packets?

> SSPLIT IN transaction      114         1
> HS           No data                884.562 264 267
> 
> SSPLIT IN transaction      115         1
> HS           No data                884.562 265 217
> 
> SSPLIT IN transaction      116         1
> HS           No data                884.562 285 417
> 
> SSPLIT IN transaction      117         1
> HS           No data                884.562 286 467

I see what you mean -- the log doesn't contain any CSPLIT transactions 
for the interrupt endpoints.  Only SSPLIT.

I'll need to see the scheduling information for these endpoints.  
You'll have to run a 3.13 or later kernel; then the important files 
will be under /sys/kernel/debug/usb/ehci/X/, where X is the PCI address 
of the EHCI controller you are using.

Copy the files in that directory while the test is running.

Alan Stern

