Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <7aa80ced050726074418daf874@mail.gmail.com>
From: Mohan K <kmohangda@gmail.com>
To: bluez-users@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Subject: [Bluez-users] Xandros linux - rfcomm not working
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
Date: Tue, 26 Jul 2005 07:44:50 -0700

Hi everyone,
I am using Xandros linux distribution in my via motherboard PC.

I have installed the bluez stack.
In that "hcitool scan is working. But when i try to connect with the
remote device using "rfcomm connect 0 <BDADDR> 1", it fails with
following message.
#rfcomm connect 0 00:80:25:02:00:35 1
Can't connect RFCOMM socket: Connection refused

The following is the hcidump:

# hcidump -x
HCI sniffer - Bluetooth packet analyzer ver 1.21
device: hci0 snap_len: 1028 filter: 0xffffffff
< HCI Command: Create Connection (0x01|0x0005) plen 13
    bdaddr 00:80:25:02:00:35 ptype 0xcc18 rswitch 0x01 clkoffset 0x0000
    Packet type: DM1 DM3 DM5 DH1 DH3 DH5
> HCI Event: Command Status (0x0f) plen 4
  00 01 05 04
> HCI Event: Connect Complete (0x03) plen 11
  00 28 00 35 00 02 25 80 00 01 00
< ACL data: handle 40 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 3 scid 0x0040
< HCI Command: Write Link Policy Settings (0x02|0x000d) plen 4
    handle 40 policy 0x0f
    Link policy: RSWITCH HOLD SNIFF PARK
> HCI Event: Number of Completed Packets (0x13) plen 5
  01 28 00 01 00
> HCI Event: Command Complete (0x0e) plen 6
  01 0D 08 00 28 00
> HCI Event: Max Slots Change (0x1b) plen 3
  28 00 05
> ACL data: handle 40 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0043 scid 0x0040 result 0 status 0
      Connection successful
< ACL data: handle 40 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0043 flags 0x00 clen 4
      MTU 1024
> HCI Event: Number of Completed Packets (0x13) plen 5
  01 28 00 01 00
> ACL data: handle 40 flags 0x02 dlen 18
    L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 4
      Success
      MTU 335
> ACL data: handle 40 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 4
      MTU 335
< ACL data: handle 40 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0043 flags 0x00 result 0 clen 0
      Success
< ACL data: handle 40 flags 0x02 dlen 8
    L2CAP(d): cid 0x0043 len 4 [psm 3]
      RFCOMM(s): SABM: cr 1 dlci 0 pf 1 ilen 0 fcs 0x1c
> HCI Event: Number of Completed Packets (0x13) plen 5
  01 28 00 01 00
> HCI Event: Number of Completed Packets (0x13) plen 5
  01 28 00 01 00
> HCI Event: Link Key Request (0x17) plen 6
  35 00 02 25 80 00
< HCI Command: Link Key Request Negative Reply (0x01|0x000c) plen 6
    bdaddr 00:80:25:02:00:35
> HCI Event: Command Complete (0x0e) plen 10
  01 0C 04 00 35 00 02 25 80 00
> HCI Event: PIN Code Request (0x16) plen 6
  35 00 02 25 80 00
< HCI Command: PIN Code Request Negative Reply (0x01|0x000e) plen 6
    bdaddr 00:80:25:02:00:35
> HCI Event: Command Complete (0x0e) plen 10
  01 0E 04 00 35 00 02 25 80 00
> ACL data: handle 40 flags 0x02 dlen 8
    L2CAP(d): cid 0x0040 len 4 [psm 3]
      RFCOMM(s): DM: cr 1 dlci 0 pf 1 ilen 0 fcs 0x36
< ACL data: handle 40 flags 0x02 dlen 12
    L2CAP(s): Disconn req: dcid 0x0043 scid 0x0040
> ACL data: handle 40 flags 0x02 dlen 12
    L2CAP(s): Disconn req: dcid 0x0040 scid 0x0043
< ACL data: handle 40 flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x0040 scid 0x0043
> HCI Event: Number of Completed Packets (0x13) plen 5
  01 28 00 01 00
> HCI Event: Number of Completed Packets (0x13) plen 5
  01 28 00 01 00
> ACL data: handle 40 flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x0043 scid 0x0040
> HCI Event: Disconn Complete (0x05) plen 4
  00 28 00 13

Can anyone tell me why this is happening? Advanced thanks.

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
