Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] piconet..
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <016d01c4df70$a8e297d0$6401000a@zool>
References: <00c901c4df6a$f8c11f70$6401000a@zool>
	 <1102764489.19086.15.camel@pegasus>  <016d01c4df70$a8e297d0$6401000a@zool>
Content-Type: text/plain
Message-Id: <1102767035.19086.18.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Sat, 11 Dec 2004 13:10:35 +0100

Hi Steffen,

> > > PS. I belive that the PSM in the L2CAP layer can serve more than one
> > > client or am I totally wrong? otherwise I should update the PSM
> > > everytime a new client connect..
> > 
> > It can also serve multiple PSM on the same ACL link.
> 
> Ok.. how do I do that?
> 
> Currently I am setting the PSM on my socket like this:
> 
> <code snip>
> loc_addr.l2_family = AF_BLUETOOTH;
> 
> bacpy(&loc_addr.l2_bdaddr, local_bdaddr);
> 
> loc_addr.l2_psm = htobs(psm);
> 
> 
> if (bind(sk, (struct sockaddr *) &loc_addr, sizeof(loc_addr)) < 0) {
> 
> printf("could not bind socket: %i\n", sk);
> 
> syslog(LOG_ERR, "Can't bind socket. %s(%d)", strerror(errno), errno);
> 
> exit(1);
> 
> }
> 
> </code snip>

you call listen() and then accept() for every incoming connection. It is
the same as for TCP/IP.

Regards

Marcel




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
