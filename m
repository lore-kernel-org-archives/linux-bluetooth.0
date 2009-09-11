Return-Path: <cyrus@holtmann.org>
From: Oliver Neukum <oliver@neukum.org>
To: Kartikey Parmar <kartikey2781@gmail.com>,
 Marcel Holtmann <marcel@holtmann.org>,
 linux-bluetooth@vger.kernel.org
Subject: Re: problem in btusb driver for linux-2.6.30
Date: Fri, 11 Sep 2009 08:32:15 +0200
Cc: linux-usb@vger.kernel.org
References: <6887eb5d0909102327u2ca531d1q35d027839495a978@mail.gmail.com>
In-Reply-To: <6887eb5d0909102327u2ca531d1q35d027839495a978@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200909110832.16244.oliver@neukum.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Am Freitag, 11. September 2009 08:27:33 schrieb Kartikey Parmar:
> Dear friends,
>
> I have configured linux-2.6.30 for AT91SAM9263 with Bluetooth support
> of RFCOMM, SCO, L2CAP and HCI USB driver for bluetooth usb dongle.

Did it work with 2.6.29?

> When I insert bluetooth dongle in usb port it calls btusb_probe twice,
> and then I m receiving error like "No such device".
>
> I have checked with the debug log, it gives me an error "interface
> numbers are hardcoded in the spec" and returns ENODEV.

Please post the log and "lsusb -v" for your device.

	Regards
		Oliver
