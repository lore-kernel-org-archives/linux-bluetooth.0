Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Epox Barton keyboard: HID create error 53
From: Marcel Holtmann <marcel@holtmann.org>
To: Matthias Thomae <bluez@thomae-privat.de>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <40CF4B17.2010806@thomae-privat.de>
References: <40CDE18C.70703@thomae-privat.de>
	 <1087255678.13792.51.camel@pegasus>  <40CE96A8.3020407@thomae-privat.de>
	 <1087284859.13792.67.camel@pegasus>  <40CEC020.6050107@thomae-privat.de>
	 <1087292887.13792.81.camel@pegasus>  <40CF4B17.2010806@thomae-privat.de>
Content-Type: text/plain
Message-Id: <1087339715.13792.104.camel@pegasus>
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
Date: Wed, 16 Jun 2004 00:48:35 +0200

Hi Matthias,

> > someone has to fix the HID parser to get it working with the keyboard
> > and the presenter from EPoX. I am a little bit busy in getting the boot
> > protocol support ready, so that we can at least include HID boot support
> > into the mainline kernel. The full report protocol support has to wait
> > until the kernel gets its device independent HID support.
> 
> Alright, thank you meanwhile.

feel free to investigate and send me a patch.

> > Please do so. I want to compare it with my devices. The keyboard looks
> > the same as mine. It seems they only choosed a newer CSR firmware.
> 
> Hopefully a better one ;)

I think my EPoX keyboard and mouse were a prototype and this is why I
had a different build id. The SPD records and the HID descriptor are the
same.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by The 2004 JavaOne(SM) Conference
Learn from the experts at JavaOne(SM), Sun's Worldwide Java Developer
Conference, June 28 - July 1 at the Moscone Center in San Francisco, CA
REGISTER AND SAVE! http://java.sun.com/javaone/sf Priority Code NWMGYKND
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
