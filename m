Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <007901c4c402$84dd2280$6f04a8c0@ZBOX>
From: "Suriyan" <suriyan@netgadgets.co.th>
To: <bluez-devel@lists.sourceforge.net>
References: <E1CQIAu-0004AO-Dd@sc8-sf-list2.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="windows-874"
Subject: [Bluez-devel] Re: multi rfcomm/sco connection
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Sat, 6 Nov 2004 20:14:13 +0700

Hi Marcel,

> > I have application to uses Bluetooth Headset work as Wireless Microphone
so
> > that I would like support up to 3 channels for each dongle.
Unfotunately,
> > with lastest BlueZ stack my application can support only one Headset per
> > dongle.
>
> Please read and understand my responses. We support one SCO per ACL
> link. Which means when you open three ACL links, you can also have three
> SCO links, but of course there can be only one ACL link between two
> Bluetooth devices.
>
I see, one SCO link per an ACL link between two Bluetooth devices.
My application each Bluetooth Headset operate separately (see text
diagram below) so that they have only one SCO link per an ACL link to
BlueZ side.

In the BlueZ side it must handle up to three pairs of SCO and ACL links
however each pair of links route to different Bluetooth device (Headset).

                                                                   V
                                                                   |
                  +-------------------------------------------+
                  |    BlueZ Stack (1 USB BT Adaptor)   |
                  +-------------------------------------------+


                   V                         V                         V
                   |                          |                          |
+----------------+    +----------------+      +----------------+
| BT Headset 1 |     |BT Headset 2 |       | BT Headset 3 |
+----------------+    +----------------+      +----------------+

I have test with hsplay (bluez-utils-2.7/test) to play audio file to two
Headsets by run hsplay separately but it's failed since the second
hsplay cannot create SCO connection with error report address in
use (-EADDRINUSE). By loooking into sco.c and bypass address check
in sco_sock_bind() the second hsplay can create SCO connection but
when SCO connection on secord hsplay is connected it cause both
Headsets are quiet while hcidump -x continue dump SCO data on
both SCO handles (I uses fixed 48 bytes of SCO packet size in hstest.c)

In the other way, I have test with hsmicro with two Headsets it's OK
but I must force Alternate Setting of Isochronous interface from default
2 to 4 (two 16 bits Voice links) in hci_usb_probe() [hci_usb.c]

I have work backward to hsplay after I force Alternate Setting to 4, it's
failed even first Headset since I heard noise on Headset.

Do you have any suggestions to solve my problem?

> > Anyone have going to add multi SCO connections support on BlueZ stack?
> > Please let me known, I'd like to hear from you all. Any contact would be
> > greatly appreciated.
>
> As I said, I haven't seen any application that needs to connect more
> than one SCO link to an ACL link. Your problem looks like a hardware
> limit. Are you using SCO over HCI or over PCM? What kind of Bluetooth
> dongle do you use (hciconfig -a)?
>
My application is described above needs more than one pair of SCO and ACL
link, not more than one SCO link to an ACL link.

I uses SCO over HCI (hci_usb.c). My dongle hciconfig -a shown below :-

hci0: Type: USB
BD Address: 00:10:60:AA:32:13 ACL MTU: 192:8 SCO MTU: 64:8
UP RUNNING PSCAN ISCAN
RX bytes:1057 acl:0 sco:0 events:29 errors:0
TX bytes:440 acl:0 sco:0 commands:28 errors:0
Features: 0xff 0xff 0x0f 0x00 0x00 0x00 0x00 0x00
Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
Link policy: RSWITCH HOLD SNIFF PARK
Link mode: SLAVE ACCEPT
Name: 'BlueZ (0)'
Class: 0x000100
Service Classes: Unspecified
Device Class: Computer, Uncategorized
HCI Ver: 1.1 (0x1) HCI Rev: 0x33c LMP Ver: 1.1 (0x1) LMP Subver: 0x33c
Manufacturer: Cambridge Silicon Radio (10)


Additional hciconfig hci0 revision shown below :-

hci0: Type: USB
BD Address: 00:10:60:AA:32:13 ACL MTU: 192:8 SCO MTU: 64:8
HCI 16.14
Chip version: BlueCore02
Max key size: 56 bit
SCO mapping: HCI


Any your suggestions would be greatly appreciated.

Regards

Suriyan




-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel/listinfo/bluez-devel
