Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Carlos Azevedo <carlosarazevedo@netcabo.pt>
To: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200412021935.44622.carlosarazevedo@netcabo.pt>
Subject: [Bluez-users] More problems with btsco
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
Date: Thu, 2 Dec 2004 19:35:44 +0000

Greetings,

I've stripped down btsco (the app), removing all references to the snd-bt-s=
co=20
module. So now it connects to the RFCOMM socket, waits for a first AT=20
command, then connects to the SCO socket, waits for a second AT command and=
=20
closes the sockets and exists.=20
The code runs at the first attempt but timeouts connecting to the SCO socke=
t=20
at the second run. I've ran hcidump (version 1.14) while doing this and fou=
nd=20
some protocol data that it can't understand :

HCIDump - HCI packet analyzer ver 1.14
< HCI Command: Read Voice Setting (0x03|0x0025) plen 0
> HCI Event: Command Complete (0x0e) plen 6
< HCI Command: Create Connection (0x01|0x0005) plen 13
> HCI Event: Command Status (0x0f) plen 4
> HCI Event: Link Key Request (0x17) plen 6
< HCI Command: Link Key Request Reply (0x01|0x000b) plen 22
> HCI Event: Command Complete (0x0e) plen 10
> HCI Event: Connect Complete (0x03) plen 11
< ACL data: handle 0x0001 flags 0x02 dlen 12
=A0 =A0 L2CAP(s): Connect req: psm 1 scid 0x0040
< HCI Command: Write Link Policy Settings (0x02|0x000d) plen 4
> HCI Event: Connection Packet Type Changed (0x1d) plen 5
> HCI Event: Command Complete (0x0e) plen 6
> HCI Event: Number of Completed Packets (0x13) plen 5
> ACL data: handle 0x0001 flags 0x02 dlen 4
> ACL data: handle 0x0001 flags 0x01 dlen 12
=A0 =A0 L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0040 result 1 status 2
> ACL data: handle 0x0001 flags 0x02 dlen 16
=A0 =A0 L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0040 result 0 status 0
< ACL data: handle 0x0001 flags 0x02 dlen 12
=A0 =A0 L2CAP(s): Config req: dcid 0x0040 flags 0x0000 clen 0
> HCI Event: Number of Completed Packets (0x13) plen 5
> ACL data: handle 0x0001 flags 0x02 dlen 14
=A0 =A0 L2CAP(s): Config rsp: scid 0x0040 flags 0x0000 result 0 clen 0
> ACL data: handle 0x0001 flags 0x02 dlen 4
> ACL data: handle 0x0001 flags 0x01 dlen 12
=A0 =A0 L2CAP(s): Config req: dcid 0x0040 flags 0x0000 clen 4
=A0 =A0 MTU 48
< ACL data: handle 0x0001 flags 0x02 dlen 14
=A0 =A0 L2CAP(s): Config rsp: scid 0x0040 flags 0x0000 result 0 clen 0
< ACL data: handle 0x0001 flags 0x02 dlen 24
=A0 =A0 L2CAP(d): cid 0x0040 len 20 [psm 1]
=A0 =A0 =A0 =A0 SDP SSA Req: tid 0x0 len 0xf
=A0 =A0 =A0 =A0 =A0 pat uuid-16 0x1108 (Headset)
=A0 =A0 =A0 =A0 =A0 max 0xffff
=A0 =A0 =A0 =A0 =A0 aid(s) 0x0000 - 0xffff
=A0 =A0 =A0 =A0 =A0 cont 00
> HCI Event: Number of Completed Packets (0x13) plen 5
> HCI Event: Number of Completed Packets (0x13) plen 5
> ACL data: handle 0x0001 flags 0x02 dlen 27
> ACL data: handle 0x0001 flags 0x01 dlen 25
=A0 =A0 L2CAP(d): cid 0x0040 len 48 [psm 1]
=A0 =A0 =A0 =A0 SDP SSA Rsp: tid 0x0 len 0x2b
=A0 =A0 =A0 =A0 =A0 cnt 0x26
=A0 =A0 =A0 =A0 =A0 srv rec #0
=A0 =A0 =A0 =A0 =A0 =A0 aid 0x0000 (SrvRecHndl)
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0uint 0x10000
=A0 =A0 =A0 =A0 =A0 =A0 aid 0x0001 (SrvClassIDList)
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0< uuid-16 0x1108 (Headset) uuid-16 0x1203 (A=
udio) >
=A0 =A0 =A0 =A0 =A0 =A0 aid 0x0004 (ProtocolDescList)
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0< < uuid-16 0x0100 (L2CAP) > <
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0uuid-16 0x0200 [ ] > >

=A0 =A0 =A0 =A0 =A0 cont
< ACL data: handle 0x0001 flags 0x02 dlen 26
=A0 =A0 L2CAP(d): cid 0x0040 len 22 [psm 1]
=A0 =A0 =A0 =A0 SDP SSA Req: tid 0x1 len 0x11
=A0 =A0 =A0 =A0 =A0 pat uuid-16 0x1108 (Headset)
=A0 =A0 =A0 =A0 =A0 max 0xffff
=A0 =A0 =A0 =A0 =A0 aid(s) 0x0000 - 0xffff
=A0 =A0 =A0 =A0 =A0 cont 02 00 3D
> HCI Event: Number of Completed Packets (0x13) plen 5
> ACL data: handle 0x0001 flags 0x02 dlen 4
> ACL data: handle 0x0001 flags 0x01 dlen 27
> ACL data: handle 0x0001 flags 0x01 dlen 21
=A0 =A0 L2CAP(d): cid 0x0040 len 48 [psm 1]
=A0 =A0 =A0 =A0 SDP SSA Rsp: tid 0x1 len 0x2b
=A0 =A0 =A0 =A0 =A0 cnt 0x26

ERROR: Unexpected syntax
=A0 =A0 =A0 =A0 =A0 cont 03 08 01 09 00 06 35 09 09 65 6E 09 00 6A 09 01 00=
 09 00 09 35=20
08 35 06 19 11 08 09 01 0
0 09 01 00 25 14 4D 32 02 00 17
< ACL data: handle 0x0001 flags 0x02 dlen 26
=A0 =A0 L2CAP(d): cid 0x0040 len 22 [psm 1]
=A0 =A0 =A0 =A0 SDP SSA Req: tid 0x2 len 0x11
=A0 =A0 =A0 =A0 =A0 pat uuid-16 0x1108 (Headset)
=A0 =A0 =A0 =A0 =A0 max 0xffff
=A0 =A0 =A0 =A0 =A0 aid(s) 0x0000 - 0xffff
=A0 =A0 =A0 =A0 =A0 cont 02 00 17
> HCI Event: Number of Completed Packets (0x13) plen 5
> ACL data: handle 0x0001 flags 0x02 dlen 27
> ACL data: handle 0x0001 flags 0x01 dlen 8
=A0 =A0 L2CAP(d): cid 0x0040 len 31 [psm 1]
=A0 =A0 =A0 =A0 SDP SSA Rsp: tid 0x2 len 0x1a
=A0 =A0 =A0 =A0 =A0 cnt 0x17
=A0 =A0 =A0 =A0 =A0 srv rec #0

ERROR: Unexpected syntax

=A0 =A0 =A0 =A0 =A0 srv rec #1

ERROR: Unexpected syntax
=A0 =A0 =A0 =A0 =A0 srv rec #2

ERROR: Unexpected syntax
=A0 =A0 =A0 =A0 =A0 srv rec #3

ERROR: Unexpected syntax
=A0 =A0 =A0 =A0 =A0 srv rec #4

ERROR: Unexpected syntax
=A0 =A0 =A0 =A0 =A0 srv rec #5

ERROR: Unexpected syntax
=A0 =A0 =A0 =A0 =A0 srv rec #6

ERROR: Unexpected syntax
=A0 =A0 =A0 =A0 =A0 srv rec #7

ERROR: Unexpected syntax
=A0 =A0 =A0 =A0 =A0 srv rec #8

ERROR: Unexpected syntax
=A0 =A0 =A0 =A0 =A0 srv rec #9

ERROR: Unexpected syntax
=A0 =A0 =A0 =A0 =A0 srv rec #10

ERROR: Unexpected syntax
=A0 =A0 =A0 =A0 =A0 srv rec #11

ERROR: Unexpected syntax
=A0 =A0 =A0 =A0 =A0 srv rec #12

ERROR: Unexpected syntax
=A0 =A0 =A0 =A0 =A0 srv rec #13

ERROR: Unexpected syntax
=A0 =A0 =A0 =A0 =A0 srv rec #14

ERROR: Unexpected syntax
=A0 =A0 =A0 =A0 =A0 cont
< ACL data: handle 0x0001 flags 0x02 dlen 12
=A0 =A0 L2CAP(s): Disconn req: dcid 0x0040 scid 0x0040
< ACL data: handle 0x0001 flags 0x02 dlen 12
=A0 =A0 L2CAP(s): Connect req: psm 3 scid 0x0041
> HCI Event: Number of Completed Packets (0x13) plen 5
> HCI Event: Number of Completed Packets (0x13) plen 5
=2E. more follows..

I'm now running 2.6.9-mh4. Are these errors a problem with the protocol=20
decoder or with the kernel drivers ? Anyone ?

Carlos A. R. Azevedo

PS. More background info at=20
http://sourceforge.net/mailarchive/forum.php?thread_id=3D6055972&forum_id=
=3D1883
http://sourceforge.net/mailarchive/forum.php?thread_id=3D6047020&forum_id=
=3D1883
http://sourceforge.net/mailarchive/forum.php?thread_id=3D6030842&forum_id=
=3D1883


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
