Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Re: Toshiba and BT (SuSE 9.2)
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <!~!UENERkVCMDkAAQACAAAAAAAAAAAAAAAAABgAAAAAAAAAosiAEZOtxUiHqgChZUVmh8KAAAAQAAAA9S4pOIQ8k0u5TiNLQ6Cr6AEAAAAA@t-online.de>
References: 
	 <!~!UENERkVCMDkAAQACAAAAAAAAAAAAAAAAABgAAAAAAAAAosiAEZOtxUiHqgChZUVmh8KAAAAQAAAA9S4pOIQ8k0u5TiNLQ6Cr6AEAAAAA@t-online.de>
Content-Type: text/plain
Message-Id: <1103024865.2143.154.camel@pegasus>
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
Date: Tue, 14 Dec 2004 12:47:44 +0100

Hi Peter,

> with YaST now I stopped pand and started dund --search --persist

why don't you try it first by hand and with the YaST settings for dund
and pand. Actually these entries are for a PAN or LAP server and not
really for the client use.

> ##>
> ##>this means PSM not supported. Are you sure that your AP 
> ##>supports the PAN profile? Maybe you wanna try dund.
> 
> here the results of dund
> 
> Linux-Notebook:~ # dund -c 00:0B:CE:00:01:8F
> 
> Linux-Notebook:~ # hcidump -x
> HCIDump - HCI packet analyzer ver 1.11
> device: hci0 snap_len: 1028 filter: 0xffffffff
> < HCI Command: Disconnect (0x01|0x0006) plen 3
>   2B 00 13
> > HCI Event: Command Status (0x0f) plen 4
>   00 01 06 04
> > HCI Event: Disconn Complete (0x05) plen 4
>   00 2B 00 16
> < HCI Command: Inquiry (0x01|0x0001) plen 5
>   33 8B 9E 0A 0A
> > HCI Event: Command Status (0x0f) plen 4
>   00 01 01 04
> > HCI Event: Inquiry Result (0x02) plen 15
>   01 8F 01 00 CE 0B 00 01 00 00 00 03 02 0C 5A
> > HCI Event: Inquiry Complete (0x01) plen 1
>   00
> < HCI Command: Create Connection (0x01|0x0005) plen 13
>   8F 01 00 CE 0B 00 18 CC 01 00 0C DA 01
> > HCI Event: Command Status (0x0f) plen 4
>   00 01 05 04
> > HCI Event: Role Change (0x12) plen 8
>   00 8F 01 00 CE 0B 00 01
> > HCI Event: Connect Complete (0x03) plen 11
>   00 29 00 8F 01 00 CE 0B 00 01 00
> < ACL data: handle 0x0029 flags 0x02 dlen 12
>     L2CAP(s): Connect req: psm 1 scid 0x0040
> < HCI Command: Write Link Policy Settings (0x02|0x000d) plen 4
>   29 00 0F 00
> > HCI Event: Command Complete (0x0e) plen 6
>   01 0D 08 00 29 00
> > HCI Event: Number of Completed Packets (0x13) plen 5
>   01 29 00 01 00
> > HCI Event: Max Slots Change (0x1b) plen 3
>   29 00 05
> > HCI Event: Link Key Request (0x17) plen 6
>   8F 01 00 CE 0B 00
> < HCI Command: Link Key Request Reply (0x01|0x000b) plen 22
>   8F 01 00 CE 0B 00 F8 AA 01 A8 18 28 1B 17 C5 CB 52 40 71 AF
>   72 BF
> > HCI Event: Command Complete (0x0e) plen 10
>   01 0B 04 00 8F 01 00 CE 0B 00
> > ACL data: handle 0x0029 flags 0x02 dlen 16
>     L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0040 result 3 status 0
> < HCI Command: Disconnect (0x01|0x0006) plen 3
>   29 00 13
> > HCI Event: Command Status (0x0f) plen 4
>   00 01 06 04
> > HCI Event: Disconn Complete (0x05) plen 4
>   00 29 00 16

this time the connection is refused, because of a security issue. I
assume that the link key you send is wrong. Remove the link_key file
from /etc/bluetooth/ and disable pand and dund settings in YaST and then
restart your system. Then try "dund -n -c ...".

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
