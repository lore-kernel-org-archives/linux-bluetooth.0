Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] no concurrent inquiry / inquiry scan and L2CAP
	connection as slave
From: Marcel Holtmann <marcel@holtmann.org>
To: Michael Schmidt <schmidt@nue.et-inf.uni-siegen.de>
Cc: bluez-users@lists.sourceforge.net
In-Reply-To: <413B18F9.6010101@nue.et-inf.uni-siegen.de>
References: <413B18F9.6010101@nue.et-inf.uni-siegen.de>
Content-Type: text/plain
Message-Id: <1094459425.5145.19.camel@notepaq>
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
Date: Mon, 06 Sep 2004 10:30:26 +0200

Hi Michael,

> I'm experiencing the following behavior with BlueZ and L2CAP:
> 
> After establishing an L2CAP connection between two nodes, only the 
> master of this connection is still able to:
> 
> - perform periodic device inquiries (i.e. search other devices
>    in 'Periodic_Inquiry_Mode')	
> - perform inquiry scans (i.e. be visible for other searching devices)
> 
> However, I would like to be able to do this as slave as well (at least, 
> to perform inquiry scans as slave).
> 
> Now I'm wondering whether:
> 
> - this is a restriction of BlueZ		or
> - this is a restriction of my BT chipsets	or
> - this is a restriction of Bluetooth		or
> - I'm doing (configuring) something wrong...
> 
> My environment:
> 
> SuSE Linux 9.0: kernel 2.4.21, bluez-libs 2.4, bluez-utils-2.3
> 
> I have tested and verified this behavior with the BrainBoxes BL-500 and
> BL-554 adapters.
> I'd be very grateful if someone of you could shed some light on this topic.

this sounds like a chip limitation. What does "hciconfig -a" say?

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
