Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users]  Again dund
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <!~!UENERkVCMDkAAQACAAAAAAAAAAAAAAAAABgAAAAAAAAAosiAEZOtxUiHqgChZUVmh8KAAAAQAAAAO5qWLdOLE0SlT9H59+95+AEAAAAA@t-online.de>
References: 
	 <!~!UENERkVCMDkAAQACAAAAAAAAAAAAAAAAABgAAAAAAAAAosiAEZOtxUiHqgChZUVmh8KAAAAQAAAAO5qWLdOLE0SlT9H59+95+AEAAAAA@t-online.de>
Content-Type: text/plain
Message-Id: <1099913396.6896.88.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Mon, 08 Nov 2004 12:29:56 +0100

Hi Peter,

> now I give you the responses of hcidump -x and I hope that you can give me a
> hint for my next steps to the bluetooth connection.
> 
> Than I run dund --connect 00:0B:CE:00:01:8F # address of BT-Modul
> and
> HCIDUMP -X response
> < HCI Command: Create Connection(0x01|0x0005) plen 13
>   8F 01 00 CE 0B 00 18 CC 02 00 00 00 01
> > HCI Event: Command Status(0x0f) plen 4
>   00 01 05 04
> > HCI Event: Role Change(0x12) plen 8
>   00 8F 01 00 CE 0B 00 01
> > HCI Event: Connect Complete(0x03) plen 11
>   00 29 00 8F 01 00 CE 0B 00 01 00
> < ACL data: handle 0x0029 flags 0x02 dlen 12
>     L2CAP(s): Connect req: psm 1 scid 0x0040
> < HCI Command: Write Link Policy Settings(0x02|0x000d) plen 4
>   29 00 0F 00
> > HCI Event: Page Scan Repetition Mode Change(0x20) plen 7
>   8F 01 00 CE 0B 00 01
> > HCI Event: Command Complete(0x0e) plen 6
>   01 0D 08 00 29 00
> > HCI Event: Max Slots Change(0x1b) plen 3
>   29 00 05
> > HCI Event: Number of Completed Packets(0x13) plen 5
>   01 29 00 01 00
> > HCI Event: Link Key Request(0x17) plen 6
>   8F 01 00 CE 0B 00
> < HCI Command: Link Key Request Reply(0x01|0x000b) plen 22
>   8F 01 00 CE 0B 00 57 D3 4C A0 11 16 5C 3F 27 59 01 71 9C D2
>   AC 1B
> > HCI Event: Command Complete(0x0e) plen 10
>   01 0B 04 00 8F 01 00 CE 0B 00
> > ACL data: handle 0x0029 flags 0x02 dlen 16
>     L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0040 result 3 status 0
> < HCI Command: Disconnect(0x01|0x0006) plen 3
>   29 00 13
> > HCI Event: Command Status(0x0f) plen 4
>   00 01 06 04
> > HCI Event: Disconn Complete(0x05) plen 4
>   00 29 00 16
> 
> there is no bt-connection established and I don't know why.

the L2CAP response failed with result code 3 and this means "Connection
refused - security block". The link key request is there and you reply
with a link key, but the connection fails. This means that your link key
that is stored on your system is wrong.

There is no easy way to delete a link key at the moment and so I think
the best way is to delete the file /etc/bluetooth/link_key and restart
your running hcid.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users/listinfo/bluez-users
