Return-Path: <cyrus@holtmann.org>
Message-ID: <4FC35278.40903@tu-ilmenau.de>
Date: Mon, 28 May 2012 12:24:56 +0200
From: Steffen Becker <steffen.becker@tu-ilmenau.de>
MIME-Version: 1.0
To: linux-bluetooth@vger.kernel.org
Subject: no security block - but connection still gets refused
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello Everyone,

I searched for an answer the whole last time, but I didn't gained any 
new information - so I hope you can help me to solve my problem.
I have two gentoo-PCs with a Bluetooth3.0-Dongle at each PC.
I have installed net-wireless/bluez with "test-programs" USE-Flag.
I tried to connect them via
# bluez-test-serial <remote address>
and
# bluez-test-network <remote address>

First important question:
How do I have to use this commands? Are these "standalone" commands or 
do I have to use some "additional" command, e.g. some kind of 
"listen"-command at the remote device?

Next big thing:
I always got a "security block"-issue while tried to connect. I searched 
your mail-archive & you told me, this problem is solved in kernel 3.3 
and later.
I installed kernel 3.4 and - hooray - no "security block" anymore!
*But* the connection still doesn't work. I connect them - they are 
connected for about 2 seconds - then connection is refused.
So I really hope you can have a look at the following lines and tell me 
how to solve this problem.

PS:
I'm sorry for wasting your time, but this case isn't "just for fun for 
me"; it's important that it works. So I even would donate/pay something 
if you can help me solve this problem.

Here is what I get when I use test-network:

# bluez-test-network 00:02:72:AE:58:73 NAP

Traceback (most recent call last):
   File "/usr/bin/bluez-test-network", line 40, in <module>
     device = adapter.FindDevice(address)
   File "/usr/lib64/python2.7/site-packages/dbus/proxies.py", line 70, 
in __call__
     return self._proxy_method(*args, **keywords)
   File "/usr/lib64/python2.7/site-packages/dbus/proxies.py", line 145, 
in __call__
     **keywords)
   File "/usr/lib64/python2.7/site-packages/dbus/connection.py", line 
651, in
call_blocking
     message, timeout)
dbus.exceptions.DBusException: org.bluez.Error.DoesNotExist: Does Not Exist

----------------------------------------------------------------------------

/var/log/messages

May 24 18:11:21 bluetooth2 bluetoothd[3015]: Bluetooth daemon 4.99
May 24 18:11:21 bluetooth2 bluetoothd[3022]: Starting SDP server
May 24 18:11:21 bluetooth2 bluetoothd[3022]: Listening for HCI events on 
hci0
May 24 18:11:21 bluetooth2 bluetoothd[3022]: HCI dev 0 up
May 24 18:11:22 bluetooth2 bluetoothd[3022]: Unable to load keys to 
adapter_ops: Function not implemented (38)
May 24 18:11:22 bluetooth2 bluetoothd[3022]: Adapter 
/org/bluez/3015/hci0 has been enabled
May 24 18:11:22 bluetooth2 bluetoothd[3022]: mce replied with an error: 
org.freedesktop.DBus.Error.ServiceUnknown, The name com.nokia.mce was 
not provided by any .service files
May 24 18:11:22 bluetooth2 bluetoothd[3022]: Inquiry Cancel Failed with 
status 0x12
May 24 18:11:54 bluetooth2 bluetoothd[3022]: Discovery session 
0x7f113de51070 with :1.10 activated
May 24 18:15:43 bluetooth2 bluetoothd[3022]: Requesting DUN 
authorization failed
May 24 18:15:45 bluetooth2 bluetoothd[3022]: input-headset driver probe 
failed for device 00:02:72:AE:58:73


-----------------------------------------------------------------------------

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
     bdaddr 00:02:72:AE:58:73 passkey 118961
< HCI Command: User Confirmation Request Reply (0x01|0x002c) plen 6
     bdaddr 00:02:72:AE:58:73
 > HCI Event: Command Complete (0x0e) plen 10
     User Confirmation Request Reply (0x01|0x002c) ncmd 1
     status 0x00 bdaddr 00:02:72:AE:58:73
 > HCI Event: Simple Pairing Complete (0x36) plen 7
     status 0x00 bdaddr 00:02:72:AE:58:73
< HCI Command: Read Remote Version Information (0x01|0x001d) plen 2
     handle 11
 > HCI Event: Command Status (0x0f) plen 4
     Read Remote Version Information (0x01|0x001d) status 0x00 ncmd 1
 > HCI Event: Read Remote Ver Info Complete (0x0c) plen 8
     status 0x00 handle 11
     LMP Version: 3.0 (0x5) LMP Subversion: 0x4203
     Manufacturer: Broadcom Corporation (15)
 > HCI Event: Link Key Notification (0x18) plen 23
     bdaddr 00:02:72:AE:58:73 key 9AE2016EF5F668A76C16D37E5103F7A2 type 4
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
     L2CAP(s): Connect req: psm 3 scid 0x0040
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
< ACL data: handle 11 flags 0x00 dlen 27
     L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 15
       MTU 1013
       RFC 0x00 (Basic)
 > HCI Event: Number of Completed Packets (0x13) plen 5
     handle 11 packets 2
 > ACL data: handle 11 flags 0x02 dlen 27
     L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 15
       MTU 1013
       RFC 0x00 (Basic)
< ACL data: handle 11 flags 0x00 dlen 18
     L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 4
       MTU 1013
 > ACL data: handle 11 flags 0x02 dlen 18
     L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 4
       MTU 1013
 > HCI Event: Number of Completed Packets (0x13) plen 5
     handle 11 packets 2
 > ACL data: handle 11 flags 0x02 dlen 8
     L2CAP(d): cid 0x0040 len 4 [psm 3]
       RFCOMM(s): SABM: cr 1 dlci 0 pf 1 ilen 0 fcs 0x1c
< ACL data: handle 11 flags 0x00 dlen 8
     L2CAP(d): cid 0x0040 len 4 [psm 3]
       RFCOMM(s): UA: cr 1 dlci 0 pf 1 ilen 0 fcs 0xd7
 > ACL data: handle 11 flags 0x02 dlen 18
     L2CAP(d): cid 0x0040 len 14 [psm 3]
       RFCOMM(s): PN CMD: cr 1 dlci 0 pf 0 ilen 10 fcs 0x70 mcc_len 8
       dlci 2 frame_type 0 credit_flow 15 pri 7 ack_timer 0
       frame_size 1008 max_retrans 0 credits 7
< ACL data: handle 11 flags 0x00 dlen 18
     L2CAP(d): cid 0x0040 len 14 [psm 3]
       RFCOMM(s): PN RSP: cr 0 dlci 0 pf 0 ilen 10 fcs 0xaa mcc_len 8
       dlci 2 frame_type 0 credit_flow 14 pri 7 ack_timer 0
       frame_size 1008 max_retrans 0 credits 7
 > HCI Event: Number of Completed Packets (0x13) plen 5
     handle 11 packets 2
 > ACL data: handle 11 flags 0x02 dlen 8
     L2CAP(d): cid 0x0040 len 4 [psm 3]
       RFCOMM(s): SABM: cr 1 dlci 2 pf 1 ilen 0 fcs 0x59
< ACL data: handle 11 flags 0x00 dlen 8
     L2CAP(d): cid 0x0040 len 4 [psm 3]
       RFCOMM(s): DM: cr 1 dlci 2 pf 1 ilen 0 fcs 0x73
 > HCI Event: Number of Completed Packets (0x13) plen 5
     handle 11 packets 1
< ACL data: handle 11 flags 0x00 dlen 12
     L2CAP(s): Connect req: psm 1 scid 0x0041
 > ACL data: handle 11 flags 0x02 dlen 16
     L2CAP(s): Connect rsp: dcid 0x0041 scid 0x0041 result 0 status 0
       Connection successful
< ACL data: handle 11 flags 0x00 dlen 23
     L2CAP(s): Config req: dcid 0x0041 flags 0x00 clen 11
       RFC 0x00 (Basic)
 > ACL data: handle 11 flags 0x02 dlen 23
     L2CAP(s): Config req: dcid 0x0041 flags 0x00 clen 11
       RFC 0x00 (Basic)
< ACL data: handle 11 flags 0x00 dlen 18
     L2CAP(s): Config rsp: scid 0x0041 flags 0x00 result 0 clen 4
       MTU 672
 > HCI Event: Number of Completed Packets (0x13) plen 5
     handle 11 packets 2
 > ACL data: handle 11 flags 0x02 dlen 18
     L2CAP(s): Config rsp: scid 0x0041 flags 0x00 result 0 clen 4
       MTU 672
< ACL data: handle 11 flags 0x00 dlen 24
     L2CAP(d): cid 0x0041 len 20 [psm 1]
         SDP SSA Req: tid 0x0 len 0xf
           pat uuid-16 0x0100 (L2CAP)
           max 65535
           aid(s) 0x0000 - 0xffff
           cont 00
 > HCI Event: Number of Completed Packets (0x13) plen 5
     handle 11 packets 2
 > ACL data: handle 11 flags 0x02 dlen 547
     L2CAP(d): cid 0x0041 len 543 [psm 1]
         SDP SSA Rsp: tid 0x0 len 0x21a
           count 535
           record #0
               aid 0x0000 (SrvRecHndl)
                  uint 0x10000
               aid 0x0001 (SrvClassIDList)
< uuid-16 0x1112 (Headset AG) uuid-16 0x1203 (Audio) >
               aid 0x0004 (ProtocolDescList)
< < uuid-16 0x0100 (L2CAP) > <
                  uuid-16 0x0003 (RFCOMM) uint 0xc > >
               aid 0x0005 (BrwGrpList)
< uuid-16 0x1002 (PubBrwsGrp) >
               aid 0x0009 (BTProfileDescList)
< < uuid-16 0x1108 (Headset) uint 0x102 > >
               aid 0x0100 (SrvName)
                  str "Headset Audio Gateway"
           record #1
               aid 0x0000 (SrvRecHndl)
                  uint 0x10001
               aid 0x0001 (SrvClassIDList)
< uuid-16 0x111f (Handsfree AG) uuid-16 0x1203 (Audio) >
               aid 0x0004 (ProtocolDescList)
< < uuid-16 0x0100 (L2CAP) > <
                  uuid-16 0x0003 (RFCOMM) uint 0xd > >
               aid 0x0005 (BrwGrpList)
< uuid-16 0x1002 (PubBrwsGrp) >
               aid 0x0009 (BTProfileDescList)
< < uuid-16 0x111e (Handsfree) uint 0x105 > >
               aid 0x0100 (SrvName)
                  str "Hands-Free Audio Gateway"
               aid 0x0301 (SuppDataStoresList)
                  uint 0x1
               aid 0x0311 (SuppFeatures)
                  uint 0x0
           record #2
               aid 0x0000 (SrvRecHndl)
                  uint 0x10002
               aid 0x0001 (SrvClassIDList)
< uuid-16 0x110c (AVRemTarget) >
               aid 0x0004 (ProtocolDescList)
< < uuid-16 0x0100 (L2CAP) uint 0x17 > <
                  uuid-16 0x0017 (AVCTP) uint 0x103 > >
               aid 0x0005 (BrwGrpList)
< uuid-16 0x1002 (PubBrwsGrp) >
               aid 0x0009 (BTProfileDescList)
< < uuid-16 0x110e (AVRemote) uint 0x103 > >
               aid 0x0100 (SrvName)
                  str "AVRCP TG"
               aid 0x0311 (SuppFeatures)
                  uint 0xf
           record #3
               aid 0x0000 (SrvRecHndl)
                  uint 0x10003
               aid 0x0001 (SrvClassIDList)
< uuid-16 0x110e (AVRemote) >
               aid 0x0004 (ProtocolDescList)
< < uuid-16 0x0100 (L2CAP) uint 0x17 > <
                  uuid-16 0x0017 (AVCTP) uint 0x103 > >
               aid 0x0005 (BrwGrpList)
< uuid-16 0x1002 (PubBrwsGrp) >
               aid 0x0009 (BTProfileDescList)
< < uuid-16 0x110e (AVRemote) uint 0x100 > >
               aid 0x0100 (SrvName)
                  str "AVRCP CT"
               aid 0x0311 (SuppFeatures)
                  uint 0xf
           record #4
               aid 0x0000 (SrvRecHndl)
                  uint 0x10004
               aid 0x0001 (SrvClassIDList)
< uuid-16 0x1103 (DUN) uuid-16 0x1201 (Networking) >
               aid 0x0004 (ProtocolDescList)
< < uuid-16 0x0100 (L2CAP) > <
                  uuid-16 0x0003 (RFCOMM) uint 0x1 > >
               aid 0x0005 (BrwGrpList)
< uuid-16 0x1002 (PubBrwsGrp) >
               aid 0x0009 (BTProfileDescList)
< < uuid-16 0x1103 (DUN) uint 0x100 > >
               aid 0x0100 (SrvName)
                  str "Dial-Up Networking"
           record #5
               aid 0x0000 (SrvRecHndl)
                  uint 0x10005
               aid 0x0001 (SrvClassIDList)
< uuid-16 0x1116 (NAP) >
               aid 0x0004 (ProtocolDescList)
< < uuid-16 0x0100 (L2CAP) uint 0xf > <
                  uuid-16 0x000f (BNEP) uint 0x100 < uint 0x10 uint 0x20 
uint 0x30

uint 0x40 > > >
               aid 0x0005 (BrwGrpList)
< uuid-16 0x1002 (PubBrwsGrp) >
               aid 0x0009 (BTProfileDescList)
< < uuid-16 0x1116 (NAP) uint 0x100 > >
               aid 0x0100 (SrvName)
                  str "Network Access Point Service"
           cont 00
< ACL data: handle 11 flags 0x00 dlen 24
     L2CAP(d): cid 0x0041 len 20 [psm 1]
         SDP SSA Req: tid 0x1 len 0xf
           pat uuid-16 0x1200 (PNPInfo)
           max 65535
           aid(s) 0x0000 - 0xffff
           cont 00
< ACL data: handle 11 flags 0x00 dlen 8
     L2CAP(d): cid 0x0040 len 4 [psm 3]
       RFCOMM(s): DISC: cr 0 dlci 0 pf 1 ilen 0 fcs 0x9c
 > ACL data: handle 11 flags 0x02 dlen 8
     L2CAP(d): cid 0x0040 len 4 [psm 3]
       RFCOMM(s): DISC: cr 1 dlci 0 pf 1 ilen 0 fcs 0xfd
< ACL data: handle 11 flags 0x00 dlen 8
     L2CAP(d): cid 0x0040 len 4 [psm 3]
       RFCOMM(s): UA: cr 1 dlci 0 pf 1 ilen 0 fcs 0xd7
 > ACL data: handle 11 flags 0x02 dlen 12
     L2CAP(s): Disconn req: dcid 0x0040 scid 0x0040
< ACL data: handle 11 flags 0x00 dlen 12
     L2CAP(s): Disconn rsp: dcid 0x0040 scid 0x0040
 > ACL data: handle 11 flags 0x02 dlen 14
     L2CAP(d): cid 0x0041 len 10 [psm 1]
         SDP SSA Rsp: tid 0x1 len 0x5
           count 2
           cont 00
 > HCI Event: Number of Completed Packets (0x13) plen 5
     handle 11 packets 3
 > HCI Event: Number of Completed Packets (0x13) plen 5
     handle 11 packets 1
 > ACL data: handle 11 flags 0x02 dlen 12
     L2CAP(s): Connect req: psm 1 scid 0x0040
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
 > ACL data: handle 11 flags 0x02 dlen 18
     L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 4
       MTU 672
 > ACL data: handle 11 flags 0x02 dlen 24
     L2CAP(d): cid 0x0040 len 20 [psm 1]
         SDP SSA Req: tid 0x0 len 0xf
           pat uuid-16 0x0100 (L2CAP)
           max 65535
           aid(s) 0x0000 - 0xffff
           cont 00
< ACL data: handle 11 flags 0x00 dlen 547
     L2CAP(d): cid 0x0040 len 543 [psm 1]
         SDP SSA Rsp: tid 0x0 len 0x21a
           count 535
           record #0
               aid 0x0000 (SrvRecHndl)
                  uint 0x10000
               aid 0x0001 (SrvClassIDList)
< uuid-16 0x1112 (Headset AG) uuid-16 0x1203 (Audio) >
               aid 0x0004 (ProtocolDescList)
< < uuid-16 0x0100 (L2CAP) > <
                  uuid-16 0x0003 (RFCOMM) uint 0xc > >
               aid 0x0005 (BrwGrpList)
< uuid-16 0x1002 (PubBrwsGrp) >
               aid 0x0009 (BTProfileDescList)
< < uuid-16 0x1108 (Headset) uint 0x102 > >
               aid 0x0100 (SrvName)
                  str "Headset Audio Gateway"
           record #1
               aid 0x0000 (SrvRecHndl)
                  uint 0x10001
               aid 0x0001 (SrvClassIDList)
< uuid-16 0x111f (Handsfree AG) uuid-16 0x1203 (Audio) >
               aid 0x0004 (ProtocolDescList)
< < uuid-16 0x0100 (L2CAP) > <
                  uuid-16 0x0003 (RFCOMM) uint 0xd > >
               aid 0x0005 (BrwGrpList)
< uuid-16 0x1002 (PubBrwsGrp) >
               aid 0x0009 (BTProfileDescList)
< < uuid-16 0x111e (Handsfree) uint 0x105 > >
               aid 0x0100 (SrvName)
                  str "Hands-Free Audio Gateway"
               aid 0x0301 (SuppDataStoresList)
                  uint 0x1
               aid 0x0311 (SuppFeatures)
                  uint 0x0
           record #2
               aid 0x0000 (SrvRecHndl)
                  uint 0x10002
               aid 0x0001 (SrvClassIDList)
< uuid-16 0x110c (AVRemTarget) >
               aid 0x0004 (ProtocolDescList)
< < uuid-16 0x0100 (L2CAP) uint 0x17 > <
                  uuid-16 0x0017 (AVCTP) uint 0x103 > >
               aid 0x0005 (BrwGrpList)
< uuid-16 0x1002 (PubBrwsGrp) >
               aid 0x0009 (BTProfileDescList)
< < uuid-16 0x110e (AVRemote) uint 0x103 > >
               aid 0x0100 (SrvName)
                  str "AVRCP TG"
               aid 0x0311 (SuppFeatures)
                  uint 0xf
           record #3
               aid 0x0000 (SrvRecHndl)
                  uint 0x10003
               aid 0x0001 (SrvClassIDList)
< uuid-16 0x110e (AVRemote) >
               aid 0x0004 (ProtocolDescList)
< < uuid-16 0x0100 (L2CAP) uint 0x17 > <
                  uuid-16 0x0017 (AVCTP) uint 0x103 > >
               aid 0x0005 (BrwGrpList)
< uuid-16 0x1002 (PubBrwsGrp) >
               aid 0x0009 (BTProfileDescList)
< < uuid-16 0x110e (AVRemote) uint 0x100 > >
               aid 0x0100 (SrvName)
                  str "AVRCP CT"
               aid 0x0311 (SuppFeatures)
                  uint 0xf
           record #4
               aid 0x0000 (SrvRecHndl)
                  uint 0x10004
               aid 0x0001 (SrvClassIDList)
< uuid-16 0x1103 (DUN) uuid-16 0x1201 (Networking) >
               aid 0x0004 (ProtocolDescList)
< < uuid-16 0x0100 (L2CAP) > <
                  uuid-16 0x0003 (RFCOMM) uint 0x1 > >
               aid 0x0005 (BrwGrpList)
< uuid-16 0x1002 (PubBrwsGrp) >
               aid 0x0009 (BTProfileDescList)
< < uuid-16 0x1103 (DUN) uint 0x100 > >
               aid 0x0100 (SrvName)
                  str "Dial-Up Networking"
           record #5
               aid 0x0000 (SrvRecHndl)
                  uint 0x10005
               aid 0x0001 (SrvClassIDList)
< uuid-16 0x1116 (NAP) >
               aid 0x0004 (ProtocolDescList)
< < uuid-16 0x0100 (L2CAP) uint 0xf > <
                  uuid-16 0x000f (BNEP) uint 0x100 < uint 0x10 uint 0x20 
uint 0x30

uint 0x40 > > >
               aid 0x0005 (BrwGrpList)
< uuid-16 0x1002 (PubBrwsGrp) >
               aid 0x0009 (BTProfileDescList)
< < uuid-16 0x1116 (NAP) uint 0x100 > >
               aid 0x0100 (SrvName)
                  str "Network Access Point Service"
           cont 00
 > HCI Event: Number of Completed Packets (0x13) plen 5
     handle 11 packets 2
 > ACL data: handle 11 flags 0x02 dlen 24
     L2CAP(d): cid 0x0040 len 20 [psm 1]
         SDP SSA Req: tid 0x1 len 0xf
           pat uuid-16 0x1200 (PNPInfo)
           max 65535
           aid(s) 0x0000 - 0xffff
           cont 00
< ACL data: handle 11 flags 0x00 dlen 14
     L2CAP(d): cid 0x0040 len 10 [psm 1]
         SDP SSA Rsp: tid 0x1 len 0x5
           count 2
           cont 00
 > HCI Event: Number of Completed Packets (0x13) plen 5
     handle 11 packets 1
< ACL data: handle 11 flags 0x00 dlen 12
     L2CAP(s): Disconn req: dcid 0x0041 scid 0x0041
 > ACL data: handle 11 flags 0x02 dlen 12
     L2CAP(s): Disconn rsp: dcid 0x0041 scid 0x0041
 > HCI Event: Number of Completed Packets (0x13) plen 5
     handle 11 packets 1
 > ACL data: handle 11 flags 0x02 dlen 12
     L2CAP(s): Disconn req: dcid 0x0040 scid 0x0040
< ACL data: handle 11 flags 0x00 dlen 12
     L2CAP(s): Disconn rsp: dcid 0x0040 scid 0x0040
 > HCI Event: Number of Completed Packets (0x13) plen 5
     handle 11 packets 1
 > HCI Event: Disconn Complete (0x05) plen 4
     status 0x00 handle 11 reason 0x13
     Reason: Remote User Terminated Connection
< HCI Command: Delete Stored Link Key (0x03|0x0012) plen 7
     bdaddr 00:02:72:AE:58:73 all 0
 > HCI Event: Command Complete (0x0e) plen 6
     Delete Stored Link Key (0x03|0x0012) ncmd 1
     status 0x00 deleted 0


