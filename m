Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Date: Fri, 14 Jul 2006 19:26:17 +0200 (CEST)
From: Andreas Fehr <andreas@mrs.ch>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.64.0607140931090.19685@ysf-zvav.gfns.pu>
Message-ID: <Pine.LNX.4.64.0607141906370.9987@ybpnyubfg.ybpnyqbznva>
References: <Pine.LNX.4.64.0607132135350.4704@ybpnyubfg.ybpnyqbznva>
	<1152820951.4838.76.camel@localhost>
	<Pine.LNX.4.64.0607132205380.4704@ybpnyubfg.ybpnyqbznva>
	<1152824695.4838.81.camel@localhost>
	<Pine.LNX.4.64.0607140608250.3992@ybpnyubfg.ybpnyqbznva>
	<20060714064703.GA19807@suse.de>
	<Pine.LNX.4.64.0607140911530.19575@ysf-zvav.gfns.pu>
	<1152862064.13430.9.camel@localhost>
	<Pine.LNX.4.64.0607140931090.19685@ysf-zvav.gfns.pu>
MIME-Version: 1.0
Subject: Re: [Bluez-users] rfcomm pairing and timeout
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

On Friday, 14. July 2006, 09:39, Andreas Fehr (as AF) wrote:

>AF: >MH: > >SS: Do you know, that the PIN handling changed with BlueZ 
>AF: >MH: > >SS: 3.0?
>AF: >MH: > 
>AF: >MH: > I figured it out reading hcid.conf. Would be better to have 
>AF: >MH: > something in the README or the ChangeLog or somewhere else. 
>AF: >MH: > Is there some documentation I missed? I grepped for pin and 
>AF: >MH: > pin_helper (to find some replacement for the old 
>AF: >MH: > pin_helper).
>AF: >MH: 
>AF: >MH: This was in the announcement of the BlueZ 3.0 series.
>AF: 
>AF: Well... I didn't use the 3.0 version, blame me for not being up to 
>AF: date with each version :-)

Anyway... this might be the problem... how do I configure a pin_helper? 
I read the announcement of BlueZ 3.0, all I saw was the new ability with 
a D-Bus passkey agent. But how to setup? (I have to admit, I didn't read 
the D-Bus documentation, but a link would be nice).


>AF: >MH: 2006-07-13 21:40:06.703037 < ACL data: handle 2 flags 0x02 dlen 8
>AF: >MH:     L2CAP(d): cid 0x0040 len 4 [psm 3]
>AF: >MH:       RFCOMM(s): SABM: cr 1 dlci 6 pf 1 ilen 0 fcs 0xd3 
>AF: >MH: 2006-07-13 21:40:06.704014 > HCI Event: Number of Completed Packets (0x13) plen 5
>AF: >MH:     handle 2 packets 1
>AF: >MH: 2006-07-13 21:40:06.706011 > HCI Event: Number of Completed Packets (0x13) plen 5
>AF: >MH:     handle 2 packets 1
>AF: >MH: 2006-07-13 21:40:06.708012 > HCI Event: Number of Completed Packets (0x13) plen 5
>AF: >MH:     handle 2 packets 2
>AF: >MH: 2006-07-13 21:40:06.718010 > HCI Event: Number of Completed Packets (0x13) plen 5
>AF: >MH:     handle 2 packets 1
>AF: >MH: 
>AF: >MH: **************** press accept on the phone
>AF: >MH: **************** and try to enter pin here
>AF: >MH: 
>AF: >MH: 2006-07-13 21:40:07.798989 < ACL data: handle 2 flags 0x02 dlen 8
>AF: >MH:     L2CAP(d): cid 0x0040 len 4 [psm 3]
>AF: >MH:       RFCOMM(s): DISC: cr 1 dlci 6 pf 1 ilen 0 fcs 0x32 
>AF: >MH: 
>AF: >MH: We send the SABM and then phone should answer with an UA. Are 
>AF: >MH: you sure that channel 3 is the correct one?
>AF: 
>AF: Well, it did work with the old version of bluez. And my phone asks 
>AF: me to accept a serial connection. So this seems ok for me. Unless 
>AF: there is a change in the definition between bluez-2.x and 
>AF: bluez-3.x, it still should work.
>AF: 
>AF: I'll downgrade to a version 2.x, but this wont happen till this 
>AF: evening. What is the last version of the 2.x series, 2.25 or 2.26? 
>AF: Just to make sure, that the rest of the system still works as 
>AF: expected.

Ok, just downgraded from 3.1 to 2.25. This version does work with my 
Linux Kernel 2.6.17.4

I tested 2.6.16.17, 2.6.17.2, and 2.6.17.4 all of them worked with BlueZ 
2.25, none of them worked with 3.1 (I did not test BlueZ 3.0).

If once paired with 2.25, it does work with BlueZ 3.1.



Below, find hcidump -X -V -t of this 2.6.17.4 with 2.25 (hcidump 1.30):

HCI sniffer - Bluetooth packet analyzer ver 1.30
device: hci0 snap_len: 1028 filter: 0xffffffff
2006-07-14 18:58:11.985407 < HCI Command: Create Connection (0x01|0x0005) plen 13
    bdaddr 00:18:0F:D8:02:3D ptype 0xcc18 rswitch 0x01 clkoffset 0x0000
    Packet type: DM1 DM3 DM5 DH1 DH3 DH5 
2006-07-14 18:58:11.988384 > HCI Event: Command Status (0x0f) plen 4
    Create Connection (0x01|0x0005) status 0x00 ncmd 1
2006-07-14 18:58:12.912238 > HCI Event: Role Change (0x12) plen 8
    status 0x00 bdaddr 00:18:0F:D8:02:3D role 0x01
    Role: Slave
2006-07-14 18:58:12.922234 > HCI Event: Link Key Request (0x17) plen 6
    bdaddr 00:18:0F:D8:02:3D
2006-07-14 18:58:12.922379 < HCI Command: Link Key Request Reply (0x01|0x000b) plen 22
    bdaddr 00:18:0F:D8:02:3D key 3DC39AC5BA2EBC8846E3412BF67D0A96
2006-07-14 18:58:12.925231 > HCI Event: Command Complete (0x0e) plen 10
    Link Key Request Reply (0x01|0x000b) ncmd 1
    status 0x00 bdaddr 00:18:0F:D8:02:3D
2006-07-14 18:58:12.978226 > HCI Event: PIN Code Request (0x16) plen 6
    bdaddr 00:18:0F:D8:02:3D
2006-07-14 18:58:12.986724 < HCI Command: PIN Code Request Reply (0x01|0x000d) plen 23
    bdaddr 00:18:0F:D8:02:3D len 4 pin '****'
2006-07-14 18:58:12.989223 > HCI Event: Command Complete (0x0e) plen 10
    PIN Code Request Reply (0x01|0x000d) ncmd 1
    status 0x00 bdaddr 00:18:0F:D8:02:3D

*************** accept serial connection and
*************** enter passkey with the phone

2006-07-14 18:58:27.625855 > HCI Event: Link Key Notification (0x18) plen 23
    bdaddr 00:18:0F:D8:02:3D key 1B863D6B64F4A9D53EB73FD5EC0A3A69 type 0
2006-07-14 18:58:27.729840 > HCI Event: Connect Complete (0x03) plen 11
    status 0x00 handle 1 bdaddr 00:18:0F:D8:02:3D type ACL encrypt 0x01
2006-07-14 18:58:27.729860 < ACL data: handle 1 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 3 scid 0x0040
2006-07-14 18:58:27.729867 < HCI Command: Write Link Policy Settings (0x02|0x000d) plen 4
    handle 1 policy 0x0f
    Link policy: RSWITCH HOLD SNIFF PARK 
2006-07-14 18:58:27.732838 > HCI Event: Command Complete (0x0e) plen 6
    Write Link Policy Settings (0x02|0x000d) ncmd 1
    status 0x00 handle 1
2006-07-14 18:58:27.737837 > HCI Event: Max Slots Change (0x1b) plen 3
    handle 1 slots 5
2006-07-14 18:58:27.739836 > HCI Event: Number of Completed Packets (0x13) plen 5
    handle 1 packets 1
2006-07-14 18:58:27.747837 > ACL data: handle 1 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0040 result 0 status 0
      Connection successful
2006-07-14 18:58:27.747854 < ACL data: handle 1 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 4
      MTU 1013 
2006-07-14 18:58:27.748840 > ACL data: handle 1 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 4
      MTU 32772 
2006-07-14 18:58:27.748859 < ACL data: handle 1 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 0
      Success
2006-07-14 18:58:27.751835 > HCI Event: Number of Completed Packets (0x13) plen 5
    handle 1 packets 1
2006-07-14 18:58:27.753836 > HCI Event: Number of Completed Packets (0x13) plen 5
    handle 1 packets 1
2006-07-14 18:58:27.753840 > ACL data: handle 1 flags 0x02 dlen 18
    L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 4
      Success
      MTU 1013 
2006-07-14 18:58:27.753862 < ACL data: handle 1 flags 0x02 dlen 8
    L2CAP(d): cid 0x0040 len 4 [psm 3]
      RFCOMM(s): SABM: cr 1 dlci 0 pf 1 ilen 0 fcs 0x1c 
2006-07-14 18:58:27.758835 > HCI Event: Number of Completed Packets (0x13) plen 5
    handle 1 packets 1
2006-07-14 18:58:27.760835 > ACL data: handle 1 flags 0x02 dlen 8
    L2CAP(d): cid 0x0040 len 4 [psm 3]
      RFCOMM(s): UA: cr 1 dlci 0 pf 1 ilen 0 fcs 0xd7 
2006-07-14 18:58:35.987323 < ACL data: handle 1 flags 0x02 dlen 8
    L2CAP(d): cid 0x0040 len 4 [psm 3]
      RFCOMM(s): DISC: cr 1 dlci 0 pf 1 ilen 0 fcs 0xfd 
2006-07-14 18:58:35.987339 < ACL data: handle 1 flags 0x02 dlen 12
    L2CAP(s): Disconn req: dcid 0x0040 scid 0x0040
2006-07-14 18:58:35.999502 > HCI Event: Number of Completed Packets (0x13) plen 5
    handle 1 packets 1
2006-07-14 18:58:36.000503 > ACL data: handle 1 flags 0x02 dlen 8
    L2CAP(d): cid 0x0040 len 4 [psm 3]
      RFCOMM(s): UA: cr 1 dlci 0 pf 1 ilen 0 fcs 0xd7 
2006-07-14 18:58:36.001504 > HCI Event: Number of Completed Packets (0x13) plen 5
    handle 1 packets 1
2006-07-14 18:58:36.003503 > ACL data: handle 1 flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x0040 scid 0x0040
2006-07-14 18:58:38.003443 < HCI Command: Disconnect (0x01|0x0006) plen 3
    handle 1 reason 0x13
    Reason: Remote User Terminated Connection
2006-07-14 18:58:38.007176 > HCI Event: Command Status (0x0f) plen 4
    Disconnect (0x01|0x0006) status 0x00 ncmd 1
2006-07-14 18:58:38.026175 > HCI Event: Disconn Complete (0x05) plen 4
    status 0x00 handle 1 reason 0x16
    Reason: Connection Terminated by Local Host



-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
