Return-Path: <cyrus@holtmann.org>
Subject: Re: Bluetooth honeypot - hci socket that reads package problem -
From: Marcel Holtmann <marcel@holtmann.org>
To: Vincenzo Ampolo <vincenzo.ampolo@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	Stefano Zanero <zanero@elet.polimi.it>
In-Reply-To: <200907201503.51944.vincenzo.ampolo@gmail.com>
References: <200907200938.35808.vincenzo.ampolo@gmail.com>
	 <1248075928.4549.91.camel@violet>
	 <200907201503.51944.vincenzo.ampolo@gmail.com>
Content-Type: text/plain
Date: Mon, 20 Jul 2009 15:09:32 +0200
Message-Id: <1248095372.4549.122.camel@violet>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Vincenzo,

> > You need to set the device into RAW mode. Otherwise the kernel will keep
> > processing the HCI packets.
> 
> Do you mean that i've to use a special device that supports RAW mode or that i 
> can open a socket in RAW mode?
> 
> if it's the latter,i'm googlin for a while and i don't find any useful 
> information. How should i call the socket C function to accomplish it?

you have to turn the Bluetooth HCI device into RAW mode. And also
hciconfig will tell you if the device is in that mode. Otherwise you
will have the kernel interfere and act as it is suppose to.

	dd = hci_open_dev(dev_id);
	ioctl(dd, HCISETRAW, 1);
	hci_close_dev(dd);

Regards

Marcel


