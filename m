Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Bluetooth Synchronization on Nokia (3650)
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <OF5B3D8884.B77486D9-ON85256FD7.007C2BAB-85256FD7.007C5FC0@alps.com>
References: 
	 <OF5B3D8884.B77486D9-ON85256FD7.007C2BAB-85256FD7.007C5FC0@alps.com>
Content-Type: text/plain
Message-Id: <1112554808.8263.15.camel@pegasus>
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
Date: Sun, 03 Apr 2005 21:00:08 +0200

Hi Scott,

> A while back I wrote an application that syncs my Sony Ericcson phone
> via IrMC synchronization.  Recently I purchased a Nokia 3650 thinking
> that it supported same IrMC Synchronization profile over Bluetooth (I
> guess I just based that thinking on Apple iSync supporting the 3650,
> because I though that iSync only used IrMC sync).  Well I was
> wrong :-) ...
> 
> Does anyone know how synchronization is done over bluetooth on this
> nokia 3650 (and other symbian nokias?).  It must be possible, iSync is
> doing it...  some kind of OBEX command ? or something over
> tcp/ip/network ? 

as far as I know, you need the mRouter (PPP over RFCOMM) for syncing the
old Symbian based phones via SyncML. For the newer ones it seems that
they started using SyncML over OBEX.

Regards

Marcel




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
