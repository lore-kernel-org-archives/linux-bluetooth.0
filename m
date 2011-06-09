Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Message-ID: <70c3591.2c9bb3104890d70c4f20e2f78ab19c38@1oca1host.de>
From: thilo@cestona.ro
To: "Marcel Holtmann" <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: AW: AW: Re: Support for 0489:e031 Foxconn / Hon Hai
Date: Thu, 9 Jun 2011 15:58:40 +0200 (CEST)
Content-Type: text/plain;
	charset="utf-8"
List-ID: <linux-bluetooth.vger.kernel.org>

Hey Marcel,

thx for your help! Now it works.

>>Maybe the antenna is kinda wrongly calibrated, but I can't tell any
>>details here. That is hardware specific.
>
>So you think it's not connected correctly or what means wrongly calibra=
ted?
>Perhaps I can give it a try via Virtualbox under windows ... 

As Virtualbox does a direct usb passthrough to the client I could instal=
l the bluetooth adapter in windows with the original broadcom bluetooth =
driver.
Once I opened the settings there and "saved" theses, the adapter finds b=
luetooth devices nicely under windows AND linux.

Sadly I have no idea what the broadcom driver did to "activate" the adap=
ter.

Does this make sence? For me not, but it works now.

When someone is interessted in any details, I will answer any question a=
s good as I can!

Perhaps someone can integrate the vendor id and product id in the kernel=
 source btusb.c file.
The broadcom driver names the adapter 'Broadcom BCM20702 Bluetooth USB D=
evice'.
vid: 0x0489
pid: 0xE031

Ciao
Thilo
