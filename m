Return-Path: <cyrus@holtmann.org>
Message-id: <0004441400404C638F928BC1E2E8285B@sisodomain.com>
From: Syam Sidhardhan <s.syam@samsung.com>
To: linux-bluetooth@vger.kernel.org
Subject: HDP source incoming connection with new kernel & BlueZ 4.101
Date: Thu, 06 Sep 2012 21:34:20 +0530
MIME-version: 1.0
Content-type: text/plain; format=flowed; charset=iso-8859-1; reply-type=original
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan, Luiz, Andrei,

I have backported the bluetooth.git kernel and testing the HDP profile using
the bluez 4.101 release at both end. As per the code and my understanding 
HDP
MCAP is not using defer setup (bt_io_listen confirm param is null), hence 
there
should not be any authorization. Am I correct here?

While initiating connection from HDP Sync to Source, I'm getting 
authorization
request at Source side in the backported bluetooth.git code (based on commit 
id:
ea1e76a3f92f8565d395c549b9ca836c7eaa44b9  Date:2012-06-19). I have tried 
with
disabling the mgmtops using bluetoothd -P option, but the same authorization
is coming at the Source side.

When I tested it on the 3.0 kernel with same Bluez 4.101, it is working 
fine.
In the hcidump, the difference is old 3.0 kernel requesting for 
authentication request,
instead of authorization request.
Failed case hcidump logs given below.
The l2cap kernel log is provided here "http://pastebin.com/FxSDmPcV"-(used 
printk)
and the success logs with the old kernel is given here 
"http://pastebin.com/L6ZMcTu"


So it seems something is broken in the bluetooth kernel.
Any idea, what is wrong?


Hcidump logs failure logs:
------------------------------------
1) Activate HDP source


< HCI Command: Write Extended Inquiry Response (0x03|0x0052) plen 241
    fec 0x00
    Unknown type 0x52 with 8 bytes data
    Flags: 0x14 0x16
> HCI Event: Command Complete (0x0e) plen 4
    Write Extended Inquiry Response (0x03|0x0052) ncmd 1
    status 0x00

2) Incoming connection from the remote HDP Sync device

> HCI Event: Connect Request (0x04) plen 10
    bdaddr 00:02:C4:EC:AD:E6 class 0x5a020c type ACL
< HCI Command: Accept Connection Request (0x01|0x0009) plen 7
    bdaddr 00:02:C4:EC:AD:E6 role 0x00
    Role: Master
> HCI Event: Command Status (0x0f) plen 4
    Accept Connection Request (0x01|0x0009) status 0x00 ncmd 1
> HCI Event: Role Change (0x12) plen 8
    status 0x00 bdaddr 00:02:C4:EC:AD:E6 role 0x00
    Role: Master
> HCI Event: Connect Complete (0x03) plen 11
    status 0x00 handle 11 bdaddr 00:02:C4:EC:AD:E6 type ACL encrypt 0x00
< HCI Command: Read Remote Supported Features (0x01|0x001b) plen 2
    handle 11
> HCI Event: Command Status (0x0f) plen 4
    Read Remote Supported Features (0x01|0x001b) status 0x00 ncmd 1
> HCI Event: Read Remote Supported Features (0x0b) plen 11
    status 0x00 handle 11
    Features: 0xbf 0xfe 0xcf 0xfe 0xdb 0xff 0x7b 0x87
< HCI Command: Read Remote Extended Features (0x01|0x001c) plen 3
    handle 11 page 1
> HCI Event: Command Status (0x0f) plen 4
    Read Remote Extended Features (0x01|0x001c) status 0x00 ncmd 1
> HCI Event: Read Remote Extended Features (0x23) plen 13
    status 0x00 handle 11 page 1 max 1
    Features: 0x01 0x00 0x00 0x00 0x00 0x00 0x00 0x00

 < HCI Command: Remote Name Request (0x01|0x0019) plen 10
    bdaddr 00:02:C4:EC:AD:E6 mode 2 clkoffset 0x0000
> HCI Event: Command Status (0x0f) plen 4
    Remote Name Request (0x01|0x0019) status 0x00 ncmd 1
> HCI Event: Max Slots Change (0x1b) plen 3
    handle 11 slots 5
> HCI Event: Remote Name Req Complete (0x07) plen 255
    status 0x00 bdaddr 00:02:C4:EC:AD:E6 name 'Redwood'
> ACL data: handle 11 flags 0x02 dlen 10
    L2CAP(s): Info req: type 2
< ACL data: handle 11 flags 0x00 dlen 16
    L2CAP(s): Info rsp: type 2 result 0
      Extended feature mask 0x00b8
        Enhanced Retransmission mode
        Streaming mode
        FCS Option
        Fixed Channels
> ACL data: handle 11 flags 0x02 dlen 10
    L2CAP(s): Info req: type 3
< ACL data: handle 11 flags 0x00 dlen 20
    L2CAP(s): Info rsp: type 3 result 0
      Fixed channel list 0x00000002
        L2CAP Signalling Channel
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 11 packets 2
> ACL data: handle 11 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 1 scid 0x0040
< ACL data: handle 11 flags 0x00 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0040 result 1 status 0
      Connection pending - No futher information available
< ACL data: handle 11 flags 0x00 dlen 10
    L2CAP(s): Info req: type 2
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 11 packets 2
> ACL data: handle 11 flags 0x02 dlen 16
    L2CAP(s): Info rsp: type 2 result 0
      Extended feature mask 0x00b8
        Enhanced Retransmission mode
        Streaming mode
        FCS Option
        Fixed Channels
< ACL data: handle 11 flags 0x00 dlen 10
    L2CAP(s): Info req: type 3
> ACL data: handle 11 flags 0x02 dlen 20
    L2CAP(s): Info rsp: type 3 result 0
      Fixed channel list 0x00000002
        L2CAP Signalling Channel
< ACL data: handle 11 flags 0x00 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0040 result 0 status 0
      Connection successful
< ACL data: handle 11 flags 0x00 dlen 23
    L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 11
      RFC 0x00 (Basic)
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 11 packets 2
> ACL data: handle 11 flags 0x02 dlen 23
    L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 11
      RFC 0x00 (Basic)
< ACL data: handle 11 flags 0x00 dlen 18
    L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 4
      MTU 672
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 11 packets 2
> ACL data: handle 11 flags 0x02 dlen 18
    L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 4
      MTU 672
> ACL data: handle 11 flags 0x02 dlen 38
    L2CAP(d): cid 0x0040 len 34 [psm 1]
        SDP SSA Req: tid 0x0 len 0x1d
          pat uuid-128 00001400-0000-1000-8000-00805f9b34fb
          max 65535
          aid(s) 0x0000 - 0xffff
          cont 00
< ACL data: handle 11 flags 0x00 dlen 206
    L2CAP(d): cid 0x0040 len 202 [psm 1]
        SDP SSA Rsp: tid 0x0 len 0xc5
          count 194
          record #0
              aid 0x0000 (SrvRecHndl)
                 uint 0x1000b
              aid 0x0001 (SrvClassIDList)
                 < uuid-16 0x1401 >
              aid 0x0002 (SrvRecState)
                 uint 0x0
              aid 0x0004 (ProtocolDescList)
                 < < uuid-16 0x0100 (L2CAP) uint 0x1001 > <
                 uuid-16 0x001e uint 0x100 > >
              aid 0x0009 (BTProfileDescList)
                 < < uuid-16 0x1400 uint 0x100 > >
              aid 0x000d (AdditionalProtocolDescLists)
                 < < < uuid-16 0x0100 (L2CAP) uint 0x1003 > < uuid-16 0x001f 
 > > >
              aid 0x0100 (SrvName)
                 str "Bluez HDP"
              aid 0x0101 (SrvDesc)
                 str "A Bluez health device profile implementation"
              aid 0x0102 (ProviderName)
                 str "Bluez"
              aid 0x0200 (VersionNumList)
                 < < uint 0x1 uint 0x1007 uint 0x0 str "Health Device" > >
              aid 0x0301 (SuppDataStoresList)
                 uint 0x1
              aid 0x0302 (unknown)
                 uint 0x6
          cont 00
> ACL data: handle 11 flags 0x02 dlen 38
    L2CAP(d): cid 0x0040 len 34 [psm 1]
        SDP SSA Req: tid 0x1 len 0x1d
          pat uuid-128 00001400-0000-1000-8000-00805f9b34fb
          max 65535
          aid(s) 0x0000 - 0xffff
          cont 00
< ACL data: handle 11 flags 0x00 dlen 206
    L2CAP(d): cid 0x0040 len 202 [psm 1]
        SDP SSA Rsp: tid 0x1 len 0xc5
          count 194
          record #0
              aid 0x0000 (SrvRecHndl)
                 uint 0x1000b
              aid 0x0001 (SrvClassIDList)
                 < uuid-16 0x1401 >
              aid 0x0002 (SrvRecState)
                 uint 0x0
              aid 0x0004 (ProtocolDescList)
                 < < uuid-16 0x0100 (L2CAP) uint 0x1001 > <
                 uuid-16 0x001e uint 0x100 > >
              aid 0x0009 (BTProfileDescList)
                 < < uuid-16 0x1400 uint 0x100 > >
              aid 0x000d (AdditionalProtocolDescLists)
                 < < < uuid-16 0x0100 (L2CAP) uint 0x1003 > < uuid-16 0x001f 
 > > >
              aid 0x0100 (SrvName)
                 str "Bluez HDP"
              aid 0x0101 (SrvDesc)
                 str "A Bluez health device profile implementation"
              aid 0x0102 (ProviderName)
                 str "Bluez"
              aid 0x0200 (VersionNumList)
                 < < uint 0x1 uint 0x1007 uint 0x0 str "Health Device" > >
              aid 0x0301 (SuppDataStoresList)
                 uint 0x1
              aid 0x0302 (unknown)
                 uint 0x6
          cont 00
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 11 packets 2
> HCI Event: Link Key Request (0x17) plen 6
    bdaddr 00:02:C4:EC:AD:E6
< HCI Command: Link Key Request Reply (0x01|0x000b) plen 22
    bdaddr 00:02:C4:EC:AD:E6 key 83E54CBBC30B55A90DFE81F7B63CF9BC
> HCI Event: Command Complete (0x0e) plen 10
    Link Key Request Reply (0x01|0x000b) ncmd 1
    status 0x00 bdaddr 00:02:C4:EC:AD:E6
> HCI Event: Encrypt Change (0x08) plen 4
    status 0x00 handle 11 encrypt 0x01
> ACL data: handle 11 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 4097 scid 0x0041
< ACL data: handle 11 flags 0x00 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0041 scid 0x0041 result 1 status 2
      Connection pending - Authorization pending

3) Why authorization is coming with new kernel and not with old kernel with
same user space bluez?

> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 11 packets 1
> ACL data: handle 11 flags 0x02 dlen 12
    L2CAP(s): Disconn req: dcid 0x0040 scid 0x0040
< ACL data: handle 11 flags 0x00 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x0040 scid 0x0040
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 11 packets 1
< ACL data: handle 11 flags 0x00 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0041 scid 0x0041 result 0 status 0
      Connection successful
< ACL data: handle 11 flags 0x00 dlen 27
    L2CAP(s): Config req: dcid 0x0041 flags 0x00 clen 15
      MTU 32767
      RFC 0x03 (Enhanced Retransmission, TxWin 63, MaxTx 3, RTo 0, MTo 0, 
MPS 1009)
> ACL data: handle 11 flags 0x02 dlen 23
    L2CAP(s): Config req: dcid 0x0041 flags 0x00 clen 11
      RFC 0x03 (Enhanced Retransmission, TxWin 63, MaxTx 3, RTo 0, MTo 0, 
MPS 1009)
< ACL data: handle 11 flags 0x00 dlen 29
    L2CAP(s): Config rsp: scid 0x0041 flags 0x00 result 0 clen 15
      MTU 672
      RFC 0x03 (Enhanced Retransmission, TxWin 63, MaxTx 3, RTo 2000, MTo 
12000, MPS 1009)
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 11 packets 2
> ACL data: handle 11 flags 0x02 dlen 29
     L2CAP(s): Config rsp: scid 0x0041 flags 0x00 result 0 clen 15
       MTU 32767
       RFC 0x03 (Enhanced Retransmission, TxWin 63, MaxTx 3, RTo 2000, MTo 
12000, MPS 1009)

> ACL data: handle 11 flags 0x02 dlen 13
    L2CAP(d): cid 0x0041 len 9 ctrl 0x0000 fcs 0xe464 [psm 4097]
      I-frame: Unsegmented TxSeq 0 ReqSeq 0
      0000: 01 77 31 01 00                                    .w1..
< ACL data: handle 11 flags 0x00 dlen 12
    L2CAP(s): Disconn req: dcid 0x0041 scid 0x0041

4) Here HDP source initiate disconnection request

> ACL data: handle 11 flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x0041 scid 0x0041
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 11 packets 2
> HCI Event: Disconn Complete (0x05) plen 4
    status 0x00 handle 11 reason 0x13
    Reason: Remote User Terminated Connection

Regards,
Syam

