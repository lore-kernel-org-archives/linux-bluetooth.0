Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Epox Barton keyboard: HID create error 53
From: Marcel Holtmann <marcel@holtmann.org>
To: Matthias Thomae <bluez@thomae-privat.de>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <40E024AD.1000101@thomae-privat.de>
References: <40CDE18C.70703@thomae-privat.de>
	 <1087255678.13792.51.camel@pegasus>  <40CE96A8.3020407@thomae-privat.de>
	 <1087284859.13792.67.camel@pegasus>  <40CEC020.6050107@thomae-privat.de>
	 <1087292887.13792.81.camel@pegasus>  <40CF4B17.2010806@thomae-privat.de>
	 <1087339715.13792.104.camel@pegasus>  <40D7DDAD.2040908@thomae-privat.de>
	 <1087897207.4328.89.camel@pegasus> <40D8D39E.3070301@thomae-privat.de>
	 <40E024AD.1000101@thomae-privat.de>
Content-Type: text/plain
Message-Id: <1088452526.6030.86.camel@pegasus>
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
Date: Mon, 28 Jun 2004 21:55:26 +0200

Hi Matthias,

> Well, I looked a little closer, and it seems that the debugging message
> 
> net/bluetooth/hidp/hid.c: usage index exceeded
> net/bluetooth/hidp/hid.c: hid_add_usage failed
> net/bluetooth/hidp/hid.c: item 0 2 2 2 parsing failed
> 
> is caused by the item USAGE_MAXIMUM(65280) which corresponds to "2A 00 
> FF", the 18th item of the descriptor (see below). The maximum number of 
> usages is set in net/bluetooth/hidp/hid.h
> 
> #define HID_MAX_USAGES                  1024
> 
> I tried to increase this to 65535 (FFFF), the theoretical max according 
> to HUT 1.11, but it didn't help, because then the max page size is exceeded.
> 
> But this doesn't seem reasonable anyway, since the codes E8-FFFF are not 
> defined yet (and which keyboard has several tens of thousand keys? ;).
> 
> So, can we assume the HID descriptor is "broken"? If yes, what would be 
> the way to deal with this? Can we re-set the USAGE_MAXIMUM to a 
> reasonable value?

I don't know if the descriptor is broken or if the HID parser has a bug.

The value you are talking about is 255 and not 65280. The questions is
if the descriptor encodes these values in big or in little endian. If
they must be in little endian than EPoX made a mistake here, otherwise
our HID parser is broken. Please check the specification for the used
endian encoding, because I will not have time to read it.

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
