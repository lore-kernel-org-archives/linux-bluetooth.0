Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Gregoire Favre <Gregoire.Favre@freesurf.ch>
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] No more bluez.o in 2.6?
Message-ID: <20040409124008.GA29582@magma.epfl.ch>
References: <20040407172325.GC9593@magma.epfl.ch> <20040407214322.GA14396@magma.epfl.ch> <1081417632.2970.0.camel@pegasus> <20040408150029.GA5539@magma.epfl.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <20040408150029.GA5539@magma.epfl.ch>
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
Date: Fri, 9 Apr 2004 14:40:08 +0200

On Thu, Apr 08, 2004 at 05:00:29PM +0200, Gregoire Favre wrote:
> Now, some kernels recompilation later, I still have a problem which I
> don't know how to solve:
>=20
> dund[3539]: DUN daemon ver 1.1
> dund[3554]: New connection from 00:...
> pppd[3561]: pppd 2.4.1 started by root, uid 0
> pppd[3561]: Using interface ppp0
> pppd[3561]: Connect: ppp0 <--> /dev/rfcomm0
> pppd[3561]: Cannot determine ethernet address for proxy ARP
> pppd[3561]: local  IP address 192.168.1.2
> pppd[3561]: remote IP address 172.31.130.67
> pppd[3561]: IPCP terminated by peer
> pppd[3561]: Hangup (SIGHUP)
> pppd[3561]: Modem hangup
> pppd[3561]: Connection terminated.
> pppd[3561]: Connect time 0.8 minutes.
> pppd[3561]: Sent 571 bytes, received 322 bytes.
> pppd[3561]: Exit.

> ...

> http://www-jcsu.jesus.cam.ac.uk/~ned21/tech/tungsten_linux.html

Just beacuse someone could have the same problem I did have: I just
commented out the proxyarp option in peers/dun and my palm was able to
try to connect to my linux box over ssh (without success due to my ssh2
or??? but I can see the try to connect on my logs in the linux box) :-)

Sorry for all my emails and thank for all who contributed in BlueZ !!!

	Gr=E9goire
_________________________________________________________________________=
_
http://algebra.epfl.ch/greg ICQ:16624071 mailto:Gregoire.Favre@freesurf.c=
h


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
