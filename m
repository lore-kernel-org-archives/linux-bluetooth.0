Return-Path: <bluez@thomae-privat.de>
Message-ID: <40D7DDAD.2040908@thomae-privat.de>
Date: Tue, 22 Jun 2004 09:20:13 +0200
From: Matthias Thomae <bluez@thomae-privat.de>
MIME-Version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
Subject: Re: [Bluez-users] Epox Barton keyboard: HID create error 53
References: <40CDE18C.70703@thomae-privat.de>	 <1087255678.13792.51.camel@pegasus>  <40CE96A8.3020407@thomae-privat.de>	 <1087284859.13792.67.camel@pegasus>  <40CEC020.6050107@thomae-privat.de>	 <1087292887.13792.81.camel@pegasus>  <40CF4B17.2010806@thomae-privat.de> <1087339715.13792.104.camel@pegasus>
In-Reply-To: <1087339715.13792.104.camel@pegasus>
Content-Type: text/plain; charset=us-ascii; format=flowed
List-ID: <bluez-users.lists.sourceforge.net>

Hi Marcel,

Marcel Holtmann wrote:
>>>someone has to fix the HID parser to get it working with the keyboard
>>>and the presenter from EPoX. I am a little bit busy in getting the boot
>>>protocol support ready, so that we can at least include HID boot support
>>>into the mainline kernel. The full report protocol support has to wait
>>>until the kernel gets its device independent HID support.
>>
>>Alright, thank you meanwhile.
> 
> feel free to investigate and send me a patch.

Hmm, I had a look at the USB "Device Class Definiton for HID" document, 
and at net/bluetooth/hidp/hid.[h,c], but I think I will need much more 
time to understand how to analyse a HID Report Descriptor.

Do you know of any tools to faciliate analysing/generating Report 
Descriptors?

BTW, I think to remember that the Descriptor of your Barton Keyboard was 
on your web pages, but I can't find it any more. Can you please put it 
back or mail it to the list?

Regards.
Matthias
