Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] B-Speech Vitac Headset
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <4245A464.2020701@tootai.net>
References: <4245A464.2020701@tootai.net>
Content-Type: text/plain
Message-Id: <1111894439.9195.209.camel@pegasus>
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
Date: Sun, 27 Mar 2005 05:33:59 +0200

Hi Daniel,

> I try to use the Vitac headset with my Linksys USB bluetooth dongle. I 
> face the following output:
> 
> nomade:/usr/src/modules/btsco# sdptool browse 00:00:fd:02:f3:7a
> Failed to connect to SDP server on 00:00:FD:02:F3:7A: Permission denied
> 
> after having been asked for the PIN code
> 
> nomade:/home/user# hcitool info 00:00:fd:02:f3:7a
> Requesting information ...
> Can't create connection: Input/output error
> 
> after having been asked for the PIN code
> 
> Relevant part of hcidump -x for the above command:
> 
> nomade:~# hcidump -x
> HCI sniffer - Bluetooth packet analyzer ver 1.17
> device: hci0 snap_len: 1028 filter: 0xffffffff
> < HCI Command: Create Connection (0x01|0x0005) plen 13
>    7A F3 02 FD 00 00 18 CC 02 00 00 00 01
>  > HCI Event: Command Status (0x0f) plen 4
>    00 01 05 04
>  > HCI Event: Link Key Request (0x17) plen 6
>    7A F3 02 FD 00 00
> < HCI Command: Link Key Request Negative Reply (0x01|0x000c) plen 6
>    7A F3 02 FD 00 00
>  > HCI Event: Command Complete (0x0e) plen 10
>    01 0C 04 00 7A F3 02 FD 00 00
>  > HCI Event: PIN Code Request (0x16) plen 6
>    7A F3 02 FD 00 00
> < HCI Command: PIN Code Request Reply (0x01|0x000d) plen 23
>    7A F3 02 FD 00 00 04 31 32 33 34 00 00 00 00 00 00 00 00 00
>    00 00 00
>  > HCI Event: Command Complete (0x0e) plen 10
>    01 0D 04 00 7A F3 02 FD 00 00
>  > HCI Event: Connect Complete (0x03) plen 11
>    05 29 00 7A F3 02 FD 00 00 01 00
> 
> Note the Link Key Request Negative Reply.

I am sick of decoding this all by myself and thus the newer hcidump
versions support verbose decoding (hcidump -X -V). Install the new
bluez-hcidump-1.19 package and redo that dump.

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
