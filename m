Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] link_key_request problems
From: Marcel Holtmann <marcel@holtmann.org>
To: wim delvaux <wim.delvaux@adaptiveplanet.com>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <200403031516.12967.wim.delvaux@adaptiveplanet.com>
References: <200402250154.18963.wim.delvaux@adaptiveplanet.com>
	 <200402250351.06911.wim.delvaux@adaptiveplanet.com>
	 <1077715714.2919.80.camel@pegasus>
	 <200403031516.12967.wim.delvaux@adaptiveplanet.com>
Content-Type: text/plain
Message-Id: <1078325166.2787.108.camel@pegasus>
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
Date: Wed, 03 Mar 2004 15:46:06 +0100

Hi Wim,

write a binary version do disk (with -w) and post it or use -x.

Regards

Marcel

> hcidump attached :
> 
> > HCI Event: Connect Request(0x04) plen 10
>   . . . . . . . . . .
> < HCI Command: Accept Connection Request(0x01|0x0009) plen 7
>   . . . . . . .
> > HCI Event: Command Status(0x0f) plen 4
>   . . . .
> > HCI Event: Link Key Request(0x17) plen 6
>   . . . . . .
> < HCI Command: Link Key Request Reply(0x01|0x000b) plen 22
>   . . . . . . . B . . 3 . . . . i . c . .
>   . b
> > HCI Event: Role Change(0x12) plen 8
>   . . . . . . . .
> > HCI Event: Command Complete(0x0e) plen 10
>   . . . . . . . . . .
> > HCI Event: Connect Complete(0x03) plen 11
>   . ( . . . . . . . . .
> 
> or RAW
> 
> > 04 04 0A 96 85 0D C7 02 00 12 01 12 01
> < 01 09 04 07 96 85 0D C7 02 00 00
> > 04 0F 04 00 01 09 04
> > 04 17 06 96 85 0D C7 02 00
> < 01 0B 04 16 96 85 0D C7 02 00 F5 42 F5 95 33 1E 18 AF B9 69
>   87 63 F4 EA DA 62
> > 04 12 08 00 96 85 0D C7 02 00 00
> > 04 0E 0A 01 0B 04 00 96 85 0D C7 02 00
> > 04 03 0B 05 28 00 96 85 0D C7 02 00 01 00
> 
> In the syslog I see ...
> 
> Mar  3 15:09:05 localhost hcid[10515]: link_key_request 
> (sba=00:60:57:02:71:A2, dba=00:02:C7:0D:85:96)
> 
> On the Ipaq (3800) I see similar messages but the ascii content of the message 
> is different
> 
> Raw output there is ...
> 
> HCIDump - HCI packet analyzer ver 1.5
> device: hci0 snap_len: 1028 filter: 0xffffffff
> > 04 12 08 00 A2 71 02 57 60 00 01 
> > 04 17 06 A2 71 02 57 60 00 
> < 01 0B 04 16 A2 71 02 57 60 00 16 66 2E EB B9 33 32 1B EE A8 
>   15 F7 11 CA B1 CF 
> > 04 0E 0A 01 0B 04 00 A2 71 02 57 60 00 
> > 04 03 0B 05 28 00 A2 71 02 57 60 00 01 00 
> 
> The only solution is still to remove the link_key file




-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
