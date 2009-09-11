Return-Path: <cyrus@holtmann.org>
Subject: Re: problem in btusb driver for linux-2.6.30
From: Marcel Holtmann <marcel@holtmann.org>
To: Oliver Neukum <oliver@neukum.org>
Cc: Kartikey Parmar <kartikey2781@gmail.com>,
	linux-bluetooth@vger.kernel.org, linux-usb@vger.kernel.org
In-Reply-To: <200909110832.16244.oliver@neukum.org>
References: <6887eb5d0909102327u2ca531d1q35d027839495a978@mail.gmail.com>
	 <200909110832.16244.oliver@neukum.org>
Content-Type: text/plain
Date: Fri, 11 Sep 2009 10:24:41 +0200
Message-Id: <1252657481.8931.53.camel@violet>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Oliver,

> > I have configured linux-2.6.30 for AT91SAM9263 with Bluetooth support
> > of RFCOMM, SCO, L2CAP and HCI USB driver for bluetooth usb dongle.
> 
> Did it work with 2.6.29?
> 
> > When I insert bluetooth dongle in usb port it calls btusb_probe twice,
> > and then I m receiving error like "No such device".
> >
> > I have checked with the debug log, it gives me an error "interface
> > numbers are hardcoded in the spec" and returns ENODEV.
> 
> Please post the log and "lsusb -v" for your device.

I actually prefer the part from /proc/bus/usb/devices since it makes it
way easier to see what interfaces are where.

Regards

Marcel


