Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] l2test problem
From: Marcel Holtmann <marcel@holtmann.org>
To: mohalik@india.hp.com
Cc: Xavier Garreau <x.garreau@prim-time.fr>,
   BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <405EECA6.2080407@india.hp.com>
References: <405E6C9E.1030600@india.hp.com>
	 <1079937432.2663.78.camel@pegasus>  <405EBCDD.3090402@india.hp.com>
	 <1079951177.2663.90.camel@pegasus> <016701c40ffc$8a07f8d0$b67ba8c0@zaz1>
	 <405EECA6.2080407@india.hp.com>
Content-Type: text/plain
Message-Id: <1079965396.2663.276.camel@pegasus>
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
Date: Mon, 22 Mar 2004 15:23:16 +0100

Hi Swarup,

> Actually I started with a client on the linux PC and a symbian server
> on the nokia 3650. I used the API's for l2cap sockets and had set the 
> psm to 5 (arbitrary choice). Then i got the 
>     connection refused(111) 
> message from the PC.
> 
> It was now that I wanted to use l2test as a client (just for the
> connection part).
> So I changed the psm in l2test.c to 5 and tested. But connection still
> gets refused.
> The reason for connect response is always - "psm not supported".
> 
> Does this mean that the nokia device may not have l2cap socket
> support?
> I did not find any such information though on the web.

you must use a PSM > 0x1000, so PSM 4097 is the first usable choise and
of course your application on the Symbian must listen on that PSM for
incoming connection. From what your hcidump shows is that the problem is
on the phone side and so a problem of your symbian server code.

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
