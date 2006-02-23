Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <007301c6384c$bf92b290$0300a8c0@akira>
From: "Sir Graham (Terra)" <sir__graham@terra.es>
To: <bluez-devel@lists.sourceforge.net>
References: <001a01c637fa$8affa800$c800a8c0@kazama> <1140649027.4519.53.camel@localhost>
Subject: Re: [Bluez-devel] Problem with SDP.
MIME-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="utf-8";
	reply-type=original
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Thu, 23 Feb 2006 08:42:49 +0100

Hi Marcel,

Thanks for you answer. I try with the HCIDUMP. This is te results:

hcidump -X -V
HCI sniffer - Bluetooth packet analyzer ver 1.18
device: hci0 snap_len: 1028 filter: 0xffffffff
> HCI Event: Connect Request (0x04) plen 10
    bdaddr 00:0E:6D:AE:41:04 class 0x500204 type ACL
< HCI Command: Accept Connection Request (0x01|0x0009) plen 7
    bdaddr 00:0E:6D:AE:41:04 role 0x00
    Role: Master
> HCI Event: Command Status (0x0f) plen 4
    Accept Connection Request (0x01|0x0009) status 0x00 ncmd 1
> HCI Event: Link Key Request (0x17) plen 6
    bdaddr 00:0E:6D:AE:41:04
> HCI Event: Role Change (0x12) plen 8
    status 0x00 bdaddr 00:0E:6D:AE:41:04 role 0x00
    Role: Master
< HCI Command: Link Key Request Reply (0x01|0x000b) plen 22
    bdaddr 00:0E:6D:AE:41:04
    Link key: c277ad30bcb93d63f6aad6527b964fd0
> HCI Event: Command Complete (0x0e) plen 10
    Link Key Request Reply (0x01|0x000b) ncmd 1
    status 0x00 bdaddr 00:0E:6D:AE:41:04
> HCI Event: Connect Complete (0x03) plen 11
    status 0x00 handle 42 bdaddr 00:0E:6D:AE:41:04 type ACL encrypt 0x01
< HCI Command: Write Link Policy Settings (0x02|0x000d) plen 4
    handle 42 policy 0x0f
    Link policy: RSWITCH HOLD SNIFF PARK
> HCI Event: Page Scan Repetition Mode Change (0x20) plen 7
  0000: 04 41 ae 6d 0e 00 01                              .A.m...
> HCI Event: Command Complete (0x0e) plen 6
    Write Link Policy Settings (0x02|0x000d) ncmd 1
    status 0x00 handle 42
< HCI Command: Change Connection Packet Type (0x01|0x000f) plen 4
    handle 42 ptype 0x0018
    Packet type: DM1 DH1
  0000: 2a 00 18 00                                       *...
> HCI Event: Command Status (0x0f) plen 4
    Change Connection Packet Type (0x01|0x000f) status 0x00 ncmd 1
> HCI Event: Connection Packet Type Changed (0x1d) plen 5
    status 0x00 handle 42 ptype 0x331e
    Packet type: DM1 DH1 2-DH1 2-DH3 2-DH5 3-DH1 3-DH3 3-DH5
> HCI Event: Max Slots Change (0x1b) plen 3
  0000: 2a 00 05                                          *..
> ACL data: handle 42 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 1 scid 0x00b9
< ACL data: handle 42 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0040 scid 0x00b9 result 0 status 0
      Connection successful
> HCI Event: QoS Setup Complete (0x0d) plen 21
    status 0x00 handle 42
    0000: 00 01 00 00 00 00 00 00  00 00 88 13 00 00 ff ff  .............=
...
    0010: ff ff                                             ..
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 42
> ACL data: handle 42 flags 0x02 dlen 12
    L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 0
< ACL data: handle 42 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x00b9 flags 0x00 result 0 clen 0
      Success
< ACL data: handle 42 flags 0x02 dlen 12
    L2CAP(s): Config req: dcid 0x00b9 flags 0x00 clen 0
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 42
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 42
> ACL data: handle 42 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 0
      Success
> ACL data: handle 42 flags 0x02 dlen 17
    L2CAP(d): cid 0x0040 len 13 [psm 1]
        SDP SS Req: tid 0x1 len 0x8
          pat uuid-16 0x0100 (L2CAP)
          max 65535
          cont 00
> HCI Event: Mode Change (0x14) plen 6
    status 0x00 handle 42 mode 0x02 interval 800
    Mode: Sniff

In this point the application of Symbian are blocket.... (BTDiscovery).
BTDiscovery is one application that returns all services and attributes o=
f=20
the SDP of one service (like the sdptool browse).

I try also with my application in symbian (It not blocket because I have=20
watchdog to control it) with the same result.

I try also from other linux and the sdptool can=C2=B4t conect. And Window=
s 32=20
can=C2=B4t return any service...

I think the problem is the configuration of the SDP in linux...

Any idea?

Regards,
Sir Graham.







----- Original Message -----=20
From: "Marcel Holtmann" <marcel@holtmann.org>
To: <bluez-devel@lists.sourceforge.net>
Sent: Wednesday, February 22, 2006 11:57 PM
Subject: Re: [Bluez-devel] Problem with SDP.


Hi,

> I hope somebody can help me. I made a aplication in c++ for blueZ and
> register my own perfil in the SDP.  The function
> to register works well.
>
> I make the SPDTOOL BROWSE LOCAL  and the new perfil appeards without
> any problem.
>
> But... If I try to conect with SDP from Symbian, other linux or
> Windows, They CAN=C2=B4T  connect and don=C2=B4t obtain any perfil.
>
> the sdpd daemon is working.... (I checkit).
>
> What is necessary to SDP are public and other bluetooth devices can
> see it?

check with "hcidump -X -V" if the other side really connects to your
machine and what maybe fails.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting langua=
ge
that extends applications into web and mobile media. Attend the live webc=
ast
and join the prime developer group breaking into this new coding territor=
y!
http://sel.as-us.falkag.net/sel?cmd=3Dk&kid=110944&bid$1720&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel=20



-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
