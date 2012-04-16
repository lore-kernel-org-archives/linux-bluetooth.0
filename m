Return-Path: <cyrus@holtmann.org>
Date: Mon, 16 Apr 2012 11:18:30 +0300
From: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>
To: Tomasz =?utf-8?Q?Mi=C5=9B?= <ext73@wp.pl>
Cc: linux-bluetooth <linux-bluetooth@vger.kernel.org>
Subject: Re: [kernel 3.3.x - 3.3.2] btusb & usb-storage regression = btusb &
 usb storage crash
Message-ID: <20120416081828.GC32078@aemeltch-MOBL1>
References: <4f8bce1d1af270.80920174@wp.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <4f8bce1d1af270.80920174@wp.pl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Tomasz,

On Mon, Apr 16, 2012 at 09:45:33AM +0200, Tomasz Miś wrote:
> So, here it is results for kernel 3.3.2 with enabled catalyst -
> dmesg.log and the results on the open drivers - here only a 'picture' -
> the system has been totally 'crashed' - as I wrote earlier on the
> linux-usb, this situation occurs when unlink usb-bluetooth dongle in a
> call to another device, or turn off the Bluetooth example, under KDE
> 
> http://dl.dropbox.com/u/72313101/3.3.2-btusb-usb-storage-crash.jpeg

Can you try patches mentioned here:

https://lkml.org/lkml/2012/3/7/68

Best regards 
Andrei Emeltchenko 

