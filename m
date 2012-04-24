Return-Path: <cyrus@holtmann.org>
Message-ID: <4F968FF7.7060303@tu-ilmenau.de>
Date: Tue, 24 Apr 2012 13:35:19 +0200
From: Steffen Becker <steffen.becker@tu-ilmenau.de>
MIME-Version: 1.0
To: linux-bluetooth@vger.kernel.org
Subject: Can't connect Bluetooth Devices
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello,

I still have a problem to connect my bluetooth devices via pand command. 
I've been searching the internet and asked in forums, but i didn't get 
an answer.

I have 2 gentoo-PCs with a Bluetooth-3.0 Dongle at each PC.
Circa 2 weeks ago, everything worked. BlueZ-4.96 was installed and I had 
no problems to connect my devices via pand and via rfcomm command.
But then I asked you for an SSP debug mode patch, because I wanted to 
sniff my rfcomm connection. At the same time BlueZ-4.99 was released and 
so I installed the new BlueZ-version and the patch.
I also deleted the stored linkkey and I was happy that I was able to 
sniff my rfcomm-connection.
But thenceforth I can't connect my devices via pand command.

Then I tried to install the BlueZ-4.99 *without* the patch, but I still 
couldn't connect via pand.
I also tried to install BlueZ-4.96, but the problem was still the same. 
So I think it's no problem of the patch or the newer BlueZ-version, but 
I really have no idea what's wrong.

If you need any of my configuration-files, just tell me and I will send it.

In the end, I show the hcidump message when I try to connect via pand 
command.

Hope anyone can help me.

Regards,
Steffen


# hcidump -i hci0
HCI sniffer - Bluetooth packet analyzer ver 2.3
device: hci0 snap_len: 1028 filter: 0xffffffffffffffff
 > HCI Event: Connect Request (0x04) plen 10
     bdaddr 00:02:72:AE:58:73 class 0x420100 type ACL
< HCI Command: Accept Connection Request (0x01|0x0009) plen 7
     bdaddr 00:02:72:AE:58:73 role 0x00
     Role: Master
 > HCI Event: Command Status (0x0f) plen 4
     Accept Connection Request (0x01|0x0009) status 0x00 ncmd 1
 > HCI Event: Role Change (0x12) plen 8
     status 0x00 bdaddr 00:02:72:AE:58:73 role 0x00
     Role: Master
 > HCI Event: Connect Complete (0x03) plen 11
     status 0x00 handle 11 bdaddr 00:02:72:AE:58:73 type ACL encrypt 0x00
< HCI Command: Read Remote Supported Features (0x01|0x001b) plen 2
     handle 11
 > HCI Event: Max Slots Change (0x1b) plen 3
     handle 11 slots 5
 > HCI Event: Command Status (0x0f) plen 4
     Read Remote Supported Features (0x01|0x001b) status 0x00 ncmd 1
 > HCI Event: Read Remote Supported Features (0x0b) plen 11
     status 0x00 handle 11
     Features: 0xff 0xff 0x8f 0xfe 0x9b 0xff 0x79 0x87
< HCI Command: Read Remote Extended Features (0x01|0x001c) plen 3
     handle 11 page 1
 > HCI Event: Command Status (0x0f) plen 4
     Read Remote Extended Features (0x01|0x001c) status 0x00 ncmd 1
 > HCI Event: Read Remote Extended Features (0x23) plen 13
     status 0x00 handle 11 page 1 max 1
     Features: 0x01 0x00 0x00 0x00 0x00 0x00 0x00 0x00
< HCI Command: Remote Name Request (0x01|0x0019) plen 10
     bdaddr 00:02:72:AE:58:73 mode 2 clkoffset 0x0000
 > HCI Event: Command Status (0x0f) plen 4
     Remote Name Request (0x01|0x0019) status 0x00 ncmd 1
 > HCI Event: Remote Name Req Complete (0x07) plen 255
     status 0x00 bdaddr 00:02:72:AE:58:73 name 'bluetooth1-0'
 > HCI Event: IO Capability Response (0x32) plen 9
     bdaddr 00:02:72:AE:58:73 capability 0x03 oob 0x00 auth 0x00
     Capability: NoInputNoOutput (OOB data not present)
     Authentication: No Bonding (No MITM Protection)
 > HCI Event: IO Capability Request (0x31) plen 6
     bdaddr 00:02:72:AE:58:73
< HCI Command: IO Capability Request Reply (0x01|0x002b) plen 9
     bdaddr 00:02:72:AE:58:73 capability 0x03 oob 0x00 auth 0x00
     Capability: NoInputNoOutput (OOB data not present)
     Authentication: No Bonding (No MITM Protection)
 > HCI Event: Command Complete (0x0e) plen 10
     IO Capability Request Reply (0x01|0x002b) ncmd 1
     status 0x00 bdaddr 00:02:72:AE:58:73
 > HCI Event: User Confirmation Request (0x33) plen 10
     bdaddr 00:02:72:AE:58:73 passkey 800553
< HCI Command: User Confirmation Request Reply (0x01|0x002c) plen 6
     bdaddr 00:02:72:AE:58:73
 > HCI Event: Command Complete (0x0e) plen 10
     User Confirmation Request Reply (0x01|0x002c) ncmd 1
     status 0x00 bdaddr 00:02:72:AE:58:73
 > HCI Event: Simple Pairing Complete (0x36) plen 7
     status 0x00 bdaddr 00:02:72:AE:58:73
 > HCI Event: Link Key Notification (0x18) plen 23
     bdaddr 00:02:72:AE:58:73 key E1C30FE5E1D620AC6DC78BB5A4AC299A type 4
     Type: Unauthenticated Combination Key
 > HCI Event: Encrypt Change (0x08) plen 4
     status 0x00 handle 11 encrypt 0x01
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
     L2CAP(s): Connect req: psm 15 scid 0x0040
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
     L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0040 result 1 status 2
       Connection pending - Authorization pending
< ACL data: handle 11 flags 0x00 dlen 16
     L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0040 result 3 status 0
       Connection refused - security block
 > HCI Event: Number of Completed Packets (0x13) plen 5
     handle 11 packets 2
 > HCI Event: Number of Completed Packets (0x13) plen 5
     handle 11 packets 1
 > HCI Event: Disconn Complete (0x05) plen 4
     status 0x00 handle 11 reason 0x13
     Reason: Remote User Terminated Connection

