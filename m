Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] lmx9814
From: Marcel Holtmann <marcel@holtmann.org>
To: Philip Blundell <pb@nexus.co.uk>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1076869842.23437.75.camel@dixie.nexus.co.uk>
References: <1076864335.23437.70.camel@dixie.nexus.co.uk>
	 <1076865499.2840.8.camel@pegasus>
	 <1076865675.23437.73.camel@dixie.nexus.co.uk>
	 <1076866147.2840.11.camel@pegasus>
	 <1076869842.23437.75.camel@dixie.nexus.co.uk>
Content-Type: text/plain
Message-Id: <1076870730.2840.25.camel@pegasus>
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
Date: Sun, 15 Feb 2004 19:45:30 +0100

Hi Philip,

> Here's what it says.  Can you interpret this for me?  :-)
> 
> dixie:/home/pb/gpe/base# hcitool info 08:00:17:19:EE:71
> Requesting information ...
>         BD Address:  08:00:17:19:EE:71
>         Device Name: POCKET_PC
>         LMP Version: 1.1 (0x1) LMP Subversion: 0x180
>         Manufacturer: RTX Telecom A/S (21)
>         Features: 0xff 0x3b 0x05 0x00 0x00 0x00 0x00 0x00
>                 <3-slot packets> <5-slot packets> <encryption> <slot
> offset>
>                 <timing accuracy> <role switch> <hold mode> <sniff mode>
>                 <park state> <RSSI> <SCO link> <HV2 packets>
>                 <HV3 packets> <CVSD> <power control>

so this is really not a CSR based device. The Internet states something
about RTX working together with National for Bluetooth solutions, so
this makes sense. And HP also uses the same chip in their DeskJet 450
Bluetooth printer. However I have not any detailed information about the
RTX chips and what is the best way to use their H4 transport layer.

Maybe you should try to contact HP and RTX for more information. The
Handhelds site state the Bluetooth support of the 5xxx series iPAQ's as
"Bluetooth works, though not completely reliable" and I think we should
fix this. Please put me on CC on your requests.

Regards

Marcel




-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
