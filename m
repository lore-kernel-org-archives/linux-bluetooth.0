Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Alain Volmat <avolmat@src.ricoh.co.jp>
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] 3com Bluetooth PC-Card
Message-ID: <20041206004903.GA29273@snoopy.src.ricoh.co.jp>
References: <1102260650.3782.3.camel@tuxlaptop.site> <1102260948.8510.28.camel@pegasus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1102260948.8510.28.camel@pegasus>
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
Date: Mon, 6 Dec 2004 09:49:03 +0900

Version 3.0 also work fine (even if 2 ttyS are being discovered after
insertion of the card). But this is more a serial_cs problem than a bluez
problem. On my config 1 ttyS is based on 16950, that's the one which should
be used. Anyway the second reports some error during initialization.

The version is serial number is: 3CRWB6096B, but it is also clearly 
written "Version 3.0" on the card label.

Alain

* Marcel Holtmann [Sun,  5 Dec 2004 at 16:35 +0100]
<quote>
> Hi Andreas,
> 
> > I want to buy a PC-Card for Bluetooth. The 3com Bluetooth Card looks
> > fine to me. Does it work well with bluez and Kernel 2.6 or are there any
> > problems?
> 
> the version 2.0 (bt3c_cs) and version 3.0 (serial_cs + hci_uart) should
> work both fine. However I only tested the 2.0 so far.
> 
> Regards
> 
> Marcel
> 
> 
> 
> 
> -------------------------------------------------------
> SF email is sponsored by - The IT Product Guide
> Read honest & candid reviews on hundreds of IT Products from real users.
> Discover which products truly live up to the hype. Start reading now. 
> http://productguide.itmanagersjournal.com/
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users
</quote>


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
