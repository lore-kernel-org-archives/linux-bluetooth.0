Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Problem with Suse 9.0 and BlueZ
From: Marcel Holtmann <marcel@holtmann.org>
To: Paulo Wollny <paulo@wollny.com.br>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <409FFE21.7040601@wollny.com.br>
References: <200405101448.i4AEmIK26418@home.iis.com.br>
	 <1084201089.9639.1.camel@pegasus>  <409FFE21.7040601@wollny.com.br>
Content-Type: text/plain; charset=ISO-8859-1
Message-Id: <1084243741.25099.1.camel@pegasus>
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
Date: Tue, 11 May 2004 04:49:02 +0200

Hi Paulo,

> i installed hcidump, and did:
> rfcomm bind 0 00:01:E3:22:59:E2
> echo "ATZ" >  /dev/rfcomm0
>=20
> the result was:
> paulo@hirscheberg:~> echo "ATZ" > /dev/rfcomm0
> bash: /dev/rfcomm0: Die Verbindung wurde vom Kommunikationspartner=20
> zur=FCckgesetzt
> After giving in on the phone the pin number stored in /etc/bluetooth/pi=
n
>=20
> The output of hcidump -x for the above was:
>=20
> hirscheberg:~ # /etc/rc.d/bluetooth restart
> Shutting down=20
> bluetooth                                                              =
done
> Starting bluetooth ...(hci_usb hci_uart=20
> )                                            done
> hirscheberg:~ # hcidump -x
> HCIDump - HCI packet analyzer ver 1.8
> device: hci0 snap_len: 1028 filter: 0xffffffff
> < HCI Command: Create Connection(0x01|0x0005) plen 13
>   E2 59 22 E3 01 00 18 CC 01 00 00 00 01
>  > HCI Event: Command Status(0x0f) plen 4
>   00 01 05 04
>  > HCI Event: Connect Complete(0x03) plen 11
>   00 28 00 E2 59 22 E3 01 00 01 00
> < ACL data: handle 0x0028 flags 0x02 dlen 12
>     L2CAP(s): Connect req: psm 3 scid 0x0040
> < HCI Command: Write Link Policy Settings(0x02|0x000d) plen 4
>   28 00 0E 00
>  > HCI Event: Number of Completed Packets(0x13) plen 5
>   01 28 00 01 00
>  > HCI Event: Command Complete(0x0e) plen 6
>   01 0D 08 00 28 00
>  > HCI Event: Max Slots Change(0x1b) plen 3
>   28 00 05
>  > ACL data: handle 0x0028 flags 0x02 dlen 16
>     L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0040 result 0 status 0
> < ACL data: handle 0x0028 flags 0x02 dlen 16
>     L2CAP(s): Config req: dcid 0x0040 flags 0x0000 clen 4
>     MTU 1024
>  > HCI Event: Number of Completed Packets(0x13) plen 5
>   01 28 00 01 00
>  > ACL data: handle 0x0028 flags 0x02 dlen 18
>     L2CAP(s): Config rsp: scid 0x0040 flags 0x0000 result 0 clen 4
>     MTU 1024
>  > ACL data: handle 0x0028 flags 0x02 dlen 16
>     L2CAP(s): Config req: dcid 0x0040 flags 0x0000 clen 4
>     MTU 339
> < ACL data: handle 0x0028 flags 0x02 dlen 14
>     L2CAP(s): Config rsp: scid 0x0040 flags 0x0000 result 0 clen 0
> < ACL data: handle 0x0028 flags 0x02 dlen 8
>     L2CAP(d): cid 0x40 len 4 [psm 3]
>       RFCOMM(s): SABM: cr 1 dlci 0 pf 1 ilen 0 fcs 0x1c
>  > HCI Event: Number of Completed Packets(0x13) plen 5
>   01 28 00 01 00
>  > HCI Event: Number of Completed Packets(0x13) plen 5
>   01 28 00 01 00
>  > ACL data: handle 0x0028 flags 0x02 dlen 8
>     L2CAP(d): cid 0x40 len 4 [psm 3]
>       RFCOMM(s): UA: cr 1 dlci 0 pf 1 ilen 0 fcs 0xd7
> < ACL data: handle 0x0028 flags 0x02 dlen 18
>     L2CAP(d): cid 0x40 len 14 [psm 3]
>       RFCOMM(s): PN CMD: cr 1 dlci 0 pf 0 ilen 10 fcs 0x70 mcc_len 8
>       dlci 2 frame_type 0 credit_flow 15 pri 7 ack_timer 0 frame_size=20
> 334 max_retrans 0 credits 7
>  > HCI Event: Number of Completed Packets(0x13) plen 5
>   01 28 00 01 00
>  > ACL data: handle 0x0028 flags 0x02 dlen 17
>  > ACL data: handle 0x0028 flags 0x01 dlen 1
>     L2CAP(d): cid 0x40 len 14 [psm 3]
>       RFCOMM(s): PN RSP: cr 0 dlci 0 pf 0 ilen 10 fcs 0xaa mcc_len 8
>       dlci 2 frame_type 0 credit_flow 14 pri 0 ack_timer 0 frame_size=20
> 334 max_retrans 0 credits 2
> < ACL data: handle 0x0028 flags 0x02 dlen 8
>     L2CAP(d): cid 0x40 len 4 [psm 3]
>       RFCOMM(s): SABM: cr 1 dlci 2 pf 1 ilen 0 fcs 0x59
>  > HCI Event: Number of Completed Packets(0x13) plen 5
>   01 28 00 01 00
>  > HCI Event: PIN Code Request(0x16) plen 6
>   E2 59 22 E3 01 00
> < HCI Command: PIN Code Request Negative Reply(0x01|0x000e) plen 6
>   E2 59 22 E3 01 00

this is a PIN helper problem. Look at the mailing list archive to solve
your problem.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by Sleepycat Software
Learn developer strategies Cisco, Motorola, Ericsson & Lucent use to deliver
higher performing products faster, at low TCO.
http://www.sleepycat.com/telcomwpreg.php?From=osdnemail3
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
