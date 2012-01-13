Return-Path: <cyrus@holtmann.org>
Subject: Re: [Regression] bluetoohd 4.85 and later fails to connect properly
From: Oliver Joos <oliver.joos@hispeed.ch>
To: linux-bluetooth@vger.kernel.org
In-Reply-To: <1324597354.7632.42.camel@oliverhp>
References: <1324597354.7632.42.camel@oliverhp>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 13 Jan 2012 14:53:44 +0100
Message-ID: <1326462824.686.76.camel@oliverhp>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Fri, Dec 23, 2011 at 00:42 +0100, Oliver Joos wrote:
> Hi everyone,
> (I'm glad to post my first message here on linux-bluetooth)
> 
> I collect facts about why various Bluetooth adapters stopped working
> with bluez since 2011. We have several Laptops with Broadcom 2035
> adapters "03f0:011d" (chip says BCM92035NMD) where Bluetooth does not
> work anymore since Ubuntu 11.04 (bluez 4.91). Pairing works, but data
> transfer does not. Same issue with my mobile (Symbian S60v3.1), my
> headset and my mini keyboard. Also affected are Android phones and other
> common Bluetooth adapters like Cambridge Silicon Radio "0a12:0001".
> See details from other victims on https://bugs.launchpad.net/bugs/839157
> 
> With the help of Nikolay Kachanov (he posted here on August 4th) I found
> that if I replace the package bluez 4.91 with 4.84 then everything works
> as expected. bluez 4.91 even works if only "/usr/sbin/bluetoothd" is
> replaced by the one from 4.84, whereas 4.85 does not work anymore.
> So IMO the regression occurred in bluetoothd 4.85.
> 
> I have attached all logs I made using bluez_4.84-0ubuntu1_i386.deb and
> bluez_4.85-0ubuntu1_i386.deb. With the bluetooth-applet I stopped the
> bluetooth service, the deleted /var/lib/bluetooth/, replaced bluetoothd,
> restarted service, did pairing (which always works!) and then tried to
> connect my mobile (which fails with 4.85).
> 
> To me one interesting difference is in bluetoothd_4.8x.log where
> "plugins/hciops.c:link_key_request()" is missing with 4.85.
> And an even more suspicious difference is in hcidump-Xt_4.8x.log here:
> 
> With bluetoothd 4.84 (which works):
> < HCI Command: Create Connection (0x01|0x0005) plen 13
>   0000: 8d 68 6b 9a 1c 00 18 cc  01 00 ed f3 01           .hk..........
> 
> With bluetoothd 4.85 (which fails):
> < HCI Command: Create Connection (0x01|0x0005) plen 13
>   0000: 8d 68 6b 9a 1c 00 18 cc  01 00 78 b6 01           .hk.......x..
> 
> Now I hope that someone on this list has an idea where this bug hides.
> Please just ask if additional info would be helpful!
> 
> With kind regards,
> +++ Oliver
> 

No feedback at all? I am surprised.
(Is there a better place for bluez bug repors?)

Since I haven't the time to go deeper into the code, I will spread the
word about downgrading to 4.84 next week among the people affected (on
launchpad.net ect.)

Thanks for reading,
+++ Oliver


