Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <420259FE.2080204@tootai.net>
From: administrator tootai <admin@tootai.net>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] Re: Connection issue with headset
References: <41FA06A5.3010904@tootai.net> <ctdn6n$sqs$1@sea.gmane.org> <41FE4744.5010804@tootai.net> <ctob73$ph0$1@sea.gmane.org> <4200D3B6.1050708@tootai.net> <ctqulk$ce4$1@sea.gmane.org>
In-Reply-To: <ctqulk$ce4$1@sea.gmane.org>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
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
Date: Thu, 03 Feb 2005 18:06:06 +0100

Sebastian Roth a =E9crit :

> [...]
> If you followed this and it does not work I have two ideas.
> 1. Is it possible that your headset does not send any AT commands
> over the connected RFCOMM channel? As far as I know btsco will never
> try to establish an SCO connection without having recived the cmd
> from your headset.
> 2. The headset is sending "other" commands when pressing the headset
> button. Same effect as 1.
>
> Please have a look at hcidump -x to see if your headset is sending such
> a command when pressing the button!

Hi list,

continuing to check what is wrong I try this command sdptool browse=20
00:0b:2e:06:01:2e

Browsing 00:0B:2E:06:01:2E ...
Service Search failed: Protocol error
nomade:#
    =20
and thats the hcidump -X result

HCIDump - HCI packet analyzer ver 1.12
device: hci0 snap_len: 1028 filter: 0xffffffff
< HCI Command: Create Connection (0x01|0x0005) plen 13
  0000: 2e 01 06 2e 0b 00 18 cc  02 00 00 00 00           .............
 > HCI Event: Command Status (0x0f) plen 4
  0000: 00 01 05 04                                       ....
 > HCI Event: Link Key Request (0x17) plen 6
  0000: 2e 01 06 2e 0b 00                                 ......
< HCI Command: Link Key Request Reply (0x01|0x000b) plen 22
  0000: 2e 01 06 2e 0b 00 98 0f  70 e7 ad ee 4b 1a 93 1c  ........p...K...
  0010: ba 18 77 0c 19 00                                 ..w...
 > HCI Event: Command Complete (0x0e) plen 10
  0000: 01 0b 04 00 2e 01 06 2e  0b 00                    ..........
 > HCI Event: Connect Complete (0x03) plen 11
  0000: 00 29 00 2e 01 06 2e 0b  00 01 00                 .).........
< ACL data: handle 0x0029 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 1 scid 0x0040
 > HCI Event: Number of Completed Packets (0x13) plen 5
  0000: 01 29 00 01 00                                    .)...
 > ACL data: handle 0x0029 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0040 result 0 status 0
< ACL data: handle 0x0029 flags 0x02 dlen 12
    L2CAP(s): Config req: dcid 0x0040 flags 0x0000 clen 0
 > HCI Event: Max Slots Change (0x1b) plen 3
  0000: 29 00 05                                          )..
 > HCI Event: Number of Completed Packets (0x13) plen 5
  0000: 01 29 00 01 00                                    .)...
 > ACL data: handle 0x0029 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0040 flags 0x0000 result 0 clen 0
 > ACL data: handle 0x0029 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0040 flags 0x0000 clen 4
    MTU 48
< ACL data: handle 0x0029 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0040 flags 0x0000 result 0 clen 0
< ACL data: handle 0x0029 flags 0x02 dlen 24
    L2CAP(d): cid 0x0040 len 20 [psm 1]
        SDP SSA Req: tid 0x0 len 0xf
          pat uuid-16 0x1002 (PubBrwsGrp)
          max 0xffff
          aid(s) 0x0000 - 0xffff
          cont 00
 > HCI Event: Number of Completed Packets (0x13) plen 5
  0000: 01 29 00 01 00                                    .)...
 > HCI Event: Number of Completed Packets (0x13) plen 5
  0000: 01 29 00 01 00                                    .)...
 > ACL data: handle 0x0029 flags 0x02 dlen 27
 > ACL data: handle 0x0029 flags 0x01 dlen 24
    L2CAP(d): cid 0x0040 len 47 [psm 1]
        SDP SSA Rsp: tid 0xd3c0 len 0x2a
          cnt 0x26
          srv rec #0
            aid 0x0000 (SrvRecHndl)
               uint 0x10000
            aid 0x22c2 (unknown)


ERROR: Unexpected syntax
            0000: 12 b3 e4 12 fc c5 12 b4  15 12 fc c5 90 0e 12 12 =20
................
            0010: b4 00 00                                          ...

          srv rec #1

ERROR: Unexpected syntax
            0000: b3 e4 12 fc c5 12 b4 15  12 fc c5 90 0e 12 12 b4 =20
................
            0010: 00 00                                             ..
          srv rec #2

ERROR: Unexpected syntax
            0000: e4 12 fc c5 12 b4 15 12  fc c5 90 0e 12 12 b4 00 =20
................
            0010: 00                                                .
          srv rec #3

ERROR: Unexpected syntax
            0000: 12 fc c5 12 b4 15 12 fc  c5 90 0e 12 12 b4 00 00 =20
................
          srv rec #4

ERROR: Unexpected syntax
            0000: fc c5 12 b4 15 12 fc c5  90 0e 12 12 b4 00 00    =20
...............
          srv rec #5

ERROR: Unexpected syntax
            0000: c5 12 b4 15 12 fc c5 90  0e 12 12 b4 00 00       =20
..............
          srv rec #6

ERROR: Unexpected syntax
            0000: b4 15 12 fc c5 90 0e 12  12 b4 00 00             =20
............
          srv rec #7

ERROR: Unexpected syntax
            0000: 15 12 fc c5 90 0e 12 12  b4 00 00                =20
...........
          srv rec #8

ERROR: Unexpected syntax
            0000: fc c5 90 0e 12 12 b4 00  00                      =20
.........
          srv rec #9

ERROR: Unexpected syntax
            0000: c5 90 0e 12 12 b4 00 00                           .....=
...
          srv rec #10

ERROR: Unexpected syntax
            0000: 0e 12 12 b4 00 00                                 ......
          srv rec #11

ERROR: Unexpected syntax
            0000: b4 00 00                                          ...
          srv rec #12

ERROR: Unexpected syntax
            0000: 00 00                                             ..
          srv rec #13

ERROR: Unexpected syntax
            0000: 00                                                .
          srv rec #14

ERROR: Unexpected syntax
          cont
< ACL data: handle 0x0029 flags 0x02 dlen 12
    L2CAP(s): Disconn req: dcid 0x0040 scid 0x0040
 > HCI Event: Number of Completed Packets (0x13) plen 5
  0000: 01 29 00 01 00                                    .)...
 > ACL data: handle 0x0029 flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x0040 scid 0x0040
< HCI Command: Disconnect (0x01|0x0006) plen 3
  0000: 29 00 13                                          )..
 > HCI Event: Command Status (0x0f) plen 4
  0000: 00 01 06 04                                       ....
 > HCI Event: Disconn Complete (0x05) plen 4
  0000: 00 29 00 16                                       .)..

It give some informations to you gurus ;-)?

--=20
Daniel


-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
