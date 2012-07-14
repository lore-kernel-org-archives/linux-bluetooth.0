Return-Path: <cyrus@holtmann.org>
Message-ID: <5001A086.7030908@tu-ilmenau.de>
Date: Sat, 14 Jul 2012 18:38:30 +0200
From: Steffen Becker <steffen.becker@tu-ilmenau.de>
MIME-Version: 1.0
To: linux-bluetooth@vger.kernel.org
Subject: how to create bnep connection
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello guys,
I'm really despaired because I'm trying for MONTH to create a bnep 
connection between my two Bluetooth-Dongles, but it never works =(
I only can create a connection via "rfcomm".
I really hope you can help me - I even would pay a little for that.
In addition I'm a linux-newbie, so your answers should be detailled.
I just did a new installation of openSuSE 12.1 on my both PC's. After 
that, I only installed "bluez-compat" and "bluez-hcidump". "bluez" was 
pre-installed. Now i wanted to use "pand" to connect - yeah, I know 
there is "dbus", but I'm not familiar with that, so I prefer pand.
First I tried to connect via the GUI (I use gnome), but the button for 
"Connect" is shown grayed out. After that I entered the following in the 
terminal at PC1:
# sdptool add NAP
# pand -s -r NAP -M
and at PC2:
# sdptool add NAP
# pand -c <remote-btaddress>

As seen in the GUI I had a connection for about 3 seconds, but it always 
gets terminated.
Down below you can see the hcidump messages at both PC's.
I hope you can help me.

Regards, Steffen


hcidump at PC1:
  # hcidump -i hci0
HCI sniffer - Bluetooth packet analyzer ver 2.0
device: hci0 snap_len: 1028 filter: 0xffffffffffffffff
 > HCI Event: Connect Request (0x04) plen 10
     bdaddr 00:02:72:AE:58:73 class 0x4a0100 type ACL
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
     status 0x00 bdaddr 00:02:72:AE:58:73 name 'linux-3h3s-0'
 > HCI Event: Link Key Request (0x17) plen 6
     bdaddr 00:02:72:AE:58:73
< HCI Command: Link Key Request Reply (0x01|0x000b) plen 22
     bdaddr 00:02:72:AE:58:73 key 06FE3A58A78229B7CB048FB77298F05F
 > HCI Event: Command Complete (0x0e) plen 10
     Link Key Request Reply (0x01|0x000b) ncmd 1
     status 0x00 bdaddr 00:02:72:AE:58:73
 > HCI Event: Encrypt Change (0x08) plen 4
     status 0x00 handle 11 encrypt 0x01
 > ACL data: handle 11 flags 0x02 dlen 10
     L2CAP(s): Info req: type 2
< ACL data: handle 11 flags 0x00 dlen 16
 > ACL data: handle 11 flags 0x02 dlen 10
     L2CAP(s): Info req: type 3
< ACL data: handle 11 flags 0x00 dlen 20
 > HCI Event: Number of Completed Packets (0x13) plen 5
     handle 11 packets 2
 > ACL data: handle 11 flags 0x02 dlen 12
     L2CAP(s): Connect req: psm 3 scid 0x0040
< ACL data: handle 11 flags 0x00 dlen 16
< ACL data: handle 11 flags 0x00 dlen 10
 > HCI Event: Number of Completed Packets (0x13) plen 5
     handle 11 packets 2
 > ACL data: handle 11 flags 0x02 dlen 16
     L2CAP(s): Info rsp: type 2 result 0
       Extended feature mask 0x00b8
< ACL data: handle 11 flags 0x00 dlen 10
 > ACL data: handle 11 flags 0x02 dlen 20
     L2CAP(s): Info rsp: type 3 result 0
       Fixed channel list
< ACL data: handle 11 flags 0x00 dlen 16
< ACL data: handle 11 flags 0x00 dlen 27
 > ACL data: handle 11 flags 0x02 dlen 27
     L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 15
       MTU 1013 RFC 0x00 (Basic)
 > HCI Event: Number of Completed Packets (0x13) plen 5
     handle 11 packets 2
< ACL data: handle 11 flags 0x00 dlen 18
 > ACL data: handle 11 flags 0x02 dlen 18
     L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 4
       MTU 1013
 > HCI Event: Number of Completed Packets (0x13) plen 5
     handle 11 packets 2
 > ACL data: handle 11 flags 0x02 dlen 8
     L2CAP(d): cid 0x0040 len 4 [psm 0]
< ACL data: handle 11 flags 0x00 dlen 8
 > ACL data: handle 11 flags 0x02 dlen 18
     L2CAP(d): cid 0x0040 len 14 [psm 0]
< ACL data: handle 11 flags 0x00 dlen 18
 > HCI Event: Number of Completed Packets (0x13) plen 5
     handle 11 packets 2
 > ACL data: handle 11 flags 0x02 dlen 8
     L2CAP(d): cid 0x0040 len 4 [psm 0]
< ACL data: handle 11 flags 0x00 dlen 8
< ACL data: handle 11 flags 0x00 dlen 12
 > ACL data: handle 11 flags 0x02 dlen 12
     L2CAP(d): cid 0x0040 len 8 [psm 0]
 > HCI Event: Number of Completed Packets (0x13) plen 5
     handle 11 packets 2
< ACL data: handle 11 flags 0x00 dlen 12
 > ACL data: handle 11 flags 0x02 dlen 18
     L2CAP(d): cid 0x0040 len 14 [psm 0]
< ACL data: handle 11 flags 0x00 dlen 18
 > ACL data: handle 11 flags 0x02 dlen 12
     L2CAP(d): cid 0x0040 len 8 [psm 0]
< ACL data: handle 11 flags 0x00 dlen 9
 > ACL data: handle 11 flags 0x02 dlen 9
     L2CAP(d): cid 0x0040 len 5 [psm 0]
 > HCI Event: Number of Completed Packets (0x13) plen 5
     handle 11 packets 2
 > HCI Event: Number of Completed Packets (0x13) plen 5
     handle 11 packets 1
 > ACL data: handle 11 flags 0x02 dlen 8
     L2CAP(d): cid 0x0040 len 4 [psm 0]
< ACL data: handle 11 flags 0x00 dlen 8
 > ACL data: handle 11 flags 0x02 dlen 8
     L2CAP(d): cid 0x0040 len 4 [psm 0]
< ACL data: handle 11 flags 0x00 dlen 8
 > HCI Event: Number of Completed Packets (0x13) plen 5
     handle 11 packets 2
 > ACL data: handle 11 flags 0x02 dlen 12
     L2CAP(s): Disconn req: dcid 0x0040 scid 0x0040
< ACL data: handle 11 flags 0x00 dlen 12
 > HCI Event: Number of Completed Packets (0x13) plen 5
     handle 11 packets 1
 > HCI Event: Disconn Complete (0x05) plen 4
     status 0x00 handle 11 reason 0x13
     Reason: Remote User Terminated Connection
< HCI Command: Write Scan Enable (0x03|0x001a) plen 1
     enable 3
 > HCI Event: Command Complete (0x0e) plen 4
     Write Scan Enable (0x03|0x001a) ncmd 1
     status 0x00
 > HCI Event: Connect Request (0x04) plen 10
     bdaddr 00:02:72:AE:58:73 class 0x5a0100 type ACL
< HCI Command: Accept Connection Request (0x01|0x0009) plen 7
     bdaddr 00:02:72:AE:58:73 role 0x00
     Role: Master
 > HCI Event: Command Status (0x0f) plen 4
     Accept Connection Request (0x01|0x0009) status 0x00 ncmd 1
 > HCI Event: Role Change (0x12) plen 8
     status 0x00 bdaddr 00:02:72:AE:58:73 role 0x00
     Role: Master
 > HCI Event: Connect Complete (0x03) plen 11
     status 0x00 handle 12 bdaddr 00:02:72:AE:58:73 type ACL encrypt 0x00
< HCI Command: Read Remote Supported Features (0x01|0x001b) plen 2
     handle 12
 > HCI Event: Max Slots Change (0x1b) plen 3
     handle 12 slots 5
 > HCI Event: Command Status (0x0f) plen 4
     Read Remote Supported Features (0x01|0x001b) status 0x00 ncmd 1
 > HCI Event: Read Remote Supported Features (0x0b) plen 11
     status 0x00 handle 12
     Features: 0xff 0xff 0x8f 0xfe 0x9b 0xff 0x79 0x87
< HCI Command: Read Remote Extended Features (0x01|0x001c) plen 3
     handle 12 page 1
 > HCI Event: Command Status (0x0f) plen 4
     Read Remote Extended Features (0x01|0x001c) status 0x00 ncmd 1
 > HCI Event: Read Remote Extended Features (0x23) plen 13
     status 0x00 handle 12 page 1 max 1
     Features: 0x01 0x00 0x00 0x00 0x00 0x00 0x00 0x00
< HCI Command: Remote Name Request (0x01|0x0019) plen 10
     bdaddr 00:02:72:AE:58:73 mode 2 clkoffset 0x0000
 > HCI Event: Command Status (0x0f) plen 4
     Remote Name Request (0x01|0x0019) status 0x00 ncmd 1
 > HCI Event: Remote Name Req Complete (0x07) plen 255
     status 0x00 bdaddr 00:02:72:AE:58:73 name 'linux-3h3s-0'
 > HCI Event: Link Key Request (0x17) plen 6
     bdaddr 00:02:72:AE:58:73
< HCI Command: Link Key Request Reply (0x01|0x000b) plen 22
     bdaddr 00:02:72:AE:58:73 key 06FE3A58A78229B7CB048FB77298F05F
 > HCI Event: Command Complete (0x0e) plen 10
     Link Key Request Reply (0x01|0x000b) ncmd 1
     status 0x00 bdaddr 00:02:72:AE:58:73
 > HCI Event: Encrypt Change (0x08) plen 4
     status 0x00 handle 12 encrypt 0x01
 > ACL data: handle 12 flags 0x02 dlen 10
     L2CAP(s): Info req: type 2
< ACL data: handle 12 flags 0x00 dlen 16
 > ACL data: handle 12 flags 0x02 dlen 10
     L2CAP(s): Info req: type 3
< ACL data: handle 12 flags 0x00 dlen 20
 > HCI Event: Number of Completed Packets (0x13) plen 5
     handle 12 packets 2
 > ACL data: handle 12 flags 0x02 dlen 12
     L2CAP(s): Connect req: psm 15 scid 0x0040
< ACL data: handle 12 flags 0x00 dlen 16
< ACL data: handle 12 flags 0x00 dlen 10
 > HCI Event: Number of Completed Packets (0x13) plen 5
     handle 12 packets 2
 > ACL data: handle 12 flags 0x02 dlen 16
     L2CAP(s): Info rsp: type 2 result 0
       Extended feature mask 0x00b8
< ACL data: handle 12 flags 0x00 dlen 10
 > ACL data: handle 12 flags 0x02 dlen 20
     L2CAP(s): Info rsp: type 3 result 0
       Fixed channel list
< HCI Command: Authentication Requested (0x01|0x0011) plen 2
     handle 12
< ACL data: handle 12 flags 0x00 dlen 16
 > HCI Event: Command Status (0x0f) plen 4
     Authentication Requested (0x01|0x0011) status 0x00 ncmd 1
< ACL data: handle 12 flags 0x00 dlen 16
 > HCI Event: Link Key Request (0x17) plen 6
     bdaddr 00:02:72:AE:58:73
< HCI Command: Link Key Request Reply (0x01|0x000b) plen 22
     bdaddr 00:02:72:AE:58:73 key 06FE3A58A78229B7CB048FB77298F05F
 > HCI Event: Number of Completed Packets (0x13) plen 5
     handle 12 packets 2
 > HCI Event: Command Complete (0x0e) plen 10
     Link Key Request Reply (0x01|0x000b) ncmd 1
     status 0x00 bdaddr 00:02:72:AE:58:73
 > HCI Event: Auth Complete (0x06) plen 3
     status 0x00 handle 12
 > HCI Event: Encryption Key Refresh Complete (0x30) plen 3
     status 0x00 handle 12
 > HCI Event: Number of Completed Packets (0x13) plen 5
     handle 12 packets 1
 > HCI Event: Disconn Complete (0x05) plen 4
     status 0x00 handle 12 reason 0x13
     Reason: Remote User Terminated Connection



-----------------------------------------------------------------------------------------------------------------


hcidump at PC2:
# hcidump -i hci0
HCI sniffer - Bluetooth packet analyzer ver 2.0
device: hci0 snap_len: 1028 filter: 0xffffffffffffffff
< HCI Command: Create Connection (0x01|0x0005) plen 13
     bdaddr 00:02:72:24:02:04 ptype 0xcc18 rswitch 0x01 clkoffset 0x0000
     Packet type: DM1 DM3 DM5 DH1 DH3 DH5
 > HCI Event: Command Status (0x0f) plen 4
     Create Connection (0x01|0x0005) status 0x00 ncmd 1
 > HCI Event: Role Change (0x12) plen 8
     status 0x00 bdaddr 00:02:72:24:02:04 role 0x01
     Role: Slave
 > HCI Event: Connect Complete (0x03) plen 11
     status 0x00 handle 12 bdaddr 00:02:72:24:02:04 type ACL encrypt 0x00
< HCI Command: Read Remote Supported Features (0x01|0x001b) plen 2
     handle 12
 > HCI Event: Max Slots Change (0x1b) plen 3
     handle 12 slots 5
 > HCI Event: Command Status (0x0f) plen 4
     Read Remote Supported Features (0x01|0x001b) status 0x00 ncmd 1
 > HCI Event: Read Remote Supported Features (0x0b) plen 11
     status 0x00 handle 12
     Features: 0xff 0xff 0x8f 0xfe 0x9b 0xff 0x79 0x87
< HCI Command: Read Remote Extended Features (0x01|0x001c) plen 3
     handle 12 page 1
 > HCI Event: Command Status (0x0f) plen 4
     Read Remote Extended Features (0x01|0x001c) status 0x00 ncmd 1
 > HCI Event: Read Remote Extended Features (0x23) plen 13
     status 0x00 handle 12 page 1 max 1
     Features: 0x01 0x00 0x00 0x00 0x00 0x00 0x00 0x00
< HCI Command: Remote Name Request (0x01|0x0019) plen 10
     bdaddr 00:02:72:24:02:04 mode 2 clkoffset 0x0000
 > HCI Event: Command Status (0x0f) plen 4
     Remote Name Request (0x01|0x0019) status 0x00 ncmd 1
 > HCI Event: Remote Name Req Complete (0x07) plen 255
     status 0x00 bdaddr 00:02:72:24:02:04 name 'linux-a633-0'
< HCI Command: Authentication Requested (0x01|0x0011) plen 2
     handle 12
 > HCI Event: Command Status (0x0f) plen 4
     Authentication Requested (0x01|0x0011) status 0x00 ncmd 1
 > HCI Event: Link Key Request (0x17) plen 6
     bdaddr 00:02:72:24:02:04
< HCI Command: Link Key Request Reply (0x01|0x000b) plen 22
     bdaddr 00:02:72:24:02:04 key 06FE3A58A78229B7CB048FB77298F05F
 > HCI Event: Command Complete (0x0e) plen 10
     Link Key Request Reply (0x01|0x000b) ncmd 1
     status 0x00 bdaddr 00:02:72:24:02:04
 > HCI Event: Auth Complete (0x06) plen 3
     status 0x00 handle 12
< HCI Command: Set Connection Encryption (0x01|0x0013) plen 3
     handle 12 encrypt 0x01
 > HCI Event: Command Status (0x0f) plen 4
     Set Connection Encryption (0x01|0x0013) status 0x00 ncmd 1
 > HCI Event: Encrypt Change (0x08) plen 4
     status 0x00 handle 12 encrypt 0x01
< ACL data: handle 12 flags 0x00 dlen 10
 > ACL data: handle 12 flags 0x02 dlen 16
     L2CAP(s): Info rsp: type 2 result 0
       Extended feature mask 0x00b8
< ACL data: handle 12 flags 0x00 dlen 10
 > HCI Event: Number of Completed Packets (0x13) plen 5
     handle 12 packets 2
 > ACL data: handle 12 flags 0x02 dlen 20
     L2CAP(s): Info rsp: type 3 result 0
       Fixed channel list
< ACL data: handle 12 flags 0x00 dlen 12
 > ACL data: handle 12 flags 0x02 dlen 16
     L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0040 result 1 status 0
       Connection pending - No futher information available
 > ACL data: handle 12 flags 0x02 dlen 10
     L2CAP(s): Info req: type 2
< ACL data: handle 12 flags 0x00 dlen 16
 > HCI Event: Number of Completed Packets (0x13) plen 5
     handle 12 packets 2
 > ACL data: handle 12 flags 0x02 dlen 10
     L2CAP(s): Info req: type 3
< ACL data: handle 12 flags 0x00 dlen 20
 > ACL data: handle 12 flags 0x02 dlen 16
     L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0040 result 1 status 1
       Connection pending - Authentication pending
 > ACL data: handle 12 flags 0x02 dlen 16
     L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0040 result 3 status 0
       Connection refused - security block
 > HCI Event: Encryption Key Refresh Complete (0x30) plen 3
     status 0x00 handle 12
 > HCI Event: Number of Completed Packets (0x13) plen 5
     handle 12 packets 1
< HCI Command: Disconnect (0x01|0x0006) plen 3
     handle 12 reason 0x13
     Reason: Remote User Terminated Connection
 > HCI Event: Command Status (0x0f) plen 4
     Disconnect (0x01|0x0006) status 0x00 ncmd 1
 > HCI Event: Disconn Complete (0x05) plen 4
     status 0x00 handle 12 reason 0x16
     Reason: Connection Terminated by Local Host


