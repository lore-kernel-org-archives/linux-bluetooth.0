Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <7aa80ced0506150032765db782@mail.gmail.com>
From: Mohan K <kmohangda@gmail.com>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <7aa80ced05061005101877c45b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <7aa80ced05061005101877c45b@mail.gmail.com>
Subject: [Bluez-users] rfcomm connect problem-help me please
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
Date: Wed, 15 Jun 2005 13:02:45 +0530

Hi all,
       Again i am resending the same mail, since i have no idea to
proceed forward.
Can anyone help me to solve this problem, please?

Thanks & Regards,
Mohan

---------- Forwarded message ----------
From: Mohan K <kmohangda@gmail.com>
Date: Jun 10, 2005 5:40 PM
Subject: rfcomm connect problem
To: bluez-users@lists.sourceforge.net


Hi Everyone,
                I am using two PC's, one consist of VIA mother board
and another one consist of Intel chipset mother board. I am having one
dongle of CSR chipset. In both PC's I installed Bluez(2.17).
               First, I plugged the usb bluetooth dongle to VIA PC
and i used "rfcomm connect 0 <BDADDR> 1". It get connected and worked
fine. Then, I plugged the same dongle in the Intel chipset PC and used
"rfcomm connect 0 <BDADDR> 1". This is also working fine.
               Again I did the First step. But now "rfcomm connect 0
<BDADDR> 1" fails with the following message:

Can't connect RFCOMM socket: Connection refused

At this time i am getting the following hcidump:

[root@localhost]# hcidump -x
HCI sniffer - Bluetooth packet analyzer ver 1.21
device: hci0 snap_len: 1028 filter: 0xffffffff
< HCI Command: Create Connection (0x01|0x0005)
plen 13
  bdaddr 00:80:25:02:02:69 ptype 0xcc18 rswitch
0x01 clkoffset 0x1cb8 (valid)
  Packet type: DM1 DM3 DM5 DH1 DH3 DH5
> HCI Event: Command Status (0x0f) plen 4
 00 01 05 04
> HCI Event: Connect Complete (0x03) plen 11
 00 29 00 69 02 02 25 80 00 01 00
< ACL data: handle 41 flags 0x02 dlen 12
  L2CAP(s): Connect req: psm 3 scid 0x0040
< HCI Command: Write Link Policy Settings
(0x02|0x000d) plen 4
  handle 41 policy 0x0f
  Link policy: RSWITCH HOLD SNIFF PARK
> HCI Event: Number of Completed Packets (0x13)
plen 5
 01 29 00 01 00
> HCI Event: Command Complete (0x0e) plen 6
 01 0D 08 00 29 00
> HCI Event: Max Slots Change (0x1b) plen 3
 29 00 05
> ACL data: handle 41 flags 0x02 dlen 16
  L2CAP(s): Connect rsp: dcid 0x0052 scid
0x0040 result 0 status 0
    Connection successful
< ACL data: handle 41 flags 0x02 dlen 16
  L2CAP(s): Config req: dcid 0x0052 flags 0x00
clen 4
    MTU 1024
> HCI Event: Number of Completed Packets (0x13)
plen 5
 01 29 00 01 00
> ACL data: handle 41 flags 0x02 dlen 18
  L2CAP(s): Config rsp: scid 0x0040 flags 0x00
result 0 clen 4
    Success
    MTU 335
> ACL data: handle 41 flags 0x02 dlen 16
  L2CAP(s): Config req: dcid 0x0040 flags 0x00
clen 4
    MTU 335
< ACL data: handle 41 flags 0x02 dlen 14
  L2CAP(s): Config rsp: scid 0x0052 flags 0x00
result 0 clen 0
    Success
< ACL data: handle 41 flags 0x02 dlen 8
  L2CAP(d): cid 0x0052 len 4 [psm 3]
    RFCOMM(s): SABM: cr 1 dlci 0 pf 1 ilen 0
fcs 0x1c
> HCI Event: Number of Completed Packets (0x13)
plen 5
 01 29 00 01 00
> HCI Event: Number of Completed Packets (0x13)
plen 5
 01 29 00 01 00
> HCI Event: Link Key Request (0x17) plen 6
 69 02 02 25 80 00
< HCI Command: Link Key Request Reply
(0x01|0x000b) plen 22
  bdaddr 00:80:25:02:02:69 key
4BA5C9668C9B95F6134A074382BE737F
> HCI Event: Command Complete (0x0e) plen 10
 01 0B 04 00 69 02 02 25 80 00
> ACL data: handle 41 flags 0x02 dlen 8
  L2CAP(d): cid 0x0040 len 4 [psm 3]
    RFCOMM(s): DM: cr 1 dlci 0 pf 1 ilen 0 fcs
0x36
< ACL data: handle 41 flags 0x02 dlen 12
  L2CAP(s): Disconn req: dcid 0x0052 scid
0x0040
> ACL data: handle 41 flags 0x02 dlen 12
  L2CAP(s): Disconn req: dcid 0x0040 scid
0x0052
< ACL data: handle 41 flags 0x02 dlen 12
  L2CAP(s): Disconn rsp: dcid 0x0040 scid
0x0052
> HCI Event: Number of Completed Packets (0x13)
plen 5
 01 29 00 01 00
> HCI Event: Number of Completed Packets (0x13)
plen 5
 01 29 00 01 00
> ACL data: handle 41 flags 0x02 dlen 12
  L2CAP(s): Disconn rsp: dcid 0x0052 scid
0x0040
> HCI Event: Disconn Complete (0x05) plen 4
 00 29 00 13
Can any one tell me why this is happenning?
Advanced thanks for your valuable suggestions

Thanks & Regards,
Mohan


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
