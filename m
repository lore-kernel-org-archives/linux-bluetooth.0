Return-Path: <cyrus@holtmann.org>
Message-ID: <1395333736.22077.32.camel@acox1-desk.ger.corp.intel.com>
Subject: Re: hci_ldsic nested locking problem
From: Alan Cox <alan@linux.intel.com>
To: balbi@ti.com
Cc: Marcel Holtmann <marcel@holtmann.org>,
	Greg KH <gregkh@linuxfoundation.org>,
	Muralidharan Karicheri <m-karicheri2@ti.com>,
	linux-bluetooth@vger.kernel.org, linux-serial@vger.kernel.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date: Thu, 20 Mar 2014 16:42:16 +0000
In-Reply-To: <20140320163435.GH32692@saruman.home>
References: <20140320163435.GH32692@saruman.home>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Thu, 2014-03-20 at 11:34 -0500, Felipe Balbi wrote:
> Hi,
> 
> when 8250 driver calls uart_write_wakeup(), the tty port lock is already
> taken. hci_ldisc.c's implementation of ->write_wakeup() calls
> tty->ops->write() to actually send the characters, but that call will
> try to acquire the same port lock again.
> 
> Looking at other line disciplines that looks like a bug in hci_ldisc.c.
> Am I correct to assume that ->write_wakeup() is supposed to *just*
> wakeup the bottom half so we handle ->write() in another context ?
> 
> Is it legal to call tty->ops->write() from within ->write_wakeup() ?

It isn't because you might send all the bytes and go

	write
		write_wakeup
			write
				write wakeup
					...

and recurse

Alan


