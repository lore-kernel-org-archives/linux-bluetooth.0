Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: "Michal Semler (volny.cz)" <cijoml@volny.cz>
Reply-To: cijoml@volny.cz
To: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Message-Id: <200403161357.54997.cijoml@volny.cz>
Subject: [Bluez-users] bthid and mouse wanted reconnect
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
Date: Tue, 16 Mar 2004 13:57:54 +0100

Hi Marcel,

sending hcidump when my mouse wants reconnect:

notas:/home/cijoml# hcidump
HCIDump - HCI packet analyzer ver 1.7
device: hci0 snap_len: 1028 filter: 0xffffffff
> HCI Event: Connect Request(0x04) plen 10
< HCI Command: Accept Connection Request(0x01|0x0009) plen 7
> HCI Event: Command Status(0x0f) plen 4
> HCI Event: Role Change(0x12) plen 8
> HCI Event: Connect Complete(0x03) plen 11
< HCI Command: Write Link Policy Settings(0x02|0x000d) plen 4
> HCI Event: Page Scan Repetition Mode Change(0x20) plen 7
> ACL data: handle 0x0029 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 17 scid 0x005a
< ACL data: handle 0x0029 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0040 scid 0x005a result 0 status 0
> HCI Event: Number of Completed Packets(0x13) plen 5
> HCI Event: Command Complete(0x0e) plen 6
< HCI Command: Change Connection Packet Type(0x01|0x000f) plen 4
> HCI Event: Command Status(0x0f) plen 4
> HCI Event: Connection Packet Type Changed(0x1d) plen 5
> ACL data: handle 0x0029 flags 0x02 dlen 17
> ACL data: handle 0x0029 flags 0x01 dlen 17
> ACL data: handle 0x0029 flags 0x01 dlen 6
    L2CAP(s): Config req: dcid 0x0040 flags 0x0000 clen 28
    MTU 48 Unknown (type 03, len 22)
< ACL data: handle 0x0029 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x005a flags 0x0000 result 0 clen 0
< ACL data: handle 0x0029 flags 0x02 dlen 12
    L2CAP(s): Config req: dcid 0x005a flags 0x0000 clen 0
> HCI Event: QoS Setup Complete(0x0d) plen 21
> HCI Event: Number of Completed Packets(0x13) plen 5
> HCI Event: Number of Completed Packets(0x13) plen 5
> ACL data: handle 0x0029 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0040 flags 0x0000 result 0 clen 0
> ACL data: handle 0x0029 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 19 scid 0x005b
< ACL data: handle 0x0029 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0041 scid 0x005b result 0 status 0
> HCI Event: Number of Completed Packets(0x13) plen 5
> ACL data: handle 0x0029 flags 0x02 dlen 17
> ACL data: handle 0x0029 flags 0x01 dlen 17
> ACL data: handle 0x0029 flags 0x01 dlen 6
    L2CAP(s): Config req: dcid 0x0041 flags 0x0000 clen 28
    MTU 48 Unknown (type 03, len 22)
< ACL data: handle 0x0029 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x005b flags 0x0000 result 0 clen 0
< ACL data: handle 0x0029 flags 0x02 dlen 12
    L2CAP(s): Config req: dcid 0x005b flags 0x0000 clen 0
> HCI Event: Number of Completed Packets(0x13) plen 5
> HCI Event: Number of Completed Packets(0x13) plen 5
> ACL data: handle 0x0029 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0041 flags 0x0000 result 0 clen 0
> ACL data: handle 0x0029 flags 0x02 dlen 4
> ACL data: handle 0x0029 flags 0x01 dlen 6
    L2CAP(d): cid 0x41 len 6 [psm 19]
      HIDP: Data: Input report
> ACL data: handle 0x0029 flags 0x02 dlen 10
    L2CAP(d): cid 0x41 len 6 [psm 19]
      HIDP: Data: Input report
> ACL data: handle 0x0029 flags 0x02 dlen 10
    L2CAP(d): cid 0x41 len 6 [psm 19]
      HIDP: Data: Input report
> ACL data: handle 0x0029 flags 0x02 dlen 10
    L2CAP(d): cid 0x41 len 6 [psm 19]
      HIDP: Data: Input report
> ACL data: handle 0x0029 flags 0x02 dlen 10
    L2CAP(d): cid 0x41 len 6 [psm 19]
      HIDP: Data: Input report
> HCI Event: Mode Change(0x14) plen 6
> ACL data: handle 0x0029 flags 0x02 dlen 10
    L2CAP(d): cid 0x41 len 6 [psm 19]
      HIDP: Data: Input report
> ACL data: handle 0x0029 flags 0x02 dlen 10
    L2CAP(d): cid 0x41 len 6 [psm 19]
      HIDP: Data: Input report
> ACL data: handle 0x0029 flags 0x02 dlen 10
    L2CAP(d): cid 0x41 len 6 [psm 19]
      HIDP: Data: Input report
> ACL data: handle 0x0029 flags 0x02 dlen 10
    L2CAP(d): cid 0x41 len 6 [psm 19]
      HIDP: Data: Input report
> ACL data: handle 0x0029 flags 0x02 dlen 10
    L2CAP(d): cid 0x41 len 6 [psm 19]
      HIDP: Data: Input report
> ACL data: handle 0x0029 flags 0x02 dlen 10
    L2CAP(d): cid 0x41 len 6 [psm 19]
      HIDP: Data: Input report
> ACL data: handle 0x0029 flags 0x02 dlen 10
    L2CAP(d): cid 0x41 len 6 [psm 19]
      HIDP: Data: Input report
> ACL data: handle 0x0029 flags 0x02 dlen 10
    L2CAP(d): cid 0x41 len 6 [psm 19]
      HIDP: Data: Input report
> ACL data: handle 0x0029 flags 0x02 dlen 10
    L2CAP(d): cid 0x41 len 6 [psm 19]
      HIDP: Data: Input report
> ACL data: handle 0x0029 flags 0x02 dlen 10
    L2CAP(d): cid 0x41 len 6 [psm 19]
      HIDP: Data: Input report
> ACL data: handle 0x0029 flags 0x02 dlen 10
    L2CAP(d): cid 0x41 len 6 [psm 19]
      HIDP: Data: Input report
> ACL data: handle 0x0029 flags 0x02 dlen 10
    L2CAP(d): cid 0x41 len 6 [psm 19]
      HIDP: Data: Input report
> ACL data: handle 0x0029 flags 0x02 dlen 10
    L2CAP(d): cid 0x41 len 6 [psm 19]
      HIDP: Data: Input report
> ACL data: handle 0x0029 flags 0x02 dlen 10
    L2CAP(d): cid 0x41 len 6 [psm 19]
      HIDP: Data: Input report
> ACL data: handle 0x0029 flags 0x02 dlen 10
    L2CAP(d): cid 0x41 len 6 [psm 19]
      HIDP: Data: Input report
> ACL data: handle 0x0029 flags 0x02 dlen 10
    L2CAP(d): cid 0x41 len 6 [psm 19]
      HIDP: Data: Input report
> ACL data: handle 0x0029 flags 0x02 dlen 10
    L2CAP(d): cid 0x41 len 6 [psm 19]
      HIDP: Data: Input report
> ACL data: handle 0x0029 flags 0x02 dlen 10
    L2CAP(d): cid 0x41 len 6 [psm 19]
      HIDP: Data: Input report
> ACL data: handle 0x0029 flags 0x02 dlen 10
    L2CAP(d): cid 0x41 len 6 [psm 19]
      HIDP: Data: Input report
> ACL data: handle 0x0029 flags 0x02 dlen 10
    L2CAP(d): cid 0x41 len 6 [psm 19]
      HIDP: Data: Input report
> ACL data: handle 0x0029 flags 0x02 dlen 10
    L2CAP(d): cid 0x41 len 6 [psm 19]
      HIDP: Data: Input report
> ACL data: handle 0x0029 flags 0x02 dlen 10
    L2CAP(d): cid 0x41 len 6 [psm 19]
      HIDP: Data: Input report
> ACL data: handle 0x0029 flags 0x02 dlen 10
    L2CAP(d): cid 0x41 len 6 [psm 19]
      HIDP: Data: Input report
> ACL data: handle 0x0029 flags 0x02 dlen 10
    L2CAP(d): cid 0x41 len 6 [psm 19]
      HIDP: Data: Input report
> ACL data: handle 0x0029 flags 0x02 dlen 10
    L2CAP(d): cid 0x41 len 6 [psm 19]
      HIDP: Data: Input report
> ACL data: handle 0x0029 flags 0x02 dlen 10
    L2CAP(d): cid 0x41 len 6 [psm 19]
      HIDP: Data: Input report
> ACL data: handle 0x0029 flags 0x02 dlen 10
    L2CAP(d): cid 0x41 len 6 [psm 19]
      HIDP: Data: Input report
> ACL data: handle 0x0029 flags 0x02 dlen 10
    L2CAP(d): cid 0x41 len 6 [psm 19]
      HIDP: Data: Input report
> ACL data: handle 0x0029 flags 0x02 dlen 10
    L2CAP(d): cid 0x41 len 6 [psm 19]
      HIDP: Data: Input report
> ACL data: handle 0x0029 flags 0x02 dlen 10
    L2CAP(d): cid 0x41 len 6 [psm 19]
      HIDP: Data: Input report
> ACL data: handle 0x0029 flags 0x02 dlen 10
    L2CAP(d): cid 0x41 len 6 [psm 19]
      HIDP: Data: Input report
> ACL data: handle 0x0029 flags 0x02 dlen 10
    L2CAP(d): cid 0x41 len 6 [psm 19]
      HIDP: Data: Input report
> ACL data: handle 0x0029 flags 0x02 dlen 10
    L2CAP(d): cid 0x41 len 6 [psm 19]
      HIDP: Data: Input report
> ACL data: handle 0x0029 flags 0x02 dlen 10
    L2CAP(d): cid 0x41 len 6 [psm 19]
      HIDP: Data: Input report
> ACL data: handle 0x0029 flags 0x02 dlen 10
    L2CAP(d): cid 0x41 len 6 [psm 19]
      HIDP: Data: Input report
> ACL data: handle 0x0029 flags 0x02 dlen 10
    L2CAP(d): cid 0x41 len 6 [psm 19]
      HIDP: Data: Input report
> ACL data: handle 0x0029 flags 0x02 dlen 10
    L2CAP(d): cid 0x41 len 6 [psm 19]
      HIDP: Data: Input report
> ACL data: handle 0x0029 flags 0x02 dlen 10
    L2CAP(d): cid 0x41 len 6 [psm 19]
      HIDP: Data: Input report
> ACL data: handle 0x0029 flags 0x02 dlen 10
    L2CAP(d): cid 0x41 len 6 [psm 19]
      HIDP: Data: Input report
> ACL data: handle 0x0029 flags 0x02 dlen 10
    L2CAP(d): cid 0x41 len 6 [psm 19]
      HIDP: Data: Input report
> ACL data: handle 0x0029 flags 0x02 dlen 10
    L2CAP(d): cid 0x41 len 6 [psm 19]
      HIDP: Data: Input report
> ACL data: handle 0x0029 flags 0x02 dlen 10
    L2CAP(d): cid 0x41 len 6 [psm 19]
      HIDP: Data: Input report
> ACL data: handle 0x0029 flags 0x02 dlen 10
    L2CAP(d): cid 0x41 len 6 [psm 19]
      HIDP: Data: Input report
> ACL data: handle 0x0029 flags 0x02 dlen 10
    L2CAP(d): cid 0x41 len 6 [psm 19]
      HIDP: Data: Input report
> ACL data: handle 0x0029 flags 0x02 dlen 10
    L2CAP(d): cid 0x41 len 6 [psm 19]
      HIDP: Data: Input report

Michal


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
