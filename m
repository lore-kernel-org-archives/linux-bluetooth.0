Return-Path: <cyrus@holtmann.org>
Date: Tue, 21 Apr 2015 11:06:40 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Peter Hurley <peter@hurleysoftware.com>
Cc: Frederic Danis <frederic.danis@linux.intel.com>,
	linux-serial@vger.kernel.org, linux-bluetooth@vger.kernel.org,
	jslaby@suse.cz
Subject: Re: [PATCH] tty: Re-add external interface for tty_set_termios()
Message-ID: <20150421090640.GB1569@kroah.com>
References: <1428671585-13310-1-git-send-email-frederic.danis@linux.intel.com>
 <5527CEFB.5070406@hurleysoftware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <5527CEFB.5070406@hurleysoftware.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Fri, Apr 10, 2015 at 09:24:11AM -0400, Peter Hurley wrote:
> On 04/10/2015 09:13 AM, Frederic Danis wrote:
> > This is needed by Bluetooth hci_uart module to be able to change speed
> > of Bluetooth controller and local UART.
> 
> Because this is the lesser evil right now,
> 
> Reviewed-by: Peter Hurley <peter@hurleysoftware.com>

Does this need to be in 4.1-rc1?  Or is this a 4.2 thing?

thanks,

greg k-h
