Return-Path: <cyrus@holtmann.org>
Subject: Re: [patch] hid2hci check usb_init return value
From: Marcel Holtmann <marcel@holtmann.org>
To: David Sainty <david.sainty@dtsp.co.nz>
Cc: Khem Raj <raj.khem@gmail.com>, linux-bluetooth@vger.kernel.org
In-Reply-To: <4962C9D0.1030005@dtsp.co.nz>
References: <20081225231444.GA23751@gmail.com>
	 <1230552751.15666.17.camel@californication>
	 <20081230062656.GA31902@gmail.com>
	 <1231210468.13304.20.camel@californication>  <4962C9D0.1030005@dtsp.co.nz>
Content-Type: text/plain
Date: Tue, 06 Jan 2009 06:19:14 +0100
Message-Id: <1231219154.13304.23.camel@californication>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi David,

> >> What you have is libusb-0.1 which has older API I suppose. There is 
> >> libusb-compat which can be used as a wrapper over libusb1 to give
> >> libusb0 like interfaces. 
> >>
> >> Actually I was using libusb-1.0.0 API as mentioned here
> >> http://libusb.sourceforge.net/api-1.0/group__lib.html
> >> that also means that the patch I attached should have been using
> >> libusb_init() instead. 
> >>
> >> Here is updated patch
> >>     
> >
> > this still breaks with a system that has libusb-0.1 installed like the
> > current Ubuntu 8.10 does. So either we switch to libusb-1.0 completely
> > or we leave it as it is.
> >   
> 
> This looks like a job for autoconf?

it could be, but I am only doing either libusb-0.1 or libusb-1.0. We can
have support for both, but these compile time options are a bad thing
and I don't want them.

Regards

Marcel


