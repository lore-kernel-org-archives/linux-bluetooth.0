Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Nokia 6230: "pairing and conn. rejected for
	security reasons"
From: Marcel Holtmann <marcel@holtmann.org>
To: Lutz Pressler <Lutz.Pressler@SerNet.DE>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <E1BQ0K1-0000wa-00@intern.SerNet.DE>
References: <E1BQ0K1-0000wa-00@intern.SerNet.DE>
Content-Type: text/plain
Message-Id: <1084872149.5833.72.camel@pegasus>
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
Date: Tue, 18 May 2004 11:22:30 +0200

Hi Lutz,

> Requesting information ...
>         BD Address:  00:E0:03:39:C9:AB
>         Device Name: Nokia 6230 LP
>         LMP Version: 1.1 (0x1) LMP Subversion: 0x380
>         Manufacturer: Cambridge Silicon Radio (10)
>         Features: 0xbf 0xee 0x00 0x09
>                 <3-slot packets> <5-slot packets> <encryption> <slot offset>
>                 <timing accuracy> <role switch> <sniff mode> <RSSI>
>                 <channel quality> <SCO link> <HV3 packets> <u-law log>
>                 <A-law log>

please install bluez-libs-2.7 and bluez-utils-2.7, because it looks like
that this phone already contains some Bluetooth 1.2 features and I need
to know the full 8 bytes of the remote features.

> HCIDump - HCI packet analyzer ver 1.8
> device: hci0 snap_len: 1028 filter: 0xffffffff
> > HCI Event: Connect Request(0x04) plen 10
>   AB C9 39 03 E0 00 04 02 52 01
> < HCI Command: Accept Connection Request(0x01|0x0009) plen 7
>   AB C9 39 03 E0 00 01
> > HCI Event: Command Status(0x0f) plen 4
>   00 01 09 04
> > HCI Event: PIN Code Request(0x16) plen 6
>   AB C9 39 03 E0 00
> < HCI Command: PIN Code Request Reply(0x01|0x000d) plen 23
>   AB C9 39 03 E0 00 05 38 34 37 37 31 00 00 00 00 00 00 00 00
>   00 00 00
> > HCI Event: Command Complete(0x0e) plen 10
>   01 0D 04 00 AB C9 39 03 E0 00
> > HCI Event: Link Key Notification(0x18) plen 23
>   AB C9 39 03 E0 00 0F B5 F9 09 4B CC 34 47 B7 91 18 71 5F 0B
>   D8 A3 01
> > HCI Event: Connect Complete(0x03) plen 11
>   00 00 00 AB C9 39 03 E0 00 01 00

You made a connection from the phone to your PC, right? And it looks
like that you are in security mode 3. From your hcid.conf I saw that you
haven't activated auth and encrypt so this is not you, but I can't think
of that your phone uses security mode 3. This is not normal.

> < HCI Command: Write Link Policy Settings(0x02|0x000d) plen 4
>   00 00 0F 00
> > HCI Event: Command Complete(0x0e) plen 6
>   01 0D 08 00 00 00
> < HCI Command: Change Connection Packet Type(0x01|0x000f) plen 4
>   00 00 18 CC
> > HCI Event: Command Status(0x0f) plen 4
>   00 01 0F 04
> > HCI Event: Connection Packet Type Changed(0x1d) plen 5
>   00 00 00 18 CC
> > HCI Event: Command Complete(0x0e) plen 3
>   01 00 00
> > HCI Event: Disconn Complete(0x05) plen 4
>   00 00 00 29

It disconnects with "Pairing With Unit Key Not Supported" error (0x29)
and I haven't seen this error before. I am no link manager expert, but I
really think that one implementation is acting very bad here. And I
guess it is your Acer dongle with the Zeevo/Telencomm chip, because it
has caused troubles in the past. Do you own another dongle (preferable
CSR based) to check this?

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by: SourceForge.net Broadband
Sign-up now for SourceForge Broadband and get the fastest
6.0/768 connection for only $19.95/mo for the first 3 months!
http://ads.osdn.com/?ad_id=2562&alloc_id=6184&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
