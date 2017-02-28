Return-Path: <greg@kroah.com>
Date: Tue, 28 Feb 2017 13:39:49 +0100
From: Greg KH <greg@kroah.com>
To: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: Marcel Holtmann <marcel@holtmann.org>,
	Gustavo Padovan <gustavo@padovan.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	linux-bluetooth@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: Decrease long resume time of Intel Bluetooth module
Message-ID: <20170228123949.GA32116@kroah.com>
References: <9dbb0c55-4aeb-633e-a4f8-ca3fa170e19b@molgen.mpg.de>
 <20170228110017.GA30523@kroah.com>
 <6fdd4378-fd7b-497f-6c1e-3681020bcd49@molgen.mpg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <6fdd4378-fd7b-497f-6c1e-3681020bcd49@molgen.mpg.de>
List-ID: <linux-bluetooth.vger.kernel.org>

On Tue, Feb 28, 2017 at 12:06:38PM +0100, Paul Menzel wrote:
> Dear Greg,
> 
> 
> On 02/28/17 12:00, Greg KH wrote:
> > On Tue, Feb 28, 2017 at 11:20:11AM +0100, Paul Menzel wrote:
> > > Is there a way to debug and optimize that – besides taking the device out –
> > > to get resume times on par with other devices like Google Chromebooks or
> > > Apple MacBooks?
> > 
> > A Chromebook is running the same Linux kernel as your desktop, so
> > perhaps you can see if it really is doing something different here or
> > not?
> 
> Sorry, for being ambiguous. I don’t know if there are Google Chromebooks
> using that USB device, and I wouldn’t have access to it.

Then perhaps the hardware itself just can't do this type of "quick"
suspend/resume?  Have you tried it in MacBook and measured it there?

> I just meant, that it would be great to get fast resume times.

I agree, but sometimes hardware just sucks :)

thanks,

greg k-h
