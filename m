Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] dund never activates pppd
From: Marcel Holtmann <marcel@holtmann.org>
To: Klaus Holst <klaus@encephalon.dk>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <20040224085351.GA3782@encephalon.dk>
References: <20040223213658.GA1453@encephalon.dk>
	 <1077573810.2791.161.camel@pegasus>  <20040224085351.GA3782@encephalon.dk>
Content-Type: text/plain
Message-Id: <1077624875.2880.44.camel@pegasus>
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
Date: Tue, 24 Feb 2004 13:14:36 +0100

Hi Klaus,

> Thanks for the quick reply. I tried to set up bnep0:
>  
> bnep0     Link encap:Ethernet  HWaddr 00:03:C9:2E:6C:F6  
>           inet addr:192.168.0.1  Bcast:192.168.0.255  Mask:255.255.255.0
>           UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
>           RX packets:14 errors:0 dropped:0 overruns:0 frame:0
>           TX packets:10 errors:0 dropped:0 overruns:0 carrier:0
>           collisions:0 txqueuelen:1000 
>           RX bytes:2182 (2.1 Kb)  TX bytes:319 (319.0 b)
> 
> But I am still not able to ping anything from the pocket pc (using vxUtils). The pocket pc
> has been assigned the ip adr:169.254.121.94 and subnet mask: 255.255.0.0 - probably assigned by
> itself because of timeout.

of course you are not able to ping, because your two devices are in
different IP networks. Configure your PDA to assign manually an IP
number or run a DHCP server for bnep0.

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
