Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Bluetooth CF card i-Tec
From: Marcel Holtmann <marcel@holtmann.org>
To: Pavel Ruzicka <pavouk@pavouk.org>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <200402151519.55271.pavouk@pavouk.org>
References: <200402151519.55271.pavouk@pavouk.org>
Content-Type: text/plain
Message-Id: <1076855242.14758.46.camel@pegasus>
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
Date: Sun, 15 Feb 2004 15:27:22 +0100

Hi Pavel,

> I was testing other new Bluetooth CF card i-Tec.
> I was discovering, that this card is exactly same like Billionton card.
> 
> This is dump_cis of i-Tec card:
> ---------------------------------------------------------------
>   dev_info
>     no_info
>   vers_1 7.1, "Compact Flash", "Bluetooth Card", "", ""
>   manfid 0x022d, 0x2000
>   funcid serial_port
>   serial_interface
>     uart 16550 [space/mark/odd/even] [5/6/7/8] [1/1.5/2]
>   config base 0x00f8 mask 0x000f last_index 0x03
>   cftable_entry 0x01 [default]
>     [rdybsy] [audio] [pwrdown]
>     Vcc Vnom 3300mV Vmin 3V Vmax 3600mV Iavg 300mA
>     Ipeak 300mA Idown 10mA
>     io 0x02f8-0x02ff [lines=3] [8bit] [range]
>     irq mask 0x86bc [level] [pulse] [shared]
>   cftable_entry 0x02
>     io 0x03e8-0x03ef [lines=3] [8bit] [range]
>   cftable_entry 0x03
>     io 0x02e8-0x02ef [lines=3] [8bit] [range]
> ------------------------------------------------------------------

this card is a serial card and so it should be recognized by the
serial_cs driver and you should get another ttySx device. These device
must be attached with hciattach to the Bluetooth core. The problem is to
know what option you have to use for hciattach. This actually depends on
what Bluetooth chip is on your card and what transport protocol and
default baud rate it uses.

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
