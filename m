Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] bluez pan problem
From: Marcel Holtmann <marcel@holtmann.org>
To: Ronan Naughton <wadgienaughton@hotmail.com>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <BAY10-F1216PYzDabig00010bb6@hotmail.com>
References: <BAY10-F1216PYzDabig00010bb6@hotmail.com>
Content-Type: text/plain
Message-Id: <1078765164.10671.11.camel@pegasus>
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
Date: Mon, 08 Mar 2004 17:59:24 +0100

Hi Ronan,

> I am having a problem with setting up a bluez pan between three machines and 
> i don't know what I'm doing wrong.
> 
> I set one node ( say B )the GN to listen
> 
>                                            pand --listen --master --role GN
> 
> 
> I then connect  the other two nodes ( A & C )
> 
>                                           pand --connect  mac_addr_of_master
> 
> 
> I then assign an ip address to A, C and then the master B:
> 
>                                            ifconfig bnep0 10.0.0.1
>                                            ifconfig bnep0 10.0.0.3
>                                            ifconfig bnep0 10.0.0.2
> 
> 
> Then for some reason:
> The first pc (10.0.0.1) can ping the other PANU and the GN
> The second pc (10.0.0.3) cannot ping the other PANU or the GN
> The GN (10.0.0.2 ) can only ping the second pc (10.0.0.3)

from your setup the master must be have to BNEP connection bnep0 and
bnep1. You must bring both up and assign an IP to them. Actually you
will ran into problems with PANU to PANU connections over the GN. I
propose that you build a bridge above every bnepX connection on the
master. See the PAN HOWTO and the mailing list archive for more details.

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
