Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] rfcomm gives "no route to host"
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <4237F5CE.7030602@carmedialab.de>
References: <4237F5CE.7030602@carmedialab.de>
Content-Type: text/plain
Message-Id: <1110965630.9818.84.camel@pegasus>
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
Date: Wed, 16 Mar 2005 10:33:50 +0100

Hi Marcus,

> I got an embedded system using the Infineon Singlestone Bluemoon Module 
> connected over UART. I can successfully start the device and scan for 
> remote devices. I want to start rfcomm to provide a basic serial service 
>   but probably I'm missing something to be successfull.
> Kernel 2.4.19 (cannot be changed, cause it's a special port for the 
> tricore 1130 microcontroller)
> BLueZ Patch patch-2.4.19-mh18
> Bluetooth support compiled in the kernel(no modules)
> <*> Bluetooth subsystem support
> <*> L2CAP protocol support
> < > SCO links support
> <*> RFCOMM protocol support
> [*]   RFCOMM TTY support
> <*> BNEP protocol support
> [ ]   Multicast filter support
> [ ]   Protocol filter support
> Bluetooth device drivers  --->
> 	<*> HCI UART driver
> 	[*]   UART (H4) protocol support
> 	[ ]   BCSP protocol support
> 	< > HCI VHCI (Virtual HCI device) driver
> 
> ---------- dmesg-output -------------------
> ...
> BlueZ HCI UART driver ver 2.1 Copyright (C) 2000,2001 Qualcomm Inc
> Written 2000,2001 by Maxim Krasnyansky <maxk@qualcomm.com>
> TriCore ASC driver version 0.03-std
> ...
> .p_tables: (C) 2000-2002 Netfilter core team
> NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
> BlueZ L2CAP ver 2.3 Copyright (C) 2000,2001 Qualcomm Inc
> Written 2000,2001 by Maxim Krasnyansky <maxk@qualcomm.com>
> BlueZ RFCOMM ver 1.1
> Copyright (C) 2002 Maxim Krasnyansky <maxk@qualcomm.com>
> Copyright (C) 2002 Marcel Holtmann <marcel@holtmann.org>
> BlueZ BNEP ver 1.2
> Copyright (C) 2001,2002 Inventel Systemes
> Written 2001,2002 by Clement Moreau <clement.moreau@inventel.fr>
> Written 2001,2002 by David Libault <david.libault@inventel.fr>
> Copyright (C) 2002 Maxim Krasnyanskiy <maxk@qualcomm.com>
> Looking up port of RPC 100003/2 on 10.0.0.40.......
> --------------------------------------------
> bash-2.05a# ps -ef
>    PID  Uid     Stat Command
> ...
>     32 root     S    hcid: processing events
>     36 root     S    /sbin/hciattach -p -b -s 115200 /dev/tts/2 any 
> 115200 noflow
> ...
> bash-2.05a# hciconfig
> hci0:   Type: UART
>          BD Address: 00:80:37:25:B7:DB ACL MTU: 339:7 SCO MTU: 120:6
>          UP RUNNING PSCAN ISCAN
>          RX bytes:682 acl:0 sco:0 events:20 errors:0
>          TX bytes:345 acl:0 sco:0 commands:15 errors:0
> 
> bash-2.05a# hcitool scan
> Scanning ...
>          00:0F:B3:4D:B8:A9       MIKOBOOK
>          00:10:60:A4:59:C9       PC-28
> bash-2.05a# rfcomm show
> bash-2.05a# rfcomm bind 0
> bash-2.05a# rfcomm show
> rfcomm0: 00:80:37:25:B7:DB channel 1 clean
> bash-2.05a# cat /dev/bluetooth/rfcomm/0
> cat: /dev/bluetooth/rfcomm/0: No route to host
> bash-2.05a# echo "Hello World" > /dev/bluetooth/rfcomm/0
> bash: /dev/bluetooth/rfcomm/0: No route to host
> bash-2.05a# rfcomm connect 0 00:80:37:25:B7:DB 1
> Can't connect RFCOMM socket: No route to host
> bash-2.05a# rfcomm connect 0
> Can't connect RFCOMM socket: No route to host

you can't connect to yourself. This is not possible with Bluetooth.

	src = 00:80:37:25:B7:DB	(hci0)
	dst = 00:80:37:25:B7:DB (rfcomm0)

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
