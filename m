Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Re: Trouble pairing with new phone...
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <Pine.GSO.4.58.0502091045480.2336@gaia3.cc.gatech.edu>
References: <Pine.GSO.4.58.0502091045480.2336@gaia3.cc.gatech.edu>
Content-Type: text/plain
Message-Id: <1107965937.13863.68.camel@pegasus>
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
Date: Wed, 09 Feb 2005 17:18:57 +0100

Hi Jay,

> When attempting to pair blueZ with the T610 Phone:
> hcidump -x gives:
> HCIDump - HCI packet analyzer ver 1.12
> device: hci0 snap_len: 1028 filter: 0xffffffff
> > HCI Event: Connect Request (0x04) plen 10
>   B2 E6 1D D9 0A 00 04 02 52 01
> < HCI Command: Accept Connection Request (0x01|0x0009) plen 7
>   B2 E6 1D D9 0A 00 00
> > HCI Event: Command Status (0x0f) plen 4
>   00 01 09 04
> > HCI Event: Connect Complete (0x03) plen 11
>   1A 29 00 B2 E6 1D D9 0A 00 01 00

this is unsupported remote feature. What says "hciconfig -a" and
"hcitool info <phone-bdaddr>"? Are you forcing the role switch?

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
