Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Aben Siatris <aben@webcom.sk>
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] Connecting from pocket PC iPaq to linux box using LAN access profile (DUND)
References: <000301c421f7$4be564e0$0c0a4e81@chimpsky>
In-Reply-To: <000301c421f7$4be564e0$0c0a4e81@chimpsky>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200404141319.16117.aben@webcom.sk>
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
Date: Wed, 14 Apr 2004 13:19:15 +0200

D=C5=88a Wednesday 14 April 2004 10:05 David West nap=C3=ADsal:
> Hi there,
>=20
> I'm trying to connect a Pocket PC iPaq to the network through a linux
> machine using the LAP.  I've had some success with the personal area
> network profile (using PAND), but not with the LAN access profile (using
> DUND).  For other devices I will be using I need to get the LAP (not PAN
> profile) working.=20
>=20
> I've been trying to follow the HOWTO on
> http://www.grinta.net/howto/bluez-ipaq.html and I believe I've done most
> of the steps mentioned there.  I am a little confused by it though: part
> of it discusses starting the pand.  Is this really required?
>=20
> In my /etc/ppp/peers/dun file, I've given the IP addresses as the ip
> address of eth0 on my linux box, and the IP address I want my iPaq to
> have, is this correct?
>=20
> I've run sdptool browse on another machine and verified that after
> starting dund (dund --listen --msdun -n call dun) the LAN Access profile
> is seen.
>=20
> When I search using my iPAQ, it successfully finds the linux box and its
> sets up a connection.  But when I try to actually connect, the
> connection fails.  There does not appear to be any output at all from
> dund: I use the -n switch to keep it in the foreground and nothing shows
> up.  The following is the trace from hcidump -a on the connection
> attempt:
>=20
> > HCI Event: Connect Request(0x04) plen 10
>   J 5 . . . . . . 2 .
> < HCI Command: Accept Connection Request(0x01|0x0009) plen 7
>   J 5 . . . . .
> > HCI Event: Command Status(0x0f) plen 4
>   . . . .
> > HCI Event: Link Key Request(0x17) plen 6
>   J 5 . . . .
> < HCI Command: Link Key Request Reply(0x01|0x000b) plen 22
>   J 5 . . . . u . R ; . 4   u . D h . O .
>   * .
> > HCI Event: Role Change(0x12) plen 8
>   . J 5 . . . . .
> > HCI Event: Command Complete(0x0e) plen 10
>   . . . . J 5 . . . .
> > HCI Event: Connect Complete(0x03) plen 11
>   . ) . J 5 . . . . . .
> < HCI Command: Write Link Policy Settings(0x02|0x000d) plen 4
>   ) . . .
> > HCI Event: Page Scan Repetition Mode Change(0x20) plen 7
>   J 5 . . . . .
> > HCI Event: Command Complete(0x0e) plen 6
>   . . . . ) .
> < HCI Command: Change Connection Packet Type(0x01|0x000f) plen 4
>   ) . . .
> > HCI Event: Command Status(0x0f) plen 4
>   . . . .
> > HCI Event: Connection Packet Type Changed(0x1d) plen 5
>   . ) . . .
> > HCI Event: Max Slots Change(0x1b) plen 3
>   ) . .
> > ACL data: handle 0x0029 flags 0x02 dlen 12
>     L2CAP(s): Connect req: psm 1 scid 0x0043
> < ACL data: handle 0x0029 flags 0x02 dlen 16
>     L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0043 result 0 status 0
> > HCI Event: Number of Completed Packets(0x13) plen 5
>   . ) . . .
> > ACL data: handle 0x0029 flags 0x02 dlen 20
>     L2CAP(s): Config req: dcid 0x0040 flags 0x0000 clen 8
>     MTU 512 FlushTO 65535
> < ACL data: handle 0x0029 flags 0x02 dlen 14
>     L2CAP(s): Config rsp: scid 0x0043 flags 0x0000 result 0 clen 0
> < ACL data: handle 0x0029 flags 0x02 dlen 12
>     L2CAP(s): Config req: dcid 0x0043 flags 0x0000 clen 0
> > HCI Event: Number of Completed Packets(0x13) plen 5
>   . ) . . .
> > HCI Event: Number of Completed Packets(0x13) plen 5
>   . ) . . .
> > ACL data: handle 0x0029 flags 0x02 dlen 14
>     L2CAP(s): Config rsp: scid 0x0040 flags 0x0000 result 0 clen 0
> > ACL data: handle 0x0029 flags 0x02 dlen 17
>     L2CAP(d): cid 0x40 len 13 [psm 1]
>         SDP SS Req: tid 0x0 len 0x8
>           pat uuid-16 0x1102 (LAN)
>           max 0x14
>           cont 00
> < ACL data: handle 0x0029 flags 0x02 dlen 18
>     L2CAP(d): cid 0x43 len 14 [psm 1]
>         SDP SS Rsp: tid 0x0 len 0x9
>           cur 0x1 tot 0x1 hndl 0x804d688
>           cont 00
> > HCI Event: Number of Completed Packets(0x13) plen 5
>   . ) . . .
> > ACL data: handle 0x0029 flags 0x02 dlen 23
>     L2CAP(d): cid 0x40 len 19 [psm 1]
>         SDP SA Req: tid 0x1 len 0xe
>           hndl 0x804d688
>           max 0x1f0
>           aid(s) 0x0000 - 0xffff
>           cont 00
> < ACL data: handle 0x0029 flags 0x02 dlen 89
>     L2CAP(d): cid 0x43 len 85 [psm 1]
>         SDP SA Rsp: tid 0x1 len 0x50
>           cnt 0x4d
>           aid 0x0000 (SrvRecHndl)
>              uint 0x804d688
>           aid 0x0001 (SrvClassIDList)
>              uuid-16 0x1102 (LAN)
>           aid 0x0004 (ProtocolDescList)
>              uuid-16 0x0100 (L2CAP)
>              uuid-16 0x0003 (RFCOMM) uint 0x1
>           aid 0x0005 (BrwGrpList)
>              uuid-16 0x1002 (PubBrwsGrp)
>           aid 0x0009 (BTProfileDescList)
>              uuid-16 0x1102 (LAN) uint 0x100
>           aid 0x0100 (SrvName)
>              str "LAN Access Point"
>=20
>           cont 00
> > HCI Event: Number of Completed Packets(0x13) plen 5
>   . ) . . .
> > ACL data: handle 0x0029 flags 0x02 dlen 12
>     L2CAP(s): Disconn req: dcid 0x0040 scid 0x0043
> < ACL data: handle 0x0029 flags 0x02 dlen 12
>     L2CAP(s): Disconn rsp: dcid 0x0040 scid 0x0043
> > HCI Event: Number of Completed Packets(0x13) plen 5
>   . ) . . .
> > ACL data: handle 0x0029 flags 0x02 dlen 12
>     L2CAP(s): Connect req: psm 3 scid 0x0044
> < ACL data: handle 0x0029 flags 0x02 dlen 16
>     L2CAP(s): Connect rsp: dcid 0x0000 scid 0x0044 result 4 status 0
> > HCI Event: Number of Completed Packets(0x13) plen 5
>   . ) . . .
> > HCI Event: Disconn Complete(0x05) plen 4
>   . ) . .
>=20
> If anyone can provide any insight to my problem, I'd greatly appreciate
> it.

first read please this documents:
http://bluez.sourceforge.net/contrib/HOWTO-PAN

and after thread "No more bluez.o in 2.6?"
in my e-mail is all relevant files


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
