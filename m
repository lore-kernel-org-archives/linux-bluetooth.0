Return-Path: <bluez@thomae-privat.de>
Message-ID: <40E12F15.9040805@thomae-privat.de>
Date: Tue, 29 Jun 2004 10:57:57 +0200
From: Matthias Thomae <bluez@thomae-privat.de>
MIME-Version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
Subject: Re: [Bluez-users] Epox Barton keyboard: HID create error 53
References: <40CDE18C.70703@thomae-privat.de>	 <1087255678.13792.51.camel@pegasus>  <40CE96A8.3020407@thomae-privat.de>	 <1087284859.13792.67.camel@pegasus>  <40CEC020.6050107@thomae-privat.de>	 <1087292887.13792.81.camel@pegasus>  <40CF4B17.2010806@thomae-privat.de>	 <1087339715.13792.104.camel@pegasus>  <40D7DDAD.2040908@thomae-privat.de>	 <1087897207.4328.89.camel@pegasus> <40D8D39E.3070301@thomae-privat.de>	 <40E024AD.1000101@thomae-privat.de> <1088452526.6030.86.camel@pegasus>
In-Reply-To: <1088452526.6030.86.camel@pegasus>
Content-Type: text/plain; charset=us-ascii; format=flowed
List-ID: <bluez-users.lists.sourceforge.net>

Hi Marcel,

the HID Specification 1.11 states on page 19:

"Multibyte numeric values in reports are represented in little-endian 
format, with the least significant byte at the lowest address."

So it really is 65280, isn't it? Also, I got this value by use of the 
HID Descriptor Tool.
Moreover, the descriptor of the Apple keyboard, according to your web 
page, has a similar sequence the other way round: "2a ff 00"

The funny thing is, the Windows Widcomm Bluetooth stack seems to cope 
with this, I tried it on a Thinkpad.

So what do we do?

Greetings
Matthias


Marcel Holtmann wrote:
>>is caused by the item USAGE_MAXIMUM(65280) which corresponds to "2A 00 
>>FF", the 18th item of the descriptor (see below). The maximum number of 
>>usages is set in net/bluetooth/hidp/hid.h
>>
>>#define HID_MAX_USAGES                  1024
>>
>>I tried to increase this to 65535 (FFFF), the theoretical max according 
>>to HUT 1.11, but it didn't help, because then the max page size is exceeded.
>>
>>But this doesn't seem reasonable anyway, since the codes E8-FFFF are not 
>>defined yet (and which keyboard has several tens of thousand keys? ;).
>>
>>So, can we assume the HID descriptor is "broken"? If yes, what would be 
>>the way to deal with this? Can we re-set the USAGE_MAXIMUM to a 
>>reasonable value?
> 
> 
> I don't know if the descriptor is broken or if the HID parser has a bug.
> 
> The value you are talking about is 255 and not 65280. The questions is
> if the descriptor encodes these values in big or in little endian. If
> they must be in little endian than EPoX made a mistake here, otherwise
> our HID parser is broken. Please check the specification for the used
> endian encoding, because I will not have time to read it.
> 
> Regards
> 
> Marcel
> 
> 
