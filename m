Return-Path: <cyrus@holtmann.org>
Message-ID: <1444142377.8361.438.camel@linux.intel.com>
Subject: Re: [PATCH v2] Revert "serial: 8250_dma: don't bother DMA with
 small transfers"
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Greg KH <gregkh@linuxfoundation.org>, Frederic Danis
	 <frederic.danis@linux.intel.com>
Cc: linux-serial@vger.kernel.org, peter@hurleysoftware.com,
	linux-bluetooth@vger.kernel.org, heikki.krogerus@linux.intel.com,
	marcel@holtmann.org
Date: Tue, 06 Oct 2015 17:39:37 +0300
In-Reply-To: <20151006135503.GA13250@kroah.com>
References: 
	<1444136920-17969-1-git-send-email-frederic.danis@linux.intel.com>
	 <20151006135503.GA13250@kroah.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>

On Tue, 2015-10-06 at 14:55 +0100, Greg KH wrote:
> On Tue, Oct 06, 2015 at 03:08:40PM +0200, Frederic Danis wrote:
> > This reverts commit 9119fba0cfeda6d415c9f068df66838a104b87cb.
> > 
> > This commit prevents from sending "big" file using Bluetooth.
> > When sending a lot of data quickly through the Bluetooth interface, 
> > and
> > after a variable amount of data sent, transfer fails with error:
> >     kernel: [  415.247453] Bluetooth: hci0 hardware error 0x00
> > 
> > Found on T100TA.
> > 
> > After reverting this commit, send works fine for any file size.
> > 
> > Signed-off-by: Frederic Danis <frederic.danis@linux.intel.com>
> > ---
> > v2: Re-send to correct people
> > 
> >  drivers/tty/serial/8250/8250_dma.c | 4 ----
> >  1 file changed, 4 deletions(-)
> 
> Andy, any objections?

No.

P.S. Unfortunately it's not easy to reproduce on our side, so I trust
Frederic on this.

> 
> Frederic, don't you want to see this backported to 4.0 and newer?
> 
> thanks,
> 
> greg k-h

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
