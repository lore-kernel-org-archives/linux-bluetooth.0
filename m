Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] starting order in debian init script for bluez
From: Marcel Holtmann <marcel@holtmann.org>
To: Matthias Thomae <bluez@thomae-privat.de>
Cc: Edd Dumbill <edd@usefulinc.com>,
   BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <40F11592.8090704@thomae-privat.de>
References: <40F03526.3000900@thomae-privat.de>
	 <1089485717.13519.75.camel@pegasus>  <40F11592.8090704@thomae-privat.de>
Content-Type: text/plain
Message-Id: <1089559362.24919.7.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Sun, 11 Jul 2004 17:22:42 +0200

Hi Matthias,

> So it would still make sense to call hci2hid before rfcomm/dund/pand, 
> wouldn't it?

this depends on what you wanna do, but you should make sure that at
least hcid and sdpd are running.

> BTW, this is exactly the case in the init script contained in 
> bluez-utils 2.8:

I know, because I wrote that init script. If you don't like the Debian
init script or thing it is wrong, file a bug report for it.

Regards

Marcel




-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
