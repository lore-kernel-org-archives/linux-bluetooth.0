Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Olivier Bornet <Olivier.Bornet@smartdata.ch>
To: bluez-devel@lists.sourceforge.net
Message-ID: <20030808102705.GD1520@smartdata.ch>
References: <20030723131952.GB1022@smartdata.ch>
Mime-Version: 1.0
In-Reply-To: <20030723131952.GB1022@smartdata.ch>
Subject: [Bluez-devel] [Bluez-users] Problem Phone -> BlueZ with USB dongle
	(CSR BlueCore02)
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: 
	<https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: 
	<http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Fri, 8 Aug 2003 12:27:05 +0200
Content-Type: multipart/signed; boundary="=-a13kkvmd4hfV0joIR11s"


--=-a13kkvmd4hfV0joIR11s
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; CHARSET=iso-8859-1

Hello,

[as we have some problems with CSR BC02 chips, and no one answer this on
 bluez-user, I'm reposting this on bluez-devel.]

I have some problems to send a file from a T68i phone via Obex to a
BlueZ Linux computer (2.4.21-mh2).

After some investigations, I have found that the problem is only when
the PC is configured as master,accept, and with a BlueCore02 version of
the CSR chip. (BlueCore01b is working OK).

I have done some tests with two differents bluetooth devices:
(Note: all the tests here are without sdp/obex server, as the problem is
before them).

- a USB dongle (Billionton):
    hciconfig hci0 revision
    hci0:   Type: USB=20
            BD Address: 00:10:60:A2:48:AE ACL MTU: 192:8  SCO MTU: 64:8
            HCI 16.4
            Chip version: BlueCore02
            Max key size: 56 bit
            SCO mapping:  HCI

- a PCMCIA 3Com card:
    hci0:   Type: PCCARD
            BD Address: 00:04:76:E1:2E:A2 ACL MTU: 128:8  SCO MTU: 64:8
            HCI 11.2
            Chip version: BlueCore01b
            SCO mapping:  HCI

Here are all my tests:

1. T68i -> PCMCIA card:

    a. hciconfig hci0 lm accept

        result: OK. hcidump -x trace:

            > HCI Event: Connect Request(0x04) plen 10
              86 0F DE 37 80 00 04 02 52 01=20
            < HCI Command: Accept Connection Request(0x01|0x0009) plen 7
              86 0F DE 37 80 00 01=20
            > HCI Event: Command Status(0x0f) plen 4
              00 01 09 04=20
            > HCI Event: Connect Complete(0x03) plen 11
              00 28 00 86 0F DE 37 80 00 01 00=20
            < HCI Command: Write Link Policy Settings(0x02|0x000d) plen 4
              28 00 0E 00=20
            > HCI Event: Command Complete(0x0e) plen 6
              01 0D 08 00 28 00=20
            < HCI Command: Change Connection Packet Type(0x01|0x000f) plen =
4
              28 00 18 CC=20
            > HCI Event: Command Status(0x0f) plen 4
              1A 01 0F 04=20
            > ACL data: handle 0x0028 flags 0x02 dlen 12
                L2CAP(s): Connect req: psm 1 scid 0x008d
            < ACL data: handle 0x0028 flags 0x02 dlen 16
                L2CAP(s): Connect rsp: dcid 0x0000 scid 0x008d result 2 sta=
tus 0
            > HCI Event: Number of Completed Packets(0x13) plen 5
              01 28 00 01 00=20
            > HCI Event: Disconn Complete(0x05) plen 4
              00 28 00 13=20


    b. hciconfig hci0 lm master,accept

        result: OK. hcidump -x trace:

            > HCI Event: Connect Request(0x04) plen 10
              86 0F DE 37 80 00 04 02 52 01=20
            < HCI Command: Accept Connection Request(0x01|0x0009) plen 7
              86 0F DE 37 80 00 00=20
            > HCI Event: Command Status(0x0f) plen 4
              00 01 09 04=20
            > HCI Event: Connect Complete(0x03) plen 11
              00 28 00 86 0F DE 37 80 00 01 00=20
            < HCI Command: Write Link Policy Settings(0x02|0x000d) plen 4
              28 00 0E 00=20
            > HCI Event: Command Complete(0x0e) plen 6
              01 0D 08 00 28 00=20
            < HCI Command: Change Connection Packet Type(0x01|0x000f) plen =
4
              28 00 18 CC=20
            > HCI Event: Command Status(0x0f) plen 4
              1A 01 0F 04=20
            > ACL data: handle 0x0028 flags 0x02 dlen 12
                L2CAP(s): Connect req: psm 1 scid 0x008e
            < ACL data: handle 0x0028 flags 0x02 dlen 16
                L2CAP(s): Connect rsp: dcid 0x0000 scid 0x008e result 2 sta=
tus 0
            > HCI Event: Number of Completed Packets(0x13) plen 5
              01 28 00 01 00=20
            > HCI Event: Disconn Complete(0x05) plen 4
              00 28 00 08=20


1. T68i -> USB dongle:

    a. hciconfig hci0 lm accept

        result: OK. hcidump -x trace:

            > HCI Event: Connect Request(0x04) plen 10
              86 0F DE 37 80 00 04 02 52 01=20
            < HCI Command: Accept Connection Request(0x01|0x0009) plen 7
              86 0F DE 37 80 00 01=20
            > HCI Event: Command Status(0x0f) plen 4
              00 01 09 04=20
            > HCI Event: Connect Complete(0x03) plen 11
              00 29 00 86 0F DE 37 80 00 01 00=20
            < HCI Command: Write Link Policy Settings(0x02|0x000d) plen 4
              29 00 0E 00=20
            > HCI Event: Page Scan Repetition Mode Change(0x20) plen 7
              86 0F DE 37 80 00 01=20
            > HCI Event: Command Complete(0x0e) plen 6
              01 0D 08 00 29 00=20
            < HCI Command: Change Connection Packet Type(0x01|0x000f) plen =
4
              29 00 18 CC=20
            > HCI Event: Command Status(0x0f) plen 4
              00 01 0F 04=20
            > HCI Event: Connection Packet Type Changed(0x1d) plen 5
              00 29 00 18 00=20
            > ACL data: handle 0x0029 flags 0x02 dlen 12
                L2CAP(s): Connect req: psm 1 scid 0x008f
            > HCI Event: Disconn Complete(0x05) plen 4
              00 29 00 13=20


    b. hciconfig hci0 lm master,accept

        result: NOT OK. hcidump -x trace:

            > HCI Event: Connect Request(0x04) plen 10
              86 0F DE 37 80 00 04 02 52 01=20
            < HCI Command: Accept Connection Request(0x01|0x0009) plen 7
              86 0F DE 37 80 00 00=20
            > HCI Event: Command Status(0x0f) plen 4
              00 01 09 04=20
            > HCI Event: Connect Complete(0x03) plen 11
              1A 29 00 86 0F DE 37 80 00 01 00=20

        Phone stop here with "Bluetooth connection failed".

3. PCMCIA card -> USB dongle:

    a. hciconfig hci0 lm accept (on USB dongle)

        result: OK. hcidump -x trace:

            > HCI Event: Connect Request(0x04) plen 10
              A2 2E E1 76 04 00 10 01 12 01=20
            < HCI Command: Accept Connection Request(0x01|0x0009) plen 7
              A2 2E E1 76 04 00 01=20
            > HCI Event: Command Status(0x0f) plen 4
              00 01 09 04=20
            > HCI Event: Connect Complete(0x03) plen 11
              00 29 00 A2 2E E1 76 04 00 01 00=20
            < HCI Command: Write Link Policy Settings(0x02|0x000d) plen 4
              29 00 0E 00=20
            > HCI Event: Page Scan Repetition Mode Change(0x20) plen 7
              A2 2E E1 76 04 00 01=20
            > HCI Event: Max Slots Change(0x1b) plen 3
              29 00 05=20
            > HCI Event: Command Complete(0x0e) plen 6
              01 0D 08 00 29 00=20
            < HCI Command: Change Connection Packet Type(0x01|0x000f) plen =
4
              29 00 18 CC=20
            > HCI Event: Command Status(0x0f) plen 4
              00 01 0F 04=20
            > HCI Event: Connection Packet Type Changed(0x1d) plen 5
              00 29 00 18 CC=20
            > ACL data: handle 0x0029 flags 0x02 dlen 12
                L2CAP(s): Connect req: psm 3 scid 0x0040
            > HCI Event: Disconn Complete(0x05) plen 4
              00 29 00 13=20

    b. hciconfig hci0 lm master,accept (on USB dongle)
       hciconfig hci0 lm master,accept (on PCMCIA card)

        result: NOT OK. hcidump -x trace:

            > HCI Event: Connect Request(0x04) plen 10
              A2 2E E1 76 04 00 10 01 12 01=20
            < HCI Command: Accept Connection Request(0x01|0x0009) plen 7
              A2 2E E1 76 04 00 00=20
            > HCI Event: Command Status(0x0f) plen 4
              00 01 09 04=20
            > HCI Event: Connect Complete(0x03) plen 11
              21 29 00 A2 2E E1 76 04 00 01 00=20

        PC stops here with: "Can't connect. Function not implemented
        (38)". I'm using obextool for this.

    c. hciconfig hci0 lm master,accept (on USB dongle)
       hciconfig hci0 lm accept (on PCMCIA card)

        result: OK. hcidump -x trace:

            > HCI Event: Connect Request(0x04) plen 10
              A2 2E E1 76 04 00 10 01 12 01=20
            < HCI Command: Accept Connection Request(0x01|0x0009) plen 7
              A2 2E E1 76 04 00 00=20
            > HCI Event: Command Status(0x0f) plen 4
              00 01 09 04=20
            > HCI Event: Role Change(0x12) plen 8
              00 A2 2E E1 76 04 00 00=20
            > HCI Event: Connect Complete(0x03) plen 11
              00 29 00 A2 2E E1 76 04 00 01 00=20
            < HCI Command: Write Link Policy Settings(0x02|0x000d) plen 4
              29 00 0E 00=20
            > HCI Event: Page Scan Repetition Mode Change(0x20) plen 7
              A2 2E E1 76 04 00 01=20
            > HCI Event: Command Complete(0x0e) plen 6
              01 0D 08 00 29 00=20
            > ACL data: handle 0x0029 flags 0x02 dlen 12
                L2CAP(s): Connect req: psm 3 scid 0x0040
            < HCI Command: Change Connection Packet Type(0x01|0x000f) plen =
4
              29 00 18 CC=20
            > HCI Event: Command Status(0x0f) plen 4
              00 01 0F 04=20
            > HCI Event: Connection Packet Type Changed(0x1d) plen 5
              00 29 00 18 CC=20
            > HCI Event: Max Slots Change(0x1b) plen 3
              29 00 05=20
            > HCI Event: Disconn Complete(0x05) plen 4
              00 29 00 13=20

So, my questions are:

- is this a correct behavior ?
- is this a problem with the BC02 core, or is this a wrong comportement
  of the BC01b (resulting of working better than the BC02 ;-) ?
- if this is a problem with the BC02 core, can we do something agins
  this ?

I don't understand why the communication is stopped when the role switch
is not done (due to the phone/pc initiating the communication refusing
it I think). Is this requiered by the BT specifications, or is this a
BC02 core bug ?

Thanks in advance for any help.

		Olivier
--=20
Olivier Bornet                      http://www.smartdata.ch/
Olivier.Bornet@smartdata.ch         SMARTDATA SA
Phone: +41-27-723'55'03             Rue du Coll=E8ge 5A
GPG key ID: C53D9218                CH-1920 Martigny

--=-a13kkvmd4hfV0joIR11s
Content-Disposition: inline
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE/M3r5dj3R/MU9khgRAiNGAJ4r6UXMVKXmVgujbp4xRjQwKAoEsQCdHHSs
ack3BnGkHb84+nLL+t0MhUQ=
=vJ5X
-----END PGP SIGNATURE-----

--=-a13kkvmd4hfV0joIR11s--
