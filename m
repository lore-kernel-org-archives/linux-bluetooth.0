Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Pavel Ruzicka <pavouk@pavouk.org>
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] IP address
References: <20050208134358.17173.qmail@web53202.mail.yahoo.com> <1107880993.7327.190.camel@pegasus> <008901c50f7e$eccd4a60$7aac623e@pc>
In-Reply-To: <008901c50f7e$eccd4a60$7aac623e@pc>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200502101916.14086.pavouk@pavouk.org>
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Thu, 10 Feb 2005 19:16:13 +0100

Hi,

> Is it possible to assign the ip-address to each laptop/dongle before
> creating connections?

I depends on distribution.
In Mandrake, Redhat and maybe others you can preconfigure parameters for first 
bnep interface in file:
/etc/sysconfig/network-scripts/ifcfg-bnep0
File looks like this:
-----
DEVICE=bnep0
BOOTPROTO=static
IPADDR=192.168.100.1
NETMASK=255.255.255.252
ONBOOT=no
-----

bnep1 can look like this:
-----
DEVICE=bnep1
BOOTPROTO=static
IPADDR=192.168.100.5
NETMASK=255.255.255.252
ONBOOT=no
-----

This is example for configuring many Point-to-Point BNEP connections.
IP 1 with 2, 5 with 6 etc...
You must have enabled routing in kernel.
For automatic enabling/disabling you must have functional hotplug.

If you want LAN with one big address space like 192.168.1.0
with mask 255.255.255.0, you must run bridge on your machine.

Some documentation is here:
http://bluez.sourceforge.net/contrib/HOWTO-PAN

Best regards,

Pavel Ruzicka


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
