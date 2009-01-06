Return-Path: <cyrus@holtmann.org>
Date: Tue, 6 Jan 2009 10:17:20 -0800
From: Khem Raj <raj.khem@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [patch] hid2hci check usb_init return value
Message-ID: <20090106181720.GA12186@gmail.com>
References: <20081225231444.GA23751@gmail.com> <1230552751.15666.17.camel@californication> <20081230062656.GA31902@gmail.com> <1231210468.13304.20.camel@californication>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1231210468.13304.20.camel@californication>
List-ID: <linux-bluetooth.vger.kernel.org>

On (06/01/09 03:54), Marcel Holtmann wrote:
> Hi Khem,
> 
> > > > Working on a system which did not have a USB in it. I was getting a
> > > > segfault with hid2hci. The problem tracked down was usb_init () was 
> > > > failing and we did not check for it and carried on with execution. 
> > > > As a result the next call to libusb failed because we passed in NULL for
> > > > ctx because during usb_init () this should have been malloc'ed if all
> > > > have gone correctly but in case of error usb_init () free's up the
> > > > allocated memory and hence the segfault. 
> > > > 
> > > > We should check for return value of usb_init () call and exit
> > > > immediately if it fails. Tested on 4.24 release. 
> > > 
> > > the problem is that usb_init() doesn't return any errors on the versions
> > > that I have here:
> > > 
> > > ii  libusb-0.1-4   2:0.1.12-12    userspace USB programming library
> > > ii  libusb-dev     2:0.1.12-12    userspace USB programming library
> > > 
> > > Applying your patch would break complication on multiple platforms.
> > What you have is libusb-0.1 which has older API I suppose. There is 
> > libusb-compat which can be used as a wrapper over libusb1 to give
> > libusb0 like interfaces. 
> > 
> > Actually I was using libusb-1.0.0 API as mentioned here
> > http://libusb.sourceforge.net/api-1.0/group__lib.html
> > that also means that the patch I attached should have been using
> > libusb_init() instead. 
> > 
> > Here is updated patch
> 
> this still breaks with a system that has libusb-0.1 installed like the
> current Ubuntu 8.10 does. So either we switch to libusb-1.0 completely
> or we leave it as it is.

Moving forward depending on libusb-1.0 seems a better idea to me. 

Thanks

-Khem
