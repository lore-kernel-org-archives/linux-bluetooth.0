Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] RFCOMM Device
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <d1f423d3050226200521a6d7a@mail.gmail.com>
References: <d1f423d3050226200521a6d7a@mail.gmail.com>
Content-Type: text/plain
Message-Id: <1109578219.17256.5.camel@pegasus>
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
Date: Mon, 28 Feb 2005 09:10:19 +0100

Hi Anderson,

> I am new with Bluez  and I trying to set up a rfcomm device but the
> /dev/rfcomm0 is not being created or does not exist.
> 
> # rfcomm bind 0 aa:aa:aa:aa:aa 1 (works)
> #rfcomm
> rfcomm0: aa:aa:aa:aa:aa clean (is it right?)

it must be "rfcomm0: aa:aa:aa:aa:aa channel 1 clean", but yes that is
right.

> but when i try to use pppd it does not work, it does not recognize the
> /dev/rfcomm0

Check if /dev/rfcomm0 exists and if not install udev or create it by
hand.

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
