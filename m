Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] pan drouble
From: Marcel Holtmann <marcel@holtmann.org>
To: patrick.steiner@bigfoot.com
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <1081199856.7860.3.camel@tux4u.skynet>
References: <1081199856.7860.3.camel@tux4u.skynet>
Content-Type: text/plain
Message-Id: <1081204891.17215.3.camel@pegasus>
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
Date: Tue, 06 Apr 2004 00:41:31 +0200

Hi Patrick,

> i want to connect my 2 linux boxes via pan. i have set up an master pand
> with the command.
> 
> pand --listen --role NAP
> 
> and then i tryed to connect with my second device. with the following
> command:
> 
> pand --role PANU --connect 00:60:57:0B:EE:6D
> 
> but i alway get this error:
> 
> Apr  5 23:06:38 tux4u pand[7221]: PAN daemon ver 1.1
> Apr  5 23:06:38 tux4u pand[7221]: Connecting to 00:60:57:0B:EE:6D
> Apr  5 23:06:38 tux4u pand[7221]: Connect to 00:60:57:0B:EE:6D failed.
> File exists(17)
> 
> if i start the pand on the other device it works :-( have anyone ah idea
> what the problem?

have you tried it without giving the --role parameter? The error you get
is a kernel error while adding the bnepX interface and it already has a
session for that device.

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
