Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Re: bluetooth 1.2 - how do I know it's working?
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <pan.2005.04.13.19.52.58.815123@wingnet.net>
References: <pan.2005.04.13.14.52.16.599459@wingnet.net>
	 <1113405322.9061.36.camel@pegasus>
	 <pan.2005.04.13.19.52.58.815123@wingnet.net>
Content-Type: text/plain
Message-Id: <1113423981.15359.0.camel@pegasus>
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
Date: Wed, 13 Apr 2005 22:26:21 +0200

Hi Jesse,

> >> # hcitool afh 00:0D:44:36:E6:F4
> >> AFH map: 0xffffffffffffffffff7f
> >> 
> >> Does this indicate that both devices are using AFH correctly?
> > 
> > monitor the "hcitool afh" call and if the value changes then AFH is
> > working.
> 
> No, they don't change. Even after a reboot it yields the same result.
> 
> What should I do to get it working?

it is working, but you need to get heavy data transmission on your
wireless LAN and place the two devices near by.

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
