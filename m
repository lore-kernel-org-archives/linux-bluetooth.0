Return-Path: <cyrus@holtmann.org>
Message-ID: <870470.9658.qm@web95413.mail.in2.yahoo.com>
References: <60bfa9f30905071939i63429b64q52333d5c4a098a6b@mail.gmail.com> <60bfa9f30905072051k734e4255q4f3eaec2a46c528f@mail.gmail.com>
Date: Fri, 8 May 2009 13:43:55 +0530 (IST)
From: balaji palaniswami <balaji_palaniswami@yahoo.com>
Subject: Re: [Issue]BlueZ 4.12: PAN does not work between 2 Ubuntu 8.10
To: Leo Lei <bluez.lei@gmail.com>, linux-bluetooth@vger.kernel.org
In-Reply-To: <60bfa9f30905072051k734e4255q4f3eaec2a46c528f@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


Hello Leo Lei ,

I have tried out Ubuntu 9.04 with default Bluez 4.32 .It is working in HandsFree and a2dp profile.

>From these pan profile also would work in new Ubuntu 9.04.

Thanks,
Balaji.P


----- Original Message ----
From: Leo Lei <bluez.lei@gmail.com>
To: linux-bluetooth@vger.kernel.org
Sent: Friday, 8 May, 2009 9:21:53 AM
Subject: [Issue]BlueZ 4.12: PAN does not work between 2 Ubuntu 8.10

Dear All,

Have you ever try to use PAN between 2 Ubuntu 8.10 machines? I'm
getting an error "Connection refused(111)". I found error string ""
when using hcidump tools. Please see the log data.

Env: BlueZ 4.12 and BlueZ 4.32 /bluez-gnome 1.8 /Ubuntu 8.10

Command: pand --connect 00:15:83:04:F8:F3 --service GN -n

error message:
-------------------------------

pand[19627]: Bluetooth PAN daemon version 4.12
pand[19627]: Connecting to 00:15:83:04:F8:F3
pand[19627]: Connect to 00:15:83:04:F8:F3 failed. Connection refused(111)



The result of 'sdptool browse'
------------------------

Service Name: BlueZ PANU service
Service Description: BlueZ PAN service
Service RecHandle: 0x10005
Service Class ID List:
 "PAN User" (0x1115)
Protocol Descriptor List:
 "L2CAP" (0x0100)
   PSM: 15
 "BNEP" (0x000f)
   Version: 0x0100
   SEQ16: 800 806
Language Base Attr List:
 code_ISO639: 0x656e
 encoding:    0x6a
 base_offset: 0x100
Profile Descriptor List:
 "PAN User" (0x1115)
   Version: 0x0100

Service Name: BlueZ GN service
Service Description: BlueZ PAN service
Service RecHandle: 0x10006
Service Class ID List:
 "PAN Group Network" (0x1117)
Protocol Descriptor List:
 "L2CAP" (0x0100)
   PSM: 15
 "BNEP" (0x000f)
   Version: 0x0100
   SEQ16: 800 806
Language Base Attr List:
 code_ISO639: 0x656e
 encoding:    0x6a
 base_offset: 0x100
Profile Descriptor List:
 "PAN Group Network" (0x1117)
   Version: 0x0100

Service Name: BlueZ NAP service
Service Description: BlueZ PAN service
Service RecHandle: 0x10007
Service Class ID List:
 "Network Access Point" (0x1116)
Protocol Descriptor List:
 "L2CAP" (0x0100)
   PSM: 15
 "BNEP" (0x000f)
   Version: 0x0100
   SEQ16: 800 806
Language Base Attr List:
 code_ISO639: 0x656e
 encoding:    0x6a
 base_offset: 0x100
Profile Descriptor List:
 "Network Access Point" (0x1116)
   Version: 0x0100



The result of hcidump -xVt:
------------------------

HCI sniffer - Bluetooth packet analyzer ver 1.42
device: hci0 snap_len: 1028 filter: 0xffffffff
2009-05-07 17:10:53.318736 > HCI Event: Connect Request (0x04) plen 10
   bdaddr 00:15:83:04:F8:F3 class 0x4a010c type ACL
2009-05-07 17:10:53.318853 < HCI Command: Accept Connection Request
(0x01|0x0009) plen 7
   bdaddr 00:15:83:04:F8:F3 role 0x01
   Role: Slave
2009-05-07 17:10:53.321732 > HCI Event: Command Status (0x0f) plen 4
   Accept Connection Request (0x01|0x0009) status 0x00 ncmd 1
2009-05-07 17:10:53.347747 > HCI Event: Connect Complete (0x03) plen 11
   status 0x00 handle 21 bdaddr 00:15:83:04:F8:F3 type ACL encrypt 0x00
2009-05-07 17:10:53.347853 < HCI Command: Read Remote Supported
Features (0x01|0x001b) plen 2
   handle 21
2009-05-07 17:10:53.349741 > HCI Event: Command Status (0x0f) plen 4
   Read Remote Supported Features (0x01|0x001b) status 0x00 ncmd 1
2009-05-07 17:10:53.378771 > HCI Event: Max Slots Change (0x1b) plen 3
   handle 21 slots 5
2009-05-07 17:10:53.380225 < HCI Command: Remote Name Request
(0x01|0x0019) plen 10
   bdaddr 00:15:83:04:F8:F3 mode 2 clkoffset 0x0000
2009-05-07 17:10:53.380756 > HCI Event: Connection Packet Type Changed
(0x1d) plen 5
   status 0x00 handle 21 ptype 0xcc18
   Packet type: DM1 DM3 DM5 DH1 DH3 DH5
2009-05-07 17:10:53.382757 > HCI Event: Read Remote Supported Features
(0x0b) plen 11
   status 0x00 handle 21
   Features: 0xff 0xff 0x8f 0x7e 0x98 0x19 0x00 0x80
2009-05-07 17:10:53.384760 > HCI Event: Command Status (0x0f) plen 4
   Remote Name Request (0x01|0x0019) status 0x00 ncmd 1
2009-05-07 17:10:53.387760 > HCI Event: Remote Host Supported Features
Notification (0x3d) plen 14
   bdaddr 00:15:83:04:F8:F3
   Features: 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00
2009-05-07 17:10:53.395763 > ACL data: handle 21 flags 0x02 dlen 10
   L2CAP(s): Info req: type 2
2009-05-07 17:10:53.395803 < ACL data: handle 21 flags 0x02 dlen 16
   L2CAP(s): Info rsp: type 2 result 0
     Extended feature mask 0x0000
2009-05-07 17:10:53.410771 > ACL data: handle 21 flags 0x02 dlen 12
   L2CAP(s): Connect req: psm 15 scid 0x0040
2009-05-07 17:10:53.410822 < ACL data: handle 21 flags 0x02 dlen 16
   L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0040 result 1 status 0
     Connection pending - No futher information available
2009-05-07 17:10:53.410831 < ACL data: handle 21 flags 0x02 dlen 10
   L2CAP(s): Info req: type 2
2009-05-07 17:10:53.426781 > ACL data: handle 21 flags 0x02 dlen 16
   L2CAP(s): Info rsp: type 2 result 0
     Extended feature mask 0x0000
2009-05-07 17:10:53.426840 < HCI Command: Authentication Requested
(0x01|0x0011) plen 2
   handle 21
2009-05-07 17:10:53..426851 < ACL data: handle 21 flags 0x02 dlen 16
   L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0040 result 1 status 1
     Connection pending - Authentication pending
2009-05-07 17:10:53.429780 > HCI Event: Remote Name Req Complete (0x07) plen 255
   status 0x00 bdaddr 00:15:83:04:F8:F3 name 'llei-t61-u810-llei'
2009-05-07 17:10:53.431785 > HCI Event: Number of Completed Packets
(0x13) plen 5
   handle 21 packets 1
2009-05-07 17:10:53.433796 > HCI Event: Number of Completed Packets
(0x13) plen 5
   handle 21 packets 1
2009-05-07 17:10:53.435790 > HCI Event: Number of Completed Packets
(0x13) plen 5
   handle 21 packets 1
2009-05-07 17:10:53..437791 > HCI Event: Command Status (0x0f) plen 4
   Authentication Requested (0x01|0x0011) status 0x00 ncmd 1
2009-05-07 17:10:53.439797 > HCI Event: Link Key Request (0x17) plen 6
   bdaddr 00:15:83:04:F8:F3
2009-05-07 17:10:53.440350 < HCI Command: Link Key Request Reply
(0x01|0x000b) plen 22
   bdaddr 00:15:83:04:F8:F3 key 2EE2F0AC59BCC74C33216655D4011798
2009-05-07 17:10:53.441789 > HCI Event: Number of Completed Packets
(0x13) plen 5
   handle 21 packets 1
2009-05-07 17:10:53.443789 > HCI Event: Command Complete (0x0e) plen 10
   Link Key Request Reply (0x01|0x000b) ncmd 1
   status 0x00 bdaddr 00:15:83:04:F8:F3
2009-05-07 17:10:53.582873 > HCI Event: Auth Complete (0x06) plen 3
   status 0x00 handle 21
2009-05-07 17:10:53.582937 < HCI Command: Set Connection Encryption
(0x01|0x0013) plen 3
   handle 21 encrypt 0x01
2009-05-07 17:10:53.584866 > HCI Event: Command Status (0x0f) plen 4
   Set Connection Encryption (0x01|0x0013) status 0x00 ncmd 1
2009-05-07 17:10:53.632911 > HCI Event: Encrypt Change (0x08) plen 4
   status 0x00 handle 21 encrypt 0x01
2009-05-07 17:10:53.632996 < ACL data: handle 21 flags 0x02 dlen 16
   L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0040 result 0 status 0
     Connection successful
2009-05-07 17:10:53.644918 > HCI Event: Number of Completed Packets
(0x13) plen 5
   handle 21 packets 1
2009-05-07 17:10:53.647906 > ACL data: handle 21 flags 0x02 dlen 12
   L2CAP(s): Connect req: psm 15 scid 0x0040
2009-05-07 17:10:53.647951 < ACL data: handle 21 flags 0x02 dlen 16
   L2CAP(s): Connect rsp: dcid 0x0000 scid 0x0040 result 4 status 0
     Connection refused - no resources available
2009-05-07 17:10:53.648899 > ACL data: handle 21 flags 0x02 dlen 16
   L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 4
     MTU 1691
2009-05-07 17:10:53.648934 < ACL data: handle 21 flags 0x02 dlen 18
   L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 4
     MTU 1691
2009-05-07 17:10:53.648941 < ACL data: handle 21 flags 0x02 dlen 16
   L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 4
     MTU 1691
2009-05-07 17:10:53.659909 > HCI Event: Number of Completed Packets
(0x13) plen 5
   handle 21 packets 1
2009-05-07 17:10:53.661905 > HCI Event: Number of Completed Packets
(0x13) plen 5
   handle 21 packets 1
2009-05-07 17:10:53.663905 > HCI Event: Number of Completed Packets
(0x13) plen 5
   handle 21 packets 1
2009-05-07 17:10:53.665909 > ACL data: handle 21 flags 0x02 dlen 10
   L2CAP(s): Command rej: reason 0
     Command not understood
2009-05-07 17:10:55.664986 > HCI Event: Disconn Complete (0x05) plen 4
   status 0x00 handle 21 reason 0x13
   Reason: Remote User Terminated Connection




Thanks,
Leo
--
To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html



      Cricket on your mind? Visit the ultimate cricket website. Enter http://beta.cricket.yahoo.com

