Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Aben Siatris <aben@webcom.sk>
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] No more bluez.o in 2.6?
References: <20040407172325.GC9593@magma.epfl.ch> <20040407214322.GA14396@magma.epfl.ch>
In-Reply-To: <20040407214322.GA14396@magma.epfl.ch>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200404080948.44365.aben@webcom.sk>
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
Date: Thu, 8 Apr 2004 09:48:44 +0200

D=C5=88a Wednesday 07 April 2004 23:43 Gregoire Favre nap=C3=ADsal:
> Hello again,
>=20
> I compiled 2.6.5-mm2 again, with all blutooth in, and now I can see my
> bluetooth device ;-) I can also scan my Palm device.
> I try http://www-jcsu.jesus.cam.ac.uk/~ned21/tech/tungsten_linux.html
> and after dund --listen --persist --msdun call dun
> I got the following error when I try to connect:
> dund[3647]: RFCOMM TTY creation failed. Operation not supported(95)
>=20
> If I lauch pppd before trying to connect:
>=20
> pppd[3693]: pppd 2.4.1 started by root, uid 0
> pppd[3693]: Using interface ppp0
> pppd[3693]: Connect: ppp0 <--> /dev/pts/1
> dund[3704]: RFCOMM TTY creation failed. Operation
>=20
> pppd[3693]: LCP: timeout sending Config-Requests=20
  ^---- same error with mi ipaq :))
now i use connect to PAN and all working rights.

# /usr/bin/pand --listen --role NAP
=2D disabled DHCP in iPAQ, using 192.168.20.2 gateway 192.168.20.1
=2D connect (all ok)
=2D on server - ifconfig bnep0 192.168.20.1 netmask 255.255.255.0
=2D now routing and iptables nat :)

all working fine :)


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
