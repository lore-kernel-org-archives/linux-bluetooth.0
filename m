Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Is briding necessary?
From: Marcel Holtmann <marcel@holtmann.org>
To: Tuomo Tikkanen <Tuomo.Tikkanen@nokia.com>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <405722BE.4040306@nokia.com>
References: <405722BE.4040306@nokia.com>
Content-Type: text/plain
Message-Id: <1079453133.3307.113.camel@pegasus>
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
Date: Tue, 16 Mar 2004 17:05:33 +0100

Hi Tuomo,

> We have a Linux application which captures IP packets from given network 
> interface. Our current configuration is such that we have a bridge (br0) 
> containing eth1 and bnep0 interfaces and its working wonderfully.
> 
> However we would like to have only bnep0 interface so that there would 
> not be need for eth1 device. We have tried to use this bnep0-only 
> approach, but it is not working properly. What we see is:
> 
> 1) PAN connection itself is successfully established
> 2) bnep0 interface is up
> 3) we can ping from mobile phone (device connected with PAN to Linux), 
> but we don't get replies back to mobile phone. We see though that ping 
> packets flow through our software to both directions i.e. ping-replies 
> are written to bnep0 too.
> 4) the state 3) stays there until we ping/traceroute the mobile phone 
> from the machine where the bnep0 interface is. After ping/traceroute 
> command the reply-ping packets start to flow to mobile phone too.
> 
> This is rather odd behavior and because we are not expert of PAN nor 
> Bluez we are wondering what could reason for above behavior. With 
> "bridge solution" there is no need to poll back the mobile connected via 
> bnep0/br0 instead everything works just fine after the bluetooth 
> connection is established. Can the bnep0 interface be actually used 
> instead of eth# or br# interface at all?

actually the bridge should only be needed in the case you have multiple
bnepX interfaces. For example on an access point. The bnepX interface is
a full virtual network card and you can expect the same behaviour like
eth0. However you need to activate IP forwarding if you want to share
your IP packets between different network cards. Check your settings,
because maybe also netfilter (firewall etc.) is involved in your setup.

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
