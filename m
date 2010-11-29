Return-Path: <cyrus@holtmann.org>
Message-ID: <4CF38E4B.9070807@ahsoftware.de>
Date: Mon, 29 Nov 2010 12:28:11 +0100
From: Alexander Holler <holler@ahsoftware.de>
MIME-Version: 1.0
To: Bala Shanmugam <sbalashanmugam@atheros.com>
CC: Shanmugamkamatchi Balashanmugam <Shanmugamkamatchi.Balashanmugam@Atheros.com>,
 Marcel Holtmann <marcel@holtmann.org>,
 "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH] Bluetooth: Add new PID for Atheros 3011
References: <1290766393-3801-1-git-send-email-sbalashanmugam@atheros.com> <1290770560.4795.12.camel@aeonflux> <4CEFA3A4.7030806@atheros.com> <4CEFD4D1.1040706@ahsoftware.de> <4CEFD855.6000503@ahsoftware.de> <4CF343A1.8010606@atheros.com>
In-Reply-To: <4CF343A1.8010606@atheros.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
List-ID: <linux-bluetooth.vger.kernel.org>

Am 29.11.2010 07:09, schrieb Bala Shanmugam:

> This patch is for Atheros 3011 with sflash firmware.
> This device gets identified Generic bluetooth USB device when plugged in.
> We are blacklisting 3002 in btusb to load actual firmware in ath3k.
> Latest firmware comes up with PID 3005 and not 3002.

Thanks for the explanation. Is there a place in the web where the latest 
firmware could be found?

The only place I've found to look at was the linux-firmware repository 
and that repo currently has no new firmware for the ath3k.

Btw., did you have a look at the small patch for ath3k I posted lately:

http://marc.info/?l=linux-bluetooth&m=129045856314243

This avoids storing the firmware in RAM (I don't see a reason to do 
that, it is never used again) and simplifies the small driver a bit.

Regards,

Alexander
