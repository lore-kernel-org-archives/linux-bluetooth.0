Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: "Collin R. Mulliner" <collin@betaversion.net>
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] no concurrent inquiry / inquiry scan and L2CAP
 connection as slave
Message-Id: <20040905105312.64316ddc@coredump>
In-Reply-To: <413B18F9.6010101@nue.et-inf.uni-siegen.de>
References: <413B18F9.6010101@nue.et-inf.uni-siegen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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
Date: Sun, 5 Sep 2004 10:53:12 -0700

Hi Michael,

I have an application which connects 2 or mode nodes via rfcomm and all
nodes still do inquirys all the time. Since rfcomm is build on top of
l2cap your stuff should work. Maybe you like to verify it by looking at
my code - http://www.mulliner.org/bluetooth/btchat/

> I'm experiencing the following behavior with BlueZ and L2CAP:
> 
> After establishing an L2CAP connection between two nodes, only the 
> master of this connection is still able to:
> 
> - perform periodic device inquiries (i.e. search other devices
>    in 'Periodic_Inquiry_Mode')	
> - perform inquiry scans (i.e. be visible for other searching devices)
> 
> However, I would like to be able to do this as slave as well (at
> least, to perform inquiry scans as slave).
> 
> Now I'm wondering whether:
> 
> - this is a restriction of BlueZ		or
> - this is a restriction of my BT chipsets	or
> - this is a restriction of Bluetooth		or
> - I'm doing (configuring) something wrong...


-- 
Collin R. Mulliner <collin@betaversion.net>
BETAVERSiON Systems [www.betaversion.net]
info/pgp: finger collin@betaversion.net
God is real, unless declared integer.


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
