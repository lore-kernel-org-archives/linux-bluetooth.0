Return-Path: <cyrus@holtmann.org>
To: linux-bluetooth@vger.kernel.org
From: =?UTF-8?Q?J=c3=bcrgen_Benjamin_Ronshausen?= <b.r@rie.eu>
Subject: L2CAP_INFO_REQ Command rejected by remote side and disconnect
Message-ID: <5628D38B.6000808@rie.eu>
Date: Thu, 22 Oct 2015 14:16:11 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello,

i am working with Bluez 4.96, kernel 3.2 on embedded ARM.

Our embedded system is passive (discoverable, connectable) and gets 
contacted by bluetooth Access Points. With the older model Access Point 
the connection is disconnected from the Access Point. It seems to me 
that the Access Point doesn't implement L2CAP_INFO_REQ and L2CAP_INFO_RSP.

I used hcidump to investigate. Here is the part that i believe is the 
problem:

< ACL data: handle 1 flags 0x00 dlen 10
     L2CAP(s): Info req: type 2
 > HCI Event: Read Remote Supported Features (0x0b) plen 11
     status 0x00 handle 1
     Features: 0xff 0xff 0x8f 0x78 0x18 0x18 0x00 0x80
< HCI Command: Remote Name Request (0x01|0x0019) plen 10
     bdaddr 00:0B:53:20:04:09 mode 2 clkoffset 0x0000
 > HCI Event: Command Status (0x0f) plen 4
     Remote Name Request (0x01|0x0019) status 0x00 ncmd 1
 > HCI Event: Number of Completed Packets (0x13) plen 5
     handle 1 packets 2
 > ACL data: handle 1 flags 0x02 dlen 10
     L2CAP(s): Command rej: reason 0
       Command not understood

So after the L2CAP connection is established the module asks the AP for 
the Extended Features Mask via Info req. The AP responds with command 
not understood.

Could i be right about that the AP doesn't implement the L2CAP_INFO_REQ 
and L2CAP_INFO_RSP? Or is this a timing issue, where the AP state 
machine doesn't expect to be asked about Extended Features Mask at this 
time?

The Access Point is a Sena Parani MSP 101/102 with software from Initium 
on it.

Regards

Benjamin


Full dump:

 > HCI Event: Connect Request (0x04) plen 10
     bdaddr 00:0B:53:20:04:09 class 0x020300 type ACL
< HCI Command: Accept Connection Request (0x01|0x0009) plen 7
     bdaddr 00:0B:53:20:04:09 role 0x00
     Role: Master
 > HCI Event: Command Status (0x0f) plen 4
     Accept Connection Request (0x01|0x0009) status 0x00 ncmd 1
 > HCI Event: Role Change (0x12) plen 8
     status 0x21 bdaddr 00:0B:53:20:04:09 role 0x01
     Error: Role Change Not Allowed
 > HCI Event: Connect Complete (0x03) plen 11
     status 0x00 handle 1 bdaddr 00:0B:53:20:04:09 type ACL encrypt 0x00
< HCI Command: Read Remote Supported Features (0x01|0x001b) plen 2
     handle 1
 > HCI Event: Page Scan Repetition Mode Change (0x20) plen 7
     bdaddr 00:0B:53:20:04:09 mode 1
 > HCI Event: Command Status (0x0f) plen 4
     Read Remote Supported Features (0x01|0x001b) status 0x00 ncmd 1
 > HCI Event: Max Slots Change (0x1b) plen 3
     handle 1 slots 5
 > ACL data: handle 1 flags 0x02 dlen 12
     L2CAP(s): Connect req: psm 1 scid 0x0086
< ACL data: handle 1 flags 0x00 dlen 16
     L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0086 result 1 status 0
       Connection pending - No futher information available
< ACL data: handle 1 flags 0x00 dlen 10
     L2CAP(s): Info req: type 2
 > HCI Event: Read Remote Supported Features (0x0b) plen 11
     status 0x00 handle 1
     Features: 0xff 0xff 0x8f 0x78 0x18 0x18 0x00 0x80
< HCI Command: Remote Name Request (0x01|0x0019) plen 10
     bdaddr 00:0B:53:20:04:09 mode 2 clkoffset 0x0000
 > HCI Event: Command Status (0x0f) plen 4
     Remote Name Request (0x01|0x0019) status 0x00 ncmd 1
 > HCI Event: Number of Completed Packets (0x13) plen 5
     handle 1 packets 2
 > ACL data: handle 1 flags 0x02 dlen 10
     L2CAP(s): Command rej: reason 0
       Command not understood
 > HCI Event: Remote Name Req Complete (0x07) plen 255
     status 0x00 bdaddr 00:0B:53:20:04:09 name 'Promi-MSP_200409'
< ACL data: handle 1 flags 0x00 dlen 16
     L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0086 result 0 status 0
       Connection successful
< ACL data: handle 1 flags 0x00 dlen 12
     L2CAP(s): Config req: dcid 0x0086 flags 0x00 clen 0
 > HCI Event: Number of Completed Packets (0x13) plen 5
     handle 1 packets 2
 > HCI Event: Disconn Complete (0x05) plen 4
     status 0x00 handle 1 reason 0x13
     Reason: Remote User Terminated Connection

