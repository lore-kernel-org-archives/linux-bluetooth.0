Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Can't get BT working on an iBook G4
From: Marcel Holtmann <marcel@holtmann.org>
To: Alberto Garcia Hierro <tcpdevil@linuxlover.org>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <200408140140.08096.tcpdevil@linuxlover.org>
References: <200408140030.10263.tcpdevil@linuxlover.org>
	 <200408140048.14641.cijoml@volny.cz>
	 <200408140140.08096.tcpdevil@linuxlover.org>
Content-Type: text/plain
Message-Id: <1092440931.4501.87.camel@pegasus>
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
Date: Sat, 14 Aug 2004 01:48:52 +0200

Hi Alberto,

> Thanks a lot, it's working fine now:
> 
> 
> americana ~ $ hid2hci -0
> Switching device 05ac:1000 to HCI mode was successful
> americana ~ $ hciconfig
> hci0:   Type: USB
>         BD Address: 00:0D:93:03:63:8E ACL MTU: 192:8  SCO MTU: 64:8
>         UP RUNNING PSCAN ISCAN
>         RX bytes:107 acl:0 sco:0 events:14 errors:0
>         TX bytes:300 acl:0 sco:0 commands:13 errors:0
> 
> 
> 	By the way, is this mentioned in the docs at www.bluez.org? I couldn't  find 
> any reference to hid2hci. Anyway, I would like to know something more about 
> hid2hci. Coul you point to somewhere with docs about it? 

I wrote some technical notes about it. Look at this page:

	http://www.holtmann.org/linux/bluetooth/epox.html

Regards

Marcel




-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
