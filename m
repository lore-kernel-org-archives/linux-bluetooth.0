Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Epox Barton keyboard: HID create error 53
From: Marcel Holtmann <marcel@holtmann.org>
To: Matthias Thomae <bluez@thomae-privat.de>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <40E12F15.9040805@thomae-privat.de>
References: <40CDE18C.70703@thomae-privat.de>
	 <1087255678.13792.51.camel@pegasus>  <40CE96A8.3020407@thomae-privat.de>
	 <1087284859.13792.67.camel@pegasus>  <40CEC020.6050107@thomae-privat.de>
	 <1087292887.13792.81.camel@pegasus>  <40CF4B17.2010806@thomae-privat.de>
	 <1087339715.13792.104.camel@pegasus>  <40D7DDAD.2040908@thomae-privat.de>
	 <1087897207.4328.89.camel@pegasus> <40D8D39E.3070301@thomae-privat.de>
	 <40E024AD.1000101@thomae-privat.de> <1088452526.6030.86.camel@pegasus>
	 <40E12F15.9040805@thomae-privat.de>
Content-Type: text/plain
Message-Id: <1088500144.6030.249.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Tue, 29 Jun 2004 11:09:05 +0200

Hi Matthias,

> the HID Specification 1.11 states on page 19:
> 
> "Multibyte numeric values in reports are represented in little-endian 
> format, with the least significant byte at the lowest address."

this makes is clear the EPoX HID descriptor is buggy and the only reason
their mouse works is, because it doesn't uses a multibyte value.

> So it really is 65280, isn't it? Also, I got this value by use of the 
> HID Descriptor Tool.
> Moreover, the descriptor of the Apple keyboard, according to your web 
> page, has a similar sequence the other way round: "2a ff 00"

I know. I checked my HID devices to see what the other manufacturer did
and if some other one uses multibyte.

> The funny thing is, the Windows Widcomm Bluetooth stack seems to cope 
> with this, I tried it on a Thinkpad.

That is not so funny, because even the bthid was able to work with EPoX
keyboard. Everything depends on how you implement the parser. The Linux
kernel HID parser stores some values for faster access. We are inside
the kernel, we can't parse it everytime a report arrives.

> So what do we do?

I will notify EPoX about it, so they can correct their bug. We must
introduce a quirk for it, but I don't know how to trigger. The keyboard
don't uses Bluetooth DeviceID and the presenter DeviceID is also wrong.
At Cebit I told them that they should take care of DeviceID :(

For a future safe code I will implement the boot protocol, so we can use
it if the parsing of the report descriptor fails.

Regards

Marcel




-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
