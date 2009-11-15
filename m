Return-Path: <cyrus@holtmann.org>
Subject: Re: Getting/setting Inquiry trasmit power level unsolved
From: Marcel Holtmann <marcel@holtmann.org>
To: Natale Vinto <ebballon@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <c6e9632c0911131047s565cc191w84d22bc1dff710a0@mail.gmail.com>
References: <c6e9632c0911131047s565cc191w84d22bc1dff710a0@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date: Sun, 15 Nov 2009 12:57:12 +0100
Message-ID: <1258286232.3299.27.camel@violet>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Natale,

> I've this issue: while trying to get/set inquiry transmit power level
> from a bluetooth usb dongle on 2.6 kernels I got always this error:
> 
> Can't read inquiry transmit power level on hci0: Input/output error (5)
> 
> I've tried with any bluetooth usb dongle class (1.1, 2 and 2.1) from
> many vendors (ex. Sitecom, Trust, D-Link, Belkin, etc), in many 2.6.x
> kernels ( 2.6.{27,31} ) on Debian and Ubuntu machines using BlueZ 3.x
> and 4.x stack and I got always that error while trying to get the TPL
> with:
> 
> hciconfig <device> inqtpl
> 
> I searched a lot in mailing list archives and I haven't seen any
> solution for this issue, I've found maybe useful only this old email
> 
> http://osdir.com/ml/bluez.devel/2003-06/msg00140.html
> 
> where is suggested a CSR chipset based hardware.
> Also looking in sources I found that the problem comes from this pieces of code:
> 
> int8_t level;
> 
>         if (hci_read_inquiry_transmit_power_level(dd, &level, 1000) < 0) {
>             fprintf(stderr, "Can't read inquiry transmit power level
> on hci%d: %s (%d)\n",
>                         hdev, strerror(errno), errno);
>             exit(1);
>         }
> 
> My question is : how can I have the inqtpl option working? Should I
> buy only CSR hardware dongle? I'm considering usb dongle because they
> are the most common in the market, although it could be a linux-usb
> issue I wonder how to try to fix it!

what does hciconfig hci0 commands tell you? Does it show that this
command is supported by the firmware. And this is a pure 2.1 feature so
all older dongles will not have it.

Regards

Marcel


