Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Selection of PtP connection type
From: Marcel Holtmann <marcel@holtmann.org>
To: Pavel Ruzicka <pavouk@pavouk.org>
Cc: Simi Winiker <simi@winiker.ch>,
   BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <200402240031.54845.pavouk@pavouk.org>
References: <200402230026.24596.pavouk@pavouk.org>
	 <1077521957.1788.7.camel@kant.winiker.ch>
	 <200402240031.54845.pavouk@pavouk.org>
Content-Type: text/plain
Message-Id: <1077580666.2880.1.camel@pegasus>
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
Date: Tue, 24 Feb 2004 00:57:46 +0100

Hi Pavel,

> I created /etc/sysconfig/network-scripts/ifcfg-bnep0
> -------------------------
> DEVICE=bnep0
> BOOTPROTO=static
> IPADDR=192.168.130.1
> NETMASK=255.255.255.0
> ONBOOT=no
> -------------------------
> When I want to connect, I must run on desktop  "pand -s -rNAP", next run
> "connect" on Zaurus, and next "ifup bnep0" on desktop.
> 
> How can I automate process on desktop side?

you can start pand from an init script. The automatic ifup is specific
to your distribution.

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
