Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Link interrupted/destroyed by CC on other hci
	device
From: Marcel Holtmann <marcel@holtmann.org>
To: Andreas Gaufer <andreas.gaufer@blue-cell-networks.com>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <20040629104140.04f9c2c8.Andreas.Gaufer@blue-cell-networks.com>
References: <20040628215642.516c0ff6.Andreas.Gaufer@blue-cell-networks.com>
	 <1088453745.6030.89.camel@pegasus>
	 <20040629104140.04f9c2c8.Andreas.Gaufer@blue-cell-networks.com>
Content-Type: text/plain
Message-Id: <1088531507.6030.321.camel@pegasus>
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
Date: Tue, 29 Jun 2004 19:51:47 +0200

Hi Andreas,

> im afraid i dont actauly see the event in hcidump. I guess this is
> something that goes wrong on the remote side.
> 
> ------------ snipp --------------
> 1088497489.410713 < ACL data: handle 0x002a flags 0x02 dlen 192
> 1088497489.410725 < ACL data: handle 0x002a flags 0x01 dlen 63
>     L2CAP(d): cid 0x85 len 251 [psm 3]
>       RFCOMM(d): UIH: cr 1 dlci 20 pf 0 ilen 246 fcs 0x31 
>       6C 61 67 00 00 00 00 01 00 00 38 42 49 4D 27 10 14 4A 61 70 
>       61 6E 65 73 65 20 50 72 69 6E 74 20 46 6C 61 67 73 00 00 00 
>       00 0A 00 01 00 00 00 00 00 00 00 02 38 42 49 4D 03 F5 17 43 
>       6F 6C 6F 72 20 48 61 6C 66 74 6F 6E 65 20 53 65 74 74 69 6E 
>       67 73 00 00 00 48 00 2F 66 66 00 01 00 6C 66 66 00 06 00 00 
>       00 00 00 01 00 2F 66 66 00 01 00 A1 99 9A 00 06 00 00 00 00 
>       00 01 00 32 00 00 00 01 00 5A 00 00 00 06 00 00 00 00 00 01 
>       00 35 00 00 00 01 00 2D 00 00 00 06 00 00 00 00 00 01 38 42 
>       49 4D 03 F8 17 43 6F 6C 6F 72 20 54 72 61 6E 73 66 65 72 20 
>       53 65 74 74 69 6E 67 73 00 00 00 70 00 00 FF FF FF FF FF FF 
>       FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF 03 E8 00 00 
>       00 00 FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF 
>       FF FF FF FF 03 E8 
> 1088497489.410753 < ACL data: handle 0x002a flags 0x02 dlen 28
>     L2CAP(d): cid 0x85 len 24 [psm 3]
>       RFCOMM(d): UIH: cr 1 dlci 20 pf 0 ilen 20 fcs 0x31 
>       00 00 00 00 FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF 
> 1088497489.425622 > HCI Event: Number of Completed Packets(0x13) plen 5
>   01 2A 00 01 00 
> 1088497489.427617 > HCI Event: Number of Completed Packets(0x13) plen 5
>   01 2A 00 01 00 
> 1088497489.437616 > HCI Event: Number of Completed Packets(0x13) plen 5
>   01 2A 00 01 00 
> 1088497489.440617 > HCI Event: Number of Completed Packets(0x13) plen 5
>   01 2A 00 01 00 
> 1088497489.442615 > HCI Event: Number of Completed Packets(0x13) plen 5
>   01 2A 00 01 00 
> 
> Here the phone says "Link interupted" and the Transfer is stalled on
> host side. 
> 
> After 10s of inactivity during the transfer I kill the obex process so
> the link gets closed.
> 
> 1088497499.412666 < ACL data: handle 0x002a flags 0x02 dlen 12
>     L2CAP(s): Disconn req: dcid 0x0083 scid 0x0040
> 
> Do you see anything strange here? I guess i need a PA to debug this. 
> Since this happens on SE Phones only i'll try to get somone to talk to
> there. 
> 
> As i sayd it heappens not always but verry often in the moment when
> another chip is paging. Maby this makes the phones stack crazy when they
> jump on the same freq?
> 
> Anyways i guess this is not a bluez issue so thanks for the help so far.

if you can only reproduce it with a SE phone then I think it is really
not a BlueZ problem. However I am not sure if you will find the bug with
a protocol analyser.

Try to play with different master/slave roles and the role switch
itself. I have seen problems with role switches in piconets with more
than 5 HID devices.

Regards

Marcel




-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
