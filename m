Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <4210E7C1.6010706@cc.gatech.edu>
From: Jay Summet <summetj@cc.gatech.edu>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Content-Type: multipart/mixed;
 boundary="------------000208020107010609020803"
Subject: [Bluez-users] Re: Trouble pairing with new phone... (FIXED!)
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Mon, 14 Feb 2005 13:02:41 -0500

This is a multi-part message in MIME format.
--------------000208020107010609020803
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

I figured out how to pair with my T610 phone.

Point 1: The computer must initiate the connection. (If you attempt to scan for 
new devices on your phone and add it there, apparently bluez will not accept 
incoming pairing requests. Something to do with roleswitch and bluez wanting to 
be the master? Perhaps...)

Point 2: My version of blueZ ignores the /etc/bluetooth/pin file (even when in 
"auto" mode) and I HAD to replace the pin_helper with a link to a script which 
simply printed "PIN:1234" (replace number with your pin).

So, once I replace "pin_helper /usr/bin/bluepin" with "pin_helper /sbin/pintest" 
(where the pintest file contained "echo "PIN:1234") and initiated an rfcomm 
connection to the phone with my pppd chat script, I was able to type the pin 
into my phone and pair.

[(going the other way, from the phone to the computer, didn't work...possibly a 
problem with the phone, possibly a problem with bluez (as it works under 
windows...)]

My hcid.conf options are as follows:
Options:
autoinit yes;
security auto;
pairing multi;
pin_helper /sbin/pintest

Device:
name "BlueZ (%d)";
class 0x100;
iscan enable;
pscan enable;
lp rswitch,hold,sniff,park;
lm accept,master;
# Authentication and Encryption
         auth enable;
         encrypt enable;


I've attached two log files from hcidump -x. from_phone is when I attempted to 
pair the phone with the computer. to_phone is when I allowed the pppd/rfcomm 
connection to initiate the pairing between the phone and the computer. (After 
the link key is established, it then goes into my rfcomm/PPP setup...)

In summary, the SE T610 doesn't want to pair with bluez when it initializes the 
connection (is the master?) and for some reason bluez doesn't seem to correct 
this (doesn't role switch by default?). However, you can work around the problem 
by forcing bluez to initialize the connection.

(Also, it appears that my bluez hcid is not waiting for the pin_helper to return 
with a pin (e.g. the /usr/bin/bluepin and /usr/bin/bluez-pin helper programs did 
not work for me, while replacing them with a script that just echoed my pin 
(quickly) did work...)


Jay

--------------000208020107010609020803
Content-Type: text/plain;
 name="from_phone.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="from_phone.txt"

HCIDump - HCI packet analyzer ver 1.10
device: hci0 snap_len: 1028 filter: 0xffffffff
> HCI Event: Connect Request (0x04) plen 10
  B2 E6 1D D9 0A 00 04 02 52 01 
< HCI Command: Accept Connection Request (0x01|0x0009) plen 7
  B2 E6 1D D9 0A 00 00 
> HCI Event: Command Status (0x0f) plen 4
  00 01 09 04 
> HCI Event: Connect Complete (0x03) plen 11
  1A 29 00 B2 E6 1D D9 0A 00 01 00 

--------------000208020107010609020803
Content-Type: text/plain;
 name="to_phone.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="to_phone.txt"

HCIDump - HCI packet analyzer ver 1.10
device: hci0 snap_len: 1028 filter: 0xffffffff
< HCI Command: Create Connection (0x01|0x0005) plen 13
  B2 E6 1D D9 0A 00 18 CC 02 00 00 00 01 
> HCI Event: Command Status (0x0f) plen 4
  00 01 05 04 
> HCI Event: Connect Complete (0x03) plen 11
  00 29 00 B2 E6 1D D9 0A 00 01 00 
< ACL data: handle 0x0029 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 3 scid 0x0040
> HCI Event: Number of Completed Packets (0x13) plen 5
  01 29 00 01 00 
> ACL data: handle 0x0029 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0043 scid 0x0040 result 0 status 0
< ACL data: handle 0x0029 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0043 flags 0x0000 clen 4
    MTU 1024 
> HCI Event: Number of Completed Packets (0x13) plen 5
  01 29 00 01 00 
> ACL data: handle 0x0029 flags 0x02 dlen 17
> ACL data: handle 0x0029 flags 0x01 dlen 1
    L2CAP(s): Config rsp: scid 0x0040 flags 0x0000 result 0 clen 4
    MTU 251 
> ACL data: handle 0x0029 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0040 flags 0x0000 clen 4
    MTU 251 
< ACL data: handle 0x0029 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0043 flags 0x0000 result 0 clen 0
< ACL data: handle 0x0029 flags 0x02 dlen 8
    L2CAP(d): cid 0x0043 len 4 [psm 3]
      RFCOMM(s): SABM: cr 1 dlci 0 pf 1 ilen 0 fcs 0x1c 
> HCI Event: Number of Completed Packets (0x13) plen 5
  01 29 00 01 00 
> HCI Event: Number of Completed Packets (0x13) plen 5
  01 29 00 01 00 
> ACL data: handle 0x0029 flags 0x02 dlen 8
    L2CAP(d): cid 0x0040 len 4 [psm 3]
      RFCOMM(s): UA: cr 1 dlci 0 pf 1 ilen 0 fcs 0xd7 
< ACL data: handle 0x0029 flags 0x02 dlen 18
    L2CAP(d): cid 0x0043 len 14 [psm 3]
      RFCOMM(s): PN CMD: cr 1 dlci 0 pf 0 ilen 10 fcs 0x70 mcc_len 8
      dlci 2 frame_type 0 credit_flow 15 pri 7 ack_timer 0
      frame_size 246 max_retrans 0 credits 7
> HCI Event: Number of Completed Packets (0x13) plen 5
  01 29 00 01 00 
> ACL data: handle 0x0029 flags 0x02 dlen 17
> ACL data: handle 0x0029 flags 0x01 dlen 2
    L2CAP(d): cid 0x0040 len 15 [psm 3]
      RFCOMM(s): PN RSP: cr 0 dlci 0 pf 0 ilen 10 fcs 0xaa mcc_len 8
      dlci 2 frame_type 0 credit_flow 14 pri 7 ack_timer 0
      frame_size 246 max_retrans 0 credits 7
< ACL data: handle 0x0029 flags 0x02 dlen 8
    L2CAP(d): cid 0x0043 len 4 [psm 3]
      RFCOMM(s): SABM: cr 1 dlci 2 pf 1 ilen 0 fcs 0x59 
> HCI Event: Number of Completed Packets (0x13) plen 5
  01 29 00 01 00 
> HCI Event: PIN Code Request (0x16) plen 6
  B2 E6 1D D9 0A 00 
< HCI Command: PIN Code Request Reply (0x01|0x000d) plen 23
  B2 E6 1D D9 0A 00 04 32 36 30 33 00 00 00 00 00 00 00 00 00 
  00 00 00 
> HCI Event: Command Complete (0x0e) plen 10
  01 0D 04 00 B2 E6 1D D9 0A 00 
> HCI Event: Link Key Notification (0x18) plen 23
  B2 E6 1D D9 0A 00 57 BE 6F 49 9C 52 28 76 92 2E 02 E0 51 51 
  D9 91 00 
> ACL data: handle 0x0029 flags 0x02 dlen 8
    L2CAP(d): cid 0x0040 len 4 [psm 3]
      RFCOMM(s): UA: cr 1 dlci 2 pf 1 ilen 0 fcs 0x92 
< ACL data: handle 0x0029 flags 0x02 dlen 12
    L2CAP(d): cid 0x0043 len 8 [psm 3]
      RFCOMM(s): MSC CMD: cr 1 dlci 0 pf 0 ilen 4 fcs 0x70 mcc_len 2
      dlci 2 fc 0 rtc 1 rtr 1 ic 0 dv 1 b1 0 b2 0 b3 0 len 5
> ACL data: handle 0x0029 flags 0x02 dlen 13
    L2CAP(d): cid 0x0040 len 9 [psm 3]
      RFCOMM(s): MSC CMD: cr 0 dlci 0 pf 0 ilen 4 fcs 0xaa mcc_len 2
      dlci 2 fc 0 rtc 1 rtr 1 ic 0 dv 0 b1 0 b2 0 b3 0 len 5
< ACL data: handle 0x0029 flags 0x02 dlen 12
    L2CAP(d): cid 0x0043 len 8 [psm 3]
      RFCOMM(s): MSC RSP: cr 1 dlci 0 pf 0 ilen 4 fcs 0x70 mcc_len 2
      dlci 2 fc 0 rtc 1 rtr 1 ic 0 dv 0 b1 0 b2 0 b3 0 len 5
> HCI Event: Encrypt Change (0x08) plen 4
  00 29 00 01 
> HCI Event: Number of Completed Packets (0x13) plen 5
  01 29 00 01 00 
> HCI Event: Number of Completed Packets (0x13) plen 5
  01 29 00 01 00 
> ACL data: handle 0x0029 flags 0x02 dlen 13
    L2CAP(d): cid 0x0040 len 9 [psm 3]
      RFCOMM(s): MSC RSP: cr 0 dlci 0 pf 0 ilen 4 fcs 0xaa mcc_len 2
      dlci 2 fc 0 rtc 1 rtr 1 ic 0 dv 1 b1 0 b2 0 b3 0 len 5
< ACL data: handle 0x0029 flags 0x02 dlen 12
    L2CAP(d): cid 0x0043 len 8 [psm 3]
      RFCOMM(s): MSC CMD: cr 1 dlci 0 pf 0 ilen 4 fcs 0x70 mcc_len 2
      dlci 2 fc 0 rtc 0 rtr 1 ic 0 dv 1 b1 0 b2 0 b3 0 len 5
< ACL data: handle 0x0029 flags 0x02 dlen 9
    L2CAP(d): cid 0x0043 len 5 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 2 pf 1 ilen 0 fcs 0x86 credits 33
> HCI Event: Number of Completed Packets (0x13) plen 5
  01 29 00 01 00 
> HCI Event: Number of Completed Packets (0x13) plen 5
  01 29 00 01 00 
> ACL data: handle 0x0029 flags 0x02 dlen 13
    L2CAP(d): cid 0x0040 len 9 [psm 3]
      RFCOMM(s): MSC RSP: cr 0 dlci 0 pf 0 ilen 4 fcs 0xaa mcc_len 2
      dlci 2 fc 0 rtc 0 rtr 1 ic 0 dv 1 b1 0 b2 0 b3 0 len 5
< ACL data: handle 0x0029 flags 0x02 dlen 12
    L2CAP(d): cid 0x0043 len 8 [psm 3]
      RFCOMM(s): MSC CMD: cr 1 dlci 0 pf 0 ilen 4 fcs 0x70 mcc_len 2
      dlci 2 fc 0 rtc 1 rtr 1 ic 0 dv 1 b1 0 b2 0 b3 0 len 5
> HCI Event: Number of Completed Packets (0x13) plen 5
  01 29 00 01 00 
< ACL data: handle 0x0029 flags 0x02 dlen 9
    L2CAP(d): cid 0x0043 len 5 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 2 pf 0 ilen 1 fcs 0x9a 
      0D 
> HCI Event: Number of Completed Packets (0x13) plen 5
  01 29 00 01 00 
> ACL data: handle 0x0029 flags 0x02 dlen 13
    L2CAP(d): cid 0x0040 len 9 [psm 3]
      RFCOMM(s): MSC RSP: cr 0 dlci 0 pf 0 ilen 4 fcs 0xaa mcc_len 2
      dlci 2 fc 0 rtc 1 rtr 1 ic 0 dv 1 b1 0 b2 0 b3 0 len 5
< ACL data: handle 0x0029 flags 0x02 dlen 9
    L2CAP(d): cid 0x0043 len 5 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 2 pf 0 ilen 1 fcs 0x9a 
      41 
> ACL data: handle 0x0029 flags 0x02 dlen 11
    L2CAP(d): cid 0x0040 len 7 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 2 pf 1 ilen 1 fcs 0x5c credits 4
      0D 
> HCI Event: Number of Completed Packets (0x13) plen 5
  01 29 00 01 00 
< ACL data: handle 0x0029 flags 0x02 dlen 9
    L2CAP(d): cid 0x0043 len 5 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 2 pf 0 ilen 1 fcs 0x9a 
      54 
< ACL data: handle 0x0029 flags 0x02 dlen 9
    L2CAP(d): cid 0x0043 len 5 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 2 pf 0 ilen 1 fcs 0x9a 
      0D 
> HCI Event: Number of Completed Packets (0x13) plen 5
  01 29 00 01 00 
> ACL data: handle 0x0029 flags 0x02 dlen 11
    L2CAP(d): cid 0x0040 len 7 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 2 pf 1 ilen 1 fcs 0x5c credits 1
      41 
> HCI Event: Number of Completed Packets (0x13) plen 5
  01 29 00 01 00 
> ACL data: handle 0x0029 flags 0x02 dlen 11
    L2CAP(d): cid 0x0040 len 7 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 2 pf 1 ilen 1 fcs 0x5c credits 2
      54 
> ACL data: handle 0x0029 flags 0x02 dlen 11
    L2CAP(d): cid 0x0040 len 7 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 2 pf 1 ilen 1 fcs 0x5c credits 0
      0D 
> ACL data: handle 0x0029 flags 0x02 dlen 16
    L2CAP(d): cid 0x0040 len 12 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 2 pf 1 ilen 6 fcs 0x5c credits 0
      0D 0A 4F 4B 0D 0A 
< ACL data: handle 0x0029 flags 0x02 dlen 9
    L2CAP(d): cid 0x0043 len 5 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 2 pf 0 ilen 1 fcs 0x9a 
      41 
< ACL data: handle 0x0029 flags 0x02 dlen 9
    L2CAP(d): cid 0x0043 len 5 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 2 pf 0 ilen 1 fcs 0x9a 
      54 
> HCI Event: Number of Completed Packets (0x13) plen 5
  01 29 00 01 00 
> HCI Event: Number of Completed Packets (0x13) plen 5
  01 29 00 01 00 
< ACL data: handle 0x0029 flags 0x02 dlen 9
    L2CAP(d): cid 0x0043 len 5 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 2 pf 0 ilen 1 fcs 0x9a 
      2B 
< ACL data: handle 0x0029 flags 0x02 dlen 9
    L2CAP(d): cid 0x0043 len 5 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 2 pf 0 ilen 1 fcs 0x9a 
      43 
> HCI Event: Number of Completed Packets (0x13) plen 5
  01 29 00 01 00 
> ACL data: handle 0x0029 flags 0x02 dlen 11
    L2CAP(d): cid 0x0040 len 7 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 2 pf 1 ilen 1 fcs 0x5c credits 2
      41 
> ACL data: handle 0x0029 flags 0x02 dlen 11
    L2CAP(d): cid 0x0040 len 7 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 2 pf 1 ilen 1 fcs 0x5c credits 0
      54 
> HCI Event: Number of Completed Packets (0x13) plen 5
  01 29 00 01 00 
< ACL data: handle 0x0029 flags 0x02 dlen 9
    L2CAP(d): cid 0x0043 len 5 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 2 pf 0 ilen 1 fcs 0x9a 
      47 
> ACL data: handle 0x0029 flags 0x02 dlen 11
    L2CAP(d): cid 0x0040 len 7 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 2 pf 1 ilen 1 fcs 0x5c credits 2
      2B 
> ACL data: handle 0x0029 flags 0x02 dlen 11
    L2CAP(d): cid 0x0040 len 7 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 2 pf 1 ilen 1 fcs 0x5c credits 0
      43 
> HCI Event: Number of Completed Packets (0x13) plen 5
  01 29 00 01 00 
< ACL data: handle 0x0029 flags 0x02 dlen 9
    L2CAP(d): cid 0x0043 len 5 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 2 pf 0 ilen 1 fcs 0x9a 
      44 
< ACL data: handle 0x0029 flags 0x02 dlen 9
    L2CAP(d): cid 0x0043 len 5 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 2 pf 0 ilen 1 fcs 0x9a 
      43 
> HCI Event: Number of Completed Packets (0x13) plen 5
  01 29 00 01 00 
> HCI Event: Number of Completed Packets (0x13) plen 5
  01 29 00 01 00 
> ACL data: handle 0x0029 flags 0x02 dlen 11
    L2CAP(d): cid 0x0040 len 7 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 2 pf 1 ilen 1 fcs 0x5c credits 1
      47 
< ACL data: handle 0x0029 flags 0x02 dlen 9
    L2CAP(d): cid 0x0043 len 5 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 2 pf 0 ilen 1 fcs 0x9a 
      4F 
> HCI Event: Number of Completed Packets (0x13) plen 5
  01 29 00 01 00 
< ACL data: handle 0x0029 flags 0x02 dlen 9
    L2CAP(d): cid 0x0043 len 5 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 2 pf 0 ilen 1 fcs 0x9a 
      4E 
< ACL data: handle 0x0029 flags 0x02 dlen 9
    L2CAP(d): cid 0x0043 len 5 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 2 pf 0 ilen 1 fcs 0x9a 
      54 
> HCI Event: Number of Completed Packets (0x13) plen 5
  01 29 00 01 00 
> HCI Event: Number of Completed Packets (0x13) plen 5
  01 29 00 01 00 
> ACL data: handle 0x0029 flags 0x02 dlen 11
    L2CAP(d): cid 0x0040 len 7 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 2 pf 1 ilen 1 fcs 0x5c credits 3
      44 
> ACL data: handle 0x0029 flags 0x02 dlen 11
    L2CAP(d): cid 0x0040 len 7 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 2 pf 1 ilen 1 fcs 0x5c credits 0
      43 
< ACL data: handle 0x0029 flags 0x02 dlen 9
    L2CAP(d): cid 0x0043 len 5 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 2 pf 0 ilen 1 fcs 0x9a 
      3D 
> ACL data: handle 0x0029 flags 0x02 dlen 11
    L2CAP(d): cid 0x0040 len 7 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 2 pf 1 ilen 1 fcs 0x5c credits 0
      4F 
> HCI Event: Number of Completed Packets (0x13) plen 5
  01 29 00 01 00 
> ACL data: handle 0x0029 flags 0x02 dlen 11
    L2CAP(d): cid 0x0040 len 7 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 2 pf 1 ilen 1 fcs 0x5c credits 2
      4E 
< ACL data: handle 0x0029 flags 0x02 dlen 9
    L2CAP(d): cid 0x0043 len 5 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 2 pf 0 ilen 1 fcs 0x9a 
      32 
> ACL data: handle 0x0029 flags 0x02 dlen 11
    L2CAP(d): cid 0x0040 len 7 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 2 pf 1 ilen 1 fcs 0x5c credits 1
      54 
> HCI Event: Number of Completed Packets (0x13) plen 5
  01 29 00 01 00 
> ACL data: handle 0x0029 flags 0x02 dlen 11
    L2CAP(d): cid 0x0040 len 7 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 2 pf 1 ilen 1 fcs 0x5c credits 0
      3D 
< ACL data: handle 0x0029 flags 0x02 dlen 9
    L2CAP(d): cid 0x0043 len 5 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 2 pf 0 ilen 1 fcs 0x9a 
      2C 
> HCI Event: Number of Completed Packets (0x13) plen 5
  01 29 00 01 00 
> ACL data: handle 0x0029 flags 0x02 dlen 11
    L2CAP(d): cid 0x0040 len 7 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 2 pf 1 ilen 1 fcs 0x5c credits 1
      32 
< ACL data: handle 0x0029 flags 0x02 dlen 9
    L2CAP(d): cid 0x0043 len 5 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 2 pf 0 ilen 1 fcs 0x9a 
      22 
> ACL data: handle 0x0029 flags 0x02 dlen 11
    L2CAP(d): cid 0x0040 len 7 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 2 pf 1 ilen 1 fcs 0x5c credits 1
      2C 
> HCI Event: Number of Completed Packets (0x13) plen 5
  01 29 00 01 00 
< ACL data: handle 0x0029 flags 0x02 dlen 9
    L2CAP(d): cid 0x0043 len 5 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 2 pf 0 ilen 1 fcs 0x9a 
      49 
< ACL data: handle 0x0029 flags 0x02 dlen 9
    L2CAP(d): cid 0x0043 len 5 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 2 pf 0 ilen 1 fcs 0x9a 
      50 
> HCI Event: Number of Completed Packets (0x13) plen 5
  01 29 00 01 00 
> HCI Event: Number of Completed Packets (0x13) plen 5
  01 29 00 01 00 
< ACL data: handle 0x0029 flags 0x02 dlen 9
    L2CAP(d): cid 0x0043 len 5 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 2 pf 0 ilen 1 fcs 0x9a 
      22 
> ACL data: handle 0x0029 flags 0x02 dlen 11
    L2CAP(d): cid 0x0040 len 7 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 2 pf 1 ilen 1 fcs 0x5c credits 1
      22 
> HCI Event: Number of Completed Packets (0x13) plen 5
  01 29 00 01 00 
< ACL data: handle 0x0029 flags 0x02 dlen 9
    L2CAP(d): cid 0x0043 len 5 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 2 pf 0 ilen 1 fcs 0x9a 
      2C 
< ACL data: handle 0x0029 flags 0x02 dlen 9
    L2CAP(d): cid 0x0043 len 5 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 2 pf 0 ilen 1 fcs 0x9a 
      22 
> HCI Event: Number of Completed Packets (0x13) plen 5
  01 29 00 01 00 
> ACL data: handle 0x0029 flags 0x02 dlen 11
    L2CAP(d): cid 0x0040 len 7 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 2 pf 1 ilen 1 fcs 0x5c credits 3
      49 
> HCI Event: Number of Completed Packets (0x13) plen 5
  01 29 00 01 00 
> ACL data: handle 0x0029 flags 0x02 dlen 11
    L2CAP(d): cid 0x0040 len 7 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 2 pf 1 ilen 1 fcs 0x5c credits 0
      50 
< ACL data: handle 0x0029 flags 0x02 dlen 9
    L2CAP(d): cid 0x0043 len 5 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 2 pf 0 ilen 1 fcs 0x9a 
      69 
> ACL data: handle 0x0029 flags 0x02 dlen 11
    L2CAP(d): cid 0x0040 len 7 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 2 pf 1 ilen 1 fcs 0x5c credits 0
      22 
> ACL data: handle 0x0029 flags 0x02 dlen 11
    L2CAP(d): cid 0x0040 len 7 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 2 pf 1 ilen 1 fcs 0x5c credits 2
      2C 
> HCI Event: Number of Completed Packets (0x13) plen 5
  01 29 00 01 00 
> ACL data: handle 0x0029 flags 0x02 dlen 11
    L2CAP(d): cid 0x0040 len 7 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 2 pf 1 ilen 1 fcs 0x5c credits 0
      22 
< ACL data: handle 0x0029 flags 0x02 dlen 9
    L2CAP(d): cid 0x0043 len 5 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 2 pf 0 ilen 1 fcs 0x9a 
      6E 
> HCI Event: Number of Completed Packets (0x13) plen 5
  01 29 00 01 00 
> ACL data: handle 0x0029 flags 0x02 dlen 11
    L2CAP(d): cid 0x0040 len 7 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 2 pf 1 ilen 1 fcs 0x5c credits 1
      69 
< ACL data: handle 0x0029 flags 0x02 dlen 9
    L2CAP(d): cid 0x0043 len 5 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 2 pf 0 ilen 1 fcs 0x9a 
      74 
> ACL data: handle 0x0029 flags 0x02 dlen 11
    L2CAP(d): cid 0x0040 len 7 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 2 pf 1 ilen 1 fcs 0x5c credits 1
      6E 
> HCI Event: Number of Completed Packets (0x13) plen 5
  01 29 00 01 00 
< ACL data: handle 0x0029 flags 0x02 dlen 9
    L2CAP(d): cid 0x0043 len 5 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 2 pf 0 ilen 1 fcs 0x9a 
      65 
< ACL data: handle 0x0029 flags 0x02 dlen 9
    L2CAP(d): cid 0x0043 len 5 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 2 pf 0 ilen 1 fcs 0x9a 
      72 
> HCI Event: Number of Completed Packets (0x13) plen 5
  01 29 00 01 00 
> HCI Event: Number of Completed Packets (0x13) plen 5
  01 29 00 01 00 
> ACL data: handle 0x0029 flags 0x02 dlen 11
    L2CAP(d): cid 0x0040 len 7 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 2 pf 1 ilen 1 fcs 0x5c credits 1
      74 
< ACL data: handle 0x0029 flags 0x02 dlen 9
    L2CAP(d): cid 0x0043 len 5 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 2 pf 0 ilen 1 fcs 0x9a 
      6E 
> HCI Event: Number of Completed Packets (0x13) plen 5
  01 29 00 01 00 
> ACL data: handle 0x0029 flags 0x02 dlen 11
    L2CAP(d): cid 0x0040 len 7 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 2 pf 1 ilen 1 fcs 0x5c credits 2
      65 
< ACL data: handle 0x0029 flags 0x02 dlen 9
    L2CAP(d): cid 0x0043 len 5 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 2 pf 0 ilen 1 fcs 0x9a 
      65 
> ACL data: handle 0x0029 flags 0x02 dlen 11
    L2CAP(d): cid 0x0040 len 7 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 2 pf 1 ilen 1 fcs 0x5c credits 1
      72 
> HCI Event: Number of Completed Packets (0x13) plen 5
  01 29 00 01 00 
> ACL data: handle 0x0029 flags 0x02 dlen 11
    L2CAP(d): cid 0x0040 len 7 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 2 pf 1 ilen 1 fcs 0x5c credits 0
      6E 
< ACL data: handle 0x0029 flags 0x02 dlen 9
    L2CAP(d): cid 0x0043 len 5 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 2 pf 1 ilen 0 fcs 0x86 credits 30
< ACL data: handle 0x0029 flags 0x02 dlen 9
    L2CAP(d): cid 0x0043 len 5 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 2 pf 0 ilen 1 fcs 0x9a 
      74 
> HCI Event: Number of Completed Packets (0x13) plen 5
  01 29 00 01 00 
> ACL data: handle 0x0029 flags 0x02 dlen 11
    L2CAP(d): cid 0x0040 len 7 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 2 pf 1 ilen 1 fcs 0x5c credits 1
      65 
> HCI Event: Number of Completed Packets (0x13) plen 5
  01 29 00 01 00 
< ACL data: handle 0x0029 flags 0x02 dlen 9
    L2CAP(d): cid 0x0043 len 5 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 2 pf 0 ilen 1 fcs 0x9a 
      33 
> ACL data: handle 0x0029 flags 0x02 dlen 11
    L2CAP(d): cid 0x0040 len 7 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 2 pf 1 ilen 1 fcs 0x5c credits 1
      74 
> HCI Event: Number of Completed Packets (0x13) plen 5
  01 29 00 01 00 
< ACL data: handle 0x0029 flags 0x02 dlen 9
    L2CAP(d): cid 0x0043 len 5 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 2 pf 0 ilen 1 fcs 0x9a 
      2E 
< ACL data: handle 0x0029 flags 0x02 dlen 9
    L2CAP(d): cid 0x0043 len 5 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 2 pf 0 ilen 1 fcs 0x9a 
      76 
> HCI Event: Number of Completed Packets (0x13) plen 5
  01 29 00 01 00 
> HCI Event: Number of Completed Packets (0x13) plen 5
  01 29 00 01 00 
> ACL data: handle 0x0029 flags 0x02 dlen 11
    L2CAP(d): cid 0x0040 len 7 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 2 pf 1 ilen 1 fcs 0x5c credits 1
      33 
< ACL data: handle 0x0029 flags 0x02 dlen 9
    L2CAP(d): cid 0x0043 len 5 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 2 pf 0 ilen 1 fcs 0x9a 
      6F 
> HCI Event: Number of Completed Packets (0x13) plen 5
  01 29 00 01 00 
> ACL data: handle 0x0029 flags 0x02 dlen 11
    L2CAP(d): cid 0x0040 len 7 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 2 pf 1 ilen 1 fcs 0x5c credits 2
      2E 
< ACL data: handle 0x0029 flags 0x02 dlen 9
    L2CAP(d): cid 0x0043 len 5 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 2 pf 0 ilen 1 fcs 0x9a 
      69 
> ACL data: handle 0x0029 flags 0x02 dlen 11
    L2CAP(d): cid 0x0040 len 7 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 2 pf 1 ilen 1 fcs 0x5c credits 1
      76 
> HCI Event: Number of Completed Packets (0x13) plen 5
  01 29 00 01 00 
> ACL data: handle 0x0029 flags 0x02 dlen 11
    L2CAP(d): cid 0x0040 len 7 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 2 pf 1 ilen 1 fcs 0x5c credits 0
      6F 
< ACL data: handle 0x0029 flags 0x02 dlen 9
    L2CAP(d): cid 0x0043 len 5 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 2 pf 0 ilen 1 fcs 0x9a 
      63 
> HCI Event: Number of Completed Packets (0x13) plen 5
  01 29 00 01 00 
> ACL data: handle 0x0029 flags 0x02 dlen 11
    L2CAP(d): cid 0x0040 len 7 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 2 pf 1 ilen 1 fcs 0x5c credits 1
      69 
< ACL data: handle 0x0029 flags 0x02 dlen 9
    L2CAP(d): cid 0x0043 len 5 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 2 pf 0 ilen 1 fcs 0x9a 
      65 
> ACL data: handle 0x0029 flags 0x02 dlen 11
    L2CAP(d): cid 0x0040 len 7 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 2 pf 1 ilen 1 fcs 0x5c credits 1
      63 
> HCI Event: Number of Completed Packets (0x13) plen 5
  01 29 00 01 00 
< ACL data: handle 0x0029 flags 0x02 dlen 9
    L2CAP(d): cid 0x0043 len 5 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 2 pf 0 ilen 1 fcs 0x9a 
      73 
< ACL data: handle 0x0029 flags 0x02 dlen 9
    L2CAP(d): cid 0x0043 len 5 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 2 pf 0 ilen 1 fcs 0x9a 
      74 
> HCI Event: Number of Completed Packets (0x13) plen 5
  01 29 00 01 00 
> HCI Event: Number of Completed Packets (0x13) plen 5
  01 29 00 01 00 
> ACL data: handle 0x0029 flags 0x02 dlen 11
    L2CAP(d): cid 0x0040 len 7 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 2 pf 1 ilen 1 fcs 0x5c credits 1
      65 
< ACL data: handle 0x0029 flags 0x02 dlen 9
    L2CAP(d): cid 0x0043 len 5 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 2 pf 0 ilen 1 fcs 0x9a 
      72 
> HCI Event: Number of Completed Packets (0x13) plen 5
  01 29 00 01 00 
> ACL data: handle 0x0029 flags 0x02 dlen 11
    L2CAP(d): cid 0x0040 len 7 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 2 pf 1 ilen 1 fcs 0x5c credits 2
      73 
< ACL data: handle 0x0029 flags 0x02 dlen 9
    L2CAP(d): cid 0x0043 len 5 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 2 pf 0 ilen 1 fcs 0x9a 
      65 
> ACL data: handle 0x0029 flags 0x02 dlen 11
    L2CAP(d): cid 0x0040 len 7 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 2 pf 1 ilen 1 fcs 0x5c credits 1
      74 
> HCI Event: Number of Completed Packets (0x13) plen 5
  01 29 00 01 00 
> ACL data: handle 0x0029 flags 0x02 dlen 11
    L2CAP(d): cid 0x0040 len 7 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 2 pf 1 ilen 1 fcs 0x5c credits 0
      72 
< ACL data: handle 0x0029 flags 0x02 dlen 9
    L2CAP(d): cid 0x0043 len 5 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 2 pf 0 ilen 1 fcs 0x9a 
      61 
> ACL data: handle 0x0029 flags 0x02 dlen 11
    L2CAP(d): cid 0x0040 len 7 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 2 pf 1 ilen 1 fcs 0x5c credits 1
      65 
> HCI Event: Number of Completed Packets (0x13) plen 5
  01 29 00 01 00 
< ACL data: handle 0x0029 flags 0x02 dlen 9
    L2CAP(d): cid 0x0043 len 5 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 2 pf 0 ilen 1 fcs 0x9a 
      6D 
< ACL data: handle 0x0029 flags 0x02 dlen 9
    L2CAP(d): cid 0x0043 len 5 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 2 pf 0 ilen 1 fcs 0x9a 
      2E 
> HCI Event: Number of Completed Packets (0x13) plen 5
  01 29 00 01 00 
> HCI Event: Number of Completed Packets (0x13) plen 5
  01 29 00 01 00 
> ACL data: handle 0x0029 flags 0x02 dlen 11
    L2CAP(d): cid 0x0040 len 7 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 2 pf 1 ilen 1 fcs 0x5c credits 1
      61 
< ACL data: handle 0x0029 flags 0x02 dlen 9
    L2CAP(d): cid 0x0043 len 5 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 2 pf 0 ilen 1 fcs 0x9a 
      63 
> HCI Event: Number of Completed Packets (0x13) plen 5
  01 29 00 01 00 
> ACL data: handle 0x0029 flags 0x02 dlen 11
    L2CAP(d): cid 0x0040 len 7 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 2 pf 1 ilen 1 fcs 0x5c credits 2
      6D 
< ACL data: handle 0x0029 flags 0x02 dlen 9
    L2CAP(d): cid 0x0043 len 5 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 2 pf 0 ilen 1 fcs 0x9a 
      6F 
> ACL data: handle 0x0029 flags 0x02 dlen 11
    L2CAP(d): cid 0x0040 len 7 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 2 pf 1 ilen 1 fcs 0x5c credits 1
      2E 
> HCI Event: Number of Completed Packets (0x13) plen 5
  01 29 00 01 00 
> ACL data: handle 0x0029 flags 0x02 dlen 11
    L2CAP(d): cid 0x0040 len 7 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 2 pf 1 ilen 1 fcs 0x5c credits 0
      63 
< ACL data: handle 0x0029 flags 0x02 dlen 9
    L2CAP(d): cid 0x0043 len 5 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 2 pf 0 ilen 1 fcs 0x9a 
      6D 
> ACL data: handle 0x0029 flags 0x02 dlen 11
    L2CAP(d): cid 0x0040 len 7 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 2 pf 1 ilen 1 fcs 0x5c credits 1
      6F 
> HCI Event: Number of Completed Packets (0x13) plen 5
  01 29 00 01 00 
< ACL data: handle 0x0029 flags 0x02 dlen 9
    L2CAP(d): cid 0x0043 len 5 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 2 pf 0 ilen 1 fcs 0x9a 
      22 
< ACL data: handle 0x0029 flags 0x02 dlen 9
    L2CAP(d): cid 0x0043 len 5 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 2 pf 0 ilen 1 fcs 0x9a 
      0D 
> HCI Event: Number of Completed Packets (0x13) plen 5
  01 29 00 01 00 
> HCI Event: Number of Completed Packets (0x13) plen 5
  01 29 00 01 00 
> ACL data: handle 0x0029 flags 0x02 dlen 11
    L2CAP(d): cid 0x0040 len 7 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 2 pf 1 ilen 1 fcs 0x5c credits 1
      6D 
> ACL data: handle 0x0029 flags 0x02 dlen 11
    L2CAP(d): cid 0x0040 len 7 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 2 pf 1 ilen 1 fcs 0x5c credits 2
      22 
> ACL data: handle 0x0029 flags 0x02 dlen 11
    L2CAP(d): cid 0x0040 len 7 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 2 pf 1 ilen 1 fcs 0x5c credits 0
      0D 
> ACL data: handle 0x0029 flags 0x02 dlen 16
    L2CAP(d): cid 0x0040 len 12 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 2 pf 1 ilen 6 fcs 0x5c credits 0
      0D 0A 4F 4B 0D 0A 
< ACL data: handle 0x0029 flags 0x02 dlen 9
    L2CAP(d): cid 0x0043 len 5 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 2 pf 0 ilen 1 fcs 0x9a 
      41 
< ACL data: handle 0x0029 flags 0x02 dlen 9
    L2CAP(d): cid 0x0043 len 5 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 2 pf 0 ilen 1 fcs 0x9a 
      54 
> HCI Event: Number of Completed Packets (0x13) plen 5
  01 29 00 01 00 
> HCI Event: Number of Completed Packets (0x13) plen 5
  01 29 00 01 00 
< ACL data: handle 0x0029 flags 0x02 dlen 9
    L2CAP(d): cid 0x0043 len 5 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 2 pf 0 ilen 1 fcs 0x9a 
      44 
< ACL data: handle 0x0029 flags 0x02 dlen 9
    L2CAP(d): cid 0x0043 len 5 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 2 pf 0 ilen 1 fcs 0x9a 
      2A 
> HCI Event: Number of Completed Packets (0x13) plen 5
  01 29 00 01 00 
> ACL data: handle 0x0029 flags 0x02 dlen 11
    L2CAP(d): cid 0x0040 len 7 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 2 pf 1 ilen 1 fcs 0x5c credits 1
      41 
> HCI Event: Number of Completed Packets (0x13) plen 5
  01 29 00 01 00 
> ACL data: handle 0x0029 flags 0x02 dlen 11
    L2CAP(d): cid 0x0040 len 7 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 2 pf 1 ilen 1 fcs 0x5c credits 1
      54 
< ACL data: handle 0x0029 flags 0x02 dlen 9
    L2CAP(d): cid 0x0043 len 5 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 2 pf 0 ilen 1 fcs 0x9a 
      39 
> HCI Event: Number of Completed Packets (0x13) plen 5
  01 29 00 01 00 
> ACL data: handle 0x0029 flags 0x02 dlen 11
    L2CAP(d): cid 0x0040 len 7 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 2 pf 1 ilen 1 fcs 0x5c credits 2
      44 
> ACL data: handle 0x0029 flags 0x02 dlen 11
    L2CAP(d): cid 0x0040 len 7 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 2 pf 1 ilen 1 fcs 0x5c credits 0
      2A 
< ACL data: handle 0x0029 flags 0x02 dlen 9
    L2CAP(d): cid 0x0043 len 5 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 2 pf 0 ilen 1 fcs 0x9a 
      38 
> HCI Event: Number of Completed Packets (0x13) plen 5
  01 29 00 01 00 
> ACL data: handle 0x0029 flags 0x02 dlen 11
    L2CAP(d): cid 0x0040 len 7 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 2 pf 1 ilen 1 fcs 0x5c credits 1
      39 
< ACL data: handle 0x0029 flags 0x02 dlen 9
    L2CAP(d): cid 0x0043 len 5 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 2 pf 0 ilen 1 fcs 0x9a 
      2A 
> HCI Event: Number of Completed Packets (0x13) plen 5
  01 29 00 01 00 
> ACL data: handle 0x0029 flags 0x02 dlen 11
    L2CAP(d): cid 0x0040 len 7 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 2 pf 1 ilen 1 fcs 0x5c credits 1
      38 
< ACL data: handle 0x0029 flags 0x02 dlen 9
    L2CAP(d): cid 0x0043 len 5 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 2 pf 0 ilen 1 fcs 0x9a 
      39 
> ACL data: handle 0x0029 flags 0x02 dlen 11
    L2CAP(d): cid 0x0040 len 7 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 2 pf 1 ilen 1 fcs 0x5c credits 1
      2A 
> HCI Event: Number of Completed Packets (0x13) plen 5
  01 29 00 01 00 
< ACL data: handle 0x0029 flags 0x02 dlen 9
    L2CAP(d): cid 0x0043 len 5 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 2 pf 0 ilen 1 fcs 0x9a 
      23 
< ACL data: handle 0x0029 flags 0x02 dlen 9
    L2CAP(d): cid 0x0043 len 5 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 2 pf 0 ilen 1 fcs 0x9a 
      0D 
> HCI Event: Number of Completed Packets (0x13) plen 5
  01 29 00 01 00 
> HCI Event: Number of Completed Packets (0x13) plen 5
  01 29 00 01 00 
> ACL data: handle 0x0029 flags 0x02 dlen 11
    L2CAP(d): cid 0x0040 len 7 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 2 pf 1 ilen 1 fcs 0x5c credits 1
      39 
< ACL data: handle 0x0029 flags 0x02 dlen 9
    L2CAP(d): cid 0x0043 len 5 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 2 pf 1 ilen 0 fcs 0x86 credits 30
> HCI Event: Number of Completed Packets (0x13) plen 5
  01 29 00 01 00 
> ACL data: handle 0x0029 flags 0x02 dlen 11
    L2CAP(d): cid 0x0040 len 7 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 2 pf 1 ilen 1 fcs 0x5c credits 2
      23 
> ACL data: handle 0x0029 flags 0x02 dlen 11
    L2CAP(d): cid 0x0040 len 7 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 2 pf 1 ilen 1 fcs 0x5c credits 0
      0D 
> ACL data: handle 0x0029 flags 0x02 dlen 17
> ACL data: handle 0x0029 flags 0x01 dlen 4
    L2CAP(d): cid 0x0040 len 17 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 2 pf 1 ilen 11 fcs 0x5c credits 0
      0D 0A 43 4F 4E 4E 45 43 54 0D 0A 
> ACL data: handle 0x0029 flags 0x02 dlen 13
    L2CAP(d): cid 0x0040 len 9 [psm 3]
      RFCOMM(s): MSC CMD: cr 0 dlci 0 pf 0 ilen 4 fcs 0xaa mcc_len 2
      dlci 2 fc 0 rtc 1 rtr 1 ic 0 dv 1 b1 0 b2 0 b3 0 len 5
< ACL data: handle 0x0029 flags 0x02 dlen 12
    L2CAP(d): cid 0x0043 len 8 [psm 3]
      RFCOMM(s): MSC RSP: cr 1 dlci 0 pf 0 ilen 4 fcs 0x70 mcc_len 2
      dlci 2 fc 0 rtc 1 rtr 1 ic 0 dv 1 b1 1 b2 0 b3 0 len 4
> ACL data: handle 0x0029 flags 0x02 dlen 9
    L2CAP(d): cid 0x0040 len 5 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 2 pf 1 ilen 0 fcs 0x5c credits 0
> HCI Event: Number of Completed Packets (0x13) plen 5
  01 29 00 01 00 
< ACL data: handle 0x0029 flags 0x02 dlen 9
    L2CAP(d): cid 0x0043 len 5 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 2 pf 0 ilen 1 fcs 0x9a 
      0D 
< ACL data: handle 0x0029 flags 0x02 dlen 12
    L2CAP(d): cid 0x0043 len 8 [psm 3]
      RFCOMM(s): MSC CMD: cr 1 dlci 0 pf 0 ilen 4 fcs 0x70 mcc_len 2
      dlci 2 fc 0 rtc 1 rtr 1 ic 0 dv 1 b1 1 b2 0 b3 0 len 4
> HCI Event: Number of Completed Packets (0x13) plen 5
  01 29 00 01 00 
> HCI Event: Number of Completed Packets (0x13) plen 5
  01 29 00 01 00 
> ACL data: handle 0x0029 flags 0x02 dlen 13
    L2CAP(d): cid 0x0040 len 9 [psm 3]
      RFCOMM(s): MSC RSP: cr 0 dlci 0 pf 0 ilen 4 fcs 0xaa mcc_len 2
      dlci 2 fc 0 rtc 1 rtr 1 ic 0 dv 1 b1 0 b2 0 b3 0 len 5

--------------000208020107010609020803--


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
