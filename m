Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Timeout message from kernel
From: Marcel Holtmann <marcel@holtmann.org>
To: Jeff Sutherland <jeffs@fairwayacademy.org>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <200402121636.02074.jeffs@fairwayacademy.org>
References: <200402121636.02074.jeffs@fairwayacademy.org>
Content-Type: text/plain
Message-Id: <1076631244.2671.16.camel@pegasus>
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
Date: Fri, 13 Feb 2004 01:14:04 +0100

Hi Jeff,

> Some newbie bluetooth questions: I'm running the latest bluez-utils on a 
> 2.4.24 uClinx kernel on a Moto ColdFire 5282 processor.  It's sort of 
> working, but having a bit of trouble trying to connect between a brain box 
> serial dongle on the ColdFire board and a brainbox usb dongle on a pc.  
> 'hcitool info from the pc yields:
> 
> [root@Arwen bluetooth]# hcitool info 00:0A:4F:00:13:5F
> Requesting information ...
>         BD Address:  00:0A:4F:00:13:5F
>         Device Name: BlueZ (0)
>         LMP Version: 1.1 (0x1) LMP Subversion: 0x175
>         Manufacturer: Cambridge Silicon Radio (10)
>         Features: 0xff 0xff 0x0f 0x00 0x00 0x00 0x00 0x00
>                 <3-slot packets> <5-slot packets> <encryption> <slot offset>
>                 <timing accuracy> <role switch> <hold mode> <sniff mode>
>                 <park state> <RSSI> <channel quality> <SCO link>
>                 <HV2 packets> <HV3 packets> <u-law log> <A-law log>
>                 <CVSD> <paging scheme> <power control> <transparent SCO>
> 
> so it looks like the ColdFire dongle is alive and responding to the pc.  A 
> 'hcitool scan' from the ColdFire board yields:
> 
> /> hcitool scan
> Scanning ...
> bcsp_timed_event: Timeout, retransmitting 1 pkts
> bcsp_timed_event: Timeout, retransmitting 1 pkts
> bcsp_timed_event: Timeout, retransmitting 1 pkts

you can ignore these messages, because they are no errors.

> and hcitool info on the ColdFire board yields:
> 
> /> hcitool info 00:0A:4F:00:09:5E
> Requesting information ...
> bcsp_timed_event: Timeout, retransmitting 1 pkts
> Can't create connection: Input/output error

This can mean many things. Try using l2ping or l2test. Can you run
hcidump on the ColdFire board?

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
