Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <430E4674.2030402@gmx.de>
From: Johannes Bauer <dfnsonfsduifb@gmx.de>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] rfcomm: Connection Refused
References: <430E0AF9.4050502@gmx.de> <1124996959.8019.70.camel@pegasus>
In-Reply-To: <1124996959.8019.70.camel@pegasus>
Content-Type: text/plain; charset=ISO-8859-1
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
Date: Fri, 26 Aug 2005 00:30:12 +0200

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Marcel Holtmann wrote:
> Hi Johannes,
> 
>>I'm having trouble with Bluez. I think I'm almost there, however. Here's
>>the description:
> 
> run "hcidump -X -V" of your connection attempt.

Yes, sir :-)

# hcidump -X -V
HCI sniffer - Bluetooth packet analyzer ver 1.21
device: hci0 snap_len: 1028 filter: 0xffffffff
< HCI Command: Create Connection (0x01|0x0005) plen 13
    bdaddr 00:0E:07:A7:7E:D2 ptype 0xcc18 rswitch 0x01 clkoffset 0x4295
(valid)
    Packet type: DM1 DM3 DM5 DH1 DH3 DH5
> HCI Event: Command Status (0x0f) plen 4
    Create Connection (0x01|0x0005) status 0x00 ncmd 1
> HCI Event: Connect Complete (0x03) plen 11
    status 0x00 handle 7 bdaddr 00:0E:07:A7:7E:D2 type ACL encrypt 0x00
< ACL data: handle 7 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 3 scid 0x0040
< HCI Command: Write Link Policy Settings (0x02|0x000d) plen 4
    handle 7 policy 0x0f
    Link policy: RSWITCH HOLD SNIFF PARK
> HCI Event: Command Complete (0x0e) plen 6
    Write Link Policy Settings (0x02|0x000d) ncmd 1
    status 0x00 handle 7
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 7
> HCI Event: Max Slots Change (0x1b) plen 3
    handle 7 slots 5
> ACL data: handle 7 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x007d scid 0x0040 result 0 status 0
      Connection successful
< ACL data: handle 7 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x007d flags 0x00 clen 4
      MTU 1024
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 7
> ACL data: handle 7 flags 0x02 dlen 18
    L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 4
      Success
      MTU 674
> ACL data: handle 7 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 4
      MTU 674
< ACL data: handle 7 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x007d flags 0x00 result 0 clen 0
      Success
< ACL data: handle 7 flags 0x02 dlen 8
    L2CAP(d): cid 0x007d len 4 [psm 3]
      RFCOMM(s): SABM: cr 1 dlci 0 pf 1 ilen 0 fcs 0x1c
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 7
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 7
> ACL data: handle 7 flags 0x02 dlen 8
    L2CAP(d): cid 0x0040 len 4 [psm 3]
      RFCOMM(s): UA: cr 1 dlci 0 pf 1 ilen 0 fcs 0xd7
< ACL data: handle 7 flags 0x02 dlen 18
    L2CAP(d): cid 0x007d len 14 [psm 3]
      RFCOMM(s): PN CMD: cr 1 dlci 0 pf 0 ilen 10 fcs 0x70 mcc_len 8
      dlci 2 frame_type 0 credit_flow 15 pri 7 ack_timer 0
      frame_size 669 max_retrans 0 credits 7
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 7
> ACL data: handle 7 flags 0x02 dlen 19
    L2CAP(d): cid 0x0040 len 15 [psm 3]
      RFCOMM(s): PN RSP: cr 0 dlci 0 pf 0 ilen 10 fcs 0xaa mcc_len 8
      dlci 2 frame_type 0 credit_flow 14 pri 7 ack_timer 0
      frame_size 330 max_retrans 0 credits 7
< ACL data: handle 7 flags 0x02 dlen 8
    L2CAP(d): cid 0x007d len 4 [psm 3]
      RFCOMM(s): SABM: cr 1 dlci 2 pf 1 ilen 0 fcs 0x59
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 7
> ACL data: handle 7 flags 0x02 dlen 8
    L2CAP(d): cid 0x0040 len 4 [psm 3]
      RFCOMM(s): DM: cr 1 dlci 2 pf 1 ilen 0 fcs 0x73
< ACL data: handle 7 flags 0x02 dlen 8
    L2CAP(d): cid 0x007d len 4 [psm 3]
      RFCOMM(s): DISC: cr 1 dlci 0 pf 1 ilen 0 fcs 0xfd
< ACL data: handle 7 flags 0x02 dlen 12
    L2CAP(s): Disconn req: dcid 0x007d scid 0x0040
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 7
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 7
> ACL data: handle 7 flags 0x02 dlen 8
    L2CAP(d): cid 0x0040 len 4 [psm 3]
      RFCOMM(s): UA: cr 1 dlci 0 pf 1 ilen 0 fcs 0xd7
> ACL data: handle 7 flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x007d scid 0x0040
< HCI Command: Disconnect (0x01|0x0006) plen 3
    handle 7 reason 0x13
    Reason: Remote User Terminated Connection
> HCI Event: Command Status (0x0f) plen 4
    Disconnect (0x01|0x0006) status 0x00 ncmd 1
> HCI Event: Disconn Complete (0x05) plen 4
    status 0x00 handle 7 reason 0x16
    Reason: Connection Terminated by Local Host

>># hcitool cc 00:0E:07:A7:7E:D2
>># hcitool auth 00:0E:07:A7:7E:D2
>># hcitool dc 00:0E:07:A7:7E:D2
> 
> 
> Who cares about this commands? These are for testing and development
> only.

Well, I read several HOWTOs, it was mentioned in one.

Hope the log helps,
Greetings,
Johannes
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFDDkZ0CseFG8xyfi4RAl4KAJ9xDOyxupDYlXLn+QAXTEV77+9ZuACfRSqY
IFWK98hEkYmbC1LhOSJEz6g=
=oYOd
-----END PGP SIGNATURE-----


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
