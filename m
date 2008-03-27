Return-Path: <cyrus@holtmann.org>
Message-Id: <83810412-22B0-461B-9307-48269B59E8FA@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <BAY118-DAV9D9EC1C84DCF7A987834CC7FE0@phx.gbl>
Mime-Version: 1.0 (Apple Message framework v919.2)
Date: Thu, 27 Mar 2008 15:58:35 +0100
References: <BAY118-DAV9D9EC1C84DCF7A987834CC7FE0@phx.gbl>
Subject: Re: [Bluez-users] sdptool add service
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Hi Chane,

> Do I need to add service manually using sdptool add? I got different
> results using pand and rfcomm listen as servers.
>
> 1. >pand -s -M --role=NAP
> After run the command above, no need to run "sdptool add NAP". The
> service is already registered to sdpd.

the pand will register service records for you. Why are you not using  
the network service?

> 2.>rfcomm listen 1 1
> Need to run sdptool add SP to register SPP service to sdpd.

Yes, you need to register your own service record. However using the  
serial service might be a better idea here.

Regards

Marcel


-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://ad.doubleclick.net/clk;164216239;13503038;w?http://sf.net/marketplace
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
