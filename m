Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Aben Siatris <aben@webcom.sk>
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] No more bluez.o in 2.6?
References: <20040407172325.GC9593@magma.epfl.ch> <200404080948.44365.aben@webcom.sk> <20040408150950.GB5539@magma.epfl.ch>
In-Reply-To: <20040408150950.GB5539@magma.epfl.ch>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200404101743.00181.aben@webcom.sk>
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
Date: Sat, 10 Apr 2004 17:43:00 +0200

> > > pppd[3693]: pppd 2.4.1 started by root, uid 0
> > > pppd[3693]: Using interface ppp0
> > > pppd[3693]: Connect: ppp0 <--> /dev/pts/1
> > > dund[3704]: RFCOMM TTY creation failed. Operation
> > > 
> > > pppd[3693]: LCP: timeout sending Config-Requests 
> >   ^---- same error with mi ipaq :))
> > now i use connect to PAN and all working rights.
> > 
> > # /usr/bin/pand --listen --role NAP
> > - disabled DHCP in iPAQ, using 192.168.20.2 gateway 192.168.20.1
> > - connect (all ok)
> > - on server - ifconfig bnep0 192.168.20.1 netmask 255.255.255.0
> > - now routing and iptables nat :)
> > 
> > all working fine :)
> 
> That's sound great, could you give some more details on what sould be
> done?
> pand --listen --role NAP
> OK
> ifconfig bnep0 192.168.20.1 netmask 255.255.255.0
> SIOCSIFADDR: No such device
> bnep0: unknown interface: No such device
> SIOCSIFNETMASK: No such device
> 
> And I don't have anything in /udev/bnep, how to create it in dev?
> 
> Thank you very much,

ad first, you must make connection.
tip - add ifconfig and iptables to hotplug and
to /etc/init.d/net.bnep0.

tail from /var/messages

Apr 10 17:23:04 gentoo_aben pand[15975]: New connection from 08:00:28:84:C2:E4 bnep0
Apr 10 17:23:04 gentoo_aben default.hotplug[15977]: arguments (net) env (OLDPWD=/ DEVPATH=/class/net/bnep0 PATH=/bin:/sbin:/usr/sbin:/usr/bin ACTION=add PWD=/etc/hotplug HOME=/ SHLVL=2 INTERFACE=bnep0 DEBUG=yes SEQNUM=647 _=/bin/env)
Apr 10 17:23:04 gentoo_aben default.hotplug[15977]: invoke /etc/hotplug/net.agent ()
Apr 10 17:23:04 gentoo_aben net.agent[15977]: script=/etc/init.d/net.bnep0 in action add
Apr 10 17:23:04 gentoo_aben net.agent[15977]: adding bnep0

and now i am in lan and internet with mi ipaq

(sorry for my english :)



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
