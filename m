Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Epox Barton keyboard: HID create error 53
From: Marcel Holtmann <marcel@holtmann.org>
To: Matthias Thomae <bluez@thomae-privat.de>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <40F02654.1090200@thomae-privat.de>
References: <40CDE18C.70703@thomae-privat.de>
	 <1087255678.13792.51.camel@pegasus>  <40CE96A8.3020407@thomae-privat.de>
	 <1087284859.13792.67.camel@pegasus>  <40CEC020.6050107@thomae-privat.de>
	 <1087292887.13792.81.camel@pegasus>  <40CF4B17.2010806@thomae-privat.de>
	 <1087339715.13792.104.camel@pegasus>  <40D7DDAD.2040908@thomae-privat.de>
	 <1087897207.4328.89.camel@pegasus> <40D8D39E.3070301@thomae-privat.de>
	 <40E024AD.1000101@thomae-privat.de> <1088452526.6030.86.camel@pegasus>
	 <40E12F15.9040805@thomae-privat.de> <1088500144.6030.249.camel@pegasus>
	 <40E1C91C.8030500@thomae-privat.de> <1088543513.6030.332.camel@pegasus>
	 <40F02654.1090200@thomae-privat.de>
Content-Type: text/plain
Message-Id: <1089480571.13519.60.camel@pegasus>
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
Date: Sat, 10 Jul 2004 19:29:31 +0200

Hi Matthias,

> I just tried bluez-libs/utils 2.8 and the 2.6.7-mh2 patch, and got my 
> "broken" keyboard running with it :)
> 
> Great work, please keep it up!

not really, but the 2.6.7-mh2 is capable of switching back into boot
protocol mode if the HID descriptor is buggy. I will implement the quirk
for the EPoX bug in the hidd when I got more time.

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
