Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <01b901c41015$1aefb050$b67ba8c0@zaz1>
From: "Xavier Garreau" <x.garreau@prim-time.fr>
To: <mohalik@india.hp.com>
Cc: "BlueZ Mailing List" <bluez-users@lists.sourceforge.net>
References: <405E6C9E.1030600@india.hp.com> <1079937432.2663.78.camel@pegasus>  <405EBCDD.3090402@india.hp.com> <1079951177.2663.90.camel@pegasus> <016701c40ffc$8a07f8d0$b67ba8c0@zaz1> <405EECA6.2080407@india.hp.com>
Subject: Re: [Bluez-users] l2test problem
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
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
Date: Mon, 22 Mar 2004 14:53:50 +0100

> Actually I started with a client on the linux PC and a symbian server
> on the nokia 3650. I used the API's for l2cap sockets and had set the
> psm to 5 (arbitrary choice). Then i got the
>     connection refused(111)
> message from the PC.

> It was now that I wanted to use l2test as a client (just for the
connection part).
> So I changed the psm in l2test.c to 5 and tested. But connection still
gets refused.
> The reason for connect response is always - "psm not supported".

PSM 5 is reserved for Telephony Control Protocol so it can be tricky to
access it.
Use a PSM > 0x1000, odd, and with the least significant bit of the most
significant octet equal to 0.

Also look at the -P param for l2test ;-)

BR,
-- 
Xavier Garreau <x.garreau@prim-time.fr>
Prim'Time Technology
http://www.prim-time.fr/



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
