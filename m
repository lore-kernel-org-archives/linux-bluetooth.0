Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] No more bluez.o in 2.6?
From: Marcel Holtmann <marcel@holtmann.org>
To: Gregoire Favre <Gregoire.Favre@freesurf.ch>
Cc: Aben Siatris <aben@webcom.sk>,
   BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <20040408150950.GB5539@magma.epfl.ch>
References: <20040407172325.GC9593@magma.epfl.ch>
	 <20040407214322.GA14396@magma.epfl.ch> <200404080948.44365.aben@webcom.sk>
	 <20040408150950.GB5539@magma.epfl.ch>
Content-Type: text/plain
Message-Id: <1081441750.17209.1.camel@pegasus>
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
Date: Thu, 08 Apr 2004 18:29:10 +0200

Hi Gregoire,

> That's sound great, could you give some more details on what sould be
> done?
> pand --listen --role NAP
> OK
> ifconfig bnep0 192.168.20.1 netmask 255.255.255.0
> SIOCSIFADDR: No such device
> bnep0: unknown interface: No such device
> SIOCSIFNETMASK: No such device
> 
> And I don't have anything in /udev/bnep, how to create it in dev?

network interface don't have a device node. The bnep0 is only available
if you've made a connection.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
