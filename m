Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <42664856.3050502@gmx.ch>
From: Marco Trudel <mtrudel@gmx.ch>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] error on connect
References: <425FFF54.6000701@gmx.ch> <1113607202.16433.42.camel@pegasus>	 <42616275.1090103@gmx.ch> <1113682195.18450.0.camel@pegasus>	 <4261BCFB.8040204@gmx.ch> <1113702363.18450.26.camel@pegasus>	 <426237CF.5060604@gmx.ch>  <4263F8DF.1040400@gmx.ch>	 <1113849662.16233.118.camel@pegasus>  <42651A2E.2080601@gmx.ch>	 <1113923580.2469.7.camel@pegasus>  <426522C6.10700@gmx.ch>	 <1113925620.2469.26.camel@pegasus>  <42652B35.7060803@gmx.ch>	 <1113927187.2469.40.camel@pegasus>  <4265329A.3030100@gmx.ch>	 <1113929462.2469.52.camel@pegasus>  <4265820A.2000400@gmx.ch> <1113949928.2469.88.camel@pegasus>
In-Reply-To: <1113949928.2469.88.camel@pegasus>
Content-Type: multipart/mixed;
 boundary="------------050400080506030100000608"
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
Date: Wed, 20 Apr 2005 14:17:26 +0200

This is a multi-part message in MIME format.
--------------050400080506030100000608
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit



Marcel Holtmann wrote:
> Hi Marco,
> 
> 
>>>>- The ACL packet that cause the problem is sent before the connection is 
>>>>etablished. This is ok and defined in the specification.
>>>
>>>this is not ok and can also not happen since you only get the connection
>>>handle from the connect complete event. In BlueZ this is indicated with
>>>the hci_proto_connect_cfm() and only at that time the L2CAP layer starts
>>>sending out its connect request. Please check the sender side again.
>>
>>yes. I got this wrong. this way it makes much more sense...
> 
> 
> please do a "hcidump -X -V" for the sender side, too. I like to look how
> the Broadcom responds here.

here they are.
I attached the listening ones again because I updated to hcidump1.20.
The listening dongle is the acer, the sending one the ednet.

>>>>- the broadcom dongle seem to don't handle this correct. they probably 
>>>>suffer a race condition. so they may work or may not work.
>>>
>>>Maybe the stacks Broadcom tested their dongles with are needing some
>>>time before they can send out the first ACL data packet. Or they do
>>>other HCI tasks before they start L2CAP. However this is a problem with
>>>the dongle, because the ACL data packet is not allowed at that time.
>>
>>ok. that leads me to some questions:
>>- what would be the behaviour of the listening dongle if you fix the 
>>flow control after this error occured?
> 
> 
> If this package really corrupts the internal HCI flow control states of
> BlueZ then this needs to be fixed. However this will not change anything
> of the behavior, because the L2CAP connect request packet will be still
> dropped.

I just found out that the listening dongle doesn't freeze. The connecting 
dongle runs into a timeout and disconnects propertly. After that 
connections are possible again.

>>- (just curious) How can you find out that this packet was processed too 
>>early? does bluez always know the order of processed packets like the 
>>hcidump shows?
> 
> 
> The hcidump order should match the kernel queue order. Nobody really
> verified this, but I doubt that there is a problem.

I'm sorry, I made a thinking mistake. This shure is not a problem...


>>- Are you interested in having this ACL datapacket queue you supposed 
>>inside bluez (kernel)? respectively, did you mean to do this in the program?
> 
> This must be done inside the kernel and it will be an ugly workaround.

Actually I think this isn't needed because everything's fine again after 
the timeout.

>>and two comments:
>>- you told bluez might be too fast for ednet. actually bluez looks like 
>>it's too fast for the nokia 6230 too. i've to wait 1 second before I 
>>close a connection, else the mobile phone doesn't get all packets.
>>maybee this is a bigger problem (the speed thing)...
> 
> 
> I meant this in comparison to the Windows stacks. We will do the final
> setup of the ACL link (packet type etc.) at the same time the L2CAP
> layer already sends its first commands. This is because BlueZ is fully
> multi-threaded and not one stupid state machine for all layers thing.
> 
> 
>>- I made a try with windows. it played the listening part with the 
>>broadcom dongle. Unfortunately i haven't a hcidump here, but from more 
>>than 100 connection tries, every single one worked...
>>but as I said, this is not reliable because I don't know what windows is 
>>doing in background...
> 
> 
> If this is the Widcomm stack you can look at it with Spylite. For the XP
> stack I have no idea how to do that without an USB sniffer.

It's a widcomm. But I think I can live with the timeout and will not check 
what windows is exactly doing...


regards
Marco

--------------050400080506030100000608
Content-Type: text/plain;
 name="hcidump1.20_connecting_failure.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="hcidump1.20_connecting_failure.txt"

< HCI Command: Create Connection (0x01|0x0005) plen 13
    bdaddr 00:02:72:C3:26:F5 ptype 0xcc18 rswitch 0x01 clkoffset 0x0000
    Packet type: DM1 DM3 DM5 DH1 DH3 DH5
> HCI Event: Command Status (0x0f) plen 4
    Create Connection (0x01|0x0005) status 0x00 ncmd 1
> HCI Event: Connect Complete (0x03) plen 11
    status 0x00 handle 6 bdaddr 00:02:72:C3:26:F5 type ACL encrypt 0x00
< ACL data: handle 6 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 3 scid 0x0040
< HCI Command: Write Link Policy Settings (0x02|0x000d) plen 4
    handle 6 policy 0x0f
    Link policy: RSWITCH HOLD SNIFF PARK
> HCI Event: Command Complete (0x0e) plen 6
    Write Link Policy Settings (0x02|0x000d) ncmd 1
    status 0x00 handle 6
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 6
> HCI Event: Max Slots Change (0x1b) plen 3
    handle 6 slots 5

--------------050400080506030100000608
Content-Type: text/plain;
 name="hcidump1.20_connecting_success.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="hcidump1.20_connecting_success.txt"

< HCI Command: Create Connection (0x01|0x0005) plen 13
    bdaddr 00:02:72:C3:26:F5 ptype 0xcc18 rswitch 0x01 clkoffset 0x0000
    Packet type: DM1 DM3 DM5 DH1 DH3 DH5
> HCI Event: Command Status (0x0f) plen 4
    Create Connection (0x01|0x0005) status 0x00 ncmd 1
> HCI Event: Connect Complete (0x03) plen 11
    status 0x00 handle 6 bdaddr 00:02:72:C3:26:F5 type ACL encrypt 0x00
< ACL data: handle 6 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 3 scid 0x0040
< HCI Command: Write Link Policy Settings (0x02|0x000d) plen 4
    handle 6 policy 0x0f
    Link policy: RSWITCH HOLD SNIFF PARK
> HCI Event: Command Complete (0x0e) plen 6
    Write Link Policy Settings (0x02|0x000d) ncmd 1
    status 0x00 handle 6
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 6
> ACL data: handle 6 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0040 result 0 status 0
      Connection successful
< ACL data: handle 6 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 4
      MTU 1024
> HCI Event: Max Slots Change (0x1b) plen 3
    handle 6 slots 5
> ACL data: handle 6 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 0
      Success
> ACL data: handle 6 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 4
      MTU 1024
< ACL data: handle 6 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 0
      Success
< ACL data: handle 6 flags 0x02 dlen 8
    L2CAP(d): cid 0x0040 len 4 [psm 3]
      RFCOMM(s): SABM: cr 1 dlci 0 pf 1 ilen 0 fcs 0x1c
> ACL data: handle 6 flags 0x02 dlen 8
    L2CAP(d): cid 0x0040 len 4 [psm 3]
      RFCOMM(s): UA: cr 1 dlci 0 pf 1 ilen 0 fcs 0xd7
< ACL data: handle 6 flags 0x02 dlen 18
    L2CAP(d): cid 0x0040 len 14 [psm 3]
      RFCOMM(s): PN CMD: cr 1 dlci 0 pf 0 ilen 10 fcs 0x70 mcc_len 8
      dlci 10 frame_type 0 credit_flow 15 pri 7 ack_timer 0
      frame_size 1019 max_retrans 0 credits 7
> ACL data: handle 6 flags 0x02 dlen 18
    L2CAP(d): cid 0x0040 len 14 [psm 3]
      RFCOMM(s): PN RSP: cr 0 dlci 0 pf 0 ilen 10 fcs 0xaa mcc_len 8
      dlci 10 frame_type 0 credit_flow 14 pri 7 ack_timer 0
      frame_size 1019 max_retrans 0 credits 7
< ACL data: handle 6 flags 0x02 dlen 8
    L2CAP(d): cid 0x0040 len 4 [psm 3]
      RFCOMM(s): SABM: cr 1 dlci 10 pf 1 ilen 0 fcs 0x8c
> ACL data: handle 6 flags 0x02 dlen 8
    L2CAP(d): cid 0x0040 len 4 [psm 3]
      RFCOMM(s): UA: cr 1 dlci 10 pf 1 ilen 0 fcs 0x47
< ACL data: handle 6 flags 0x02 dlen 12
    L2CAP(d): cid 0x0040 len 8 [psm 3]
      RFCOMM(s): MSC CMD: cr 1 dlci 0 pf 0 ilen 4 fcs 0x70 mcc_len 2
      dlci 10 fc 0 rtc 1 rtr 1 ic 0 dv 1 b1 1 b2 1 b3 0 len 0
< ACL data: handle 6 flags 0x02 dlen 8
    L2CAP(d): cid 0x0040 len 4 [psm 3]
      RFCOMM(s): DISC: cr 1 dlci 10 pf 1 ilen 0 fcs 0x6d
> ACL data: handle 6 flags 0x02 dlen 12
    L2CAP(d): cid 0x0040 len 8 [psm 3]
      RFCOMM(s): MSC CMD: cr 0 dlci 0 pf 0 ilen 4 fcs 0xaa mcc_len 2
      dlci 10 fc 0 rtc 1 rtr 1 ic 0 dv 1 b1 1 b2 1 b3 0 len 0
< ACL data: handle 6 flags 0x02 dlen 12
    L2CAP(d): cid 0x0040 len 8 [psm 3]
      RFCOMM(s): MSC RSP: cr 1 dlci 0 pf 0 ilen 4 fcs 0x70 mcc_len 2
      dlci 10 fc 0 rtc 1 rtr 1 ic 0 dv 1 b1 1 b2 1 b3 0 len 0
> ACL data: handle 6 flags 0x02 dlen 8
    L2CAP(d): cid 0x0040 len 4 [psm 3]
      RFCOMM(s): DISC: cr 0 dlci 10 pf 1 ilen 0 fcs 0xc
< ACL data: handle 6 flags 0x02 dlen 8
    L2CAP(d): cid 0x0040 len 4 [psm 3]
      RFCOMM(s): UA: cr 0 dlci 10 pf 1 ilen 0 fcs 0x26
< ACL data: handle 6 flags 0x02 dlen 8
    L2CAP(d): cid 0x0040 len 4 [psm 3]
      RFCOMM(s): DISC: cr 1 dlci 0 pf 1 ilen 0 fcs 0xfd
> ACL data: handle 6 flags 0x02 dlen 12
    L2CAP(d): cid 0x0040 len 8 [psm 3]
      RFCOMM(s): MSC RSP: cr 0 dlci 0 pf 0 ilen 4 fcs 0xaa mcc_len 2
      dlci 10 fc 0 rtc 1 rtr 1 ic 0 dv 1 b1 1 b2 1 b3 0 len 0
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 6
< ACL data: handle 6 flags 0x02 dlen 12
    L2CAP(s): Disconn req: dcid 0x0040 scid 0x0040
> ACL data: handle 6 flags 0x02 dlen 8
    L2CAP(d): cid 0x0040 len 4 [psm 3]
      RFCOMM(s): UA: cr 1 dlci 10 pf 1 ilen 0 fcs 0x47
> ACL data: handle 6 flags 0x02 dlen 8
    L2CAP(d): cid 0x0040 len 4 [psm 3]
      RFCOMM(s): DM: cr 1 dlci 10 pf 1 ilen 0 fcs 0xa6
> ACL data: handle 6 flags 0x02 dlen 8
    L2CAP(d): cid 0x0040 len 4 [psm 3]
      RFCOMM(s): UA: cr 1 dlci 0 pf 1 ilen 0 fcs 0xd7
> ACL data: handle 6 flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x0040 scid 0x0040
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 6
< HCI Command: Disconnect (0x01|0x0006) plen 3
    handle 6 reason 0x13
    Reason: Remote User Terminated Connection
> HCI Event: Command Status (0x0f) plen 4
    Disconnect (0x01|0x0006) status 0x00 ncmd 1
> HCI Event: Disconn Complete (0x05) plen 4
    status 0x00 handle 6 reason 0x16
    Reason: Connection Terminated by Local Host

--------------050400080506030100000608
Content-Type: text/plain;
 name="hcidump1.20_listening_failure.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="hcidump1.20_listening_failure.txt"

> HCI Event: Connect Request (0x04) plen 10
    bdaddr 00:02:72:C3:F1:FE class 0x3e0100 type ACL
< HCI Command: Accept Connection Request (0x01|0x0009) plen 7
    bdaddr 00:02:72:C3:F1:FE role 0x01
    Role: Slave
> HCI Event: Command Status (0x0f) plen 4
    Accept Connection Request (0x01|0x0009) status 0x00 ncmd 1
> ACL data: handle 7 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 3 scid 0x0040
> HCI Event: Connect Complete (0x03) plen 11
    status 0x00 handle 7 bdaddr 00:02:72:C3:F1:FE type ACL encrypt 0x00
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
    handle 7 slots 5

--------------050400080506030100000608
Content-Type: text/plain;
 name="hcidump1.20_listening_success.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="hcidump1.20_listening_success.txt"

> HCI Event: Connect Request (0x04) plen 10
    bdaddr 00:02:72:C3:F1:FE class 0x3e0100 type ACL
< HCI Command: Accept Connection Request (0x01|0x0009) plen 7
    bdaddr 00:02:72:C3:F1:FE role 0x01
    Role: Slave
> HCI Event: Command Status (0x0f) plen 4
    Accept Connection Request (0x01|0x0009) status 0x00 ncmd 1
> HCI Event: Connect Complete (0x03) plen 11
    status 0x00 handle 7 bdaddr 00:02:72:C3:F1:FE type ACL encrypt 0x00
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
> ACL data: handle 7 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 3 scid 0x0040
< ACL data: handle 7 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0040 result 0 status 0
      Connection successful
> HCI Event: Max Slots Change (0x1b) plen 3
    handle 7 slots 5
> ACL data: handle 7 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 4
      MTU 1024
< ACL data: handle 7 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 0
      Success
< ACL data: handle 7 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 4
      MTU 1024
> ACL data: handle 7 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 0
      Success
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
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 7
> ACL data: handle 7 flags 0x02 dlen 8
    L2CAP(d): cid 0x0040 len 4 [psm 3]
      RFCOMM(s): DISC: cr 1 dlci 10 pf 1 ilen 0 fcs 0x6d
< ACL data: handle 7 flags 0x02 dlen 8
    L2CAP(d): cid 0x0040 len 4 [psm 3]
      RFCOMM(s): UA: cr 1 dlci 10 pf 1 ilen 0 fcs 0x47
> ACL data: handle 7 flags 0x02 dlen 12
    L2CAP(d): cid 0x0040 len 8 [psm 3]
      RFCOMM(s): MSC RSP: cr 1 dlci 0 pf 0 ilen 4 fcs 0x70 mcc_len 2
      dlci 10 fc 0 rtc 1 rtr 1 ic 0 dv 1 b1 1 b2 1 b3 0 len 0
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
< ACL data: handle 7 flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x0040 scid 0x0040
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 7
> HCI Event: Disconn Complete (0x05) plen 4
    status 0x00 handle 7 reason 0x13
    Reason: Remote User Terminated Connection

--------------050400080506030100000608--


-------------------------------------------------------
This SF.Net email is sponsored by: New Crystal Reports XI.
Version 11 adds new functionality designed to reduce time involved in
creating, integrating, and deploying reporting solutions. Free runtime info,
new features, or free trial, at: http://www.businessobjects.com/devxi/728
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
