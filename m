Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] uinput and modules.conf
From: Marcel Holtmann <marcel@holtmann.org>
To: cijoml@volny.cz
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <200403162226.46383.cijoml@volny.cz>
References: <200403160905.27291.cijoml@volny.cz>
	 <200403161746.03391.cijoml@volny.cz> <1079456964.3307.116.camel@pegasus>
	 <200403162226.46383.cijoml@volny.cz>
Content-Type: text/plain
Message-Id: <1079474536.3301.2.camel@pegasus>
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
Date: Tue, 16 Mar 2004 23:02:17 +0100

Hi Michal,

> Marcel I looked through code too and haven't seen any bugs too, but it doesn't 
> work as you seen.
> 
> When I try Peter's bthid 0.8 with fake module, everything works perfectly.
> 
> Thats really strange - but I found one thing.
> 
> Starts peter's bthid
> rmmod fake;modprobe uinput;killall bthid
> start yours bthid and keyboard connets 
> stop bthid
> start it again
> keyboard doesn't reconnect
> 
> this happens everytime

maybe this is the disconnect problem with the Microsoft devices. Take
the batteries out and try with my bthid from the beginning.

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
