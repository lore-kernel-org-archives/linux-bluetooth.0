Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Paul Koster <pckoster@wanadoo.nl>
To: bluez-devel@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200412291538.46078.pckoster@wanadoo.nl>
Subject: [Bluez-devel] Strange receive buffer mix-up when accessing /dev/rfcomm0 as a file
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Wed, 29 Dec 2004 15:38:45 +0100

Hi list,

I've got a strange problem when reading the /dev/rfcomm0 device as a file. It 
boils down to a mix-up of one byte from the inputbuffer.

My system information is as follows:

- My transceiving USB key is a MSI PC2PC Bluetooth
- Mobile device is a TMSI Mobi8e bluetooth ExG amplifier with serial service 
(SP) enabled and bound via "rfcomm bind 0 00:A0:96:1D:77:A8 1"

Some useful system command outputs:

[root@paul ~]# rpm -qa | grep bluez
bluez-hcidump-1.11-1
bluez-utils-2.10-2
bluez-pin-0.23-3
bluez-libs-2.10-2
bluez-bluefw-1.0-6

[root@paul ~]# uname -r
2.6.9-1.678_FC3

[root@paul ~]# rfcomm
rfcomm0: 00:A0:96:1D:77:A8 channel 1 closed

I access the created /dev/rfcomm0 node as a standard file. Therefore I've 
written a small test program which is listed below. To get the device going a 
specific protocol is needed, but is basically boils down to sending 3 packets 
and waiting for acknowledge packets which are all sent and received well and 
then a series of packets from the mobi device, containing the measured data. 
These last type of packets is sent continiously from the device. I fetch them 
continuously using fgetc.

Every packet starts with 0xAAAA (so called blocksync).

The problem lies in these last type of packets. I do receive them, but there 
is a discrepancy between what "hcidump -x" says, and what I actually receive 
from the buffer. I should receive i.e.:

AA AA 0D 01 00 00 80 00 00 80 00 00 80 00 00 80 00 00 80 00 00 80 00 00 80 00 
00 80 00 0C 49 46 

but I get:

AA AA >0A< 01 00 00 80 00 00 80 00 00 80 00 00 80 00 00 80 00 00 80 00 00 80 
00 00 80 00 0C 49 46 

The 0D (13) has become a 0A (10), but the rest of the packet is totally 
perfect. This is the case with ALL packets received of this kind. It should 
be 0D according to the protocol (and hcidump).
I've listed the relevant pieces of hcidump output as well as program output 
below (program output is in decimal notation however. 0xAA = 170, so the 
relevant sequence is 170 170 10 01 at the end of the output)

Does anyone have a clue on what this could be? Thanks in advance for your 
help.

Kind regards,

Paul Koster

----------------------------------------
Example program
----------------------------------------

#include <iostream>
using namespace std;

int main(int argc, char *argv[])
{
 FILE* file = fopen("/dev/rfcomm0", "a+");
  
 char blocksync[2];

 char out1[6] = {0xAA, 0xAA, 0x00, 0x05, 0x56, 0x50};
 
 fwrite(out1, 6, 1, file);
 fflush(file);
 
 cerr << "Packet 0x05 sent" << endl;
 
 blocksync[0] = 0;
 blocksync[1] = 0;
 
 while((unsigned char)blocksync[0] != 0xAA && (unsigned char)blocksync[1] != 
0xAA)
  fread(blocksync, 2, 1, file);

 cerr << "Reply packet received" << endl;
 
 char out2[10] = {0xAA, 0xAA, 0x02, 0x22, 0x00, 0x01, 0x80, 0x00, 0xD4, 0x31};
 
 fwrite(out2, 10, 1, file);
 fflush(file);
 
 cerr << "Packet 0x22 sent" << endl;

 blocksync[0] = 0;
 blocksync[1] = 0;
 
 while((unsigned char)blocksync[0] != 0xAA && (unsigned char)blocksync[1] != 
0xAA)
  fread(blocksync, 2, 1, file);

 cerr << "Reply packet received" << endl;
 
 char out3[6] = {0xAA, 0xAA, 0x00, 0x02, 0x56, 0x53};
 
 fwrite(out3, 6, 1, file);
 fflush(file);
 
 cerr << "Packet 0x02 sent" << endl;
 
 while(true) {
  int a = fgetc(file);
  cerr << a << " ";
 }

 fclose(file);
}

----------------------------------------
hcidump -x output
----------------------------------------
HCIDump - HCI packet analyzer ver 1.11
device: hci0 snap_len: 1028 filter: 0xffffffff
< HCI Command: Create Connection (0x01|0x0005) plen 13
  A8 77 1D 96 A0 00 18 CC 02 00 00 00 01 
> HCI Event: Command Status (0x0f) plen 4
  00 01 05 04 
> HCI Event: Link Key Request (0x17) plen 6
  A8 77 1D 96 A0 00 
< HCI Command: Link Key Request Reply (0x01|0x000b) plen 22
  A8 77 1D 96 A0 00 0E 74 04 B5 CD E0 AF 40 CC A5 6F D3 47 8F 
  B0 A5 
> HCI Event: Command Complete (0x0e) plen 10
  01 0B 04 00 A8 77 1D 96 A0 00 
> HCI Event: Connect Complete (0x03) plen 11
  00 29 00 A8 77 1D 96 A0 00 01 01 
< ACL data: handle 0x0029 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 3 scid 0x0040
< HCI Command: Write Link Policy Settings (0x02|0x000d) plen 4
  29 00 0F 00 
> HCI Event: Number of Completed Packets (0x13) plen 5
  01 29 00 01 00 
> HCI Event: Command Complete (0x0e) plen 6
  01 0D 08 00 29 00 
> HCI Event: Page Scan Repetition Mode Change (0x20) plen 7
  A8 77 1D 96 A0 00 01 
> HCI Event: Max Slots Change (0x1b) plen 3
  29 00 05 
> ACL data: handle 0x0029 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0040 result 1 status 2
> ACL data: handle 0x0029 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0040 result 0 status 0
< ACL data: handle 0x0029 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0040 flags 0x0000 clen 4
    MTU 1024 
> HCI Event: Number of Completed Packets (0x13) plen 5
  01 29 00 01 00 
> ACL data: handle 0x0029 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0040 flags 0x0000 result 0 clen 0
> ACL data: handle 0x0029 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0040 flags 0x0000 clen 4
    MTU 1024 
< ACL data: handle 0x0029 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0040 flags 0x0000 result 0 clen 0
< ACL data: handle 0x0029 flags 0x02 dlen 8
    L2CAP(d): cid 0x0040 len 4 [psm 3]
      RFCOMM(s): SABM: cr 1 dlci 0 pf 1 ilen 0 fcs 0x1c 
> HCI Event: Number of Completed Packets (0x13) plen 5
  01 29 00 01 00 
> HCI Event: Number of Completed Packets (0x13) plen 5
  01 29 00 01 00 
> ACL data: handle 0x0029 flags 0x02 dlen 8
    L2CAP(d): cid 0x0040 len 4 [psm 3]
      RFCOMM(s): UA: cr 1 dlci 0 pf 1 ilen 0 fcs 0xd7 
< ACL data: handle 0x0029 flags 0x02 dlen 18
    L2CAP(d): cid 0x0040 len 14 [psm 3]
      RFCOMM(s): PN CMD: cr 1 dlci 0 pf 0 ilen 10 fcs 0x70 mcc_len 8
      dlci 2 frame_type 0 credit_flow 15 pri 7 ack_timer 0
      frame_size 1019 max_retrans 0 credits 7
> HCI Event: Number of Completed Packets (0x13) plen 5
  01 29 00 01 00 
> ACL data: handle 0x0029 flags 0x02 dlen 18
    L2CAP(d): cid 0x0040 len 14 [psm 3]
      RFCOMM(s): PN RSP: cr 0 dlci 0 pf 0 ilen 10 fcs 0xaa mcc_len 8
      dlci 2 frame_type 0 credit_flow 14 pri 0 ack_timer 0
      frame_size 320 max_retrans 0 credits 0
< ACL data: handle 0x0029 flags 0x02 dlen 8
    L2CAP(d): cid 0x0040 len 4 [psm 3]
      RFCOMM(s): SABM: cr 1 dlci 2 pf 1 ilen 0 fcs 0x59 
> HCI Event: Number of Completed Packets (0x13) plen 5
  01 29 00 01 00 
> ACL data: handle 0x0029 flags 0x02 dlen 8
    L2CAP(d): cid 0x0040 len 4 [psm 3]
      RFCOMM(s): UA: cr 1 dlci 2 pf 1 ilen 0 fcs 0x92 
< ACL data: handle 0x0029 flags 0x02 dlen 12
    L2CAP(d): cid 0x0040 len 8 [psm 3]
      RFCOMM(s): MSC CMD: cr 1 dlci 0 pf 0 ilen 4 fcs 0x70 mcc_len 2
      dlci 2 fc 0 rtc 1 rtr 1 ic 0 dv 1 b1 0 b2 0 b3 0 len 0
> ACL data: handle 0x0029 flags 0x02 dlen 12
    L2CAP(d): cid 0x0040 len 8 [psm 3]
      RFCOMM(s): MSC CMD: cr 0 dlci 0 pf 0 ilen 4 fcs 0xaa mcc_len 2
      dlci 2 fc 0 rtc 1 rtr 1 ic 0 dv 0 b1 0 b2 0 b3 0 len 0
< ACL data: handle 0x0029 flags 0x02 dlen 12
    L2CAP(d): cid 0x0040 len 8 [psm 3]
      RFCOMM(s): MSC RSP: cr 1 dlci 0 pf 0 ilen 4 fcs 0x70 mcc_len 2
      dlci 2 fc 0 rtc 1 rtr 1 ic 0 dv 0 b1 0 b2 0 b3 0 len 0
> HCI Event: Number of Completed Packets (0x13) plen 5
  01 29 00 01 00 
> HCI Event: Number of Completed Packets (0x13) plen 5
  01 29 00 01 00 
> ACL data: handle 0x0029 flags 0x02 dlen 12
    L2CAP(d): cid 0x0040 len 8 [psm 3]
      RFCOMM(s): MSC RSP: cr 0 dlci 0 pf 0 ilen 4 fcs 0xaa mcc_len 2
      dlci 2 fc 0 rtc 1 rtr 1 ic 0 dv 1 b1 0 b2 0 b3 0 len 0
< ACL data: handle 0x0029 flags 0x02 dlen 9
    L2CAP(d): cid 0x0040 len 5 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 2 pf 1 ilen 0 fcs 0x86 credits 33
> HCI Event: Number of Completed Packets (0x13) plen 5
  01 29 00 01 00 
> ACL data: handle 0x0029 flags 0x02 dlen 9
    L2CAP(d): cid 0x0040 len 5 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 2 pf 1 ilen 0 fcs 0x5c credits 5
< ACL data: handle 0x0029 flags 0x02 dlen 14
    L2CAP(d): cid 0x0040 len 10 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 2 pf 0 ilen 6 fcs 0x9a 
      AA AA 00 05 56 50 
> HCI Event: Number of Completed Packets (0x13) plen 5
  01 29 00 01 00 
> ACL data: handle 0x0029 flags 0x02 dlen 19
    L2CAP(d): cid 0x0040 len 15 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 2 pf 1 ilen 10 fcs 0x5c credits 1
      AA AA 10 02 0A 00 04 00 01 00 
< ACL data: handle 0x0029 flags 0x02 dlen 18
    L2CAP(d): cid 0x0040 len 14 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 2 pf 0 ilen 10 fcs 0x9a 
      AA AA 02 22 00 01 80 00 D4 31 
> ACL data: handle 0x0029 flags 0x02 dlen 35
> ACL data: handle 0x0029 flags 0x01 dlen 1
    L2CAP(d): cid 0x0040 len 32 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 2 pf 0 ilen 28 fcs 0x40 
      00 04 83 06 60 37 08 00 00 00 00 09 05 01 8E 00 8A 00 0A 00 
      00 04 FF FF FF FF 27 02 
> HCI Event: Number of Completed Packets (0x13) plen 5
  01 29 00 01 00 
> ACL data: handle 0x0029 flags 0x02 dlen 121
> ACL data: handle 0x0029 flags 0x01 dlen 94
    L2CAP(d): cid 0x0040 len 211 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 2 pf 1 ilen 205 fcs 0x5c credits 1
      AA AA 82 23 00 01 80 00 00 D2 06 60 10 74 C7 8D 44 F2 A3 F0 
      01 B0 48 17 41 48 4F 51 60 E2 42 B8 40 80 B3 59 22 C1 14 7A 
      00 DB 98 37 02 D0 40 64 02 51 53 66 52 F5 0C 71 60 F4 93 17 
      06 B2 14 67 84 D0 06 40 01 F0 30 50 40 F0 2E 98 03 91 29 78 
      54 F1 E8 70 00 50 36 3A 24 B1 A4 70 1C 70 04 E3 00 60 70 5E 
      22 F2 38 A6 10 B0 F0 60 00 E2 42 8A 00 D0 54 7F 2C F5 6E 3F 
      04 7D A0 44 25 74 64 4F 22 70 C4 D3 20 72 85 78 80 D0 91 B5 
      44 F1 4B A4 01 E1 11 B0 04 F8 BA 80 18 70 21 51 00 F1 44 31 
      65 E0 D0 94 E6 54 7F 79 15 F3 43 D0 42 51 80 C2 00 B1 07 06 
      00 B2 71 60 00 60 41 F4 02 F2 31 31 00 B0 7B 70 28 D0 D2 C4 
      06 90 E0 30 01 
< ACL data: handle 0x0029 flags 0x02 dlen 14
    L2CAP(d): cid 0x0040 len 10 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 2 pf 0 ilen 6 fcs 0x9a 
      AA AA 00 02 56 53 
> HCI Event: Number of Completed Packets (0x13) plen 5
  01 29 00 01 00 
> ACL data: handle 0x0029 flags 0x02 dlen 65
    L2CAP(d): cid 0x0040 len 61 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 2 pf 0 ilen 57 fcs 0x40 
      C0 89 A8 74 10 A0 70 40 13 61 82 05 B0 8A 05 62 E0 B3 41 60 
      70 F4 E2 20 C3 D0 5D 05 F7 14 BB 81 B1 C0 59 09 12 21 F0 42 
      70 2B DA 40 F8 64 61 42 21 87 1C 81 F5 11 3D 10 50 
> ACL data: handle 0x0029 flags 0x02 dlen 12
    L2CAP(d): cid 0x0040 len 8 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 2 pf 0 ilen 4 fcs 0x40 
      67 86 7B DF 
> ACL data: handle 0x0029 flags 0x02 dlen 19
    L2CAP(d): cid 0x0040 len 15 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 2 pf 1 ilen 10 fcs 0x5c credits 1
      AA AA 02 00 00 02 1A 00 3A 53 
> ACL data: handle 0x0029 flags 0x02 dlen 40
    L2CAP(d): cid 0x0040 len 36 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 2 pf 0 ilen 32 fcs 0x40 
      AA AA 0D 01 00 00 80 00 00 80 00 00 80 00 00 80 00 00 80 00 
      00 80 00 00 80 00 00 80 00 38 49 1A 
> ACL data: handle 0x0029 flags 0x02 dlen 40
    L2CAP(d): cid 0x0040 len 36 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 2 pf 0 ilen 32 fcs 0x40 
      AA AA 0D 01 00 00 80 00 00 80 00 00 80 00 00 80 00 00 80 00 
      00 80 00 00 80 00 00 80 00 3A 49 18 
> ACL data: handle 0x0029 flags 0x02 dlen 40
    L2CAP(d): cid 0x0040 len 36 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 2 pf 0 ilen 32 fcs 0x40 
      AA AA 0D 01 00 00 80 00 00 80 00 00 80 00 00 80 00 00 80 00 
      00 80 00 00 80 00 00 80 00 3C 49 16 
> ACL data: handle 0x0029 flags 0x02 dlen 40
    L2CAP(d): cid 0x0040 len 36 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 2 pf 0 ilen 32 fcs 0x40 
      AA AA 0D 01 00 00 80 00 00 80 00 00 80 00 00 80 00 00 80 00 
      00 80 00 00 80 00 00 80 00 3E 49 14 
> ACL data: handle 0x0029 flags 0x02 dlen 7

----------------------------------------
program output
----------------------------------------
Packet 0x05 sent
Reply packet received
Packet 0x22 sent
Reply packet received
Packet 0x02 sent
-1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 
-1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 
-1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 
-1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 
-1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 
-1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 192 137 168 116 16 
160 112 64 19 97 130 5 176 138 5 98 224 179 65 96 112 244 226 32 195 208 93 5 
247 20 187 129 177 192 89 9 18 33 240 66 112 43 218 64 248 100 97 66 33 135 
28 129 245 17 61 16 80 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 
-1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 
-1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 103 134 123 223 -1 -1 -1 -1 
-1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 
-1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 
-1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 
-1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 
-1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 
-1 -1 -1 -1 -1 -1 170 170 2 0 0 2 26 0 58 83 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 
-1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 
-1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 
-1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 
-1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 170 170 10 1 0 0 
128 0 0 128 0 0 128 0 0 128 0 0 128 0 0 128 0 0 128 0 0 128 0 56 73 26 -1 -1 
-1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 
-1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 
-1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 
-1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 
-1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 
-1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 
-1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 170 170 10 1 0 0 128 0 0 128 0 0 
128 0 0 128 0 0 128 0 0 128 0 0 128 0 0 128 0 58 73 24 -1 -1 -1 -1 -1 -1 -1 
-1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 
-1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 
-1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 
-1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 
-1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 
-1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 
-1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 
-1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 
-1 -1 -1 -1 -1 -1 170 170 10 1 0 0 128 0 0 128 0 0 128 0 0 128 0 0 128 0 0 
128 0 0 128 0 0 128 0 60 73 22 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 
-1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 
-1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 
-1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 
-1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 
-1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 
-1 -1 -1 -1 -1 -1 -1 -1 170 170 10 1 0 0 128 0 0 128 0 0 128 0 0 128 0 0 128 
0 0 128 0 0 128 0 0 128 0 62 73 20 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 
-1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 
--1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 
-1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 
-1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 
-1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 
-1 -1 -1 -1 -1 -1 170 170 10 1 0 0 128 0 0 128 0 0 128 0 0 128 0 0 128 0 0 
128 0 0 128 0 0 128 0 0 73 82


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
