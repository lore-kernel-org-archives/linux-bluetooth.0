Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] install/connection problem
From: Marcel Holtmann <marcel@holtmann.org>
To: Piotr Skrzypek <bluezet@interia.pl>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <008401c43b7c$54a74b90$0200a8c0@pc>
References: <008401c43b7c$54a74b90$0200a8c0@pc>
Content-Type: text/plain
Message-Id: <1084869367.5833.48.camel@pegasus>
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
Date: Tue, 18 May 2004 10:36:07 +0200

Hi Piotr,

> I`m new here and i`m new in linux. I`ve just installed BlueZ files in my
> machine with kernel 2.4.24 without any patches. I have installed everything
> in bluetooth section of the kernel. Now i don`t know, maybe i shoud install
> bnep as a module, because on most tutorials i see line modprobe bnep. Or
> maybe i don`t need to do it? just leave it installed in kernel? My next step
> was install everything from bluez. Of cource i couldn`t install kde
> bluetooth because of some problems, so i must work with command line. My
> point is to make network tcp/ip connection between server machine (debian)
> and windows xp. I realised, that i can see my server from the computer with
> windows. I see it as a "BlueZ" Device, and it has no protocols. Now: how can
> i create network connection, so i can share my internet connection with the
> other pc? And how can i make some simple security configuration, because i
> don`t want anyone to connect to my bluetooth device, except that machine
> with winXP. I hope U understood me. Pleas help me - i can`t find any
> tutorial that fits to my needs.  Maybe U have some expirience?

you must find out of your Windows Bluetooth stack really supports the
PAN profile or if its only support LAN access using PPP. For the first
you can use pand, but for the second you must use dund.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by: SourceForge.net Broadband
Sign-up now for SourceForge Broadband and get the fastest
6.0/768 connection for only $19.95/mo for the first 3 months!
http://ads.osdn.com/?ad_id=2562&alloc_id=6184&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
