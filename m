Return-Path: <cyrus@holtmann.org>
Message-ID: <4E00C755.1070501@orange-ftgroup.com>
Date: Tue, 21 Jun 2011 18:31:17 +0200
From: beyler olivier <olivier.beyler@orange-ftgroup.com>
MIME-Version: 1.0
To: linux-bluetooth@vger.kernel.org
Subject: PIN code pb
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,
I've try to connect to the Serial Port Device

hcitool scan
Scanning ...
     00:03:C9:74:AA:90    n/a
     00:0F:B3:91:1C:70    G-NC6000-95
     00:15:0E:E2:3E:21    n/a
     00:18:B2:00:0B:83    Serial Port Device


./simple-agent hci0 00:18:B2:00:0B:83
Creating device failed: org.bluez.Error.AuthenticationRejected: 
Authentication Rejected

The pin code is normaly "0000" but I don't know where to put it.

I try many answers without succed when I use minicom
minicom: cannot open /dev/rfcomm0 : the Connection refused

and on the hcidump I see this log :

< HCI Command: Create Connection (0x01|0x0005) plen 13
 > HCI Event: Command Status (0x0f) plen 4
 > HCI Event: Connect Complete (0x03) plen 11
< HCI Command: Read Remote Supported Features (0x01|0x001b) plen 2
 > HCI Event: Command Status (0x0f) plen 4
< HCI Command: Remote Name Request (0x01|0x0019) plen 10
 > HCI Event: Command Status (0x0f) plen 4
 > HCI Event: Max Slots Change (0x1b) plen 3
 > HCI Event: Read Remote Supported Features (0x0b) plen 11
< HCI Command: Remote Name Request (0x01|0x0019) plen 10
< ACL data: handle 1 flags 0x02 dlen 10
     L2CAP(s): Info req: type 2
 > HCI Event: Command Status (0x0f) plen 4
 > HCI Event: Remote Name Req Complete (0x07) plen 255
 > HCI Event: Number of Completed Packets (0x13) plen 5
 > ACL data: handle 1 flags 0x02 dlen 12
     L2CAP(s): Info rsp: type 2 result 1
       Not supported
< ACL data: handle 1 flags 0x02 dlen 12
     L2CAP(s): Connect req: psm 3 scid 0x0040
 > HCI Event: Number of Completed Packets (0x13) plen 5
 > HCI Event: Remote Name Req Complete (0x07) plen 255
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
 > HCI Event: Number of Completed Packets (0x13) plen 5
 > HCI Event: Number of Completed Packets (0x13) plen 5
 > ACL data: handle 1 flags 0x02 dlen 14
     L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 0
       Success
< ACL data: handle 1 flags 0x02 dlen 8
     L2CAP(d): cid 0x0040 len 4 [psm 3]
       RFCOMM(s): SABM: cr 1 dlci 0 pf 1 ilen 0 fcs 0x1c
 > HCI Event: Number of Completed Packets (0x13) plen 5
 > HCI Event: QoS Setup Complete (0x0d) plen 21
 > ACL data: handle 1 flags 0x02 dlen 8
     L2CAP(d): cid 0x0040 len 4 [psm 3]
       RFCOMM(s): UA: cr 1 dlci 0 pf 1 ilen 0 fcs 0xd7
< ACL data: handle 1 flags 0x02 dlen 18
     L2CAP(d): cid 0x0040 len 14 [psm 3]
       RFCOMM(s): PN CMD: cr 1 dlci 0 pf 0 ilen 10 fcs 0x70 mcc_len 8
       dlci 2 frame_type 0 credit_flow 15 pri 7 ack_timer 0
       frame_size 1008 max_retrans 0 credits 7
 > HCI Event: Number of Completed Packets (0x13) plen 5
 > ACL data: handle 1 flags 0x02 dlen 18
     L2CAP(d): cid 0x0040 len 14 [psm 3]
       RFCOMM(s): PN RSP: cr 0 dlci 0 pf 0 ilen 10 fcs 0xaa mcc_len 8
       dlci 2 frame_type 0 credit_flow 14 pri 7 ack_timer 0
       frame_size 1008 max_retrans 0 credits 1
< ACL data: handle 1 flags 0x02 dlen 8
     L2CAP(d): cid 0x0040 len 4 [psm 3]
       RFCOMM(s): SABM: cr 1 dlci 2 pf 1 ilen 0 fcs 0x59
 > HCI Event: Number of Completed Packets (0x13) plen 5
 > HCI Event: PIN Code Request (0x16) plen 6
< HCI Command: PIN Code Request Negative Reply (0x01|0x000e) plen 6
 > HCI Event: Command Complete (0x0e) plen 10
< HCI Command: PIN Code Request Negative Reply (0x01|0x000e) plen 6
 > HCI Event: Command Complete (0x0e) plen 10
 > ACL data: handle 1 flags 0x02 dlen 8
     L2CAP(d): cid 0x0040 len 4 [psm 3]
       RFCOMM(s): DM: cr 1 dlci 2 pf 1 ilen 0 fcs 0x73
< ACL data: handle 1 flags 0x02 dlen 8
     L2CAP(d): cid 0x0040 len 4 [psm 3]
       RFCOMM(s): DISC: cr 1 dlci 0 pf 1 ilen 0 fcs 0xfd
< ACL data: handle 1 flags 0x02 dlen 12
     L2CAP(s): Disconn req: dcid 0x0040 scid 0x0040
 > HCI Event: Number of Completed Packets (0x13) plen 5
 > HCI Event: Number of Completed Packets (0x13) plen 5
 > ACL data: handle 1 flags 0x02 dlen 8
     L2CAP(d): cid 0x0040 len 4 [psm 3]
       RFCOMM(s): UA: cr 1 dlci 0 pf 1 ilen 0 fcs 0xd7
 > ACL data: handle 1 flags 0x02 dlen 12
     L2CAP(s): Disconn rsp: dcid 0x0040 scid 0x0040

Best regards

