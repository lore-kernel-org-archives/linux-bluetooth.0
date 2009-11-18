Return-Path: <cyrus@holtmann.org>
Subject: Re: Getting/setting Inquiry trasmit power level unsolved
From: Marcel Holtmann <marcel@holtmann.org>
To: Natale Vinto <ebballon@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <c6e9632c0911180959p3e56668aqc298a673baea7350@mail.gmail.com>
References: <c6e9632c0911131047s565cc191w84d22bc1dff710a0@mail.gmail.com>
	 <1258286232.3299.27.camel@violet>
	 <c6e9632c0911170853g5ef4061cr75c42c71a1a87b7d@mail.gmail.com>
	 <1258491418.2003.37.camel@violet>
	 <c6e9632c0911171318l1b60fa85h55b3e6083777d516@mail.gmail.com>
	 <c6e9632c0911180959p3e56668aqc298a673baea7350@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 18 Nov 2009 19:15:14 +0100
Message-ID: <1258568114.2003.128.camel@violet>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Natale,

> I would also know what could be the problem for other CSR based usb
> bluetooth dongles, the dongle I've linked before from Cubic 3c. Corp.
> is CSR according to lsusb. Is a linux-usb issue or the implementation
> of TPL in BlueZ that deal only with certain kind of chipset?
> 
> When you talk about CSR dongle do you mean some developer stuff like
> Nanosira-EDR USB Bluetooth Dongle
> available at http://www.csr.com/store/search.php?q=PTS
> or other CSR based dongles as Belkin or Targus ACB10US, as I read in Bluez News?

I tried it with a Fujitsu-Siemens BlueCore4-External flashed with a 2.1
firmware. That was the one I had laying on my desk.

And as I said, before run "hciconfig hci0 commands" and see if the
command is actually supported. Maybe the ROM chips are different.

Regards

Marcel


