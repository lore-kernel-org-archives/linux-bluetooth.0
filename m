Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: Re3: [Bluez-users] Can l2ping phone but can't `sdptool browse`
	or
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <1101073449.41a10c2976047@www.bluebottle.com>
References: <1101073449.41a10c2976047@www.bluebottle.com>
Content-Type: text/plain
Message-Id: <1101075279.7250.80.camel@pegasus>
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
Date: Sun, 21 Nov 2004 23:14:38 +0100

Hi,

> root@betty.net[~] # uname -a 
> Linux betty 2.6.5 #6 Tue Jun 1 17:11:14 GMT 2004 i686 Intel(R)
> Celeron(TM) CPU                1000MHz GenuineIntel GNU/Linux
> root@betty.net[~] #

update to a 2.6.10-rc2 or 2.6.9-mh4 kernel.

> root@betty.net[~] # hciconfig -a
> hci0:   Type: USB
>         BD Address: 00:0C:41:E2:0D:BE ACL MTU: 192:8  SCO MTU: 64:8
>         UP RUNNING PSCAN ISCAN 
>         RX bytes:368202 acl:23542 sco:0 events:3232 errors:0
>         TX bytes:100964 acl:2584 sco:0 commands:335 errors:0
>         Features: 0xff 0xff 0x0f 0x00 0x00 0x00 0x00 0x00
>         Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3 
>         Link policy: RSWITCH HOLD SNIFF PARK 
>         Link mode: SLAVE ACCEPT 
>         Name: 'Ethel-Linux (0)'
>         Class: 0x100100
>         Service Classes: Object Transfer
>         Device Class: Computer, Uncategorized
>         HCI Ver: 1.1 (0x1) HCI Rev: 0x20d LMP Ver: 1.1 (0x1) LMP
> Subver: 0x20d
>         Manufacturer: Cambridge Silicon Radio (10)

This device should work without any problems.

> root@betty.net[~] # emerge -s bluez
> Searching...   
> [ Results for search key : bluez ]
> [ Applications found : 9 ]
>  
> *  net-wireless/bluez-bluefw
>       Latest version available: 1.0
>       Latest version installed: 1.0
>       Size of downloaded files: 135 kB
>       Homepage:    http://bluez.sourceforge.net/
>       Description: Bluetooth USB Firmware Downloader
>       License:     GPL-2

Not needed and it is replaced with a kernel module anyway.

> *  net-wireless/bluez-hciemu
>       Latest version available: 1.0
>       Latest version installed: 1.0
>       Size of downloaded files: 144 kB
>       Homepage:    http://bluez.sourceforge.net/
>       Description: bluetooth HCI emulator
>       License:     GPL-2

You don't need this.

> *  net-wireless/bluez-kernel
>       Latest version available: 2.3
>       Latest version installed: 2.3
>       Size of downloaded files: 169 kB
>       Homepage:    http://bluez.sourceforge.net/
>       Description: bluetooth kernel drivers
>       License:     GPL-2

Don't install such package. Always use the latest kernel.

> *  net-wireless/bluez-sdp [ Masked ]
>       Latest version available: 1.5
>       Latest version installed: 1.5
>       Size of downloaded files: 240 kB
>       Homepage:    http://bluez.sourceforge.net/
>       Description: bluetooth service discovery protocol (sdp)
> utilities
>       License:     GPL-2

Don't install this one. It is deprecated.

Regards

Marcel




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
