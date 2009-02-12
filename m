Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1234280390.12847.32.camel@californication>
References: <6887eb5d0902092123p2aa3f31chbd00bfc713b313dc@mail.gmail.com>
	 <1234280390.12847.32.camel@californication>
Date: Thu, 12 Feb 2009 15:15:15 +0530
Message-ID: <6887eb5d0902120145g52d70ed5la78fe6c1717ca8ca@mail.gmail.com>
Subject: Re: Problem in Pairing
From: Kartikey Parmar <kartikey2781@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Tue, Feb 10, 2009 at 9:09 PM, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi Kartikey,
>
>> I m using Bluez-4.27 to implement my bluetooth module which will
>> detect nearby bluetooth enabled device & connects with its Audio
>> Gateway.
>>
>> Now when I attempt to connect Audio Gateway channel through my test
>> module it prompts me to Pair with "Bluez" on the remote device.
>>
>> When I accept the same it prompts me to enter "Pass Code" to pair.
>>
>> I did not ask for such passcodes in my test application...even in my
>> mobile phone I have not such type of setup to request for passcode.
>>
>> This problem arise when I attempt to connect on the rfcomm socket
>> which is bind to local bluetooth adapter.
>>
>> if somebody has also faced this type of problem, kindly reply me how
>> to solve this issue.
>
> send in output of "hcidump -X -V". Otherwise we can't tell what is going
> on.
>
> Regards
>
> Marcel
>
>
>
Pls find hcidump -X -V o/p below:

===========================================================

HCI sniffer - Bluetooth packet analyzer ver 1.42
device: hci0 snap_len: 1028 filter: 0xffffffff
< HCI Command: Read Local Name (0x03|0x0014) plen 0
> HCI Event: Command Complete (0x0e) plen 252
    Read Local Name (0x03|0x0014) ncmd 1
    status 0x00 name 'BlueZ'
< HCI Command: Read BD ADDR (0x04|0x0009) plen 0
> HCI Event: Command Complete (0x0e) plen 10
    Read BD ADDR (0x04|0x0009) ncmd 1
    status 0x00 bdaddr 00:11:67:88:ED:F8
< HCI Command: Read BD ADDR (0x04|0x0009) plen 0
> HCI Event: Command Complete (0x0e) plen 10
    Read BD ADDR (0x04|0x0009) ncmd 1
    status 0x00 bdaddr 00:11:67:88:ED:F8
< HCI Command: Read Voice Setting (0x03|0x0025) plen 0
> HCI Event: Command Complete (0x0e) plen 6
    Read Voice Setting (0x03|0x0025) ncmd 1
    status 0x00 voice setting 0x0060
< HCI Command: Create Connection (0x01|0x0005) plen 13
    bdaddr 00:1F:5D:B5:36:BC ptype 0xcc18 rswitch 0x01 clkoffset 0x0000
    Packet type: DM1 DM3 DM5 DH1 DH3 DH5
> HCI Event: Command Status (0x0f) plen 4
    Create Connection (0x01|0x0005) status 0x00 ncmd 1
> HCI Event: Connect Complete (0x03) plen 11
    status 0x00 handle 1 bdaddr 00:1F:5D:B5:36:BC type ACL encrypt 0x00
< ACL data: handle 1 flags 0x02 dlen 10
    L2CAP(s): Info req: type 2
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
< HCI Command: Remote Name Request (0x01|0x0019) plen 10
    bdaddr 00:1F:5D:B5:36:BC mode 2 clkoffset 0x0000
> HCI Event: Command Status (0x0f) plen 4
    Remote Name Request (0x01|0x0019) status 0x00 ncmd 1
> HCI Event: Number of Completed Packets (0x13) plen 6
    handle 1 packets 1
> HCI Event: Connection Packet Type Changed (0x1d) plen 5
    status 0x00 handle 1 ptype 0xcc18
    Packet type: DM1 DM3 DM5 DH1 DH3 DH5
> HCI Event: Read Remote Supported Features (0x0b) plen 11
    status 0x00 handle 1
    Features: 0xbf 0xee 0x0f 0xc6 0x98 0x39 0x00 0x00
> ACL data: handle 1 flags 0x02 dlen 16
    L2CAP(s): Info rsp: type 2 result 0
      Extended feature mask 0x0000
< ACL data: handle 1 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 3 scid 0x0040
> ACL data: handle 1 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0040 result 0 status 0
      Connection successful
< ACL data: handle 1 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 4
      MTU 1013
> ACL data: handle 1 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 4
      MTU 32772
< ACL data: handle 1 flags 0x02 dlen 18
    L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 4
      MTU 32772
> HCI Event: Remote Name Req Complete (0x07) plen 255
    status 0x00 bdaddr 00:1F:5D:B5:36:BC name 'Kartikey'
> HCI Event: Number of Completed Packets (0x13) plen 6
    handle 1 packets 1
> HCI Event: Number of Completed Packets (0x13) plen 6
    handle 1 packets 1
> HCI Event: Number of Completed Packets (0x13) plen 6
    handle 1 packets 1
> ACL data: handle 1 flags 0x02 dlen 18
    L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 4
      MTU 1013
< ACL data: handle 1 flags 0x02 dlen 8
    L2CAP(d): cid 0x0040 len 4 [psm 3]
      RFCOMM(s): SABM: cr 1 dlci 0 pf 1 ilen 0 fcs 0x1c
> HCI Event: Number of Completed Packets (0x13) plen 6
    handle 1 packets 1
> ACL data: handle 1 flags 0x02 dlen 8
    L2CAP(d): cid 0x0040 len 4 [psm 3]
      RFCOMM(s): UA: cr 1 dlci 0 pf 1 ilen 0 fcs 0xd7
< ACL data: handle 1 flags 0x02 dlen 18
    L2CAP(d): cid 0x0040 len 14 [psm 3]
      RFCOMM(s): PN CMD: cr 1 dlci 0 pf 0 ilen 10 fcs 0x70 mcc_len 8
      dlci 26 frame_type 0 credit_flow 15 pri 7 ack_timer 0
      frame_size 1008 max_retrans 0 credits 7
> HCI Event: Number of Completed Packets (0x13) plen 6
    handle 1 packets 1
> ACL data: handle 1 flags 0x02 dlen 18
    L2CAP(d): cid 0x0040 len 14 [psm 3]
      RFCOMM(s): PN RSP: cr 0 dlci 0 pf 0 ilen 10 fcs 0xaa mcc_len 8
      dlci 26 frame_type 0 credit_flow 14 pri 7 ack_timer 0
      frame_size 329 max_retrans 0 credits 0
< ACL data: handle 1 flags 0x02 dlen 8
    L2CAP(d): cid 0x0040 len 4 [psm 3]
      RFCOMM(s): SABM: cr 1 dlci 26 pf 1 ilen 0 fcs 0xe7
> HCI Event: Number of Completed Packets (0x13) plen 6
    handle 1 packets 1
> HCI Event: PIN Code Request (0x16) plen 6
    bdaddr 00:1F:5D:B5:36:BC
< HCI Command: PIN Code Request Negative Reply (0x01|0x000e) plen 6
    bdaddr 00:1F:5D:B5:36:BC
> HCI Event: Command Complete (0x0e) plen 10
    PIN Code Request Negative Reply (0x01|0x000e) ncmd 1
    status 0x00 bdaddr 00:1F:5D:B5:36:BC
< HCI Command: PIN Code Request Negative Reply (0x01|0x000e) plen 6
    bdaddr 00:1F:5D:B5:36:BC
> HCI Event: Auth Complete (0x06) plen 3
    status 0x06 handle 1
    Error: PIN or Key Missing
> HCI Event: Command Complete (0x0e) plen 10
    PIN Code Request Negative Reply (0x01|0x000e) ncmd 1
    status 0x00 bdaddr 00:1F:5D:B5:36:BC
> HCI Event: Auth Complete (0x06) plen 3
    status 0x06 handle 1
    Error: PIN or Key Missing
> ACL data: handle 1 flags 0x02 dlen 8
    L2CAP(d): cid 0x0040 len 4 [psm 3]
      RFCOMM(s): DM: cr 1 dlci 26 pf 1 ilen 0 fcs 0xcd
< ACL data: handle 1 flags 0x02 dlen 8
    L2CAP(d): cid 0x0040 len 4 [psm 3]
      RFCOMM(s): DISC: cr 1 dlci 0 pf 1 ilen 0 fcs 0xfd
< ACL data: handle 1 flags 0x02 dlen 12
    L2CAP(s): Disconn req: dcid 0x0040 scid 0x0040
> HCI Event: Number of Completed Packets (0x13) plen 6
    handle 1 packets 1
> HCI Event: Number of Completed Packets (0x13) plen 6
    handle 1 packets 1
> ACL data: handle 1 flags 0x02 dlen 8
    L2CAP(d): cid 0x0040 len 4 [psm 3]
      RFCOMM(s): UA: cr 1 dlci 0 pf 1 ilen 0 fcs 0xd7
> ACL data: handle 1 flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x0040 scid 0x0040
< HCI Command: Disconnect (0x01|0x0006) plen 3
    handle 1 reason 0x13
    Reason: Remote User Terminated Connection
> HCI Event: Command Status (0x0f) plen 4
    Disconnect (0x01|0x0006) status 0x00 ncmd 1
> HCI Event: Disconn Complete (0x05) plen 4
    status 0x00 handle 1 reason 0x16
    Reason: Connection Terminated by Local Host

===========================================================
-- 
Kartikey Parmar
R&D Engineer, Matrix Telesol Pvt Ltd
09879095390 (M)
