Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <415C6D46.1020309@Dartmouth.edu>
From: Edward Wei <Edward.Wei@Dartmouth.EDU>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Subject: [Bluez-users] Infineon ROK104001 Bluetooth Problem
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Thu, 30 Sep 2004 16:32:06 -0400

Hi,

I'm using the Infineon ROK104001 module connected to an Intel PXA255 
serial BTUART.  I tried running rctest and l2test from the bluez-libs 
sources and I seem to have problems sending with this setup and no 
problems receiving.

Infineon ROK + PXA (sender)
linux 2.6.9-rc1
bluez-libs-2.10

Laptop with Kensington USB Dongle (receiver)
linux 2.6.9-rc2-bk7
bluez-libs-2.10

I have enclosed hciconfig and hcidump information below.

Thank you.


Ed



Here is the output from hciconfig:

Infineon ROK + PXA255 BTUART:
hci0:   Type: UART
        BD Address: 00:80:37:1C:3B:87 ACL MTU: 672:8  SCO MTU: 64:0
        UP RUNNING PSCAN ISCAN
        RX bytes:1562477 acl:2746 sco:0 events:1415 errors:3665
        TX bytes:11943 acl:425 sco:0 commands:348 errors:0
        Features: 0xff 0xfb 0x01 0x00 0x00 0x00 0x00 0x00
        Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
        Link policy: RSWITCH HOLD SNIFF PARK
        Link mode: SLAVE ACCEPT
        Name: 'Gumstix (0)'
        Class: 0x820116
        Service Classes: Networking, Information
        Device Class: Computer, Palm
        HCI Ver: 1.1 (0x1) HCI Rev: 0x8105 LMP Ver: 1.1 (0x1) LMP 
Subver: 0x8d40
        Manufacturer: Ericsson Technology Licensing (0)

Laptop with Kensington Bluetooth USB dongle:

hci0:   Type: USB
        BD Address: 00:0C:76:46:D6:93 ACL MTU: 192:8  SCO MTU: 64:8
        UP RUNNING PSCAN ISCAN
        RX bytes:122105 acl:434 sco:0 events:14625 errors:0
        TX bytes:4733246 acl:27673 sco:0 commands:215 errors:0
        Features: 0xff 0xff 0x0f 0x00 0x00 0x00 0x00 0x00
        Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
        Link policy: RSWITCH HOLD SNIFF PARK
        Link mode: SLAVE ACCEPT
        Name: 'reshiftedity (0)'
        Class: 0x120114
        Service Classes: Networking, Object Transfer
        Device Class: Computer, Palm
        HCI Ver: 1.1 (0x1) HCI Rev: 0x20d LMP Ver: 1.1 (0x1) LMP Subver: 0x20d
        Manufacturer: Cambridge Silicon Radio (10)


Output from hcidump -x:

# ./rctest.exec -s -P 10 00:0c:76:46:D6:93
< HCI Command: Create Connection (0x01|0x0005) plen 13
  93 D6 46 76 0C 00 18 CC 01 00 B7 ED 01 
> HCI Event: Command Status (0x0f) plen 4
  00 07 05 04 
> HCI Event: Connect Complete (0x03) plen 11
  00 02 00 93 D6 46 76 0C 00 01 00 
< ACL data: handle 0x0002 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 3 scid 0x0040
< HCI Command: Write Link Policy Settings (0x02|0x000d) plen 4
  02 00 0F 00 
> HCI Event: Command Status (0x0f) plen 4
  00 08 00 00 
> HCI Event: Command Complete (0x0e) plen 6
  08 0D 08 00 02 00 
> HCI Event: Number of Completed Packets (0x13) plen 5
  01 02 00 01 00 
> HCI Event: Max Slots Change (0x1b) plen 3
  02 00 05 
> ACL data: handle 0x0002 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0040 result 0 status 0
< ACL data: handle 0x0002 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0040 flags 0x0000 clen 4
    MTU 1024 
> HCI Event: Number of Completed Packets (0x13) plen 5
  01 02 00 01 00 
> ACL data: handle 0x0002 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0040 flags 0x0000 result 0 clen 0
> ACL data: handle 0x0002 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0040 flags 0x0000 clen 4
    MTU 1024 
< ACL data: handle 0x0002 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0040 flags 0x0000 result 0 clen 0
< ACL data: handle 0x0002 flags 0x02 dlen 8
    L2CAP(d): cid 0x0040 len 4 [psm 3]
      RFCOMM(s): SABM: cr 1 dlci 0 pf 1 ilen 0 fcs 0x1c 
> HCI Event: Number of Completed Packets (0x13) plen 5
  01 02 00 01 00 
> HCI Event: Number of Completed Packets (0x13) plen 5
  01 02 00 01 00 
> ACL data: handle 0x0002 flags 0x02 dlen 8
    L2CAP(d): cid 0x0040 len 4 [psm 3]
      RFCOMM(s): UA: cr 1 dlci 0 pf 1 ilen 0 fcs 0xd7 
< ACL data: handle 0x0002 flags 0x02 dlen 18
    L2CAP(d): cid 0x0040 len 14 [psm 3]
      RFCOMM(s): PN CMD: cr 1 dlci 0 pf 0 ilen 10 fcs 0x70 mcc_len 8
      dlci 20 frame_type 0 credit_flow 15 pri 7 ack_timer 0
      frame_size 1019 max_retrans 0 credits 7
> HCI Event: Number of Completed Packets (0x13) plen 5
  01 02 00 01 00 
> ACL data: handle 0x0002 flags 0x02 dlen 18
    L2CAP(d): cid 0x0040 len 14 [psm 3]
      RFCOMM(s): PN RSP: cr 0 dlci 0 pf 0 ilen 10 fcs 0xaa mcc_len 8
      dlci 20 frame_type 0 credit_flow 14 pri 7 ack_timer 0
      frame_size 1019 max_retrans 0 credits 7
< ACL data: handle 0x0002 flags 0x02 dlen 8
    L2CAP(d): cid 0x0040 len 4 [psm 3]
      RFCOMM(s): SABM: cr 1 dlci 20 pf 1 ilen 0 fcs 0xfd 
> HCI Event: Number of Completed Packets (0x13) plen 5
  01 02 00 01 00 
> ACL data: handle 0x0002 flags 0x02 dlen 8
    L2CAP(d): cid 0x0040 len 4 [psm 3]
      RFCOMM(s): UA: cr 1 dlci 20 pf 1 ilen 0 fcs 0x36 
< ACL data: handle 0x0002 flags 0x02 dlen 12
    L2CAP(d): cid 0x0040 len 8 [psm 3]
      RFCOMM(s): MSC CMD: cr 1 dlci 0 pf 0 ilen 4 fcs 0x70 mcc_len 2
      dlci 20 fc 0 rtc 1 rtr 1 ic 0 dv 1 b1 1 b2 1 b3 0 len 0
rctest[172]: Connected
rctest[172]: Sending ...
> HCI Event: Number of Completed Packets (0x13) plen 5
  01 02 00 01 00 
> ACL data: handle 0x0002 flags 0x02 dlen 12
    L2CAP(d): cid 0x0040 len 8 [psm 3]
      RFCOMM(s): MSC CMD: cr 0 dlci 0 pf 0 ilen 4 fcs 0xaa mcc_len 2
      dlci 20 fc 0 rtc 1 rtr 1 ic 0 dv 1 b1 1 b2 1 b3 0 len 0
< ACL data: handle 0x0002 flags 0x02 dlen 12
    L2CAP(d): cid 0x0040 len 8 [psm 3]
      RFCOMM(s): MSC RSP: cr 1 dlci 0 pf 0 ilen 4 fcs 0x70 mcc_len 2
      dlci 20 fc 0 rtc 1 rtr 1 ic 0 dv 1 b1 1 b2 1 b3 0 len 0
> HCI Event: Number of Completed Packets (0x13) plen 5
  01 02 00 01 00 
> ACL data: handle 0x0002 flags 0x02 dlen 12
    L2CAP(d): cid 0x0040 len 8 [psm 3]
      RFCOMM(s): MSC RSP: cr 0 dlci 0 pf 0 ilen 4 fcs 0xaa mcc_len 2
      dlci 20 fc 0 rtc 1 rtr 1 ic 0 dv 1 b1 1 b2 1 b3 0 len 0
< ACL data: handle 0x0002 flags 0x02 dlen 9
    L2CAP(d): cid 0x0040 len 5 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 20 pf 1 ilen 0 fcs 0x2d credits 33
< ACL data: handle 0x0002 flags 0x02 dlen 135
    L2CAP(d): cid 0x0040 len 131 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 20 pf 0 ilen 127 fcs 0x31 
      00 00 00 00 7F 00 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 
      7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 
      7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 
      7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 
      7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 
      7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 
      7F 7F 7F 7F 7F 7F 7F 
> HCI Event: Number of Completed Packets (0x13) plen 5
  01 02 00 01 00 
> ACL data: handle 0x0002 flags 0x02 dlen 9
    L2CAP(d): cid 0x0040 len 5 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 20 pf 1 ilen 0 fcs 0xf7 credits 33
> HCI Event: Number of Completed Packets (0x13) plen 5
  01 02 00 01 00 
< ACL data: handle 0x0002 flags 0x02 dlen 135
    L2CAP(d): cid 0x0040 len 131 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 20 pf 0 ilen 127 fcs 0x31 
      01 00 00 00 7F 00 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 
      7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 
      7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 
      7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 
      7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 
      7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 
      7F 7F 7F 7F 7F 7F 7F 
> HCI Event: Number of Completed Packets (0x13) plen 5
  01 02 00 01 00 
< ACL data: handle 0x0002 flags 0x02 dlen 135
    L2CAP(d): cid 0x0040 len 131 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 20 pf 0 ilen 127 fcs 0x31 
      02 00 00 00 7F 00 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 
      7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 
      7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 
      7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 
      7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 
      7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 
      7F 7F 7F 7F 7F 7F 7F 
> HCI Event: Number of Completed Packets (0x13) plen 5
  01 02 00 01 00 
< ACL data: handle 0x0002 flags 0x02 dlen 135
    L2CAP(d): cid 0x0040 len 131 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 20 pf 0 ilen 127 fcs 0x31 
      03 00 00 00 7F 00 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 
      7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 
      7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 
      7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 
      7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 
      7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 
      7F 7F 7F 7F 7F 7F 7F 
> HCI Event: Hardware Error (0x10) plen 2
  23 08 
< ACL data: handle 0x0002 flags 0x02 dlen 135
    L2CAP(d): cid 0x0040 len 131 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 20 pf 0 ilen 127 fcs 0x31 
      04 00 00 00 7F 00 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 
      7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 
      7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 
      7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 
      7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 
      7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 
      7F 7F 7F 7F 7F 7F 7F 
> HCI Event: Hardware Error (0x10) plen 1
  20 
> HCI Event: Number of Completed Packets (0x13) plen 5
  01 02 00 01 00 
< ACL data: handle 0x0002 flags 0x02 dlen 135
    L2CAP(d): cid 0x0040 len 131 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 20 pf 0 ilen 127 fcs 0x31 
      05 00 00 00 7F 00 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 
      7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 
      7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 
      7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 
      7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 
      7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 
      7F 7F 7F 7F 7F 7F 7F 
< ACL data: handle 0x0002 flags 0x02 dlen 135
    L2CAP(d): cid 0x0040 len 131 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 20 pf 0 ilen 127 fcs 0x31 
      06 00 00 00 7F 00 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 
      7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 
      7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 
      7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 
      7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 
      7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 
      7F 7F 7F 7F 7F 7F 7F 
< ACL data: handle 0x0002 flags 0x02 dlen 135
    L2CAP(d): cid 0x0040 len 131 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 20 pf 0 ilen 127 fcs 0x31 
      07 00 00 00 7F 00 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 
      7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 
      7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 
      7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 
      7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 
      7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 
      7F 7F 7F 7F 7F 7F 7F 
< ACL data: handle 0x0002 flags 0x02 dlen 135
    L2CAP(d): cid 0x0040 len 131 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 20 pf 0 ilen 127 fcs 0x31 
      08 00 00 00 7F 00 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 
      7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 
      7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 
      7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 
      7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 
      7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 7F 
      7F 7F 7F 7F 7F 7F 7F 



-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
