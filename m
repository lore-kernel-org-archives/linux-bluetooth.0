Return-Path: <cyrus@holtmann.org>
Subject: Re: [patch] hid2hci check usb_init return value
From: Marcel Holtmann <marcel@holtmann.org>
To: Khem Raj <raj.khem@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <20090106181720.GA12186@gmail.com>
References: <20081225231444.GA23751@gmail.com>
	 <1230552751.15666.17.camel@californication>
	 <20081230062656.GA31902@gmail.com>
	 <1231210468.13304.20.camel@californication>
	 <20090106181720.GA12186@gmail.com>
Content-Type: text/plain
Date: Tue, 06 Jan 2009 19:21:04 +0100
Message-Id: <1231266064.14901.0.camel@californication>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Khem,

> > > > > Working on a system which did not have a USB in it. I was getting a
> > > > > segfault with hid2hci. The problem tracked down was usb_init () was 
> > > > > failing and we did not check for it and carried on with execution. 
> > > > > As a result the next call to libusb failed because we passed in NULL for
> > > > > ctx because during usb_init () this should have been malloc'ed if all
> > > > > have gone correctly but in case of error usb_init () free's up the
> > > > > allocated memory and hence the segfault. 
> > > > > 
> > > > > We should check for return value of usb_init () call and exit
> > > > > immediately if it fails. Tested on 4.24 release. 
> > > > 
> > > > the problem is that usb_init() doesn't return any errors on the versions
> > > > that I have here:
> > > > 
> > > > ii  libusb-0.1-4   2:0.1.12-12    userspace USB programming library
> > > > ii  libusb-dev     2:0.1.12-12    userspace USB programming library
> > > > 
> > > > Applying your patch would break complication on multiple platforms.
> > > What you have is libusb-0.1 which has older API I suppose. There is 
> > > libusb-compat which can be used as a wrapper over libusb1 to give
> > > libusb0 like interfaces. 
> > > 
> > > Actually I was using libusb-1.0.0 API as mentioned here
> > > http://libusb.sourceforge.net/api-1.0/group__lib.html
> > > that also means that the patch I attached should have been using
> > > libusb_init() instead. 
> > > 
> > > Here is updated patch
> > 
> > this still breaks with a system that has libusb-0.1 installed like the
> > current Ubuntu 8.10 does. So either we switch to libusb-1.0 completely
> > or we leave it as it is.
> 
> Moving forward depending on libusb-1.0 seems a better idea to me. 

feel free to submit patches for all utilities with USB support. Then we
can talk about switching.

Regards

Marcel


