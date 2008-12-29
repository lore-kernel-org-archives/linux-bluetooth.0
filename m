Return-Path: <cyrus@holtmann.org>
Subject: Re: [patch] hid2hci check usb_init return value
From: Marcel Holtmann <marcel@holtmann.org>
To: Khem Raj <raj.khem@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <20081225231444.GA23751@gmail.com>
References: <20081225231444.GA23751@gmail.com>
Content-Type: text/plain
Date: Mon, 29 Dec 2008 13:12:31 +0100
Message-Id: <1230552751.15666.17.camel@californication>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Khem,

> Working on a system which did not have a USB in it. I was getting a
> segfault with hid2hci. The problem tracked down was usb_init () was 
> failing and we did not check for it and carried on with execution. 
> As a result the next call to libusb failed because we passed in NULL for
> ctx because during usb_init () this should have been malloc'ed if all
> have gone correctly but in case of error usb_init () free's up the
> allocated memory and hence the segfault. 
> 
> We should check for return value of usb_init () call and exit
> immediately if it fails. Tested on 4.24 release. 

the problem is that usb_init() doesn't return any errors on the versions
that I have here:

ii  libusb-0.1-4   2:0.1.12-12    userspace USB programming library
ii  libusb-dev     2:0.1.12-12    userspace USB programming library

Applying your patch would break complication on multiple platforms.

Regards

Marcel


