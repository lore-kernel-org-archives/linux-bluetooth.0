Return-Path: <bluez-users-admin@lists.sourceforge.net>
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] problems using rfcomm device
References: <87r7mqidhb.fsf@khaberz.net> <1100861511.7213.0.camel@pegasus>
	<87is82hzp6.fsf@khaberz.net> <1100862575.7213.6.camel@pegasus>
	<87ekiqyqx4.fsf@khaberz.net>
From: Kai Haberzettl <kai@khaberz.net>
In-Reply-To: <87ekiqyqx4.fsf@khaberz.net> (Kai Haberzettl's message of "Fri,
 19 Nov 2004 13:16:55 +0100")
Message-ID: <871xepoit6.fsf@khaberz.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
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
Date: Fri, 19 Nov 2004 18:22:13 +0100

Kai Haberzettl <kai@khaberz.net> writes:

> That was it. Thanks a lot!

Well. Almost. I got further. The PIN authentication worked and the key
is saved in /etc/bluetooth. However, minicom and pppd still don't
quite work. Here's what I get from minicom:

arthur:/home/khaberz# minicom
minicom: cannot open /dev/rfcomm0: No such file or directory

It's there of course:

arthur:/home/khaberz# ls -l /dev/rfcomm0
crw-rw----  1 root dialout 216, 0 Nov 18 19:48 /dev/rfcomm0

This is in the syslog:

Nov 19 18:11:38 arthur kernel: hci_cmd_task: hci0 command tx timeout

The output of hcidump -X while starting minicom is attached.

Thanks!
Kai

===File ~/bluez.txt=========================================
HCIDump - HCI packet analyzer ver 1.12
device: hci0 snap_len: 1028 filter: 0xffffffff
< HCI Command: Create Connection (0x01|0x0005) plen 13
  0000: fa 44 56 6d 0e 00 18 cc  02 00 00 00 01           .DVm.........
> HCI Event: Command Status (0x0f) plen 4
  0000: 00 01 05 04                                       ....
> HCI Event: Connect Complete (0x03) plen 11
  0000: 00 29 00 fa 44 56 6d 0e  00 01 00                 .)..DVm....
< ACL data: handle 0x0029 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 3 scid 0x0040
< HCI Command: Write Link Policy Settings (0x02|0x000d) plen 4
  0000: 29 00 0f 00                                       )...
> HCI Event: Number of Completed Packets (0x13) plen 5
  0000: 01 29 00 01 00                                    .)...
> HCI Event: Command Complete (0x0e) plen 6
  0000: 01 0d 08 00 29 00                                 ....).
> HCI Event: Max Slots Change (0x1b) plen 3
  0000: 29 00 05                                          )..
> ACL data: handle 0x0029 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0085 scid 0x0040 result 1 status 2
> ACL data: handle 0x0029 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0085 scid 0x0040 result 0 status 0
< ACL data: handle 0x0029 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0085 flags 0x0000 clen 4
    MTU 1024 
> HCI Event: QoS Setup Complete (0x0d) plen 21
  0000: 00 29 00 00 01 00 00 00  00 00 00 00 00 88 13 00  .)..............
  0010: 00 ff ff ff ff                                    .....
> ACL data: handle 0x0029 flags 0x02 dlen 12
    L2CAP(s): Config req: dcid 0x0040 flags 0x0000 clen 0
< ACL data: handle 0x0029 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0085 flags 0x0000 result 0 clen 0
> HCI Event: Number of Completed Packets (0x13) plen 5
  0000: 01 29 00 01 00                                    .)...
> HCI Event: Number of Completed Packets (0x13) plen 5
  0000: 01 29 00 01 00                                    .)...
> ACL data: handle 0x0029 flags 0x02 dlen 18
    L2CAP(s): Config rsp: scid 0x0040 flags 0x0000 result 0 clen 4
    MTU 672 
< ACL data: handle 0x0029 flags 0x02 dlen 8
    L2CAP(d): cid 0x0085 len 4 [psm 3]
      RFCOMM(s): SABM: cr 1 dlci 0 pf 1 ilen 0 fcs 0x1c 
> HCI Event: Number of Completed Packets (0x13) plen 5
  0000: 01 29 00 01 00                                    .)...
> ACL data: handle 0x0029 flags 0x02 dlen 8
    L2CAP(d): cid 0x0040 len 4 [psm 3]
      RFCOMM(s): UA: cr 1 dlci 0 pf 1 ilen 0 fcs 0xd7 
< ACL data: handle 0x0029 flags 0x02 dlen 18
    L2CAP(d): cid 0x0085 len 14 [psm 3]
      RFCOMM(s): PN CMD: cr 1 dlci 0 pf 0 ilen 10 fcs 0x70 mcc_len 8
      dlci 2 frame_type 0 credit_flow 15 pri 7 ack_timer 0
      frame_size 667 max_retrans 0 credits 7
> HCI Event: Number of Completed Packets (0x13) plen 5
  0000: 01 29 00 01 00                                    .)...
> ACL data: handle 0x0029 flags 0x02 dlen 18
    L2CAP(d): cid 0x0040 len 14 [psm 3]
      RFCOMM(s): PN RSP: cr 0 dlci 0 pf 0 ilen 10 fcs 0xaa mcc_len 8
      dlci 2 frame_type 0 credit_flow 14 pri 7 ack_timer 0
      frame_size 667 max_retrans 0 credits 3
< ACL data: handle 0x0029 flags 0x02 dlen 8
    L2CAP(d): cid 0x0085 len 4 [psm 3]
      RFCOMM(s): SABM: cr 1 dlci 2 pf 1 ilen 0 fcs 0x59 
> HCI Event: Number of Completed Packets (0x13) plen 5
  0000: 01 29 00 01 00                                    .)...
< ACL data: handle 0x0029 flags 0x02 dlen 8
    L2CAP(d): cid 0x0085 len 4 [psm 3]
      RFCOMM(s): DISC: cr 1 dlci 2 pf 1 ilen 0 fcs 0xb8 
> HCI Event: Number of Completed Packets (0x13) plen 5
  0000: 01 29 00 01 00                                    .)...
> ACL data: handle 0x0029 flags 0x02 dlen 8
    L2CAP(d): cid 0x0040 len 4 [psm 3]
      RFCOMM(s): UA: cr 1 dlci 2 pf 1 ilen 0 fcs 0x92 
< ACL data: handle 0x0029 flags 0x02 dlen 8
    L2CAP(d): cid 0x0085 len 4 [psm 3]
      RFCOMM(s): DISC: cr 1 dlci 0 pf 1 ilen 0 fcs 0xfd 
< ACL data: handle 0x0029 flags 0x02 dlen 12
    L2CAP(s): Disconn req: dcid 0x0085 scid 0x0040
> HCI Event: Number of Completed Packets (0x13) plen 5
  0000: 01 29 00 01 00                                    .)...
> HCI Event: Number of Completed Packets (0x13) plen 5
  0000: 01 29 00 01 00                                    .)...
> ACL data: handle 0x0029 flags 0x02 dlen 8
    L2CAP(d): cid 0x0040 len 4 [psm 3]
      RFCOMM(s): UA: cr 1 dlci 0 pf 1 ilen 0 fcs 0xd7 
> ACL data: handle 0x0029 flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x0085 scid 0x0040
< HCI Command: Disconnect (0x01|0x0006) plen 3
  0000: 29 00 13                                          )..
> HCI Event: Command Status (0x0f) plen 4
  0000: 00 01 06 04                                       ....
> HCI Event: Disconn Complete (0x05) plen 4
  0000: 00 29 00 16                                       .)..
============================================================


-------------------------------------------------------
This SF.Net email is sponsored by: InterSystems CACHE
FREE OODBMS DOWNLOAD - A multidimensional database that combines
robust object and relational technologies, making it a perfect match
for Java, C++,COM, XML, ODBC and JDBC. www.intersystems.com/match8
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
