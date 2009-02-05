Return-Path: <cyrus@holtmann.org>
Message-ID: <498B0C6A.6000609@access-company.com>
Date: Thu, 05 Feb 2009 16:57:30 +0100
From: Frederic Danis <frederic.danis@access-company.com>
MIME-Version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>
CC: linux-bluetooth@vger.kernel.org
Subject: Re: BlueZ pairing failure and kernel 2.6.24 crash
References: <49886819.2030401@access-company.com> <1233772466.12562.6.camel@californication>
In-Reply-To: <1233772466.12562.6.camel@californication>
Content-Type: multipart/mixed;
 boundary="------------080101020003010402060102"
List-ID: <linux-bluetooth.vger.kernel.org>

This is a multi-part message in MIME format.
--------------080101020003010402060102
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hello Marcel,
> Hi Frederic,
> 
>> I am working with BlueZ 3.22, kernel 2.6.24 on ARM and found 2 problems :
>>
>> -  I am not able to pair with some phones (Nokia N70 and sony-ericsson 
>> P800). After some investigations, I found that a "L2CAP information 
>> request packet" is sent just after the ACL connection. Both phones reply 
>> with "command rejected" error, then disconnect the ACL link before BlueZ 
>> is able to finish the pairing (see attached traces).
>>
>> - with some other phones (LG 990 Viewty and sony-ericsson T610), the 
>> kernel crashes after pairing initiated by the phone is completed.
>>
>> For the first problem I removed the send of the "L2CAP information 
>> request packet" in the kernel (see attached patch). This fixes both 
>> problems.
>>
>> I did not found any usage of the remote L2CAP information in kernel.
>> Is sending "L2CAP information request packet" mandatory for upper layer 
>> and/or qualification ?
>> Is my fix OK ?
> 
> sending the L2CAP info is just fine. It should not cause any problems. I
> think it is the pairing code that does some weird things at the wrong
> time. Can you test with bluetooth-testing.git against bluez-4.28 to
> verify that this issue still exists.

I try multiple configuration to test these 2 problems :

- pairing out failure with P800 or N70 :
   - Ubuntu 8.04 + kernel 2.6.24.23 + BlueZ 3.26 => unable to pair (see Ubuntu804_Bluez326_traces.txt)
   - Ubuntu 8.04 + kernel 2.6.24.23 + BlueZ 4.28 => unable to pair (see Ubuntu804_Bluez428_traces.txt)
   - Ubuntu 8.10 + kernel 2.6.27.11 + BlueZ 4.12 => pairing OK (see Ubuntu810_Bluez412_traces.txt)

   To perform pairing I use :
   BlueZ 3.26 : dbus-send --system --type=method_call --print-reply --dest=org.bluez /org/bluez/hci1 org.bluez.Adapter.CreateBonding string:00:0A:D9:14:D0:85
   BlueZ 4.xx : bluez-4.xx/test/simple-agent hci0 00:0A:D9:14:D0:85

- kernel crash with LG 990 :
   - Ubuntu 8.04 + kernel 2.6.24.23 + BlueZ 3.26 => Ubuntu freeze (kernel crash)
   - Ubuntu 8.04 + kernel 2.6.24.23 + BlueZ 4.28 => Ubuntu freeze (kernel crash)
   - Ubuntu 8.10 + kernel 2.6.27.11 + BlueZ 4.12 => pairing OK

So, for me, it seems to be a problem in the kernel 2.6.24.
What is your opinion ?

Unfortunately, I am not able to change kernel version. Do you have any idea how to fix this, please ? Is my fix OK ?

Regards

Fred


-- 
-----------------------------------------------
It is not by improving the oil lamp that one invents the electric bulb!
-----------------------------------------------
Danis Frederic                   Access Company
Software engineer
Mail : mailto:frederic.danis@access-company.com
-----------------------------------------------

--------------080101020003010402060102
Content-Type: text/plain;
 name="Ubuntu804_Bluez326_traces.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="Ubuntu804_Bluez326_traces.txt"

< HCI Command: Create Connection (0x01|0x0005) plen 13
    bdaddr 00:0A:D9:14:D0:85 ptype 0xcc18 rswitch 0x01 clkoffset 0x0000
    Packet type: DM1 DM3 DM5 DH1 DH3 DH5 
> HCI Event: Command Status (0x0f) plen 4
    Create Connection (0x01|0x0005) status 0x00 ncmd 1
> HCI Event: Connect Complete (0x03) plen 11
    status 0x00 handle 42 bdaddr 00:0A:D9:14:D0:85 type ACL encrypt 0x00
< ACL data: handle 42 flags 0x02 dlen 10
    L2CAP(s): Info req: type 2
< HCI Command: Read Remote Supported Features (0x01|0x001b) plen 2
    handle 42
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 42 packets 1
> HCI Event: Command Status (0x0f) plen 4
    Read Remote Supported Features (0x01|0x001b) status 0x00 ncmd 0
> ACL data: handle 42 flags 0x02 dlen 10
    L2CAP(s): Command rej: reason 0
      Command not understood
> HCI Event: Max Slots Change (0x1b) plen 3
    handle 42 slots 5
> HCI Event: Command Status (0x0f) plen 4
    Unknown (0x00|0x0000) status 0x00 ncmd 1
< HCI Command: Write Link Policy Settings (0x02|0x000d) plen 4
    handle 42 policy 0x0f
    Link policy: RSWITCH HOLD SNIFF PARK 
> HCI Event: Read Remote Supported Features (0x0b) plen 11
    status 0x00 handle 42
    Features: 0xff 0xfb 0x01 0x00 0x00 0x00 0x00 0x00
> HCI Event: Command Complete (0x0e) plen 6
    Write Link Policy Settings (0x02|0x000d) ncmd 1
    status 0x00 handle 42
< HCI Command: Remote Name Request (0x01|0x0019) plen 10
    bdaddr 00:0A:D9:14:D0:85 mode 2 clkoffset 0x0000
> HCI Event: Command Status (0x0f) plen 4
    Remote Name Request (0x01|0x0019) status 0x00 ncmd 1
< HCI Command: Authentication Requested (0x01|0x0011) plen 2
    handle 42
> HCI Event: Remote Name Req Complete (0x07) plen 255
    status 0x00 bdaddr 00:0A:D9:14:D0:85 name 'P800 sqa'
> HCI Event: Command Status (0x0f) plen 4
    Authentication Requested (0x01|0x0011) status 0x00 ncmd 1
> HCI Event: Link Key Request (0x17) plen 6
    bdaddr 00:0A:D9:14:D0:85
< HCI Command: Link Key Request Negative Reply (0x01|0x000c) plen 6
    bdaddr 00:0A:D9:14:D0:85
> HCI Event: Command Complete (0x0e) plen 10
    Link Key Request Negative Reply (0x01|0x000c) ncmd 1
    status 0x00 bdaddr 00:0A:D9:14:D0:85
> HCI Event: PIN Code Request (0x16) plen 6
    bdaddr 00:0A:D9:14:D0:85
< HCI Command: Read Local Name (0x03|0x0014) plen 0
> HCI Event: Command Complete (0x0e) plen 252
    Read Local Name (0x03|0x0014) ncmd 1
    status 0x00 name 'zavatta-1'
> HCI Event: Auth Complete (0x06) plen 3
    status 0x13 handle 42
    Error: Remote User Terminated Connection
> HCI Event: Disconn Complete (0x05) plen 4
    status 0x00 handle 42 reason 0x13
    Reason: Remote User Terminated Connection


--------------080101020003010402060102
Content-Type: text/plain;
 name="Ubuntu804_Bluez428_traces.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="Ubuntu804_Bluez428_traces.txt"

< HCI Command: Create Connection (0x01|0x0005) plen 13
    bdaddr 00:0A:D9:14:D0:85 ptype 0xcc18 rswitch 0x01 clkoffset 0x0000
    Packet type: DM1 DM3 DM5 DH1 DH3 DH5 
> HCI Event: Command Status (0x0f) plen 4
    Create Connection (0x01|0x0005) status 0x00 ncmd 1
> HCI Event: Connect Complete (0x03) plen 11
    status 0x00 handle 42 bdaddr 00:0A:D9:14:D0:85 type ACL encrypt 0x00
< ACL data: handle 42 flags 0x02 dlen 10
    L2CAP(s): Info req: type 2
< HCI Command: Read Remote Supported Features (0x01|0x001b) plen 2
    handle 42
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 42 packets 1
> HCI Event: Command Status (0x0f) plen 4
    Read Remote Supported Features (0x01|0x001b) status 0x00 ncmd 0
> ACL data: handle 42 flags 0x02 dlen 10
    L2CAP(s): Command rej: reason 0
      Command not understood
> HCI Event: Max Slots Change (0x1b) plen 3
    handle 42 slots 5
> HCI Event: Command Status (0x0f) plen 4
    Unknown (0x00|0x0000) status 0x00 ncmd 1
< HCI Command: Write Link Policy Settings (0x02|0x000d) plen 4
    handle 42 policy 0x0f
    Link policy: RSWITCH HOLD SNIFF PARK 
> HCI Event: Read Remote Supported Features (0x0b) plen 11
    status 0x00 handle 42
    Features: 0xff 0xfb 0x01 0x00 0x00 0x00 0x00 0x00
> HCI Event: Command Complete (0x0e) plen 6
    Write Link Policy Settings (0x02|0x000d) ncmd 1
    status 0x00 handle 42
< HCI Command: Remote Name Request (0x01|0x0019) plen 10
    bdaddr 00:0A:D9:14:D0:85 mode 2 clkoffset 0x0000
> HCI Event: Command Status (0x0f) plen 4
    Remote Name Request (0x01|0x0019) status 0x00 ncmd 1
< HCI Command: Authentication Requested (0x01|0x0011) plen 2
    handle 42
> HCI Event: Remote Name Req Complete (0x07) plen 255
    status 0x00 bdaddr 00:0A:D9:14:D0:85 name 'P800 sqa'
> HCI Event: Command Status (0x0f) plen 4
    Authentication Requested (0x01|0x0011) status 0x00 ncmd 1
> HCI Event: Link Key Request (0x17) plen 6
    bdaddr 00:0A:D9:14:D0:85
< HCI Command: Link Key Request Negative Reply (0x01|0x000c) plen 6
    bdaddr 00:0A:D9:14:D0:85
> HCI Event: Command Complete (0x0e) plen 10
    Link Key Request Negative Reply (0x01|0x000c) ncmd 1
    status 0x00 bdaddr 00:0A:D9:14:D0:85
> HCI Event: PIN Code Request (0x16) plen 6
    bdaddr 00:0A:D9:14:D0:85
< HCI Command: PIN Code Request Reply (0x01|0x000d) plen 23
    bdaddr 00:0A:D9:14:D0:85 len 1 pin '1'
> HCI Event: Command Complete (0x0e) plen 10
    PIN Code Request Reply (0x01|0x000d) ncmd 1
    status 0x00 bdaddr 00:0A:D9:14:D0:85
> HCI Event: Auth Complete (0x06) plen 3
    status 0x18 handle 42
    Error: Pairing Not Allowed
> HCI Event: Disconn Complete (0x05) plen 4
    status 0x00 handle 42 reason 0x13
    Reason: Remote User Terminated Connection


--------------080101020003010402060102
Content-Type: text/plain;
 name="Ubuntu810_Bluez412_traces.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="Ubuntu810_Bluez412_traces.txt"

< HCI Command: Create Connection (0x01|0x0005) plen 13
    bdaddr 00:0A:D9:14:D0:85 ptype 0xcc18 rswitch 0x01 clkoffset 0x0000
    Packet type: DM1 DM3 DM5 DH1 DH3 DH5 
> HCI Event: Command Status (0x0f) plen 4
    Create Connection (0x01|0x0005) status 0x00 ncmd 1
> HCI Event: Connect Complete (0x03) plen 11
    status 0x00 handle 43 bdaddr 00:0A:D9:14:D0:85 type ACL encrypt 0x00
< HCI Command: Read Remote Supported Features (0x01|0x001b) plen 2
    handle 43
> HCI Event: Command Status (0x0f) plen 4
    Read Remote Supported Features (0x01|0x001b) status 0x00 ncmd 0
> HCI Event: Max Slots Change (0x1b) plen 3
    handle 43 slots 5
> HCI Event: Command Status (0x0f) plen 4
    Unknown (0x00|0x0000) status 0x00 ncmd 1
< HCI Command: Remote Name Request (0x01|0x0019) plen 10
    bdaddr 00:0A:D9:14:D0:85 mode 2 clkoffset 0x0000
> HCI Event: Read Remote Supported Features (0x0b) plen 11
    status 0x00 handle 43
    Features: 0xff 0xfb 0x01 0x00 0x00 0x00 0x00 0x00
> HCI Event: Command Status (0x0f) plen 4
    Remote Name Request (0x01|0x0019) status 0x00 ncmd 1
< HCI Command: Authentication Requested (0x01|0x0011) plen 2
    handle 43
> HCI Event: Remote Name Req Complete (0x07) plen 255
    status 0x00 bdaddr 00:0A:D9:14:D0:85 name 'P800 sqa'
> HCI Event: Command Status (0x0f) plen 4
    Authentication Requested (0x01|0x0011) status 0x00 ncmd 1
> HCI Event: Link Key Request (0x17) plen 6
    bdaddr 00:0A:D9:14:D0:85
< HCI Command: Link Key Request Negative Reply (0x01|0x000c) plen 6
    bdaddr 00:0A:D9:14:D0:85
> HCI Event: Command Complete (0x0e) plen 10
    Link Key Request Negative Reply (0x01|0x000c) ncmd 1
    status 0x00 bdaddr 00:0A:D9:14:D0:85
> HCI Event: PIN Code Request (0x16) plen 6
    bdaddr 00:0A:D9:14:D0:85
< HCI Command: PIN Code Request Reply (0x01|0x000d) plen 23
    bdaddr 00:0A:D9:14:D0:85 len 1 pin '1'
> HCI Event: Command Complete (0x0e) plen 10
    PIN Code Request Reply (0x01|0x000d) ncmd 1
    status 0x00 bdaddr 00:0A:D9:14:D0:85
> HCI Event: Link Key Notification (0x18) plen 23
    bdaddr 00:0A:D9:14:D0:85 key A904972E67A25A6104783725A3D09F3B type 0
    Type: Combination Key
> HCI Event: Auth Complete (0x06) plen 3
    status 0x00 handle 43
< ACL data: handle 43 flags 0x02 dlen 10
    L2CAP(s): Info req: type 2
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 43 packets 1
> ACL data: handle 43 flags 0x02 dlen 10
    L2CAP(s): Command rej: reason 0
      Command not understood
< ACL data: handle 43 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 1 scid 0x0040
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 43 packets 1
> ACL data: handle 43 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0040 result 1 status 2
      Connection pending - Authorization pending
> ACL data: handle 43 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0040 result 0 status 0
      Connection successful
< ACL data: handle 43 flags 0x02 dlen 12
    L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 0
> ACL data: handle 43 flags 0x02 dlen 12
    L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 0
< ACL data: handle 43 flags 0x02 dlen 18
    L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 4
      MTU 672 
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 43 packets 1
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 43 packets 1
> ACL data: handle 43 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 0
      Success
< ACL data: handle 43 flags 0x02 dlen 24
    L2CAP(d): cid 0x0040 len 20 [psm 1]
        SDP SSA Req: tid 0x0 len 0xf
          pat uuid-16 0x1002 (PubBrwsGrp)
          max 65535
          aid(s) 0x0000 - 0xffff
          cont 00
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 43 packets 1
> ACL data: handle 43 flags 0x02 dlen 17
> ACL data: handle 43 flags 0x01 dlen 34
> ACL data: handle 43 flags 0x01 dlen 51
> ACL data: handle 43 flags 0x01 dlen 85
> ACL data: handle 43 flags 0x01 dlen 136
> ACL data: handle 43 flags 0x01 dlen 187
> ACL data: handle 43 flags 0x01 dlen 32
    L2CAP(d): cid 0x0040 len 538 [psm 1]
        SDP SSA Rsp: tid 0x0 len 0x215
          count 530
          record #0
              aid 0x0000 (SrvRecHndl)
                 uint 0x10000
              aid 0x0001 (SrvClassIDList)
                 < uuid-16 0x1112 (Headset AG) uuid-16 0x1203 (Audio) >
              aid 0x0002 (SrvRecState)
                 uint 0x9
              aid 0x0004 (ProtocolDescList)
                 < < uuid-16 0x0100 (L2CAP) > <
                 uuid-16 0x0003 (RFCOMM) uint 0x8 > >
              aid 0x0005 (BrwGrpList)
                 < uuid-16 0x1002 (PubBrwsGrp) >
              aid 0x0006 (LangBaseAttrIDList)
                 < uint 0x656e uint 0x6a uint 0x100 >
              aid 0x0008 (SrvAvail)
                 uint 0xff
              aid 0x0009 (BTProfileDescList)
                 < < uuid-16 0x1108 (Headset) uint 0x100 > >
              aid 0x0100 (SrvName)
                 str "Voice gateway"
              aid 0x0101 (SrvDesc)
                 str "Voice gateway"
              aid 0x0102 (ProviderName)
                 str "Sony Ericsson"
          record #1
              aid 0x0000 (SrvRecHndl)
                 uint 0x10001
              aid 0x0001 (SrvClassIDList)
                 < uuid-16 0x1101 (SP) >
              aid 0x0002 (SrvRecState)
                 uint 0x9
              aid 0x0004 (ProtocolDescList)
                 < < uuid-16 0x0100 (L2CAP) > <
                 uuid-16 0x0003 (RFCOMM) uint 0x1 > >
              aid 0x0005 (BrwGrpList)
                 < uuid-16 0x1002 (PubBrwsGrp) >
              aid 0x0006 (LangBaseAttrIDList)
                 < uint 0x656e uint 0x6a uint 0x100 >
              aid 0x0007 (SrvInfoTimeToLive)
                 uint 0x4b0
              aid 0x0008 (SrvAvail)
                 uint 0xff
              aid 0x0100 (SrvName)
                 str "Bluetooth Serial Port"
              aid 0x0101 (SrvDesc)
                 str "Bluetooth Serial Port"
              aid 0x0102 (ProviderName)
                 str "Symbian Ltd."
          record #2
              aid 0x0000 (SrvRecHndl)
                 uint 0x10002
              aid 0x0001 (SrvClassIDList)
                 < uuid-16 0x1103 (DUN) >
              aid 0x0002 (SrvRecState)
                 uint 0xa
              aid 0x0004 (ProtocolDescList)
                 < < uuid-16 0x0100 (L2CAP) > <
                 uuid-16 0x0003 (RFCOMM) uint 0x2 > >
              aid 0x0005 (BrwGrpList)
                 < uuid-16 0x1002 (PubBrwsGrp) >
              aid 0x0006 (LangBaseAttrIDList)
                 < uint 0x656e uint 0x6a uint 0x100 >
              aid 0x0008 (SrvAvail)
                 uint 0xff
              aid 0x0009 (BTProfileDescList)
                 < < uuid-16 0x1103 (DUN) uint 0x100 > >
              aid 0x0100 (SrvName)
                 str "Dial-up Networking"
              aid 0x0101 (SrvDesc)
                 str "Dial-up Networking"
              aid 0x0102 (ProviderName)
                 str "Sony Ericsson"
          record #3
              aid 0x0000 (SrvRecHndl)
                 uint 0x10003
              aid 0x0001 (SrvClassIDList)
                 < uuid-16 0x1105 (OBEXObjPush) >
              aid 0x0004 (ProtocolDescList)
                 < < uuid-16 0x0100 (L2CAP) > <
                 uuid-16 0x0003 (RFCOMM) uint 0x3 > <
                 uuid-16 0x0008 (OBEX) > >
              aid 0x0005 (BrwGrpList)
                 < uuid-16 0x1002 (PubBrwsGrp) >
              aid 0x0009 (BTProfileDescList)
                 < < uuid-16 0x1105 (OBEXObjPush) uint 0x100 > >
              aid 0x0100 (SrvName)
                 str "OBEX Object Push"
              aid 0x0303 (SuppFormatsList)
                 < uint 0x1 uint 0x3 uint 0xff >
          cont 00
< ACL data: handle 43 flags 0x02 dlen 12
    L2CAP(s): Disconn req: dcid 0x0040 scid 0x0040
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 43 packets 1
> ACL data: handle 43 flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x0040 scid 0x0040
< HCI Command: Disconnect (0x01|0x0006) plen 3
    handle 43 reason 0x13
    Reason: Remote User Terminated Connection
> HCI Event: Command Status (0x0f) plen 4
    Disconnect (0x01|0x0006) status 0x00 ncmd 1
> HCI Event: Disconn Complete (0x05) plen 4
    status 0x00 handle 43 reason 0x16
    Reason: Connection Terminated by Local Host


--------------080101020003010402060102--
