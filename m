Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] rfcomm
From: Marcel Holtmann <marcel@holtmann.org>
To: mohalik@india.hp.com
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <4101C6BE.3010707@india.hp.com>
References: <200401302209.52396.raydar@nwlink.com>
	 <4100F85D.5080200@india.hp.com> <1090583514.4791.42.camel@pegasus>
	 <4101C6BE.3010707@india.hp.com>
Content-Type: text/plain
Message-Id: <1090659535.4791.60.camel@pegasus>
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
Date: Sat, 24 Jul 2004 10:58:55 +0200

Hi Swarup,

> I have upgraded the bluez-modules. But the problem persists:
> To recap,
> ***********************************************************
> Problem: 
>     lx1 runs rctest -s <bt_addr of lx2>
>     lx2 freezes
>     
>     No problem with l2test.
> ***********************************************************
> 
> The current configuration of lx2 is :
> 
> usb dongles twin pack from amazing tech
> 
> ==================================
> Linux RH 8.0 running 2.6.0. kernel

you should have said this earlier. The 2.6.0 has a module reference
counting bug. Update to 2.6.8-rc2 and everything should work fine.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
