Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] A2DP working :-) , voice not :-(
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <200412010907.09587.mail@sebastian-eichner.de>
References: <200412010839.06669.mailsp@sebastian-eichner.de>
	 <1101887686.18840.38.camel@pegasus>
	 <200412010907.09587.mail@sebastian-eichner.de>
Content-Type: text/plain
Message-Id: <1101889919.18840.40.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Wed, 01 Dec 2004 09:31:59 +0100

Hi Sebastian,

> "hciconfig hci0 revision" gives me:
> 
> hci0:   Type: USB
>         BD Address: 00:0F:B3:17:3E:D0 ACL MTU: 192:8  SCO MTU: 64:8
>         HCI 18.2
>         Chip version: BlueCore02
>         Max key size: 128 bit
>         SCO mapping:  HCI

this should work. Do you enabled CONFIG_BT_HCIUSB_SCO in your kernel?

Regards

Marcel




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
