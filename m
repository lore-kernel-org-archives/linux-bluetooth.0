Return-Path: <cyrus@holtmann.org>
References: <1375969749-2097-1-git-send-email-luiz.dentz@gmail.com>
Message-ID: <1376728537.91176.YahooMailNeo@web193101.mail.sg3.yahoo.com>
Date: Sat, 17 Aug 2013 16:35:37 +0800 (SGT)
From: Tama <pkm_munot@yahoo.co.in>
Reply-To: Tama <pkm_munot@yahoo.co.in>
Subject: Rfcomm connection error while connecting from android app
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
In-Reply-To: <1375969749-2097-1-git-send-email-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello all,

This is my first post to this mailing list. I am new to Bluetooth, I am trying to develop an embedded application with bluetooth using bluez 4.96 stack which would be controled by an adroid application.

My embedded platfrom is IMX28 running linux with Bluex4.96. On this platfrom I have a BCM2070 bluetooth usb dongle. I am running a simple rfcomm server example from this link "http://people.csail.mit.edu/albert/bluez-intro/x502.html". I ran a rfcomm client on ubuntu pc with BCM2070 bluetooth usb dongle and I could talk between the server and client. 

Now I am developing an app on android but i am unable to connect to rfcomm server. I even tried running the rfcomm server on ubuntu machine but same result. I have attached the log of hcidump. 

> HCI Event: Connect Request (0x04) plen 10
    bdaddr D0:E7:82:4A:26:BA class 0x5a011c type ACL
< HCI Command: Accept Connection Request (0x01|0x0009) plen 7
    bdaddr D0:E7:82:4A:26:BA role 0x00
    Role: Master
> HCI Event: Command Status (0x0f) plen 4
    Accept Connection Request (0x01|0x0009) status 0x00 ncmd 1
> HCI Event: Role Change (0x12) plen 8
    status 0x00 bdaddr D0:E7:82:4A:26:BA role 0x00
    Role: Master
> HCI Event: Connect Complete (0x03) plen 11
    status 0x00 handle 12 bdaddr D0:E7:82:4A:26:BA type ACL encrypt 0x00
< HCI Command: Read Remote Supported Features (0x01|0x001b) plen 2
    handle 12
> HCI Event: Command Status (0x0f) plen 4
    Read Remote Supported Features (0x01|0x001b) status 0x00 ncmd 1
> HCI Event: Read Remote Supported Features (0x0b) plen 11
    status 0x00 handle 12
    Features: 0xbf 0x3e 0x8d 0xfe 0xdb 0xff 0x5b 0x87
< HCI Command: Read Remote Extended Features (0x01|0x001c) plen 3
    handle 12 page 1
> HCI Event: Command Status (0x0f) plen 4
    Read Remote Extended Features (0x01|0x001c) status 0x00 ncmd 1
> ACL data: handle 12 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 1 scid 0x0040
< ACL data: handle 12 flags 0x00 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0040 result 1 status 0
      Connection pending - No futher information available
< ACL data: handle 12 flags 0x00 dlen 10
    L2CAP(s): Info req: type 2
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 12 packets 2
> ACL data: handle 12 flags 0x02 dlen 16
    L2CAP(s): Info rsp: type 2 result 0
      Extended feature mask 0x02fb
        Flow control mode
        Retransmission mode
        Enhanced Retransmission mode
        Streaming mode
        FCS Option
        Extended Flow Specification
        Fixed Channels
        Unicast Connectless Data Reception
< ACL data: handle 12 flags 0x00 dlen 10
    L2CAP(s): Info req: type 3
> HCI Event: Max Slots Change (0x1b) plen 3
    handle 12 slots 5
> ACL data: handle 12 flags 0x02 dlen 20
    L2CAP(s): Info rsp: type 3 result 0
      Fixed channel list 0x00000006
        L2CAP Signalling Channel
        L2CAP Connless
< ACL data: handle 12 flags 0x00 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0040 result 0 status 0
      Connection successful
< ACL data: handle 12 flags 0x00 dlen 23
    L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 11
      RFC 0x00 (Basic) 
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 12 packets 2
> ACL data: handle 12 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 4
      MTU 1691 
< ACL data: handle 12 flags 0x00 dlen 18
    L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 4
      MTU 1691 
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 12 packets 2
> ACL data: handle 12 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 0
      Success
> ACL data: handle 12 flags 0x02 dlen 31
    L2CAP(d): cid 0x0040 len 27 [psm 1]
        SDP SS Req: tid 0x26 len 0x16
          pat uuid-128 00001101-0000-1000-8000-00805f9b34fb
          max 16
          cont 00
< ACL data: handle 12 flags 0x00 dlen 14
    L2CAP(d): cid 0x0040 len 10 [psm 1]
        SDP SS Rsp: tid 0x26 len 0x5
          count 0
          cont 00
> HCI Event: Read Remote Extended Features (0x23) plen 13
    status 0x00 handle 12 page 1 max 2
    Features: 0x03 0x00 0x00 0x00 0x00 0x00 0x00 0x00
< HCI Command: Remote Name Request (0x01|0x0019) plen 10
    bdaddr D0:E7:82:4A:26:BA mode 2 clkoffset 0x0000
> ACL data: handle 12 flags 0x02 dlen 12
    L2CAP(s): Disconn req: dcid 0x0040 scid 0x0040
< ACL data: handle 12 flags 0x00 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x0040 scid 0x0040
> HCI Event: Command Status (0x0f) plen 4
    Remote Name Request (0x01|0x0019) status 0x00 ncmd 1
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 12 packets 2
> HCI Event: Remote Name Req Complete (0x07) plen 255
    status 0x00 bdaddr D0:E7:82:4A:26:BA name 'A1-810'
> HCI Event: Disconn Complete (0x05) plen 4
    status 0x00 handle 12 reason 0x13
    Reason: Remote User Terminated Connection

What could be the reason for termination of a connection. On my host machine i just have rfcomm server running nothing else. Does my rfcomm server needs to have anything else in it. 

Can some one please help me to understand what could be causing this issue.

Thanks
Tama
