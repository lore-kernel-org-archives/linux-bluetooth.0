Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: "Peter K. Martin" <Peter.K.Martin@t-online.de>
To: <bluez-users@lists.sourceforge.net>
Subject: AW: [Bluez-users] BT unter SuSE 9.2
Message-ID: <!~!UENERkVCMDkAAQACAAAAAAAAAAAAAAAAABgAAAAAAAAAosiAEZOtxUiHqgChZUVmh8KAAAAQAAAAsfVFWzu3xEqf6jbMNBUU/QEAAAAA@t-online.de>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <1102627923.7962.8.camel@pegasus>
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
Date: Fri, 10 Dec 2004 12:40:17 +0100

Hi Marcel,
here are the missing infos. I'll give you both hciconfig -a and again -x =
and
I hope that you have a solution for me. I want to use Linux as the =
primary
OS and NOT windows, but without the bluetooth-connection, I'm not able =
to do
so.

##>
##>what does "hciconfig -a" show you?
##>

Linux-Notebook:~ # dmabt

How can I start dmabt automatically? With boot.local it doesn't work!

Linux-Notebook:~ # hciconfig -a
hci0:   Type: USB
        BD Address: 00:03:7A:08:54:80 ACL MTU: 192:8  SCO MTU: 64:8
        UP RUNNING PSCAN ISCAN AUTH
        RX bytes:1038 acl:0 sco:0 events:34 errors:0
        TX bytes:371 acl:0 sco:0 commands:22 errors:0
        Features: 0xff 0xff 0x0f 0x00 0x00 0x00 0x00 0x00
        Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
        Link policy: RSWITCH HOLD SNIFF PARK
        Link mode: SLAVE ACCEPT
        Name: 'BlueZ (0)'
        Class: 0x100100
        Service Classes:
        Device Class: Computer, Uncategorized
        HCI Ver: 1.1 (0x1) HCI Rev: 0x20d LMP Ver: 1.1 (0x1) LMP Subver:
0x20d
        Manufacturer: Cambridge Silicon Radio (10)

Linux-Notebook:~ #

and now hciconfig -x
I have to send the PIN to the bt-accesspoint, the PIN is set in
/etc/bluetooth/pin and in hcid.conf security is set to auto.

Linux-Notebook:~ # hcidump -x
HCIDump - HCI packet analyzer ver 1.11
device: hci0 snap_len: 1028 filter: 0xffffffff
< HCI Command: Inquiry (0x01|0x0001) plen 5
  33 8B 9E 06 00
> HCI Event: Command Status (0x0f) plen 4
  00 01 01 04
> HCI Event: Inquiry Result (0x02) plen 15
  01 8F 01 00 CE 0B 00 01 00 00 00 03 02 41 56
> HCI Event: Inquiry Complete (0x01) plen 1
  00
< HCI Command: Remote Name Request (0x01|0x0019) plen 10
  8F 01 00 CE 0B 00 02 00 00 00
> HCI Event: Command Status (0x0f) plen 4
  00 01 19 04
< HCI Command: Create Connection (0x01|0x0005) plen 13
  8F 01 00 CE 0B 00 18 CC 01 00 41 D6 01
> HCI Event: Command Status (0x0f) plen 4
  0C 01 05 04
< HCI Command: Create Connection (0x01|0x0005) plen 13
  8F 01 00 CE 0B 00 18 CC 01 00 41 D6 01
> HCI Event: Command Status (0x0f) plen 4
  0C 01 05 04
> HCI Event: Remote Name Req Complete (0x07) plen 255
  00 8F 01 00 CE 0B 00 42 6C 75 65 74 6F 6F 74 68 2D 4D 6F 64
  75 6C 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
< HCI Command: Create Connection (0x01|0x0005) plen 13
  8F 01 00 CE 0B 00 18 CC 01 00 41 D6 01
> HCI Event: Command Status (0x0f) plen 4
  00 01 05 04
> HCI Event: Role Change (0x12) plen 8
  00 8F 01 00 CE 0B 00 01
> HCI Event: Link Key Request (0x17) plen 6
  8F 01 00 CE 0B 00
< HCI Command: Link Key Request Reply (0x01|0x000b) plen 22
  8F 01 00 CE 0B 00 F8 AA 01 A8 18 28 1B 17 C5 CB 52 40 71 AF
  72 BF
> HCI Event: Command Complete (0x0e) plen 10
  01 0B 04 00 8F 01 00 CE 0B 00
> HCI Event: Connect Complete (0x03) plen 11
  05 29 00 8F 01 00 CE 0B 00 01 00
< HCI Command: Create Connection (0x01|0x0005) plen 13
  8F 01 00 CE 0B 00 18 CC 01 00 41 D6 01
> HCI Event: Command Status (0x0f) plen 4
  00 01 05 04
> HCI Event: Role Change (0x12) plen 8
  00 8F 01 00 CE 0B 00 01
> HCI Event: Link Key Request (0x17) plen 6
  8F 01 00 CE 0B 00
< HCI Command: Link Key Request Reply (0x01|0x000b) plen 22
  8F 01 00 CE 0B 00 F8 AA 01 A8 18 28 1B 17 C5 CB 52 40 71 AF
  72 BF
> HCI Event: Command Complete (0x0e) plen 10
  01 0B 04 00 8F 01 00 CE 0B 00
> HCI Event: Connect Complete (0x03) plen 11
  05 2A 00 8F 01 00 CE 0B 00 01 00
< HCI Command: Inquiry (0x01|0x0001) plen 5
  33 8B 9E 06 00
> HCI Event: Command Status (0x0f) plen 4
  00 01 01 04
> HCI Event: Inquiry Complete (0x01) plen 1
  00

Regards
Peter





-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
