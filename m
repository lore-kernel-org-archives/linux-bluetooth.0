Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Simone Gotti <simone.gotti@email.it>
To: Detlef Grittner <detlef.grittner@t-online.de>
Subject: Re: [Bluez-users] Pocket PC 2003 and Linux
References: <412C5482.3010909@t-online.de> <200408251846.26673.simone.gotti@email.it> <412CC793.1000208@t-online.de>
In-Reply-To: <412CC793.1000208@t-online.de>
MIME-Version: 1.0
Cc: bluez-users@lists.sourceforge.net
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200408252002.51563.simone.gotti@email.it>
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
Date: Wed, 25 Aug 2004 20:02:51 +0000

On Wednesday 25 August 2004 17:08, Detlef Grittner wrote:
>  > ACL data: handle 0x0029 flags 0x02 dlen 23
>
>     L2CAP(d): cid 0x40 len 19 [psm 1]
>         SDP SA Req: tid 0x3 len 0xe
>           hndl 0x8051328
>           max 0x1f0
>           aid(s) 0x0000 - 0xffff
>           cont 00
Here the pocket PC sent a SDP_ServiceAttributeRequest for every attribute in 
the PC sdp record. 

> < ACL data: handle 0x0029 flags 0x02 dlen 113
>     L2CAP(d): cid 0x40 len 109 [psm 1]
>         SDP SA Rsp: tid 0x3 len 0x68
>           cnt 0x65
>           aid 0x0000 (SrvRecHndl)
>              uint 0x8051328
>           aid 0x0001 (SrvClassIDList)
>              < uuid-16 0x1105 (OBEXObjPush) >
>           aid 0x0004 (ProtocolDescList)
>              < < uuid-16 0x0100 (L2CAP) > <
>              uuid-16 0x0003 (RFCOMM) uint 0xa > <
>              uuid-16 0x0008 (OBEX) > >
>           aid 0x0005 (BrwGrpList)
>              < uuid-16 0x1002 (PubBrwsGrp) >
>           aid 0x0009 (BTProfileDescList)
>              < < uuid-16 0x1105 (OBEXObjPush) uint 0x100 > >
>           aid 0x0100 (SrvName)
>              str "OBEX Object Push"
>           aid 0x0303 (SuppFormatsList)
>              < uint 0x1 uint 0x2 uint 0x3 uint 0x4 uint 0x5 uint 0x6
> uint 0xff >
>
>           cont 00
>
>  > HCI Event: Number of Completed Packets(0x13) plen 5
>
>   01 29 00 01 00
This is the answer. The service can be located on the rfcomm chennale n.10 
(0xa), it looks right for me.

>  > ACL data: handle 0x0029 flags 0x02 dlen 23
>
>     L2CAP(d): cid 0x40 len 19 [psm 1]
>         SDP SA Req: tid 0x4 len 0xe
>           hndl 0x80516b0
>           max 0x1f0
>           aid(s) 0x0000 - 0xffff
>           cont 00
> < ACL data: handle 0x0029 flags 0x02 dlen 113
>     L2CAP(d): cid 0x40 len 109 [psm 1]
>         SDP SA Rsp: tid 0x4 len 0x68
>           cnt 0x65
>           aid 0x0000 (SrvRecHndl)
>              uint 0x80516b0
>           aid 0x0001 (SrvClassIDList)
>              < uuid-16 0x1105 (OBEXObjPush) >
>           aid 0x0004 (ProtocolDescList)
>              < < uuid-16 0x0100 (L2CAP) > <
>              uuid-16 0x0003 (RFCOMM) uint 0xa > <
>              uuid-16 0x0008 (OBEX) > >
>           aid 0x0005 (BrwGrpList)
>              < uuid-16 0x1002 (PubBrwsGrp) >
>           aid 0x0009 (BTProfileDescList)
>              < < uuid-16 0x1105 (OBEXObjPush) uint 0x100 > >
>           aid 0x0100 (SrvName)
>              str "OBEX Object Push"
>           aid 0x0303 (SuppFormatsList)
>              < uint 0x1 uint 0x2 uint 0x3 uint 0x4 uint 0x5 uint 0x6
> uint 0xff >
>
this is the same but for a different handle.
this is caused because the request for SDP_ServiceSearchRequest reported 4 
handlers and 2 of this are reffered to object push. So it looks like there 
are 2 records for the same object push service. I Don't know if this is right 
and/or will be the cause of the problem. 

did you have a similare behavior using kbluetoothd instead of opd ?

I hope that someone more expert than me (like Marcel) can find the source of 
the problem.

Bye!
-- 
Simone Gotti
<simone.gotti@email.it>
http://kde-bluetooth.sf.net


-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
