Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: [Fwd: [Bluez-users] p3nfs drops connection]
From: Dominik Blystak <Dominik.Blystak@pro-open.de>
To: bluez-users@lists.sourceforge.net
Content-Type: text/plain
Message-Id: <1090592384.2281.7.camel@localhost>
Mime-Version: 1.0
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
Date: Fri, 23 Jul 2004 16:19:53 +0200


Hi, 

after a talk with the developer of p3nfs I found the reason the trouble.
If you want to use p3nfsd you need nfs support compiled into the kernel.

Greets
Dominik Blystak



-----Forwarded Message-----
From: Dominik Blystak <Dominik.Blystak@pro-open.de>
To: bluez-users@lists.sourceforge.net
Subject: [Bluez-users] p3nfs drops connection
Date: Thu, 22 Jul 2004 23:10:34 +0200

Hi,

I hope nobody gets offended that I'm writing with an p3nfs issue to the
bluez-users list, but I believe that somebody around here might have
some experience with that tool and is willing to help a blueZ newbie ;)

The problem is, that my Siemens SX1 drops every p3nfs connection attemp.
As described in the manual I'm bringing up BT and the nfsclient on the
phone. Then I type:

#rfcomm bind 0 00:01:E3:2E:91:81 11
#p3nfsd -series60 -tty /dev/rfcomm0 -dir /mnt/sx1

The phone reacts with a message ("do you wish to allow this connec..")
and after pushing the "ok" button the connection drops.
The phone's lcd shows at first, "OK" and then "Connection closed
(-2147483647)"

At the terminal I get this output:

> p3nfsd: version 5.15, using /dev/rfcomm0 (115200), mounting on
/mnt/sx1
> p3nfsd: to stop the server do "ls /mnt/sx1/exit". (pid 2361)
> nfs mount /mnt/sx1: (errno 19) No such device

I put an hcidump (see bottom) on that problem to get further information
but im unexperienced in blueZ and I don't know what to do.



Thanks a lot

Dominik Blystak



#hcidump
HCIDump - HCI packet analyzer ver 1.5
device: hci0 snap_len: 1028 filter: 0xffffffff
< HCI Command: Create Connection(0x01|0x0005) plen 13
> HCI Event: Command Status(0x0f) plen 4
> HCI Event: Connect Complete(0x03) plen 11
< ACL data: handle 0x0028 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 3 scid 0x0040
< HCI Command: Write Link Policy Settings(0x02|0x000d) plen 4
> HCI Event: Number of Completed Packets(0x13) plen 5
> HCI Event: Command Complete(0x0e) plen 6
> HCI Event: Max Slots Change(0x1b) plen 3
> ACL data: handle 0x0028 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x004f scid 0x0040 result 1 status 2
> ACL data: handle 0x0028 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x004f scid 0x0040 result 0 status 0
< ACL data: handle 0x0028 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x004f flags 0x0000 clen 4
    MTU 1024
> HCI Event: Number of Completed Packets(0x13) plen 5
> ACL data: handle 0x0028 flags 0x02 dlen 12
    L2CAP(s): Config req: dcid 0x0040 flags 0x0000 clen 0
< ACL data: handle 0x0028 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x004f flags 0x0000 result 0 clen 0
> HCI Event: Number of Completed Packets(0x13) plen 5
> ACL data: handle 0x0028 flags 0x02 dlen 18
    L2CAP(s): Config rsp: scid 0x0040 flags 0x0000 result 0 clen 4
    MTU 672
< ACL data: handle 0x0028 flags 0x02 dlen 8
    L2CAP(d): cid 0x4f len 4 [psm 3]
      RFCOMM(s): SABM: cr 1 dlci 0 pf 1 ilen 0 fcs 0x1c
> HCI Event: Number of Completed Packets(0x13) plen 5
> ACL data: handle 0x0028 flags 0x02 dlen 8
    L2CAP(d): cid 0x40 len 4 [psm 3]
      RFCOMM(s): UA: cr 1 dlci 0 pf 1 ilen 0 fcs 0xd7
< ACL data: handle 0x0028 flags 0x02 dlen 18
    L2CAP(d): cid 0x4f len 14 [psm 3]
      RFCOMM(s): PN CMD: cr 1 dlci 0 pf 0 ilen 10 fcs 0x70 mcc_len 8
      dlci 22 frame_type 0 credit_flow 15 pri 7 ack_timer 0 frame_size
667 max_retrans 0 credits 7
> HCI Event: Number of Completed Packets(0x13) plen 5
> ACL data: handle 0x0028 flags 0x02 dlen 18
    L2CAP(d): cid 0x40 len 14 [psm 3]
      RFCOMM(s): PN RSP: cr 0 dlci 0 pf 0 ilen 10 fcs 0xaa mcc_len 8
      dlci 22 frame_type 0 credit_flow 14 pri 7 ack_timer 0 frame_size
667 max_retrans 0 credits 3
< ACL data: handle 0x0028 flags 0x02 dlen 8
    L2CAP(d): cid 0x4f len 4 [psm 3]
      RFCOMM(s): SABM: cr 1 dlci 22 pf 1 ilen 0 fcs 0xb8
> HCI Event: Number of Completed Packets(0x13) plen 5
> ACL data: handle 0x0028 flags 0x02 dlen 8
    L2CAP(d): cid 0x40 len 4 [psm 3]
      RFCOMM(s): UA: cr 1 dlci 22 pf 1 ilen 0 fcs 0x73
< ACL data: handle 0x0028 flags 0x02 dlen 12
    L2CAP(d): cid 0x4f len 8 [psm 3]
      RFCOMM(s): MSC CMD: cr 1 dlci 0 pf 0 ilen 4 fcs 0x70 mcc_len 2
      dlci 22 fc 0 rtc 1 rtr 1 ic 0 dv 1 b1 1 b2 0 b3 0 len 0
< ACL data: handle 0x0028 flags 0x02 dlen 8
    L2CAP(d): cid 0x4f len 4 [psm 3]
      RFCOMM(s): DISC: cr 1 dlci 22 pf 1 ilen 0 fcs 0x59
> HCI Event: Number of Completed Packets(0x13) plen 5
> ACL data: handle 0x0028 flags 0x02 dlen 12
    L2CAP(d): cid 0x40 len 8 [psm 3]
      RFCOMM(s): MSC CMD: cr 0 dlci 0 pf 0 ilen 4 fcs 0xaa mcc_len 2
      dlci 22 fc 0 rtc 1 rtr 1 ic 0 dv 1 b1 1 b2 0 b3 0 len 0
< ACL data: handle 0x0028 flags 0x02 dlen 12
    L2CAP(d): cid 0x4f len 8 [psm 3]
      RFCOMM(s): MSC RSP: cr 1 dlci 0 pf 0 ilen 4 fcs 0x70 mcc_len 2
      dlci 22 fc 0 rtc 1 rtr 1 ic 0 dv 1 b1 1 b2 0 b3 0 len 0
> HCI Event: Number of Completed Packets(0x13) plen 5
> HCI Event: Number of Completed Packets(0x13) plen 5
> ACL data: handle 0x0028 flags 0x02 dlen 8
    L2CAP(d): cid 0x40 len 4 [psm 3]
      RFCOMM(s): UA: cr 1 dlci 22 pf 1 ilen 0 fcs 0x73
< ACL data: handle 0x0028 flags 0x02 dlen 8
    L2CAP(d): cid 0x4f len 4 [psm 3]
      RFCOMM(s): DISC: cr 1 dlci 0 pf 1 ilen 0 fcs 0xfd
< ACL data: handle 0x0028 flags 0x02 dlen 12
    L2CAP(s): Disconn req: dcid 0x004f scid 0x0040
> HCI Event: Number of Completed Packets(0x13) plen 5
> HCI Event: Number of Completed Packets(0x13) plen 5
> ACL data: handle 0x0028 flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x004f scid 0x0040
< HCI Command: Disconnect(0x01|0x0006) plen 3
> HCI Event: Command Status(0x0f) plen 4
> HCI Event: Disconn Complete(0x05) plen 4




-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users




-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
