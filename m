Return-Path: <bluez-users-admin@lists.sourceforge.net>
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] Bluetooth after suspend? 
In-Reply-To: Message from Matija Grabnar <matija.grabnar@arnes.si>
   of "Mon, 04 Apr 2005 22:36:25 +0200." <20050404203625.GA18079@rzenik.arnes.si>
References: <42513AA3.1050309@arnes.si> <17461.1112620837@csr.com>  <20050404203625.GA18079@rzenik.arnes.si> 
Message-ID: <10838.1112692850@csr.com>
From: Peter Stephenson <pws@csr.com>
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
Date: Tue, 05 Apr 2005 10:20:50 +0100

Matija Grabnar wrote:
> lsubs -v says:
> Bus 004 Device 002: ID 0a12:0001 Cambridge Silicon Radio, Ltd Bluetooth Dongl
> e (HCI mode)
>   bcdDevice            8.28

I think that's version 828, i.e.

bc02x_4hci_bt1.1_16.14_encr56 2003-04-02

This could be our bug B-729 which is known to affect 16.14.  According to
the report the chip could reset if the suspend was sufficiently long,
typically between 1.5 and 3 minutes.  This was due to a timing error
when we entered the very low power state required by suspend.  It's
fixed in 16.15 and in the BT 1.2 firmware (version 18.x; version 17 wasn't
released for bc02x).

Most things which go wrong should result in the device falling off the
bus and reappearing, having rebooted.  If that's not your problem, there
may be something else going on.

pws


**********************************************************************
This email and any files transmitted with it are confidential and
intended solely for the use of the individual or entity to whom they
are addressed. If you have received this email in error please notify
the system manager.

**********************************************************************



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
