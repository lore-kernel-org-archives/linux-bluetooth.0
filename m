Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] bluez and billionton pcbtc1
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <b5c638dc05032907582bf771dc@mail.gmail.com>
References: <b5c638dc05032815321b2739c5@mail.gmail.com>
	 <1112075117.9016.60.camel@pegasus>
	 <b5c638dc05032907582bf771dc@mail.gmail.com>
Content-Type: text/plain
Message-Id: <1112114217.9016.92.camel@pegasus>
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
Date: Tue, 29 Mar 2005 18:36:57 +0200

Hi David,

> hey thanks for the quick reply.. 
> i have no clue what i'm doing :) but 
> here is the dump_cis result, hope it helps,:
> 
> Socket 0:
>   dev_info
>     NULL 0ns, 512b
>   manfid 0x0279, 0x950b
>   funcid serial_port [post]
>   serial_interface
>     uart 16550 [space/mark/odd/even] [5/6/7/8] [1/1.5/2]
>   vers_1 7.1, "PCMCIA", "Bluetooth Card", "", ""
>   config base 0x00f8 mask 0x000f last_index 0x04
>   cftable_entry 0x01 [default]
>     [rdybsy]
>     Vcc Vnom 3300mV
>     io 0x03f8-0x0407 [lines=8] [8bit] [range]
>     irq mask 0xffff [level] [shared]
>   cftable_entry 0x02
>     io 0x0000-0x7fff [lines=15] [8bit]

so it is a serial based card. If you call dmesg, do you see something
about a new ttyS device when you insert the card?

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
