Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] bthid dies via kernel oops in 2.6.5
From: Marcel Holtmann <marcel@holtmann.org>
To: cijoml@volny.cz
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <200404121854.08693.cijoml@volny.cz>
References: <200404120212.53136.cijoml@volny.cz>
	 <200404121822.44231.cijoml@volny.cz> <1081788433.8634.2.camel@pegasus>
	 <200404121854.08693.cijoml@volny.cz>
Content-Type: text/plain
Message-Id: <1081789919.8634.7.camel@pegasus>
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
Date: Mon, 12 Apr 2004 19:12:00 +0200

Hi Michal,

> > > preempt people told me the same as you :D They told, that this is BT
> > > problem :D But they are possibly right, coz kernel oopses too, when I use
> > > nonpreempt kernel
> >
> > I used preempt for a long time now and it works for me, but looking at
> > the oops this is not a Bluetooth problem. It is the uinput driver that
> > causes the problem.
> 
> Well and who should I ask for fixing? It is too hard to use Linux without 
> console :D

it's the input subsystem, so the right person to ask would be Vojtech
Pavlik.

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
