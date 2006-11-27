Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <002801c7125f$7197b7f0$0100a8c0@kayleigh>
From: "Olivier Le Pogam" <olepogam@free.fr>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
References: <002901c710a8$0eab3580$0100a8c0@kayleigh>
	<1164536005.25914.8.camel@aeonflux.holtmann.net>
Date: Mon, 27 Nov 2006 21:05:53 +0100
Mime-Version: 1.0
Subject: Re: [Bluez-devel] Master / Slave question
Reply-To: Olivier Le Pogam <olepogam@free.fr>,
        BlueZ development <bluez-devel@lists.sourceforge.net>
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

Hi Marcel,

Re this, I've done what you advised :

>> I am trying to make 2 mobile phones connected concurrently
>> to a RFCOMM server. Please note that they don't support
>> role switching, so as they initiate the communication, they
>> are always "master".
>>
>> My RFCOMM server is a forking one so it can virtually
>> deal with concurrent clients like on TCP.
>>
>> I have put lm=accept in hcid.conf
>>
>> If I open a RFCOMM server on channel 14 and try to make
>> the 2 mobile connect to channel 14, the first is ok, the
>> second can't connect. I suppose that's normal, because
>> channel 14 "slave" is busy linux-side with the first
>> connection and a "slave" can deal with one connection only.
>>
>> Then I've launched a second server on channel 15 (server
>> on channel 14 running concurrently), and i try to make
>> the first mobile connect to channel 14 and the second
>> to channel 15 : it's the same, only the first can connect.
>>
>> I think I have a misunderstanding here, as i thought the
>> "master/slave" was per channel. Does it mean the "slave" status
>> is for the whole adaptor, and once a "slave" connection is
>> open on one channel, it can't receive other connections at all ?
>
> the master/slave thing is per ACL connection. However there can only be
> one ACL connection between two devices. Run "hcidump -X -V" and see
> what's the actual error message on the HCI level.

- I launch both servers, one on channel 14, the other on channel 15

- I have made a hcidump -X -V with only one mobile connecting to
server on channel 14, I have dlci : 28

- I have made a hcidump -X -V with only one mobile connecting to
server on channel 15, I have dlci : 30

- When trying to make both connect concurrently, one to channel 14
the other to channel 15, once the first is connected the second can't,
and I have **absolulety nothing** in the HCI dump related to the
failed attempt, i.e. I have a final log quite similar to a single connection
one to the channel that has been successful. Could there be a lock/mutual
exclusion somewhere in the BlueZ library ? Could one

Kernel : (I applied the MH7 patch) 2.6.18-1.2239_FC5_mh7

Please find the 3 logs below, and a piece of code :

log_14.txt for the connection on channel 14 only
log_15.txt for the connection on channel 14 only
log_14_15.txt for the concurrent connection attempt,
but successful on channel 14 only.
get_bluetooth_connection function, which is the
"server" main function

Many many thanks for helping me :(
I've certainly missed something obvious !!

Regards,
Oli

----------------------------------------------------------
log_14.txt
----------------------------------------------------------

HCI sniffer - Bluetooth packet analyzer ver 1.33
device: hci0 snap_len: 1028 filter: 0xffffffff
> HCI Event: Connect Request (0x04) plen 10
    bdaddr 00:16:4E:83:2D:19 class 0x520204 type ACL
< HCI Command: Accept Connection Request (0x01|0x0009) plen 7
    bdaddr 00:16:4E:83:2D:19 role 0x01
    Role: Slave
> HCI Event: Command Status (0x0f) plen 4
    Accept Connection Request (0x01|0x0009) status 0x00 ncmd 1
> HCI Event: Connect Complete (0x03) plen 11
    status 0x00 handle 1 bdaddr 00:16:4E:83:2D:19 type ACL encrypt 0x00
< HCI Command: Read Remote Supported Features (0x01|0x001b) plen 2
    handle 1
> HCI Event: Max Slots Change (0x1b) plen 3
    handle 1 slots 5
> HCI Event: Command Status (0x0f) plen 4
    Read Remote Supported Features (0x01|0x001b) status 0x00 ncmd 1
< HCI Command: Write Link Policy Settings (0x02|0x000d) plen 4
    handle 1 policy 0x0f
    Link policy: RSWITCH HOLD SNIFF PARK
> HCI Event: Command Complete (0x0e) plen 6
    Write Link Policy Settings (0x02|0x000d) ncmd 1
    status 0x00 handle 1
< HCI Command: Change Connection Packet Type (0x01|0x000f) plen 4
    handle 1 ptype 0xcc18
    Packet type: DM1 DM3 DM5 DH1 DH3 DH5
> HCI Event: Command Status (0x0f) plen 4
    Change Connection Packet Type (0x01|0x000f) status 0x00 ncmd 1
> HCI Event: Connection Packet Type Changed (0x1d) plen 5
    status 0x00 handle 1 ptype 0xcc18
    Packet type: DM1 DM3 DM5 DH1 DH3 DH5
> HCI Event: Connection Packet Type Changed (0x1d) plen 5
    status 0x00 handle 1 ptype 0xcc18
    Packet type: DM1 DM3 DM5 DH1 DH3 DH5
> ACL data: handle 1 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 3 scid 0x0040
< ACL data: handle 1 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0040 result 0 status 0
      Connection successful
> HCI Event: Read Remote Supported Features (0x0b) plen 11
    status 0x00 handle 1
    Features: 0xbf 0xee 0x0f 0x40 0x18 0x18 0x00 0x00
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 1 packets 1
> ACL data: handle 1 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 4
      MTU 32772
< ACL data: handle 1 flags 0x02 dlen 18
    L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 4
      Success
      MTU 32772
< ACL data: handle 1 flags 0x02 dlen 10
    L2CAP(s): Info req: type 2
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 1 packets 1
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 1 packets 1
> ACL data: handle 1 flags 0x02 dlen 16
    L2CAP(s): Info rsp: type 2 result 0
      Extended feature mask 0x0000
< ACL data: handle 1 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 4
      MTU 32772
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 1 packets 1
> ACL data: handle 1 flags 0x02 dlen 18
    L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 4
      Success
      MTU 32772
> ACL data: handle 1 flags 0x02 dlen 8
    L2CAP(d): cid 0x0040 len 4 [psm 3]
      RFCOMM(s): SABM: cr 1 dlci 0 pf 1 ilen 0 fcs 0x1c
< ACL data: handle 1 flags 0x02 dlen 8
    L2CAP(d): cid 0x0040 len 4 [psm 3]
      RFCOMM(s): UA: cr 1 dlci 0 pf 1 ilen 0 fcs 0xd7
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 1 packets 1
> ACL data: handle 1 flags 0x02 dlen 18
    L2CAP(d): cid 0x0040 len 14 [psm 3]
      RFCOMM(s): PN CMD: cr 1 dlci 0 pf 0 ilen 10 fcs 0x70 mcc_len 8
      dlci 28 frame_type 0 credit_flow 15 pri 0 ack_timer 0
      frame_size 1645 max_retrans 0 credits 0
< ACL data: handle 1 flags 0x02 dlen 18
    L2CAP(d): cid 0x0040 len 14 [psm 3]
      RFCOMM(s): PN RSP: cr 0 dlci 0 pf 0 ilen 10 fcs 0xaa mcc_len 8
      dlci 28 frame_type 0 credit_flow 14 pri 0 ack_timer 0
      frame_size 1645 max_retrans 0 credits 7
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 1 packets 1
> ACL data: handle 1 flags 0x02 dlen 8
    L2CAP(d): cid 0x0040 len 4 [psm 3]
      RFCOMM(s): SABM: cr 1 dlci 28 pf 1 ilen 0 fcs 0x28
< ACL data: handle 1 flags 0x02 dlen 8
    L2CAP(d): cid 0x0040 len 4 [psm 3]
      RFCOMM(s): UA: cr 1 dlci 28 pf 1 ilen 0 fcs 0xe3
< ACL data: handle 1 flags 0x02 dlen 12
    L2CAP(d): cid 0x0040 len 8 [psm 3]
      RFCOMM(s): MSC CMD: cr 0 dlci 0 pf 0 ilen 4 fcs 0xaa mcc_len 2
      dlci 28 fc 0 rtc 1 rtr 1 ic 0 dv 1 b1 1 b2 1 b3 0 len 0
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 1 packets 1
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 1 packets 1
> ACL data: handle 1 flags 0x02 dlen 12
    L2CAP(d): cid 0x0040 len 8 [psm 3]
      RFCOMM(s): MSC CMD: cr 1 dlci 0 pf 0 ilen 4 fcs 0x70 mcc_len 2
      dlci 28 fc 0 rtc 1 rtr 1 ic 0 dv 0 b1 1 b2 1 b3 0 len 0
< ACL data: handle 1 flags 0x02 dlen 12
    L2CAP(d): cid 0x0040 len 8 [psm 3]
      RFCOMM(s): MSC RSP: cr 0 dlci 0 pf 0 ilen 4 fcs 0xaa mcc_len 2
      dlci 28 fc 0 rtc 1 rtr 1 ic 0 dv 0 b1 1 b2 1 b3 0 len 0
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 1 packets 1
> ACL data: handle 1 flags 0x02 dlen 12
    L2CAP(d): cid 0x0040 len 8 [psm 3]
      RFCOMM(s): MSC RSP: cr 1 dlci 0 pf 0 ilen 4 fcs 0x70 mcc_len 2
      dlci 28 fc 0 rtc 1 rtr 1 ic 0 dv 1 b1 1 b2 1 b3 0 len 0
< ACL data: handle 1 flags 0x02 dlen 9
    L2CAP(d): cid 0x0040 len 5 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 28 pf 1 ilen 0 fcs 0xdd credits 33
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 1 packets 1
> ACL data: handle 1 flags 0x02 dlen 9
    L2CAP(d): cid 0x0040 len 5 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 28 pf 1 ilen 0 fcs 0x7 credits 2
> ACL data: handle 1 flags 0x02 dlen 10
    L2CAP(d): cid 0x0040 len 6 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 28 pf 0 ilen 2 fcs 0x1b
      0000: 30 0a                                             0.
< ACL data: handle 1 flags 0x02 dlen 10
    L2CAP(d): cid 0x0040 len 6 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 28 pf 0 ilen 2 fcs 0xc1
      0000: 30 0a                                             0.
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 1 packets 1
> ACL data: handle 1 flags 0x02 dlen 9
    L2CAP(d): cid 0x0040 len 5 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 28 pf 1 ilen 0 fcs 0x7 credits 1
> ACL data: handle 1 flags 0x02 dlen 10
    L2CAP(d): cid 0x0040 len 6 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 28 pf 0 ilen 2 fcs 0x1b
      0000: 31 0a                                             1.
< ACL data: handle 1 flags 0x02 dlen 10
    L2CAP(d): cid 0x0040 len 6 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 28 pf 0 ilen 2 fcs 0xc1
      0000: 31 0a                                             1.
> ACL data: handle 1 flags 0x02 dlen 9
    L2CAP(d): cid 0x0040 len 5 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 28 pf 1 ilen 0 fcs 0x7 credits 1
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 1 packets 1
> ACL data: handle 1 flags 0x02 dlen 10
    L2CAP(d): cid 0x0040 len 6 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 28 pf 0 ilen 2 fcs 0x1b
      0000: 32 0a                                             2.
< ACL data: handle 1 flags 0x02 dlen 10
    L2CAP(d): cid 0x0040 len 6 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 28 pf 0 ilen 2 fcs 0xc1
      0000: 32 0a                                             2.
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 1 packets 1
> ACL data: handle 1 flags 0x02 dlen 9
    L2CAP(d): cid 0x0040 len 5 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 28 pf 1 ilen 0 fcs 0x7 credits 1
> ACL data: handle 1 flags 0x02 dlen 10
    L2CAP(d): cid 0x0040 len 6 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 28 pf 0 ilen 2 fcs 0x1b
      0000: 33 0a                                             3.
< ACL data: handle 1 flags 0x02 dlen 10
    L2CAP(d): cid 0x0040 len 6 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 28 pf 0 ilen 2 fcs 0xc1
      0000: 33 0a                                             3.
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 1 packets 1
> ACL data: handle 1 flags 0x02 dlen 9
    L2CAP(d): cid 0x0040 len 5 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 28 pf 1 ilen 0 fcs 0x7 credits 1
> ACL data: handle 1 flags 0x02 dlen 10
    L2CAP(d): cid 0x0040 len 6 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 28 pf 0 ilen 2 fcs 0x1b
      0000: 34 0a                                             4.
< ACL data: handle 1 flags 0x02 dlen 10
    L2CAP(d): cid 0x0040 len 6 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 28 pf 0 ilen 2 fcs 0xc1
      0000: 34 0a                                             4.
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 1 packets 1
> ACL data: handle 1 flags 0x02 dlen 9
    L2CAP(d): cid 0x0040 len 5 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 28 pf 1 ilen 0 fcs 0x7 credits 1
> ACL data: handle 1 flags 0x02 dlen 10
    L2CAP(d): cid 0x0040 len 6 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 28 pf 0 ilen 2 fcs 0x1b
      0000: 35 0a                                             5.
< ACL data: handle 1 flags 0x02 dlen 10
    L2CAP(d): cid 0x0040 len 6 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 28 pf 0 ilen 2 fcs 0xc1
      0000: 35 0a                                             5.
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 1 packets 1
> ACL data: handle 1 flags 0x02 dlen 9
    L2CAP(d): cid 0x0040 len 5 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 28 pf 1 ilen 0 fcs 0x7 credits 1
> ACL data: handle 1 flags 0x02 dlen 10
    L2CAP(d): cid 0x0040 len 6 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 28 pf 0 ilen 2 fcs 0x1b
      0000: 36 0a                                             6.
< ACL data: handle 1 flags 0x02 dlen 10
    L2CAP(d): cid 0x0040 len 6 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 28 pf 0 ilen 2 fcs 0xc1
      0000: 36 0a                                             6.
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 1 packets 1
> ACL data: handle 1 flags 0x02 dlen 9
    L2CAP(d): cid 0x0040 len 5 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 28 pf 1 ilen 0 fcs 0x7 credits 1
> ACL data: handle 1 flags 0x02 dlen 10
    L2CAP(d): cid 0x0040 len 6 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 28 pf 0 ilen 2 fcs 0x1b
      0000: 37 0a                                             7.
< ACL data: handle 1 flags 0x02 dlen 10
    L2CAP(d): cid 0x0040 len 6 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 28 pf 0 ilen 2 fcs 0xc1
      0000: 37 0a                                             7.
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 1 packets 1
> ACL data: handle 1 flags 0x02 dlen 9
    L2CAP(d): cid 0x0040 len 5 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 28 pf 1 ilen 0 fcs 0x7 credits 1
> ACL data: handle 1 flags 0x02 dlen 10
    L2CAP(d): cid 0x0040 len 6 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 28 pf 0 ilen 2 fcs 0x1b
      0000: 38 0a                                             8.
< ACL data: handle 1 flags 0x02 dlen 10
    L2CAP(d): cid 0x0040 len 6 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 28 pf 0 ilen 2 fcs 0xc1
      0000: 38 0a                                             8.
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 1 packets 1
> ACL data: handle 1 flags 0x02 dlen 9
    L2CAP(d): cid 0x0040 len 5 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 28 pf 1 ilen 0 fcs 0x7 credits 1
> ACL data: handle 1 flags 0x02 dlen 10
    L2CAP(d): cid 0x0040 len 6 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 28 pf 0 ilen 2 fcs 0x1b
      0000: 39 0a                                             9.
< ACL data: handle 1 flags 0x02 dlen 10
    L2CAP(d): cid 0x0040 len 6 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 28 pf 0 ilen 2 fcs 0xc1
      0000: 39 0a                                             9.
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 1 packets 1
> ACL data: handle 1 flags 0x02 dlen 9
    L2CAP(d): cid 0x0040 len 5 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 28 pf 1 ilen 0 fcs 0x7 credits 1
> ACL data: handle 1 flags 0x02 dlen 8
    L2CAP(d): cid 0x0040 len 4 [psm 3]
      RFCOMM(s): DISC: cr 1 dlci 28 pf 1 ilen 0 fcs 0xc9
< ACL data: handle 1 flags 0x02 dlen 8
    L2CAP(d): cid 0x0040 len 4 [psm 3]
      RFCOMM(s): UA: cr 1 dlci 28 pf 1 ilen 0 fcs 0xe3
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 1 packets 1
> ACL data: handle 1 flags 0x02 dlen 8
    L2CAP(d): cid 0x0040 len 4 [psm 3]
      RFCOMM(s): DISC: cr 1 dlci 0 pf 1 ilen 0 fcs 0xfd
< ACL data: handle 1 flags 0x02 dlen 8
    L2CAP(d): cid 0x0040 len 4 [psm 3]
      RFCOMM(s): UA: cr 1 dlci 0 pf 1 ilen 0 fcs 0xd7
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 1 packets 1
> ACL data: handle 1 flags 0x02 dlen 12
    L2CAP(s): Disconn req: dcid 0x0040 scid 0x0040
< ACL data: handle 1 flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x0040 scid 0x0040
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 1 packets 1
> HCI Event: Disconn Complete (0x05) plen 4
    status 0x00 handle 1 reason 0x13
    Reason: Remote User Terminated Connection

----------------------------------------------------------
log_15.txt
----------------------------------------------------------

HCI sniffer - Bluetooth packet analyzer ver 1.33
device: hci0 snap_len: 1028 filter: 0xffffffff
> HCI Event: Connect Request (0x04) plen 10
    bdaddr 00:18:C5:FE:C4:7F class 0x520204 type ACL
< HCI Command: Accept Connection Request (0x01|0x0009) plen 7
    bdaddr 00:18:C5:FE:C4:7F role 0x01
    Role: Slave
> HCI Event: Command Status (0x0f) plen 4
    Accept Connection Request (0x01|0x0009) status 0x00 ncmd 1
> HCI Event: Connect Complete (0x03) plen 11
    status 0x00 handle 1 bdaddr 00:18:C5:FE:C4:7F type ACL encrypt 0x00
< HCI Command: Read Remote Supported Features (0x01|0x001b) plen 2
    handle 1
> HCI Event: Max Slots Change (0x1b) plen 3
    handle 1 slots 5
> HCI Event: Command Status (0x0f) plen 4
    Read Remote Supported Features (0x01|0x001b) status 0x00 ncmd 1
< HCI Command: Write Link Policy Settings (0x02|0x000d) plen 4
    handle 1 policy 0x0f
    Link policy: RSWITCH HOLD SNIFF PARK
> HCI Event: Command Complete (0x0e) plen 6
    Write Link Policy Settings (0x02|0x000d) ncmd 1
    status 0x00 handle 1
< HCI Command: Change Connection Packet Type (0x01|0x000f) plen 4
    handle 1 ptype 0xcc18
    Packet type: DM1 DM3 DM5 DH1 DH3 DH5
> HCI Event: Connection Packet Type Changed (0x1d) plen 5
    status 0x00 handle 1 ptype 0xcc18
    Packet type: DM1 DM3 DM5 DH1 DH3 DH5
> HCI Event: Command Status (0x0f) plen 4
    Change Connection Packet Type (0x01|0x000f) status 0x00 ncmd 1
> HCI Event: Connection Packet Type Changed (0x1d) plen 5
    status 0x00 handle 1 ptype 0xcc18
    Packet type: DM1 DM3 DM5 DH1 DH3 DH5
> HCI Event: Read Remote Supported Features (0x0b) plen 11
    status 0x00 handle 1
    Features: 0xbf 0xee 0x0f 0xc6 0x9a 0x39 0x00 0x00
> ACL data: handle 1 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 3 scid 0x0040
< ACL data: handle 1 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0040 result 0 status 0
      Connection successful
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 1 packets 1
> ACL data: handle 1 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 4
      MTU 32772
< ACL data: handle 1 flags 0x02 dlen 18
    L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 4
      Success
      MTU 32772
< ACL data: handle 1 flags 0x02 dlen 10
    L2CAP(s): Info req: type 2
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 1 packets 1
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 1 packets 1
> ACL data: handle 1 flags 0x02 dlen 16
    L2CAP(s): Info rsp: type 2 result 0
      Extended feature mask 0x0000
< ACL data: handle 1 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 4
      MTU 32772
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 1 packets 1
> ACL data: handle 1 flags 0x02 dlen 18
    L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 4
      Success
      MTU 32772
> ACL data: handle 1 flags 0x02 dlen 8
    L2CAP(d): cid 0x0040 len 4 [psm 3]
      RFCOMM(s): SABM: cr 1 dlci 0 pf 1 ilen 0 fcs 0x1c
< ACL data: handle 1 flags 0x02 dlen 8
    L2CAP(d): cid 0x0040 len 4 [psm 3]
      RFCOMM(s): UA: cr 1 dlci 0 pf 1 ilen 0 fcs 0xd7
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 1 packets 1
> ACL data: handle 1 flags 0x02 dlen 18
    L2CAP(d): cid 0x0040 len 14 [psm 3]
      RFCOMM(s): PN CMD: cr 1 dlci 0 pf 0 ilen 10 fcs 0x70 mcc_len 8
      dlci 30 frame_type 0 credit_flow 15 pri 0 ack_timer 0
      frame_size 4935 max_retrans 0 credits 0
< ACL data: handle 1 flags 0x02 dlen 18
    L2CAP(d): cid 0x0040 len 14 [psm 3]
      RFCOMM(s): PN RSP: cr 0 dlci 0 pf 0 ilen 10 fcs 0xaa mcc_len 8
      dlci 30 frame_type 0 credit_flow 14 pri 0 ack_timer 0
      frame_size 4935 max_retrans 0 credits 7
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 1 packets 1
> ACL data: handle 1 flags 0x02 dlen 8
    L2CAP(d): cid 0x0040 len 4 [psm 3]
      RFCOMM(s): SABM: cr 1 dlci 30 pf 1 ilen 0 fcs 0x6d
< ACL data: handle 1 flags 0x02 dlen 8
    L2CAP(d): cid 0x0040 len 4 [psm 3]
      RFCOMM(s): UA: cr 1 dlci 30 pf 1 ilen 0 fcs 0xa6
< ACL data: handle 1 flags 0x02 dlen 12
    L2CAP(d): cid 0x0040 len 8 [psm 3]
      RFCOMM(s): MSC CMD: cr 0 dlci 0 pf 0 ilen 4 fcs 0xaa mcc_len 2
      dlci 30 fc 0 rtc 1 rtr 1 ic 0 dv 1 b1 1 b2 1 b3 0 len 0
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 1 packets 1
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 1 packets 1
> ACL data: handle 1 flags 0x02 dlen 12
    L2CAP(d): cid 0x0040 len 8 [psm 3]
      RFCOMM(s): MSC CMD: cr 1 dlci 0 pf 0 ilen 4 fcs 0x70 mcc_len 2
      dlci 30 fc 0 rtc 1 rtr 1 ic 0 dv 0 b1 1 b2 1 b3 0 len 0
< ACL data: handle 1 flags 0x02 dlen 12
    L2CAP(d): cid 0x0040 len 8 [psm 3]
      RFCOMM(s): MSC RSP: cr 0 dlci 0 pf 0 ilen 4 fcs 0xaa mcc_len 2
      dlci 30 fc 0 rtc 1 rtr 1 ic 0 dv 0 b1 1 b2 1 b3 0 len 0
> ACL data: handle 1 flags 0x02 dlen 12
    L2CAP(d): cid 0x0040 len 8 [psm 3]
      RFCOMM(s): MSC RSP: cr 1 dlci 0 pf 0 ilen 4 fcs 0x70 mcc_len 2
      dlci 30 fc 0 rtc 1 rtr 1 ic 0 dv 1 b1 1 b2 1 b3 0 len 0
< ACL data: handle 1 flags 0x02 dlen 9
    L2CAP(d): cid 0x0040 len 5 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 30 pf 1 ilen 0 fcs 0x37 credits 33
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 1 packets 1
> ACL data: handle 1 flags 0x02 dlen 9
    L2CAP(d): cid 0x0040 len 5 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 30 pf 1 ilen 0 fcs 0xed credits 2
> ACL data: handle 1 flags 0x02 dlen 10
    L2CAP(d): cid 0x0040 len 6 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 30 pf 0 ilen 2 fcs 0xf1
      0000: 30 0a                                             0.
< ACL data: handle 1 flags 0x02 dlen 10
    L2CAP(d): cid 0x0040 len 6 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 30 pf 0 ilen 2 fcs 0x2b
      0000: 30 0a                                             0.
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 1 packets 1
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 1 packets 1
> ACL data: handle 1 flags 0x02 dlen 9
    L2CAP(d): cid 0x0040 len 5 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 30 pf 1 ilen 0 fcs 0xed credits 1
> ACL data: handle 1 flags 0x02 dlen 10
    L2CAP(d): cid 0x0040 len 6 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 30 pf 0 ilen 2 fcs 0xf1
      0000: 31 0a                                             1.
< ACL data: handle 1 flags 0x02 dlen 10
    L2CAP(d): cid 0x0040 len 6 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 30 pf 0 ilen 2 fcs 0x2b
      0000: 31 0a                                             1.
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 1 packets 1
> ACL data: handle 1 flags 0x02 dlen 9
    L2CAP(d): cid 0x0040 len 5 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 30 pf 1 ilen 0 fcs 0xed credits 1
> ACL data: handle 1 flags 0x02 dlen 10
    L2CAP(d): cid 0x0040 len 6 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 30 pf 0 ilen 2 fcs 0xf1
      0000: 32 0a                                             2.
< ACL data: handle 1 flags 0x02 dlen 10
    L2CAP(d): cid 0x0040 len 6 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 30 pf 0 ilen 2 fcs 0x2b
      0000: 32 0a                                             2.
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 1 packets 1
> ACL data: handle 1 flags 0x02 dlen 9
    L2CAP(d): cid 0x0040 len 5 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 30 pf 1 ilen 0 fcs 0xed credits 1
> ACL data: handle 1 flags 0x02 dlen 10
    L2CAP(d): cid 0x0040 len 6 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 30 pf 0 ilen 2 fcs 0xf1
      0000: 33 0a                                             3.
< ACL data: handle 1 flags 0x02 dlen 10
    L2CAP(d): cid 0x0040 len 6 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 30 pf 0 ilen 2 fcs 0x2b
      0000: 33 0a                                             3.
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 1 packets 1
> ACL data: handle 1 flags 0x02 dlen 9
    L2CAP(d): cid 0x0040 len 5 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 30 pf 1 ilen 0 fcs 0xed credits 1
> ACL data: handle 1 flags 0x02 dlen 10
    L2CAP(d): cid 0x0040 len 6 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 30 pf 0 ilen 2 fcs 0xf1
      0000: 34 0a                                             4.
< ACL data: handle 1 flags 0x02 dlen 10
    L2CAP(d): cid 0x0040 len 6 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 30 pf 0 ilen 2 fcs 0x2b
      0000: 34 0a                                             4.
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 1 packets 1
> ACL data: handle 1 flags 0x02 dlen 9
    L2CAP(d): cid 0x0040 len 5 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 30 pf 1 ilen 0 fcs 0xed credits 1
> ACL data: handle 1 flags 0x02 dlen 10
    L2CAP(d): cid 0x0040 len 6 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 30 pf 0 ilen 2 fcs 0xf1
      0000: 35 0a                                             5.
< ACL data: handle 1 flags 0x02 dlen 10
    L2CAP(d): cid 0x0040 len 6 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 30 pf 0 ilen 2 fcs 0x2b
      0000: 35 0a                                             5.
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 1 packets 1
> ACL data: handle 1 flags 0x02 dlen 9
    L2CAP(d): cid 0x0040 len 5 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 30 pf 1 ilen 0 fcs 0xed credits 1
> ACL data: handle 1 flags 0x02 dlen 10
    L2CAP(d): cid 0x0040 len 6 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 30 pf 0 ilen 2 fcs 0xf1
      0000: 36 0a                                             6.
< ACL data: handle 1 flags 0x02 dlen 10
    L2CAP(d): cid 0x0040 len 6 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 30 pf 0 ilen 2 fcs 0x2b
      0000: 36 0a                                             6.
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 1 packets 1
> ACL data: handle 1 flags 0x02 dlen 9
    L2CAP(d): cid 0x0040 len 5 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 30 pf 1 ilen 0 fcs 0xed credits 1
> ACL data: handle 1 flags 0x02 dlen 10
    L2CAP(d): cid 0x0040 len 6 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 30 pf 0 ilen 2 fcs 0xf1
      0000: 37 0a                                             7.
< ACL data: handle 1 flags 0x02 dlen 10
    L2CAP(d): cid 0x0040 len 6 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 30 pf 0 ilen 2 fcs 0x2b
      0000: 37 0a                                             7.
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 1 packets 1
> ACL data: handle 1 flags 0x02 dlen 9
    L2CAP(d): cid 0x0040 len 5 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 30 pf 1 ilen 0 fcs 0xed credits 1
> ACL data: handle 1 flags 0x02 dlen 10
    L2CAP(d): cid 0x0040 len 6 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 30 pf 0 ilen 2 fcs 0xf1
      0000: 38 0a                                             8.
< ACL data: handle 1 flags 0x02 dlen 10
    L2CAP(d): cid 0x0040 len 6 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 30 pf 0 ilen 2 fcs 0x2b
      0000: 38 0a                                             8.
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 1 packets 1
> ACL data: handle 1 flags 0x02 dlen 9
    L2CAP(d): cid 0x0040 len 5 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 30 pf 1 ilen 0 fcs 0xed credits 1
> ACL data: handle 1 flags 0x02 dlen 10
    L2CAP(d): cid 0x0040 len 6 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 30 pf 0 ilen 2 fcs 0xf1
      0000: 39 0a                                             9.
< ACL data: handle 1 flags 0x02 dlen 10
    L2CAP(d): cid 0x0040 len 6 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 30 pf 0 ilen 2 fcs 0x2b
      0000: 39 0a                                             9.
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 1 packets 1
> ACL data: handle 1 flags 0x02 dlen 9
    L2CAP(d): cid 0x0040 len 5 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 30 pf 1 ilen 0 fcs 0xed credits 1
> ACL data: handle 1 flags 0x02 dlen 8
    L2CAP(d): cid 0x0040 len 4 [psm 3]
      RFCOMM(s): DISC: cr 1 dlci 30 pf 1 ilen 0 fcs 0x8c
< ACL data: handle 1 flags 0x02 dlen 8
    L2CAP(d): cid 0x0040 len 4 [psm 3]
      RFCOMM(s): UA: cr 1 dlci 30 pf 1 ilen 0 fcs 0xa6
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 1 packets 1
> ACL data: handle 1 flags 0x02 dlen 8
    L2CAP(d): cid 0x0040 len 4 [psm 3]
      RFCOMM(s): DISC: cr 1 dlci 0 pf 1 ilen 0 fcs 0xfd
< ACL data: handle 1 flags 0x02 dlen 8
    L2CAP(d): cid 0x0040 len 4 [psm 3]
      RFCOMM(s): UA: cr 1 dlci 0 pf 1 ilen 0 fcs 0xd7
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 1 packets 1
> ACL data: handle 1 flags 0x02 dlen 12
    L2CAP(s): Disconn req: dcid 0x0040 scid 0x0040
< ACL data: handle 1 flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x0040 scid 0x0040
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 1 packets 1
> HCI Event: Disconn Complete (0x05) plen 4
    status 0x00 handle 1 reason 0x13
    Reason: Remote User Terminated Connection



----------------------------------------------------------
log_14_15.txt
----------------------------------------------------------

HCI sniffer - Bluetooth packet analyzer ver 1.33
device: hci0 snap_len: 1028 filter: 0xffffffff
> HCI Event: Connect Request (0x04) plen 10
    bdaddr 00:16:4E:83:2D:19 class 0x520204 type ACL
< HCI Command: Accept Connection Request (0x01|0x0009) plen 7
    bdaddr 00:16:4E:83:2D:19 role 0x01
    Role: Slave
> HCI Event: Command Status (0x0f) plen 4
    Accept Connection Request (0x01|0x0009) status 0x00 ncmd 1
> HCI Event: Connect Complete (0x03) plen 11
    status 0x00 handle 1 bdaddr 00:16:4E:83:2D:19 type ACL encrypt 0x00
< HCI Command: Read Remote Supported Features (0x01|0x001b) plen 2
    handle 1
> HCI Event: Max Slots Change (0x1b) plen 3
    handle 1 slots 5
> HCI Event: Command Status (0x0f) plen 4
    Read Remote Supported Features (0x01|0x001b) status 0x00 ncmd 1
< HCI Command: Write Link Policy Settings (0x02|0x000d) plen 4
    handle 1 policy 0x0f
    Link policy: RSWITCH HOLD SNIFF PARK
> HCI Event: Command Complete (0x0e) plen 6
    Write Link Policy Settings (0x02|0x000d) ncmd 1
    status 0x00 handle 1
< HCI Command: Change Connection Packet Type (0x01|0x000f) plen 4
    handle 1 ptype 0xcc18
    Packet type: DM1 DM3 DM5 DH1 DH3 DH5
> HCI Event: Command Status (0x0f) plen 4
    Change Connection Packet Type (0x01|0x000f) status 0x00 ncmd 1
> HCI Event: Connection Packet Type Changed (0x1d) plen 5
    status 0x00 handle 1 ptype 0xcc18
    Packet type: DM1 DM3 DM5 DH1 DH3 DH5
> HCI Event: Connection Packet Type Changed (0x1d) plen 5
    status 0x00 handle 1 ptype 0xcc18
    Packet type: DM1 DM3 DM5 DH1 DH3 DH5
> ACL data: handle 1 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 3 scid 0x0040
< ACL data: handle 1 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0040 result 0 status 0
      Connection successful
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 1 packets 1
> HCI Event: Read Remote Supported Features (0x0b) plen 11
    status 0x00 handle 1
    Features: 0xbf 0xee 0x0f 0x40 0x18 0x18 0x00 0x00
> ACL data: handle 1 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 4
      MTU 32772
< ACL data: handle 1 flags 0x02 dlen 18
    L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 4
      Success
      MTU 32772
< ACL data: handle 1 flags 0x02 dlen 10
    L2CAP(s): Info req: type 2
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 1 packets 1
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 1 packets 1
> ACL data: handle 1 flags 0x02 dlen 16
    L2CAP(s): Info rsp: type 2 result 0
      Extended feature mask 0x0000
< ACL data: handle 1 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 4
      MTU 32772
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 1 packets 1
> ACL data: handle 1 flags 0x02 dlen 18
    L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 4
      Success
      MTU 32772
> ACL data: handle 1 flags 0x02 dlen 8
    L2CAP(d): cid 0x0040 len 4 [psm 3]
      RFCOMM(s): SABM: cr 1 dlci 0 pf 1 ilen 0 fcs 0x1c
< ACL data: handle 1 flags 0x02 dlen 8
    L2CAP(d): cid 0x0040 len 4 [psm 3]
      RFCOMM(s): UA: cr 1 dlci 0 pf 1 ilen 0 fcs 0xd7
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 1 packets 1
> ACL data: handle 1 flags 0x02 dlen 18
    L2CAP(d): cid 0x0040 len 14 [psm 3]
      RFCOMM(s): PN CMD: cr 1 dlci 0 pf 0 ilen 10 fcs 0x70 mcc_len 8
      dlci 28 frame_type 0 credit_flow 15 pri 0 ack_timer 0
      frame_size 1645 max_retrans 0 credits 0
< ACL data: handle 1 flags 0x02 dlen 18
    L2CAP(d): cid 0x0040 len 14 [psm 3]
      RFCOMM(s): PN RSP: cr 0 dlci 0 pf 0 ilen 10 fcs 0xaa mcc_len 8
      dlci 28 frame_type 0 credit_flow 14 pri 0 ack_timer 0
      frame_size 1645 max_retrans 0 credits 7
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 1 packets 1
> ACL data: handle 1 flags 0x02 dlen 8
    L2CAP(d): cid 0x0040 len 4 [psm 3]
      RFCOMM(s): SABM: cr 1 dlci 28 pf 1 ilen 0 fcs 0x28
< ACL data: handle 1 flags 0x02 dlen 8
    L2CAP(d): cid 0x0040 len 4 [psm 3]
      RFCOMM(s): UA: cr 1 dlci 28 pf 1 ilen 0 fcs 0xe3
< ACL data: handle 1 flags 0x02 dlen 12
    L2CAP(d): cid 0x0040 len 8 [psm 3]
      RFCOMM(s): MSC CMD: cr 0 dlci 0 pf 0 ilen 4 fcs 0xaa mcc_len 2
      dlci 28 fc 0 rtc 1 rtr 1 ic 0 dv 1 b1 1 b2 1 b3 0 len 0
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 1 packets 1
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 1 packets 1
> ACL data: handle 1 flags 0x02 dlen 12
    L2CAP(d): cid 0x0040 len 8 [psm 3]
      RFCOMM(s): MSC CMD: cr 1 dlci 0 pf 0 ilen 4 fcs 0x70 mcc_len 2
      dlci 28 fc 0 rtc 1 rtr 1 ic 0 dv 0 b1 1 b2 1 b3 0 len 0
< ACL data: handle 1 flags 0x02 dlen 12
    L2CAP(d): cid 0x0040 len 8 [psm 3]
      RFCOMM(s): MSC RSP: cr 0 dlci 0 pf 0 ilen 4 fcs 0xaa mcc_len 2
      dlci 28 fc 0 rtc 1 rtr 1 ic 0 dv 0 b1 1 b2 1 b3 0 len 0
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 1 packets 1
> ACL data: handle 1 flags 0x02 dlen 12
    L2CAP(d): cid 0x0040 len 8 [psm 3]
      RFCOMM(s): MSC RSP: cr 1 dlci 0 pf 0 ilen 4 fcs 0x70 mcc_len 2
      dlci 28 fc 0 rtc 1 rtr 1 ic 0 dv 1 b1 1 b2 1 b3 0 len 0
< ACL data: handle 1 flags 0x02 dlen 9
    L2CAP(d): cid 0x0040 len 5 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 28 pf 1 ilen 0 fcs 0xdd credits 33
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 1 packets 1
> ACL data: handle 1 flags 0x02 dlen 9
    L2CAP(d): cid 0x0040 len 5 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 28 pf 1 ilen 0 fcs 0x7 credits 2
> ACL data: handle 1 flags 0x02 dlen 10
    L2CAP(d): cid 0x0040 len 6 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 28 pf 0 ilen 2 fcs 0x1b
      0000: 30 0a                                             0.
< ACL data: handle 1 flags 0x02 dlen 10
    L2CAP(d): cid 0x0040 len 6 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 28 pf 0 ilen 2 fcs 0xc1
      0000: 30 0a                                             0.
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 1 packets 1
> ACL data: handle 1 flags 0x02 dlen 9
    L2CAP(d): cid 0x0040 len 5 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 28 pf 1 ilen 0 fcs 0x7 credits 1
> ACL data: handle 1 flags 0x02 dlen 10
    L2CAP(d): cid 0x0040 len 6 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 28 pf 0 ilen 2 fcs 0x1b
      0000: 31 0a                                             1.
< ACL data: handle 1 flags 0x02 dlen 10
    L2CAP(d): cid 0x0040 len 6 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 28 pf 0 ilen 2 fcs 0xc1
      0000: 31 0a                                             1.
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 1 packets 1
> ACL data: handle 1 flags 0x02 dlen 9
    L2CAP(d): cid 0x0040 len 5 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 28 pf 1 ilen 0 fcs 0x7 credits 1
> ACL data: handle 1 flags 0x02 dlen 10
    L2CAP(d): cid 0x0040 len 6 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 28 pf 0 ilen 2 fcs 0x1b
      0000: 32 0a                                             2.
< ACL data: handle 1 flags 0x02 dlen 10
    L2CAP(d): cid 0x0040 len 6 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 28 pf 0 ilen 2 fcs 0xc1
      0000: 32 0a                                             2.
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 1 packets 1
> ACL data: handle 1 flags 0x02 dlen 9
    L2CAP(d): cid 0x0040 len 5 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 28 pf 1 ilen 0 fcs 0x7 credits 1
> ACL data: handle 1 flags 0x02 dlen 10
    L2CAP(d): cid 0x0040 len 6 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 28 pf 0 ilen 2 fcs 0x1b
      0000: 33 0a                                             3.
< ACL data: handle 1 flags 0x02 dlen 10
    L2CAP(d): cid 0x0040 len 6 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 28 pf 0 ilen 2 fcs 0xc1
      0000: 33 0a                                             3.
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 1 packets 1
> ACL data: handle 1 flags 0x02 dlen 9
    L2CAP(d): cid 0x0040 len 5 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 28 pf 1 ilen 0 fcs 0x7 credits 1
> ACL data: handle 1 flags 0x02 dlen 10
    L2CAP(d): cid 0x0040 len 6 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 28 pf 0 ilen 2 fcs 0x1b
      0000: 34 0a                                             4.
< ACL data: handle 1 flags 0x02 dlen 10
    L2CAP(d): cid 0x0040 len 6 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 28 pf 0 ilen 2 fcs 0xc1
      0000: 34 0a                                             4.
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 1 packets 1
> ACL data: handle 1 flags 0x02 dlen 9
    L2CAP(d): cid 0x0040 len 5 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 28 pf 1 ilen 0 fcs 0x7 credits 1
> ACL data: handle 1 flags 0x02 dlen 10
    L2CAP(d): cid 0x0040 len 6 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 28 pf 0 ilen 2 fcs 0x1b
      0000: 35 0a                                             5.
< ACL data: handle 1 flags 0x02 dlen 10
    L2CAP(d): cid 0x0040 len 6 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 28 pf 0 ilen 2 fcs 0xc1
      0000: 35 0a                                             5.
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 1 packets 1
> ACL data: handle 1 flags 0x02 dlen 9
    L2CAP(d): cid 0x0040 len 5 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 28 pf 1 ilen 0 fcs 0x7 credits 1
> ACL data: handle 1 flags 0x02 dlen 10
    L2CAP(d): cid 0x0040 len 6 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 28 pf 0 ilen 2 fcs 0x1b
      0000: 36 0a                                             6.
< ACL data: handle 1 flags 0x02 dlen 10
    L2CAP(d): cid 0x0040 len 6 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 28 pf 0 ilen 2 fcs 0xc1
      0000: 36 0a                                             6.
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 1 packets 1
> ACL data: handle 1 flags 0x02 dlen 9
    L2CAP(d): cid 0x0040 len 5 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 28 pf 1 ilen 0 fcs 0x7 credits 1
> ACL data: handle 1 flags 0x02 dlen 10
    L2CAP(d): cid 0x0040 len 6 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 28 pf 0 ilen 2 fcs 0x1b
      0000: 37 0a                                             7.
< ACL data: handle 1 flags 0x02 dlen 10
    L2CAP(d): cid 0x0040 len 6 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 28 pf 0 ilen 2 fcs 0xc1
      0000: 37 0a                                             7.
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 1 packets 1
> ACL data: handle 1 flags 0x02 dlen 9
    L2CAP(d): cid 0x0040 len 5 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 28 pf 1 ilen 0 fcs 0x7 credits 1
> ACL data: handle 1 flags 0x02 dlen 10
    L2CAP(d): cid 0x0040 len 6 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 28 pf 0 ilen 2 fcs 0x1b
      0000: 38 0a                                             8.
< ACL data: handle 1 flags 0x02 dlen 10
    L2CAP(d): cid 0x0040 len 6 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 28 pf 0 ilen 2 fcs 0xc1
      0000: 38 0a                                             8.
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 1 packets 1
> ACL data: handle 1 flags 0x02 dlen 9
    L2CAP(d): cid 0x0040 len 5 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 28 pf 1 ilen 0 fcs 0x7 credits 1
> ACL data: handle 1 flags 0x02 dlen 10
    L2CAP(d): cid 0x0040 len 6 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 28 pf 0 ilen 2 fcs 0x1b
      0000: 39 0a                                             9.
< ACL data: handle 1 flags 0x02 dlen 10
    L2CAP(d): cid 0x0040 len 6 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 28 pf 0 ilen 2 fcs 0xc1
      0000: 39 0a                                             9.
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 1 packets 1
> ACL data: handle 1 flags 0x02 dlen 9
    L2CAP(d): cid 0x0040 len 5 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 28 pf 1 ilen 0 fcs 0x7 credits 1
> ACL data: handle 1 flags 0x02 dlen 8
    L2CAP(d): cid 0x0040 len 4 [psm 3]
      RFCOMM(s): DISC: cr 1 dlci 28 pf 1 ilen 0 fcs 0xc9
< ACL data: handle 1 flags 0x02 dlen 8
    L2CAP(d): cid 0x0040 len 4 [psm 3]
      RFCOMM(s): UA: cr 1 dlci 28 pf 1 ilen 0 fcs 0xe3
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 1 packets 1
> ACL data: handle 1 flags 0x02 dlen 8
    L2CAP(d): cid 0x0040 len 4 [psm 3]
      RFCOMM(s): DISC: cr 1 dlci 0 pf 1 ilen 0 fcs 0xfd
< ACL data: handle 1 flags 0x02 dlen 8
    L2CAP(d): cid 0x0040 len 4 [psm 3]
      RFCOMM(s): UA: cr 1 dlci 0 pf 1 ilen 0 fcs 0xd7
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 1 packets 1
> ACL data: handle 1 flags 0x02 dlen 12
    L2CAP(s): Disconn req: dcid 0x0040 scid 0x0040
< ACL data: handle 1 flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x0040 scid 0x0040
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 1 packets 1
> HCI Event: Disconn Complete (0x05) plen 4
    status 0x00 handle 1 reason 0x13
    Reason: Remote User Terminated Connection


-----------------------------
int get_bluetooth_connection
-----------------------------


int get_bluetooth_connection(int socket_type, u_short port, int *listener, 
char *remote_addr)
{
 struct sockaddr_rc loc_addr = { 0 }, rem_addr = { 0 };

 int listening_socket;
 int connected_socket = -1;
 int new_process;
 int reuse_addr = 1;
 int opt = sizeof(rem_addr);

 strcpy(remote_addr, "");
 listening_socket = socket(AF_BLUETOOTH, socket_type, BTPROTO_RFCOMM);
 if (listening_socket < 0) {
  perror("socket");
  exit(EXIT_FAILURE);
 }

   if (listener != NULL)
  *listener = listening_socket;

   //setsockopt(listening_socket, SOL_SOCKET, SO_REUSEADDR, &reuse_addr, 
sizeof(reuse_addr));

 loc_addr.rc_family = AF_BLUETOOTH;
 loc_addr.rc_bdaddr = *BDADDR_ANY;
 loc_addr.rc_channel = (uint8_t) port;
 if (bind(listening_socket, (struct sockaddr *)&loc_addr, sizeof(loc_addr)) 
< 0)
 {
  perror("bind");
  close(listening_socket);
  exit(EXIT_FAILURE);
 }

 if (socket_type == SOCK_STREAM)
 {
  listen(listening_socket, 5); /* Queue up to five connections before having 
them automatically rejected. */

     while(connected_socket < 0)
  {
     printf("[%ld] Waiting accept ...\n", (long)getpid(), remote_addr);
        connected_socket = accept(listening_socket, (struct sockaddr 
*)&rem_addr, &opt);
     ba2str( &(rem_addr.rc_bdaddr), remote_addr );
        if (connected_socket < 0)
   {
          /* Either a real error occured, or blocking was interrupted for
             some reason.  Only abort execution if a real error occured. */
          if (errno != EINTR)
    {
             perror("accept");
             close(listening_socket);
             exit(EXIT_FAILURE);
          } else {
             continue;    /* don't fork - do the accept again */
          }
        }

   printf("[%ld] Accepted from %s\n", (long)getpid(), remote_addr);
        new_process = fork();
        if (new_process < 0)
   {
          printf("[%ld] Forking error\n", (long)getpid());
          close(connected_socket);
          connected_socket = -1;
        } else {
    /* We have a new process... */
          if (new_process == 0)
    {
     printf("[%ld] Start of new process (after fork)\n", (long)getpid());
             /* This is the new process. */
             close(listening_socket); /* Close our copy of this socket */
       if (listener != NULL) *listener = -1; /* Closed in this process.  We 
are not responsible for it. */
          } else {
             /* This is the main loop.  Close copy of connected socket, and 
continue loop. */
             close(connected_socket);
             connected_socket = -1;
          }
        }
     }
     return connected_socket;
   } else
     return listening_socket;
}



-- 
No virus found in this outgoing message.
Checked by AVG Free Edition.
Version: 7.1.409 / Virus Database: 268.14.17/553 - Release Date: 27/11/2006


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
