Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <4261BCFB.8040204@gmx.ch>
From: Marco Trudel <mtrudel@gmx.ch>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] error on connect
References: <425FFF54.6000701@gmx.ch> <1113607202.16433.42.camel@pegasus>	 <42616275.1090103@gmx.ch> <1113682195.18450.0.camel@pegasus>
In-Reply-To: <1113682195.18450.0.camel@pegasus>
Content-Type: multipart/mixed;
 boundary="------------090206030604010608030003"
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
Date: Sun, 17 Apr 2005 03:33:47 +0200

This is a multi-part message in MIME format.
--------------090206030604010608030003
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hello Marcel

Marcel Holtmann wrote:
> Hi Marco,
> 
> 
>>Yes. Broadcom dongles cause the problem.
>>Actually it's only the slave (listening dongle).
> 
> 
> what kind of Broadcom dongle is this?

I sent you pretty exactly one week ago the data from two broadcom 1.2 
dongles (ednet and acer). Inform me if you need the informations again.
both dongles now make the problem...

> 
>>I tested all combinations with a minimal slave and master (only 
>>connects/accept connection and quit directly again).
>>the master (connecting one) doesn't care, csr and broadcom worked fine.
>>
>>but the listening one gives the mentioned error (on more than 50% of the 
>>tries) I tried with a acer and ednet broadcom dongle.
>>A csr works just perfectly fine...
>>
>>after the error, the dongle keeps waiting for a slave but won't access any 
>>more connections. so, basically the dongle is completly freezed.
> 
> 
> Send in the "hcidump -X -V" for it.

I attached a successfull and a failed attemp from the listening acer dongle.
Hope they are informative...


regards
Marco

--------------090206030604010608030003
Content-Type: text/plain;
 name="hcidump-failure.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="hcidump-failure.txt"

> HCI Event: Connect Request (0x04) plen 10
    bdaddr 00:02:72:C3:F2:10 class 0x3e0100 type ACL
< HCI Command: Accept Connection Request (0x01|0x0009) plen 7
    bdaddr 00:02:72:C3:F2:10 role 0x01
    Role: Slave
> HCI Event: Command Status (0x0f) plen 4
    Accept Connection Request (0x01|0x0009) status 0x00 ncmd 1
> ACL data: handle 7 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 3 scid 0x0040
> HCI Event: Connect Complete (0x03) plen 11
    status 0x00 handle 7 bdaddr 00:02:72:C3:F2:10 type ACL encrypt 0x00
< HCI Command: Write Link Policy Settings (0x02|0x000d) plen 4
    handle 7 policy 0x0f
    Link policy: RSWITCH HOLD SNIFF PARK
> HCI Event: Command Complete (0x0e) plen 6
    Write Link Policy Settings (0x02|0x000d) ncmd 1
    status 0x00 handle 7
< HCI Command: Change Connection Packet Type (0x01|0x000f) plen 4
    handle 7 ptype 0xcc18
    Packet type: DM1 DM3 DM5 DH1 DH3 DH5
> HCI Event: Command Status (0x0f) plen 4
    Change Connection Packet Type (0x01|0x000f) status 0x0c ncmd 1
    Error: Command Disallowed
> HCI Event: Max Slots Change (0x1b) plen 3
  0000: 07 00 05

And after the client quits:
> HCI Event: Disconn Complete (0x05) plen 4
    status 0x00 handle 6 reason 0x13
    Reason: Remote User Terminated Connection

--------------090206030604010608030003
Content-Type: text/plain;
 name="hcidump-success.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="hcidump-success.txt"

> HCI Event: Connect Request (0x04) plen 10
    bdaddr 00:02:72:C3:F2:10 class 0x3e0100 type ACL
< HCI Command: Accept Connection Request (0x01|0x0009) plen 7
    bdaddr 00:02:72:C3:F2:10 role 0x01
    Role: Slave
> HCI Event: Command Status (0x0f) plen 4
    Accept Connection Request (0x01|0x0009) status 0x00 ncmd 1
> HCI Event: Connect Complete (0x03) plen 11
    status 0x00 handle 7 bdaddr 00:02:72:C3:F2:10 type ACL encrypt 0x00
< HCI Command: Write Link Policy Settings (0x02|0x000d) plen 4
    handle 7 policy 0x0f
    Link policy: RSWITCH HOLD SNIFF PARK
> HCI Event: Command Complete (0x0e) plen 6
    Write Link Policy Settings (0x02|0x000d) ncmd 1
    status 0x00 handle 7
< HCI Command: Change Connection Packet Type (0x01|0x000f) plen 4
    handle 7 ptype 0xcc18
    Packet type: DM1 DM3 DM5 DH1 DH3 DH5
> ACL data: handle 7 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 3 scid 0x0040
> HCI Event: Command Status (0x0f) plen 4
    Change Connection Packet Type (0x01|0x000f) status 0x0c ncmd 1
    Error: Command Disallowed
< ACL data: handle 7 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0040 result 0 status 0
      Connection successful
> HCI Event: Max Slots Change (0x1b) plen 3
  0000: 07 00 05                                          ...
> ACL data: handle 7 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 4
      MTU 1024
< ACL data: handle 7 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 0
      Success
< ACL data: handle 7 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 4
      MTU 1024
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 7
> ACL data: handle 7 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 0
      Success
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 7
> ACL data: handle 7 flags 0x02 dlen 8
    L2CAP(d): cid 0x0040 len 4 [psm 3]
      RFCOMM(s): SABM: cr 1 dlci 0 pf 1 ilen 0 fcs 0x1c
< ACL data: handle 7 flags 0x02 dlen 8
    L2CAP(d): cid 0x0040 len 4 [psm 3]
      RFCOMM(s): UA: cr 1 dlci 0 pf 1 ilen 0 fcs 0xd7
> ACL data: handle 7 flags 0x02 dlen 18
    L2CAP(d): cid 0x0040 len 14 [psm 3]
      RFCOMM(s): PN CMD: cr 1 dlci 0 pf 0 ilen 10 fcs 0x70 mcc_len 8
      dlci 10 frame_type 0 credit_flow 15 pri 7 ack_timer 0
      frame_size 1019 max_retrans 0 credits 7
< ACL data: handle 7 flags 0x02 dlen 18
    L2CAP(d): cid 0x0040 len 14 [psm 3]
      RFCOMM(s): PN RSP: cr 0 dlci 0 pf 0 ilen 10 fcs 0xaa mcc_len 8
      dlci 10 frame_type 0 credit_flow 14 pri 7 ack_timer 0
      frame_size 1019 max_retrans 0 credits 7
> ACL data: handle 7 flags 0x02 dlen 8
    L2CAP(d): cid 0x0040 len 4 [psm 3]
      RFCOMM(s): SABM: cr 1 dlci 10 pf 1 ilen 0 fcs 0x8c
< ACL data: handle 7 flags 0x02 dlen 8
    L2CAP(d): cid 0x0040 len 4 [psm 3]
      RFCOMM(s): UA: cr 1 dlci 10 pf 1 ilen 0 fcs 0x47
< ACL data: handle 7 flags 0x02 dlen 12
    L2CAP(d): cid 0x0040 len 8 [psm 3]
      RFCOMM(s): MSC CMD: cr 0 dlci 0 pf 0 ilen 4 fcs 0xaa mcc_len 2
      dlci 10 fc 0 rtc 1 rtr 1 ic 0 dv 1 b1 1 b2 1 b3 0 len 0
< ACL data: handle 7 flags 0x02 dlen 8
    L2CAP(d): cid 0x0040 len 4 [psm 3]
      RFCOMM(s): DISC: cr 0 dlci 10 pf 1 ilen 0 fcs 0xc
> ACL data: handle 7 flags 0x02 dlen 12
    L2CAP(d): cid 0x0040 len 8 [psm 3]
      RFCOMM(s): MSC CMD: cr 1 dlci 0 pf 0 ilen 4 fcs 0x70 mcc_len 2
      dlci 10 fc 0 rtc 1 rtr 1 ic 0 dv 1 b1 1 b2 1 b3 0 len 0
< ACL data: handle 7 flags 0x02 dlen 12
    L2CAP(d): cid 0x0040 len 8 [psm 3]
      RFCOMM(s): MSC RSP: cr 0 dlci 0 pf 0 ilen 4 fcs 0xaa mcc_len 2
      dlci 10 fc 0 rtc 1 rtr 1 ic 0 dv 1 b1 1 b2 1 b3 0 len 0
> ACL data: handle 7 flags 0x02 dlen 12
    L2CAP(d): cid 0x0040 len 8 [psm 3]
      RFCOMM(s): MSC RSP: cr 1 dlci 0 pf 0 ilen 4 fcs 0x70 mcc_len 2
      dlci 10 fc 0 rtc 1 rtr 1 ic 0 dv 1 b1 1 b2 1 b3 0 len 0
< ACL data: handle 7 flags 0x02 dlen 9
    L2CAP(d): cid 0x0040 len 5 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 10 pf 1 ilen 0 fcs 0x76 credits 33
> ACL data: handle 7 flags 0x02 dlen 8
    L2CAP(d): cid 0x0040 len 4 [psm 3]
      RFCOMM(s): DISC: cr 1 dlci 10 pf 1 ilen 0 fcs 0x6d
< ACL data: handle 7 flags 0x02 dlen 8
    L2CAP(d): cid 0x0040 len 4 [psm 3]
      RFCOMM(s): UA: cr 1 dlci 10 pf 1 ilen 0 fcs 0x47
> ACL data: handle 7 flags 0x02 dlen 8
    L2CAP(d): cid 0x0040 len 4 [psm 3]
      RFCOMM(s): UA: cr 0 dlci 10 pf 1 ilen 0 fcs 0x26
< ACL data: handle 7 flags 0x02 dlen 8
    L2CAP(d): cid 0x0040 len 4 [psm 3]
      RFCOMM(s): DM: cr 1 dlci 10 pf 1 ilen 0 fcs 0xa6
> ACL data: handle 7 flags 0x02 dlen 8
    L2CAP(d): cid 0x0040 len 4 [psm 3]
      RFCOMM(s): DISC: cr 1 dlci 0 pf 1 ilen 0 fcs 0xfd
< ACL data: handle 7 flags 0x02 dlen 8
    L2CAP(d): cid 0x0040 len 4 [psm 3]
      RFCOMM(s): UA: cr 1 dlci 0 pf 1 ilen 0 fcs 0xd7
> ACL data: handle 7 flags 0x02 dlen 12
    L2CAP(s): Disconn req: dcid 0x0040 scid 0x0040
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 7
< ACL data: handle 7 flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x0040 scid 0x0040
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 7
> HCI Event: Disconn Complete (0x05) plen 4
    status 0x00 handle 7 reason 0x13
    Reason: Remote User Terminated Connection

--------------090206030604010608030003--


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
