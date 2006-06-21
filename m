Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <44991DF2.2000409@ibmt.fraunhofer.de>
References: <4497CE54.5080305@ibmt.fraunhofer.de>
	<4498EB58.3090200@ibmt.fraunhofer.de>
	<1150883159.3950.34.camel@localhost>
	<44991DF2.2000409@ibmt.fraunhofer.de>
Date: Wed, 21 Jun 2006 12:38:27 +0200
Message-Id: <1150886307.3950.36.camel@localhost>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] [Fwd: Re:  Problem connecting Bluetooth device]
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hi Harald,

> here the output (extract) of hcidump -X -V:
> 
> If I try to connect the device the first time after resetting:
> 
> doro:/home/harald # rfcomm connect /dev/rfcomm0 00:11:B1:A2:01:C9
> Can't connect RFCOMM socket: Permission denied
> 
> doro:/var/lib/bluetooth # hcidump -X -V -i hci0
> HCI sniffer - Bluetooth packet analyzer ver 1.30
> device: hci0 snap_len: 1028 filter: 0xffffffffffffffff
> < HCI Command: Create Connection (0x01|0x0005) plen 13
>      bdaddr 00:11:B1:A2:01:C9 ptype 0xcc18 rswitch 0x01 clkoffset 0x0000
>      Packet type: DM1 DM3 DM5 DH1 DH3 DH5
>  > HCI Event: Command Status (0x0f) plen 4
>      Create Connection (0x01|0x0005) status 0x00 ncmd 1
>  > HCI Event: PIN Code Request (0x16) plen 6
>      bdaddr 00:11:B1:A2:01:C9
> < HCI Command: PIN Code Request Reply (0x01|0x000d) plen 23
>      bdaddr 00:11:B1:A2:01:C9 len 6 pin '111111'
>  > HCI Event: Command Complete (0x0e) plen 10
>      PIN Code Request Reply (0x01|0x000d) ncmd 1
>      status 0x00 bdaddr 00:11:B1:A2:01:C9
>  > HCI Event: Link Key Notification (0x18) plen 23
>      bdaddr 00:11:B1:A2:01:C9 key C608EE0874A86C91C615086C6CF41E63 type 0
>  > HCI Event: Connect Complete (0x03) plen 11
>      status 0x00 handle 6 bdaddr 00:11:B1:A2:01:C9 type ACL encrypt 0x01
> < ACL data: handle 6 flags 0x02 dlen 12
>      L2CAP(s): Connect req: psm 3 scid 0x0040
> ...........
> 
> and here the second attempt :
> 
> doro:/home/harald # rfcomm connect /dev/rfcomm0 00:11:B1:A2:01:C9
> Can't create RFCOMM TTY: Address already in use
> 
> < HCI Command: Create Connection (0x01|0x0005) plen 13
>      bdaddr 00:11:B1:A2:01:C9 ptype 0xcc18 rswitch 0x01 clkoffset 0x0000
>      Packet type: DM1 DM3 DM5 DH1 DH3 DH5
>  > HCI Event: Command Status (0x0f) plen 4
>      Create Connection (0x01|0x0005) status 0x00 ncmd 1
>  > HCI Event: Link Key Request (0x17) plen 6
>      bdaddr 00:11:B1:A2:01:C9
> < HCI Command: Link Key Request Reply (0x01|0x000b) plen 22
>      bdaddr 00:11:B1:A2:01:C9 key 6EE7B663E623736747EE0371D9D25C74
>  > HCI Event: Command Complete (0x0e) plen 10
>      Link Key Request Reply (0x01|0x000b) ncmd 1
>      status 0x00 bdaddr 00:11:B1:A2:01:C9
>  > HCI Event: Connect Complete (0x03) plen 11
>      status 0x05 handle 6 bdaddr 00:11:B1:A2:01:C9 type ACL encrypt 0x00
>      Error: Authentication Failure
> < HCI Command: Inquiry (0x01|0x0001) plen 5
>      lap 0x9e8b33 len 6 num 0
> .......................
> 
> and in a message the alert :
> ....Authentication Error!
> 
> 
> content of linkkeys:
> 
> doro:/usr/var/lib/bluetooth/00:0A:3A:64:97:46 # more linkkeys
> 00:11:B1:A2:01:C9 6EE7B663E623736747EE0371D9D25C74 0

it seems that the link key is stored totally wrong. Please replace it
with the link key you see in the first connection attempt and then try
again.

Regards

Marcel




_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
