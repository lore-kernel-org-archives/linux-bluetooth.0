Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] help for bluez and bridge configuration needed
From: Marcel Holtmann <marcel@holtmann.org>
To: Paulo Marques <pmarques@grupopie.com>
Cc: theo.beisch@gmx.de, BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <3F82A016.2050901@grupopie.com>
References: <200310062337.37090.root <>>  <3F82A016.2050901@grupopie.com>
Content-Type: text/plain
Message-Id: <1065526456.5327.45.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: 07 Oct 2003 13:34:10 +0200

Hi,

> The problem is that when the bnep0 interface enters the bridge, the bridge's 
> "mac address" changes. You can see that happening doing a "ifconfig pan0" before 
> the bnep0 joining the bridge and after, to see the hardware address of the pan0 
> interface.
> 
> I tried to solve this by issuing "arping's" so that other machines on the 
> network would be warned about the new hardware address, but unfortunately never 
> got this to work properly... :(

I never put the eth0 into the bridge ;) You can use IP forwarding and
NAT between eth0 und pan0.

Regards

Marcel




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
