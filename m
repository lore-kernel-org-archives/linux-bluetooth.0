Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Timeout message from kernel
From: Marcel Holtmann <marcel@holtmann.org>
To: Jeff Sutherland <jeffs@fairwayacademy.org>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <200402131023.03974.jeffs@fairwayacademy.org>
References: <200402121636.02074.jeffs@fairwayacademy.org>
	 <200402130917.46561.jeffs@fairwayacademy.org>
	 <1076682121.2671.53.camel@pegasus>
	 <200402131023.03974.jeffs@fairwayacademy.org>
Content-Type: text/plain
Message-Id: <1076686120.2671.83.camel@pegasus>
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
Date: Fri, 13 Feb 2004 16:28:40 +0100

Hi Jeff,

> > Using l2test is easy and with -h you see all the options ;)
> >
> > 	One side:	l2test -r	/* listen and receive */
> > 	Other side:	l2test -s	/* connect and send */
> 
> Hmmm...
> [root@Arwen test]# ./l2test -w
> l2test[29184]: Waiting for connection on psm 10 ...
> 
> /bin> l2test -r
> l2test[79]: Waiting for connection on psm 10 ...

why don't you try what I have written? And read what "l2test -h" says.

	l2test -r	/* listen and receive */
	l2test -w	/* listen and send */

Two connections that are listening. How should they connect to each
other?

> Note that from ColdFire, this fails:
> /bin> hcitool cc --role=s 00:0A:4F:00:09:5E
> bcsp_timed_event: Timeout, retransmitting 1 pkts
> Can't create connection: Input/output error
> 
> /bin> hcitool con
> Connections:
> 
> But from the pc, I get this:
> [root@Arwen test]# hcitool cc --role=m 00:0A:4F:00:13:5F
> Can't create connection: Connection timed out
> 
> But now running 'hcitool con' on Coldfire gives this:
> /bin> hcitool con
> Connections:
>         > ACL 00:0A:4F:00:09:5E handle 40 state 1 lm SLAVE
> 
> and from the pc:
> [root@Arwen test]# hcitool con
> Connections:
>         < ACL 00:0A:4F:00:13:5F handle 41 state 1 lm MASTER
> 
> So it seems that hcitool <> hcid, or userland <> kernel is messed up on 
> ColdFire, is that correct?  Remember I'm still a newbie at this...

Maybe this is a role switch problem. Show us both outputs from
"hciconfig -a".

Regards

Marcel




-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
