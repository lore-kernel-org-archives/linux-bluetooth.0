Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] sdptool setattr
From: Marcel Holtmann <marcel@holtmann.org>
To: =?ISO-8859-1?Q?Jo=E3o?= Santos <jsantos_pt@hotmail.com>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <Sea2-F67Qra6aPYpklD00036305@hotmail.com>
References: <Sea2-F67Qra6aPYpklD00036305@hotmail.com>
Content-Type: text/plain
Message-Id: <1075851993.13285.131.camel@pegasus>
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
Date: Wed, 04 Feb 2004 00:46:33 +0100

Hi Joao,

> i have extend the set_attrib() function:
> 
> }else if(!strncasecmp(value,"b",1)) {
>                 /*Boolean*/
> 
>                  printf("Adding attrib 0x%X bool %s to record 0x%X\n",
>                        attrib, value+1, handle);
> 
>                 sdp_attr_add_new(rec, attrib, SDP_BOOL, value+1);
>              }

this code is wrong, because BOOL is not a string.

> and the sdp_data_printf(),
> 
> case SDP_BOOL:
>                 printf("%.*sBool 0x%x\n", indent, indent_spaces, 
> sdpdata->val.uint32);
>                 break;

The SPD_BOOL is not uint32 it is int8.

> i have add the attrib doing;
> 
> [root@olivia tools]# sdptool setattr 0x804f738 0x0302 bFalse
> Adding attrib 0x302 bool False to record 0x804F738

A Bool attribute is int8 and not a string, but "False" is a string.

> [root@olivia tools]# sdptool get --tree 0x804f738
> Attribute Identifier : 0x0 - ServiceRecordHandle
>   Integer : 0x804f738
> Attribute Identifier : 0x1 - ServiceClassIDList
>   Data Sequence
>     UUID16 : 0x1108 - Headset
>     UUID16 : 0x1203 - GenericAudio
> Attribute Identifier : 0x4 - ProtocolDescriptorList
>   Data Sequence
>     Data Sequence
>       UUID16 : 0x0100 - L2CAP
>     Data Sequence
>       UUID16 : 0x0003 - RFCOMM
>       Channel/Port (Integer) : 0xc
> Attribute Identifier : 0x5 - BrowseGroupList
>   Data Sequence
>     UUID16 : 0x1002 - PublicBrowseGroup (SDP)
> Attribute Identifier : 0x9 - BluetoothProfileDescriptorList
>   Data Sequence
>     Data Sequence
>       UUID16 : 0x1108 - Headset
>       Version (Integer) : 0x100
> Attribute Identifier : 0x100
>   Text : "Headset"
> Attribute Identifier : 0x302 - Remote audio volume control
>   Bool 0x46

The value of 0x46 is wrong. Is 0x46 == 'F' ???

> but the problem remaind the same;
> [root@olivia jsantos]# hcidump -a
> HCIDump - HCI packet analyzer ver 1.5
> device: hci0 snap_len: 1028 filter: 0xffffffff
> < HCI Command: Create Connection(0x01|0x0005) plen 13
>   . . . W ` . . . . . . . .
> >HCI Event: Command Status(0x0f) plen 4
>   . . . .
> >HCI Event: Link Key Request(0x17) plen 6
>   . . . W ` .
> < HCI Command: Link Key Request Reply(0x01|0x000b) plen 22
>   . . . W ` . . . * ` . . . . . . . 3 . .
>   . .
> >HCI Event: Command Complete(0x0e) plen 10
>   . . . . . . . W ` .
> >HCI Event: Connect Complete(0x03) plen 11
>   . ) . . . . W ` . . .
> < ACL data: handle 0x0029 flags 0x02 dlen 12
>     L2CAP(s): Connect req: psm 3 scid 0x0040
> < HCI Command: Write Link Policy Settings(0x02|0x000d) plen 4
>   ) . . .
> >HCI Event: Number of Completed Packets(0x13) plen 5
>   . ) . . .
> >HCI Event: Command Complete(0x0e) plen 6
>   . . . . ) .
> >HCI Event: QoS Setup Complete(0x0d) plen 21
>   . ) . . . . . . . . . . . . . . . . . .
>   .
> >ACL data: handle 0x0029 flags 0x02 dlen 16
>     L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0040 result 0 status 0
> < ACL data: handle 0x0029 flags 0x02 dlen 16
>     L2CAP(s): Config req: dcid 0x0040 flags 0x0000 clen 4
>     MTU 1024
> >HCI Event: Number of Completed Packets(0x13) plen 5
>   . ) . . .
> >ACL data: handle 0x0029 flags 0x02 dlen 16
> >ACL data: handle 0x0029 flags 0x01 dlen 16
> >ACL data: handle 0x0029 flags 0x01 dlen 8
>     L2CAP(s): Config req: dcid 0x0040 flags 0x0000 clen 28
>     MTU 32772 Unknown (type 03, len 22)
> < ACL data: handle 0x0029 flags 0x02 dlen 14
>     L2CAP(s): Config rsp: scid 0x0040 flags 0x0000 result 0 clen 0
> >ACL data: handle 0x0029 flags 0x02 dlen 14
>     L2CAP(s): Config rsp: scid 0x0040 flags 0x0000 result 0 clen 0
> >HCI Event: Number of Completed Packets(0x13) plen 5
>   . ) . . .
> < ACL data: handle 0x0029 flags 0x02 dlen 8
>     L2CAP(d): cid 0x40 len 4 [psm 3]
>       RFCOMM(s): SABM: cr 1 dlci 0 pf 1 ilen 0 fcs 0x1c
> >HCI Event: Number of Completed Packets(0x13) plen 5
>   . ) . . .
> >ACL data: handle 0x0029 flags 0x02 dlen 8
>     L2CAP(d): cid 0x40 len 4 [psm 3]
>       RFCOMM(s): UA: cr 1 dlci 0 pf 1 ilen 0 fcs 0xd7
> < ACL data: handle 0x0029 flags 0x02 dlen 18
>     L2CAP(d): cid 0x40 len 14 [psm 3]
>       RFCOMM(s): PN CMD: cr 1 dlci 0 pf 0 ilen 10 fcs 0x70 mcc_len 8
>       dlci 24 frame_type 0 credit_flow 15 pri 0 ack_timer 0 frame_size 1019 
> max_retrans 0 credits 7
> >HCI Event: Number of Completed Packets(0x13) plen 5
>   . ) . . .
> >ACL data: handle 0x0029 flags 0x02 dlen 16
> >ACL data: handle 0x0029 flags 0x01 dlen 2
>     L2CAP(d): cid 0x40 len 14 [psm 3]
>       RFCOMM(s): PN RSP: cr 0 dlci 0 pf 0 ilen 10 fcs 0xaa mcc_len 8
>       dlci 24 frame_type 0 credit_flow 14 pri 0 ack_timer 0 frame_size 324 
> max_retrans 0 credits 0
> < ACL data: handle 0x0029 flags 0x02 dlen 8
>     L2CAP(d): cid 0x40 len 4 [psm 3]
>       RFCOMM(s): SABM: cr 1 dlci 24 pf 1 ilen 0 fcs 0xa2
> >HCI Event: Number of Completed Packets(0x13) plen 5
>   . ) . . .
> >ACL data: handle 0x0029 flags 0x02 dlen 8
>     L2CAP(d): cid 0x40 len 4 [psm 3]
>       RFCOMM(s): UA: cr 1 dlci 24 pf 1 ilen 0 fcs 0x69
> < ACL data: handle 0x0029 flags 0x02 dlen 12
>     L2CAP(d): cid 0x40 len 8 [psm 3]
>       RFCOMM(s): MSC CMD: cr 1 dlci 0 pf 0 ilen 4 fcs 0x70 mcc_len 2
>       dlci 24 fc 0 rtc 1 rtr 1 ic 0 dv 1 b1 1 b2 1 b3 0 len 0
> < ACL data: handle 0x0029 flags 0x02 dlen 9
>     L2CAP(d): cid 0x40 len 5 [psm 3]
>       RFCOMM(d): UIH: cr 1 dlci 24 pf 1 ilen 0 fcs 0x12
>       !
> >HCI Event: Number of Completed Packets(0x13) plen 5
>   . ) . . .
> >HCI Event: Number of Completed Packets(0x13) plen 5
>   . ) . . .
> >ACL data: handle 0x0029 flags 0x02 dlen 12
>     L2CAP(s): Connect req: psm 1 scid 0x0041
> < ACL data: handle 0x0029 flags 0x02 dlen 16
>     L2CAP(s): Connect rsp: dcid 0x0041 scid 0x0041 result 0 status 0
> >ACL data: handle 0x0029 flags 0x02 dlen 12
>     L2CAP(d): cid 0x40 len 8 [psm 3]
>       RFCOMM(s): MSC CMD: cr 0 dlci 0 pf 0 ilen 4 fcs 0xaa mcc_len 2
>       dlci 24 fc 0 rtc 1 rtr 1 ic 0 dv 0 b1 1 b2 1 b3 0 len 0
> < ACL data: handle 0x0029 flags 0x02 dlen 12
>     L2CAP(d): cid 0x40 len 8 [psm 3]
>       RFCOMM(s): MSC RSP: cr 1 dlci 0 pf 0 ilen 4 fcs 0x70 mcc_len 2
>       dlci 24 fc 0 rtc 1 rtr 1 ic 0 dv 0 b1 1 b2 1 b3 0 len 0
> >HCI Event: Number of Completed Packets(0x13) plen 5
>   . ) . . .
> >HCI Event: Number of Completed Packets(0x13) plen 5
>   . ) . . .
> >ACL data: handle 0x0029 flags 0x02 dlen 12
>     L2CAP(s): Config req: dcid 0x0041 flags 0x0000 clen 0
> < ACL data: handle 0x0029 flags 0x02 dlen 14
>     L2CAP(s): Config rsp: scid 0x0041 flags 0x0000 result 0 clen 0
> < ACL data: handle 0x0029 flags 0x02 dlen 12
>     L2CAP(s): Config req: dcid 0x0041 flags 0x0000 clen 0
> >HCI Event: Number of Completed Packets(0x13) plen 5
>   . ) . . .
> >ACL data: handle 0x0029 flags 0x02 dlen 9
>     L2CAP(d): cid 0x40 len 5 [psm 3]
>       RFCOMM(d): UIH: cr 0 dlci 24 pf 1 ilen 0 fcs 0xc8
>       .
> < ACL data: handle 0x0029 flags 0x02 dlen 21
>     L2CAP(d): cid 0x40 len 17 [psm 3]
>       RFCOMM(d): UIH: cr 1 dlci 24 pf 0 ilen 13 fcs 0xe
>       A T + C K P D = 2 0 0 . .
> >HCI Event: Number of Completed Packets(0x13) plen 5
>   . ) . . .
> >HCI Event: Number of Completed Packets(0x13) plen 5
>   . ) . . .
> >ACL data: handle 0x0029 flags 0x02 dlen 18
>     L2CAP(d): cid 0x40 len 14 [psm 3]
>       RFCOMM(s): RPN CMD: cr 0 dlci 0 pf 0 ilen 10 fcs 0xaa mcc_len 8
> dlci 24  br: 7 db: 3 sb: 0 p: 0 pt: 0 xi: 0 xo: 0
>        rtri: 0 rtro: 0 rtci: 0 rtco: 0 xon: 17 xoff: 19 pm: 006f
> < ACL data: handle 0x0029 flags 0x02 dlen 18
>     L2CAP(d): cid 0x40 len 14 [psm 3]
>       RFCOMM(s): RPN RSP: cr 1 dlci 0 pf 0 ilen 10 fcs 0x70 mcc_len 8
> dlci 24  br: 0 db: 3 sb: 0 p: 0 pt: 0 xi: 0 xo: 0
>        rtri: 0 rtro: 0 rtci: 0 rtco: 0 xon: 0 xoff: 0 pm: 3f7f
> >HCI Event: Number of Completed Packets(0x13) plen 5
>   . ) . . .
> >ACL data: handle 0x0029 flags 0x02 dlen 14
>     L2CAP(s): Config rsp: scid 0x0041 flags 0x0000 result 0 clen 0
> >ACL data: handle 0x0029 flags 0x02 dlen 17
>     L2CAP(d): cid 0x41 len 13 [psm 1]
>         SDP SS Req: tid 0x19 len 0x8
>           pat uuid-16 0x1108 (Headset)
>           max 0xff
>           cont 00
> < ACL data: handle 0x0029 flags 0x02 dlen 18
>     L2CAP(d): cid 0x41 len 14 [psm 1]
>         SDP SS Rsp: tid 0x19 len 0x9
>           cur 0x1 tot 0x1 hndl 0x804f738
>           cont 00
> >ACL data: handle 0x0029 flags 0x02 dlen 12
>     L2CAP(d): cid 0x40 len 8 [psm 3]
>       RFCOMM(s): MSC RSP: cr 0 dlci 0 pf 0 ilen 4 fcs 0xaa mcc_len 2
>       dlci 24 fc 0 rtc 1 rtr 1 ic 0 dv 1 b1 0 b2 0 b3 1 len 3
> >HCI Event: Number of Completed Packets(0x13) plen 5
>   . ) . . .
> >ACL data: handle 0x0029 flags 0x02 dlen 21
>     L2CAP(d): cid 0x41 len 17 [psm 1]
>         SDP SA Req: tid 0x1a len 0xc
>           hndl 0x804f738
>           max 0xff
>           aid(s) 0x0302 ((null))
>           cont 00
> < ACL data: handle 0x0029 flags 0x02 dlen 19
>     L2CAP(d): cid 0x41 len 15 [psm 1]
>         SDP SA Rsp: tid 0x1a len 0xa
>           cnt 0x7
>           aid 0x0302 (unknown)
>              bool 0x46

Same as above. The value 0x46 is wrong here.

Regards

Marcel




-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
