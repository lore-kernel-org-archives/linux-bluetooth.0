Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] problem with hstest
From: Marcel Holtmann <marcel@holtmann.org>
To: Mr Jie Liu <s4048156@student.uq.edu.au>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <2260c2221e01.221e012260c2@uq.edu.au>
References: <2260c2221e01.221e012260c2@uq.edu.au>
Content-Type: text/plain
Message-Id: <1084875050.5833.84.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Tue, 18 May 2004 12:10:50 +0200

Hi,

>   I am using Anycom's USB 220 and it is not based on CSR chip. Here is the device information of it on my computer:
> [root@tom sbin]# ./hciconfig hci0 version
> hci0:   Type: USB
>         BD Address: 00:0B:0D:21:9E:81 ACL MTU: 339:4  SCO MTU: 64:0
>         HCI Ver: 1.1 (0x1) HCI Rev: 0x93 LMP Ver: 1.1 (0x1) LMP Subver: 0x93
>         Manufacturer: Transilica, Inc. (24)
> [root@tom sbin]# ./hciconfig hci0 features
> hci0:   Type: USB
>         BD Address: 00:0B:0D:21:9E:81 ACL MTU: 339:4  SCO MTU: 64:0
>         Features: 0xff 0xff 0x3d 0x00
>                 <3-slot packets> <5-slot packets> <encryption> <slot offset>
>                 <timing accuracy> <role switch> <hold mode> <sniff mode>
>                 <park mode> <RSSI> <channel quality> <SCO link>
>                 <HV2 packets> <HV3 packets> <u-law log> <A-law log>
>                 <CVSD> <power control> <transparent SCO>
> [root@tom sbin]# ./hciconfig hci0 revision
> hci0:   Type: USB
>         BD Address: 00:0B:0D:21:9E:81 ACL MTU: 339:4  SCO MTU: 64:0
>         Unsupported manufacturer
> 
> Is there any other way I could figure out if the sco packets are routed through HCI or PCM interface? Can I trace it by hcidump?

I don't have any detailed information about the Transilica chip. Run
"hcidump -x" as root and if you see SCO packets then this dongles routes
the SCO data over HCI, otherwise it goes over the PCM.

And btw. do you activated the HCIUSB_SCO kernel option and do this
dongle really have the needed ISOC interface? You must check the content
of /proc/bus/usb/devices.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by: SourceForge.net Broadband
Sign-up now for SourceForge Broadband and get the fastest
6.0/768 connection for only $19.95/mo for the first 3 months!
http://ads.osdn.com/?ad_id=2562&alloc_id=6184&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
