Return-Path: <bluez@thomae-privat.de>
Message-ID: <40E272CE.3090705@thomae-privat.de>
Date: Wed, 30 Jun 2004 09:59:10 +0200
From: Matthias Thomae <bluez@thomae-privat.de>
MIME-Version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
Subject: Re: [Bluez-users] Epox Barton keyboard: HID create error 53
References: <40CDE18C.70703@thomae-privat.de>	 <1087255678.13792.51.camel@pegasus>  <40CE96A8.3020407@thomae-privat.de>	 <1087284859.13792.67.camel@pegasus>  <40CEC020.6050107@thomae-privat.de>	 <1087292887.13792.81.camel@pegasus>  <40CF4B17.2010806@thomae-privat.de>	 <1087339715.13792.104.camel@pegasus>  <40D7DDAD.2040908@thomae-privat.de>	 <1087897207.4328.89.camel@pegasus> <40D8D39E.3070301@thomae-privat.de>	 <40E024AD.1000101@thomae-privat.de> <1088452526.6030.86.camel@pegasus>	 <40E12F15.9040805@thomae-privat.de> <1088500144.6030.249.camel@pegasus>	 <40E1C91C.8030500@thomae-privat.de> <1088543513.6030.332.camel@pegasus>
In-Reply-To: <1088543513.6030.332.camel@pegasus>
Content-Type: text/plain; charset=us-ascii; format=flowed
List-ID: <bluez-users.lists.sourceforge.net>

Hello Marcel,

Marcel Holtmann wrote:
> don't rely on that you will get a fixed device very soon. I reported
> that bug to EPoX, but I don't expect anything. I will fix it directly in
> the hidd and swap the bytes in the HID descriptor before handling the
> connection over to the HIDP module.

I think I could live very well with a quirk, if it makes the device 
work. I didn't plan to use other BT stacks anyway :)

Regards.
Matthias
