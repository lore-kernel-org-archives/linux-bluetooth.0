Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] BT programming
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <E73D9A5BC4A2D711BBC600065BF3595F1C66CF8C@il06exm10>
References: <E73D9A5BC4A2D711BBC600065BF3595F1C66CF8C@il06exm10>
Content-Type: text/plain
Message-Id: <1107992601.13863.99.camel@pegasus>
Mime-Version: 1.0
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
Date: Thu, 10 Feb 2005 00:43:21 +0100

Hi Hiren,

> I'm a newbie to BT programming. I have successfully installed my BT 
> hardware device using BlueZ packages. As a next goal I need to write my own code for simple applications like Chat and/or PIM Item Transfer based profile. Does blueZ have implemented profiles like OBEX, DUN, etc that I can use?

the profiles are implemented in applications. Either you find a
application that fits your needs or you have to write one. Be more
specific about what profiles and what roles do you wanna support.

> Also when I'm trying to connect to a particular remote BT device using  
> hcitool cc .. it does not work..no connection is established.. any idea why is that happening?

Check with "hcidump -X" what's the error code, but as I always say there
is no need to establish an ACL link by hand. The kernel core will do it
when one is needed.

Regards

Marcel




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
