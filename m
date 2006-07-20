Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <44BEF7AA.5000402@sympatico.ca>
Date: Wed, 19 Jul 2006 23:25:30 -0400
From: Jonathan Doda <jdoda@sympatico.ca>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Subject: [Bluez-users] logitech headset + msi bt adapter = not working
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

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Just as the subject says.  Below I've collected all the info that the
bluetooth-alsa page said would be useful in diagnosing the problem.
Thanks for your help.

Distro: Ubuntu 6.06
BT Adapter: MSI BToes (BCM2045)
Headset: Logitech Mobile Freedom HS02-V07

Output of hciconfig -a:
hci0:   Type: USB
        BD Address: 00:02:72:CA:94:AA ACL MTU: 1017:8 SCO MTU: 64:8
        UP RUNNING PSCAN ISCAN
        RX bytes:3708 acl:0 sco:0 events:188 errors:0
        TX bytes:651 acl:0 sco:0 commands:54 errors:0
        Features: 0xff 0xff 0x8d 0xfe 0x9b 0xf9 0x00 0x80
        Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
        Link policy: RSWITCH HOLD SNIFF PARK
        Link mode: SLAVE ACCEPT
        Name: 'canal-0'
        Class: 0x3e0100
        Service Classes: Networking, Rendering, Capturing
        Device Class: Computer, Uncategorized
        HCI Ver: 2.0 (0x3) HCI Rev: 0x204d LMP Ver: 2.0 (0x3) LMP
Subver: 0x4127        Manufacturer: Broadcom Corporation (15)

output of hciconfig hci0 revision:
hci0:   Type: USB
        BD Address: 00:02:72:CA:94:AA ACL MTU: 1017:8 SCO MTU: 64:8
        Firmware 8269.65 / 39

output of hcitool info bdaddr:
Requesting information ...
Can't create connection: Input/output error

output of btsco -v:
btsco v0.4c
Device is 1:0
Error: Failed to connect to SDP server: Invalid exchange
Assuming channel 2

Voice setting: 0x0060
Can't connect RFCOMM channel: Invalid exchange

output of hcidump -X, while above was running:
HCI sniffer - Bluetooth packet analyzer ver 1.28
device: hci0 snap_len: 1028 filter: 0xffffffff
< HCI Command: Create Connection (0x01|0x0005) plen 13
  0000: 0b cd 2f 44 0d 00 18 cc  02 00 00 00 01           ../D.........
> HCI Event: Command Status (0x0f) plen 4
  0000: 00 01 05 04                                       ....
> HCI Event: PIN Code Request (0x16) plen 6
  0000: 0b cd 2f 44 0d 00                                 ../D..
< HCI Command: PIN Code Request Negative Reply (0x01|0x000e) plen 6
  0000: 0b cd 2f 44 0d 00                                 ../D..
> HCI Event: Command Complete (0x0e) plen 10
  0000: 01 0e 04 00 0b cd 2f 44  0d 00                    ....../D..
> HCI Event: Connect Complete (0x03) plen 11
  0000: 06 0b 00 0b cd 2f 44 0d  00 01 00                 ...../D....
< HCI Command: Read Voice Setting (0x03|0x0025) plen 0
> HCI Event: Command Complete (0x0e) plen 6
  0000: 01 25 0c 00 60 00                                 .%..`.
< HCI Command: Create Connection (0x01|0x0005) plen 13
  0000: 0b cd 2f 44 0d 00 18 cc  02 00 00 00 01           ../D.........
> HCI Event: Command Status (0x0f) plen 4
  0000: 00 01 05 04                                       ....
> HCI Event: PIN Code Request (0x16) plen 6
  0000: 0b cd 2f 44 0d 00                                 ../D..
< HCI Command: PIN Code Request Negative Reply (0x01|0x000e) plen 6
  0000: 0b cd 2f 44 0d 00                                 ../D..
> HCI Event: Command Complete (0x0e) plen 10
  0000: 01 0e 04 00 0b cd 2f 44  0d 00                    ....../D..
> HCI Event: Connect Complete (0x03) plen 11
  0000: 06 0c 00 0b cd 2f 44 0d  00 01 00                 ...../D....
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQFEvveqWEgeeLQ8a74RAk7CAKCm+/bzt8Pkw6niBNtjXLrPHnmf8wCghn2V
Dy/Sllnn5NsyaDLe1dWOPr4=
=zY3y
-----END PGP SIGNATURE-----

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
