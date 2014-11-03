Return-Path: <cyrus@holtmann.org>
Date: Mon, 3 Nov 2014 11:19:40 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
To: Naveen Kumar Parna <pnaveenkos@gmail.com>
cc: Oliver Neukum <oneukum@suse.de>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	<linux-usb@vger.kernel.org>, <acho@suse.com>
Subject: Re: btusb_intr_complete returns -EPIPE
In-Reply-To: <CAG0bkv+YY90Tq1aTw1Dbg-RSVadoP2U6tyVpW1bZSxBfQ=3Y4g@mail.gmail.com>
Message-ID: <Pine.LNX.4.44L0.1411031110260.1316-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Mon, 3 Nov 2014, Naveen Kumar Parna wrote:

> On Sat, Nov 1, 2014 at 2:21 AM, Alan Stern <stern@rowland.harvard.edu> wrote:
> > On Wed, 29 Oct 2014, Naveen Kumar Parna wrote:
> >
> >> Split packet transactions are hidden. I could see them by clicking on
> >> the (Show/Hide Split transactions) button. For INT IN, I could see
> >> only Start Split packet.
> >>
> >> I attached([2014-10-28 session 144012] Trace0003.rar) complete log for
> >> this scenario.
> >
> > How come the log doesn't contain any SOF packets?
> 
> 
> To avoid recording a huge quantity of data , I enabled the "Drop Start
> of Frames" filter in the recording options.

Can you do it again, but this time keep the SOF packets?

You don't have to post the entire analyzer log.  Just extract 3 or 4 ms
from the middle, where it shows the SSPLITS but no CSPLITS for the
interrupt endpoints, and post only that portion.

> > I see what you mean -- the log doesn't contain any CSPLIT transactions
> > for the interrupt endpoints.  Only SSPLIT.
> >
> > I'll need to see the scheduling information for these endpoints.
> > You'll have to run a 3.13 or later kernel; then the important files
> > will be under /sys/kernel/debug/usb/ehci/X/, where X is the PCI address
> > of the EHCI controller you are using.
> >
> > Copy the files in that directory while the test is running.
> >
> 
> 
> I attached all the files. Please let me know if I miss anything?

All the information in the files looks correct, as far as I can see.  I 
have no idea why the CSPLIT packets are missing.

Alan Stern

