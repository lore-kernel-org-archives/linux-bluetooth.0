Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] connection timeout after interrupted software
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <20050209014831.GA12067@cirrus.madduck.net>
References: <20050208143303.GA5194@cirrus.madduck.net>
	 <1107880590.7327.180.camel@pegasus>
	 <20050209014831.GA12067@cirrus.madduck.net>
Content-Type: text/plain
Message-Id: <1107930446.14624.6.camel@pegasus>
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
Date: Wed, 09 Feb 2005 07:27:26 +0100

Hi Martin,

> first of all, sorry for sending an incomplete report. anyway,
> i don't think i can provide more information this time...
> 
> also sprach Marcel Holtmann <marcel@holtmann.org> [2005.02.08.1736 +0100]:
> > the shouldn't be any problems, but anyway what kernel version is this
> 
> 2.6.10-1-686 (Debian)
> 
> > and what does hciconfig show after you discover this problem.
> 
> looks good, the same as before
> 
> hci0: Type: USB
>   BD Address: 08:00:17:1D:32:4D ACL MTU: 339:4  SCO MTU: 60:9
>   UP RUNNING PSCAN ISCAN 
>   RX bytes:7621 acl:167 sco:0 events:119 errors:0
>   TX bytes:2823 acl:118 sco:0 commands:30 errors:0
>   Features: 0xff 0x3b 0x05 0x00 0x00 0x00 0x00 0x00
>   Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3 
>   Link policy: HOLD SNIFF PARK 
>   Link mode: SLAVE ACCEPT 
>   Name: 'cirrus'
>   Class: 0xf20100
>   Service Classes: Networking, Object Transfer, Audio, Telephony, Information
>   Device Class: Computer, Uncategorized
>   HCI Ver: 1.1 (0x1) HCI Rev: 0x180 LMP Ver: 1.1 (0x1) LMP Subver: 0x180
>   Manufacturer: RTX Telecom A/S (21)
> 
> > Are there any other information in dmesg or the logfiles?
> 
> no, nothing there...

make sure that you activate the rswitch for the link policy. You can
also try to load hci_usb with reset=1 if available.

What kind of dongle is this? Is it already in my list?

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
