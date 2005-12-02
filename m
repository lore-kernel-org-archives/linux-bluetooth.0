Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Re: 2 Successive OBEX Connect Request
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <20051202023157.95773.qmail@web32409.mail.mud.yahoo.com>
References: <20051202023157.95773.qmail@web32409.mail.mud.yahoo.com>
Content-Type: text/plain
Message-Id: <1133511464.11226.2.camel@blade>
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
Date: Fri, 02 Dec 2005 09:17:44 +0100

Hi Arch,

> Here is the trace provided by hcidump.
>  
> > HCI Event: Connect Request (0x04) plen 10
>     bdaddr 00:15:B9:24:F2:4F class 0x7a0204 type ACL
> < HCI Command: Accept Connection Request (0x01|0x0009) plen 7
>     bdaddr 00:15:B9:24:F2:4F role 0x01
>     Role: Slave
> > HCI Event: Command Status (0x0f) plen 4
>     Accept Connection Request (0x01|0x0009) status 0x00 ncmd 1
> > HCI Event: Connect Complete (0x03) plen 11
>     status 0x00 handle 41 bdaddr 00:15:B9:24:F2:4F type ACL encrypt
> 0x00
> < HCI Command: Change Connection Packet Type (0x01|0x000f) plen 4
>     handle 41 ptype 0xcc18
>     Packet type: DM1 DM3 DM5 DH1 DH3 DH5
> > HCI Event: Page Scan Repetition Mode Change (0x20) plen 7
>     bdaddr 00:15:B9:24:F2:4F mode 1
> > HCI Event: Max Slots Change (0x1b) plen 3
>     handle 41 slots 5
> > HCI Event: Command Status (0x0f) plen 4
>     Change Connection Packet Type (0x01|0x000f) status 0x00 ncmd 1
> > HCI Event: Connection Packet Type Changed (0x1d) plen 5
>     status 0x00 handle 41 ptype 0xcc18
>     Packet type: DM1 DM3 DM5 DH1 DH3 DH5
> > ACL data: handle 41 flags 0x02 dlen 12
>     L2CAP(s): Connect req: psm 3 scid 0x0042
> < ACL data: handle 41 flags 0x02 dlen 16
>     L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0042 result 0 status 0
>       Connection successful
> > HCI Event: Number of Completed Packets (0x13) plen 5
>     handle 41 packets 1
> > ACL data: handle 41 flags 0x02 dlen 16
>     L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 4
>       MTU 1598
> < ACL data: handle 41 flags 0x02 dlen 14
>     L2CAP(s): Config rsp: scid 0x0042 flags 0x00 result 0 clen 0
>       Success
> < ACL data: handle 41 flags 0x02 dlen 16
>     L2CAP(s): Config req: dcid 0x0042 flags 0x00 clen 4
>       MTU 1024
> > HCI Event: Number of Completed Packets (0x13) plen 5
>     handle 41 packets 1
> > HCI Event: Number of Completed Packets (0x13) plen 5
>     handle 41 packets 1
> > ACL data: handle 41 flags 0x02 dlen 14
>     L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 0
>       Success
> > ACL data: handle 41 flags 0x02 dlen 8
>     L2CAP(d): cid 0x0040 len 4 [psm 3]
>       RFCOMM(s): SABM: cr 1 dlci 0 pf 1 ilen 0 fcs 0x1c
> < ACL data: handle 41 flags 0x02 dlen 8
>     L2CAP(d): cid 0x0042 len 4 [psm 3]
>       RFCOMM(s): UA: cr 1 dlci 0 pf 1 ilen 0 fcs 0xd7
> > HCI Event: Number of Completed Packets (0x13) plen 5
>     handle 41 packets 1
> > ACL data: handle 41 flags 0x02 dlen 18
>     L2CAP(d): cid 0x0040 len 14 [psm 3]
>       RFCOMM(s): PN CMD: cr 1 dlci 0 pf 0 ilen 10 fcs 0x70 mcc_len 8
>       dlci 10 frame_type 0 credit_flow 15 pri 0 ack_timer 0
>       frame_size 1592 max_retrans 0 credits 3
> < ACL data: handle 41 flags 0x02 dlen 18
>     L2CAP(d): cid 0x0042 len 14 [psm 3]
>       RFCOMM(s): PN RSP: cr 0 dlci 0 pf 0 ilen 10 fcs 0xaa mcc_len 8
>       dlci 10 frame_type 0 credit_flow 14 pri 0 ack_timer 0
>       frame_size 1592 max_retrans 0 credits 7
> > HCI Event: Number of Completed Packets (0x13) plen 5
>     handle 41 packets 1
> > ACL data: handle 41 flags 0x02 dlen 8
>     L2CAP(d): cid 0x0040 len 4 [psm 3]
>       RFCOMM(s): SABM: cr 1 dlci 10 pf 1 ilen 0 fcs 0x8c
> < ACL data: ha ndle 41 flags 0x02 dlen 8
>     L2CAP(d): cid 0x0042 len 4 [psm 3]
>       RFCOMM(s): UA: cr 1 dlci 10 pf 1 ilen 0 fcs 0x47
> < ACL data: handle 41 flags 0x02 dlen 12
>     L2CAP(d): cid 0x0042 len 8 [psm 3]
>       RFCOMM(s): M SC CMD: cr 0 dlci 0 pf 0 ilen 4 fcs 0xaa mcc_len 2
>       dlci 10 fc 0 rtc 1 rtr 1 ic 0 dv 1 b1 1 b2 1 b3 0 len 0
> > HCI Event: Number of Completed Packets (0x13) plen 5
>     handle 41 packets 1
> > HCI Event: Number of Completed Packets (0x13) plen 5
>     handle 41 packets 1<
>  /div> 
> > ACL data: handle 41 flags 0x02 dlen 12
>     L2CAP(d): cid 0x0040 len 8 [psm 3]
>       RFCOMM(s): MSC CMD: cr 1 dlci 0 pf 0 ilen 4 fcs 0x70 mcc_len 2
>       dlci 10 fc 0 rtc 1 rtr 1 ic 0 dv 1 b1 1 b2 1 b3 0 len 0
> < ACL data: handle 41 flags 0x02 dlen 12
>     L2CAP(d): cid 0x0042 len 8 [psm 3]
>       RFCOMM(s): MSC RSP: cr 0 dlci 0 pf 0 ilen 4 fcs 0xaa mcc_len 2
>       dlci 10 fc 0 rtc 1 rtr 1 ic 0 dv 1 b1 1 b2 1 b3 0 len 0
> > ACL data: handle 41 flags 0x02 dlen 12
>     L2CAP(d): cid 0x0040 len 8 [ps m 3]
>       RFCOMM(s): MSC RSP: cr 1 dlci 0 pf 0 ilen 4 fcs 0x70 mcc_len 2
>       dlci 10 fc 0 rtc 1 rtr 1 ic 0 dv 1 b1 1 b2 1 b3 0 len 0
> < ACL data: handle 41 flags 0x02 dlen 9
>     L2CAP(d): cid 0x0042 len 5 [psm 3]
>       RFCOMM(d): UIH: cr 0 dlci 10 pf 1 ilen 0 fcs 0x76 credits 33
> > HCI Event: Number of Completed Packets (0x13) plen 5
>     handle 41 packets 1
> > HCI Event: Number of Completed Packets (0x13) plen 5
>     handle 41 packets 1
> > ACL data: handle 41 flags 0x02 dlen 34
>     L2CAP(d): cid 0x0040 len 30 [psm 3]
>       RFCOMM(d): UIH: cr 1 dlci 10 pf 0 ilen 26 fcs 0xb0
>         OBEX: Connect cmd(f): len 26 version 1.0 flags 0 mtu 7980
>         Target (0x46) = Sequence length 16
>         0000: 00 00 11 18 00 00 10 00  80 00 00 80 5f 9b 34
> fb  ............_.4.
> < ACL data: handle 41 flags 0x02 dlen 39
>     L2CAP(d): cid 0x0042 len 35 [psm 3]
>       RFCOMM(d): UIH: cr 0 dlci 10 pf 0 ilen 31 fcs 0x6a
>         OBEX: Connect rsp(f): status 200 len 31 version 1.1 flags 0
> mtu 1024
>         Status 200 = Success
>         Who (0x4a) = Sequence length 16
>         0000: 00 00 11 18 00 00 10 00  80 00 00 80 5f 9b 34
> fb  ............_.4.
>         Connection ID (0xcb) = 0
> > HCI Event: Number of Completed Packets (0x13) plen 5
>     handle 41 packets 1
> > ACL data: handle 41 flags 0x02 dlen 12
>     L2CAP(s): Connect req: psm 1 scid 0x0043
> < ACL data: handle 41 flags 0x02 dle n 16
>     L2CAP(s): Connect rsp: dcid 0x0041 scid 0x0043 result 0 status 0
>       Connection successful
> > HCI Event: Number of Completed Packets (0x13) plen 5
>     handle 41 packets 1
> > ACL data: handle 41 flags 0x02 dlen 20
>     L2CAP(s): Config req: dcid 0x0041 flags 0x00 clen 8
>       MTU 256 FlushTO 65535
> < ACL data: handle 41 flags 0x02 dlen 14
>     L2CAP(s): Config rsp: scid 0x0043 flags 0x00 result 0 clen 0
>       Success
> < ACL data: handle 41 flags 0x02 dlen 12
>     L2CAP(s): Config req: dcid 0x0043 flags 0x00 clen 0
> > HCI Event: Number of Completed Packets (0x13) plen 5
>     handle 41 packets 1
> > HCI Event: Number of Completed Packets (0x13) plen 5
>     handle 41 packe ts 1
> > ACL data: handle 41 flags 0x02 dlen 14
>     L2CAP(s): Config rsp: scid 0x0041 flags 0x00 result 0 clen 0
>       Success
> > ACL data: handle 41 flags 0x02 dlen 34
>     L2CAP(d): cid 0x0041 len 30 [psm 1]
>         SDP SSA Req: tid 0x0 len 0x19
>           pat uuid-16 0x1123
>           max 240
>           aid(s) 0x0001 (SrvClassIDList) 0x0003 (SrvID) 0x0004
> (ProtocolDescList) 0x000d (IconURL) 0x0100 (SrvName)
>           cont 00
> < ACL data: handle 41 flags 0x02 dlen 93
>     L2CAP(d): cid 0x0043 len 89 [psm 1]
>         SDP SSA Rsp: tid 0x0 len 0x54
>           count 81
>           record #0
>               aid 0x0001 (SrvClassIDList)
>                  < uuid-16 0x1119 uuid-16 0x1123 uuid-16 0x1118 >
>               aid 0x0004 (ProtocolDescList)
>                  < < uuid-16 0x0100 (L2CAP) > <
>                  uuid-16 0x0003 (RFCOMM) uint 0x5 > <
>                  uuid-16 0x0008 (OBEX) > >
>               aid 0x000d (IconURL)
>                  < < uuid-16 0x0100 (L2CAP) > < uuid-16 0x0003
> (RFCOMM) uint 0x6 > < uuid-16 0x0008 (OBEX) > >
>               aid 0x0100 (SrvName)
>                  str "Basic Printing"
>           cont 00
> > HCI Event: Number of Completed Packets (0x13) plen 5
>     handle 41 packets 1
> > ACL data: handle 41 flags 0x02 dlen 12
>    ;  L2CAP(s): Disconn req: dcid 0x0041 scid 0x0043
> < ACL data: handle 41 flags 0x02 dlen 12
>     L2CAP(s): Disconn rsp: dcid 0x0041 scid 0x0043
> > HCI Event: Number of Completed Packets (0x13) plen 5
>     handle 41 packets 1
> > HCI Event: Max Slots Change (0x1b) plen 3
>     handle 41 slots 1
> > HCI Event: Max Slots Change (0x1b) plen 3
>     handle 41 slots 5
>  
>  
> Supposedly, after the L2CAP disconnection, the Bluetooth device
> (mobile phone) will issue another OBEX Connect Request. However, as
> you may see in this trace, the 2nd OBEX Connect Request was not
> issued. I hope to know more about what happened to the connection and
> why doesn't the transaction proceed.

the first L2CAP is to PSM 3 to establish the RFCOMM connection and then
it establishes the OBEX connection on channel 5. The second L2CAP is to
PSM 1 for an SDP service request. There are no multiple OBEX connection
requests.

Regards

Marcel




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
