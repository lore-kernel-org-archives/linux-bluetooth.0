Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] bt on acer problem
From: Marcel Holtmann <marcel@holtmann.org>
To: ultrakorne <ultrakorne@paranoici.org>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <41CA2F05.4030603@paranoici.org>
References: <41C38758.5030106@paranoici.org>
	 <1103473035.29892.16.camel@pegasus>  <41CA2F05.4030603@paranoici.org>
Content-Type: text/plain
Message-Id: <1103796315.20258.58.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Thu, 23 Dec 2004 11:05:15 +0100

Hi,

> this before, and after echoing in echo 1 > blueled
> the control and data registry value writed in the keyb controller is 
> wrong...
> acehk writes 0xe7, 0x03 to activate bt...
> maybe on mine values are different
> cat /proc/bus/usb/devices

I think so, because there is not Bluetooth module on your USB bus.

Regards

Marcel




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
