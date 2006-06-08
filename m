Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <4487DA36.2000102@personnelware.com>
Date: Thu, 08 Jun 2006 03:05:10 -0500
From: Carl K <carl@personnelware.com>
MIME-Version: 1.0
To: BlueZ users <bluez-users@lists.sourceforge.net>
References: <549053140606021732w4263c5c2g93efa4cdf9a7614d@mail.gmail.com>	<1149362263.1977.4.camel@localhost>	<549053140606031339i43cee0a7h8622f83d76370504@mail.gmail.com>	<1149371447.1977.13.camel@localhost>	<549053140606060015h1f95955ao63714bd03df53998@mail.gmail.com>
	<1149750807.27331.1.camel@localhost>
In-Reply-To: <1149750807.27331.1.camel@localhost>
Subject: Re: [Bluez-users] PM325 by LG cell phone
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Marcel Holtmann wrote:
> Hi Carl,
>
>   
>> carl@asus17:~$ sudo rfcomm connect 0 08:00:37:03:EF:36 4
>> Can't connect RFCOMM socket: Connection refused 
>>     
>
> run "hcidump -X -V" as root to see what's going on.
>   

carl@asus17:~$ sudo hcidump -X -V
HCI sniffer - Bluetooth packet analyzer ver 1.28
device: hci0 snap_len: 1028 filter: 0xffffffff
< HCI Command: Create Connection (0x01|0x0005) plen 13
    bdaddr 08:00:37:03:EF:36 ptype 0xcc18 rswitch 0x01 clkoffset 0x0000
    Packet type: DM1 DM3 DM5 DH1 DH3 DH5
 > HCI Event: Command Status (0x0f) plen 4
    Create Connection (0x01|0x0005) status 0x00 ncmd 1
 > HCI Event: Connect Complete (0x03) plen 11
    status 0x00 handle 42 bdaddr 08:00:37:03:EF:36 type ACL encrypt 0x00
< ACL data: handle 42 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 3 scid 0x0040
< HCI Command: Write Link Policy Settings (0x02|0x000d) plen 4
    handle 42 policy 0x0f
    Link policy: RSWITCH HOLD SNIFF PARK
 > HCI Event: Number of Completed Packets (0x13) plen 5
    handle 42 packets 1
 > HCI Event: Command Complete (0x0e) plen 6
    Write Link Policy Settings (0x02|0x000d) ncmd 1
    status 0x00 handle 42
 > HCI Event: Max Slots Change (0x1b) plen 3
    handle 42 slots 5
 > ACL data: handle 42 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0041 scid 0x0040 result 0 status 0
      Connection successful
< ACL data: handle 42 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0041 flags 0x00 clen 4
      MTU 1013
 > ACL data: handle 42 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 4
      MTU 675
< ACL data: handle 42 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0041 flags 0x00 result 0 clen 0
      Success
 > HCI Event: Number of Completed Packets (0x13) plen 5
    handle 42 packets 1
 > HCI Event: Number of Completed Packets (0x13) plen 5
    handle 42 packets 1
 > ACL data: handle 42 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 0
      Success
< ACL data: handle 42 flags 0x02 dlen 8
    L2CAP(d): cid 0x0041 len 4 [psm 3]
      RFCOMM(s): SABM: cr 1 dlci 0 pf 1 ilen 0 fcs 0x1c
 > HCI Event: Number of Completed Packets (0x13) plen 5
    handle 42 packets 1
 > ACL data: handle 42 flags 0x02 dlen 8
    L2CAP(d): cid 0x0040 len 4 [psm 3]
      RFCOMM(s): UA: cr 1 dlci 0 pf 1 ilen 0 fcs 0xd7
< ACL data: handle 42 flags 0x02 dlen 18
    L2CAP(d): cid 0x0041 len 14 [psm 3]
      RFCOMM(s): PN CMD: cr 1 dlci 0 pf 0 ilen 10 fcs 0x70 mcc_len 8
      dlci 8 frame_type 0 credit_flow 15 pri 7 ack_timer 0
      frame_size 670 max_retrans 0 credits 7
 > HCI Event: Number of Completed Packets (0x13) plen 5
    handle 42 packets 1
 > ACL data: handle 42 flags 0x02 dlen 8
    L2CAP(d): cid 0x0040 len 4 [psm 3]
      RFCOMM(s): DM: cr 1 dlci 8 pf 0 ilen 0 fcs 0xf6
< ACL data: handle 42 flags 0x02 dlen 8
    L2CAP(d): cid 0x0041 len 4 [psm 3]
      RFCOMM(s): DISC: cr 1 dlci 0 pf 1 ilen 0 fcs 0xfd
< ACL data: handle 42 flags 0x02 dlen 12
    L2CAP(s): Disconn req: dcid 0x0041 scid 0x0040
 > HCI Event: Number of Completed Packets (0x13) plen 5
    handle 42 packets 1
 > HCI Event: Number of Completed Packets (0x13) plen 5
    handle 42 packets 1
 > ACL data: handle 42 flags 0x02 dlen 8
    L2CAP(d): cid 0x0040 len 4 [psm 3]
      RFCOMM(s): UA: cr 1 dlci 0 pf 1 ilen 0 fcs 0xd7
 > ACL data: handle 42 flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x0041 scid 0x0040
< HCI Command: Disconnect (0x01|0x0006) plen 3
    handle 42 reason 0x13
    Reason: Remote User Terminated Connection
 > HCI Event: Command Status (0x0f) plen 4
    Disconnect (0x01|0x0006) status 0x00 ncmd 1
 > HCI Event: Disconn Complete (0x05) plen 4
    status 0x00 handle 42 reason 0x16
    Reason: Connection Terminated by Local Host




>   
>> I am not sure I have paired.  If I did, does rebooting phone or linux
>> end that 'session' ?
>>     
>
> Maybe the channel numbers changed or you need to reactivate the DUN
> service.
>   
how did I activate it in the first place?

ck


_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
