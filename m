Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Carlos Azevedo <carlosarazevedo@netcabo.pt>
To: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200411250541.06834.carlosarazevedo@netcabo.pt>
Subject: [Bluez-users] USB bluetooth & headset don't work together with btsco
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
Date: Thu, 25 Nov 2004 05:41:06 +0000

I'm running a 2.6.9 kernel and the latest bluez packages, but the USB dongle 
(a Lifetech BlueConnect) and the headset (a Plantronics M2500) don't work 
together. Having hcid running and hcidump on the background when I do 'btsco 
00:03:89:77:4D:10 2' I get :

Device is 1:0
< HCI Command: Read Voice Setting (0x03|0x0025) plen 0
> HCI Event: Command Complete (0x0e) plen 6
  0000: 01 25 0c 00 60 00                                 .%..`.
Voice setting: 0x0060
< HCI Command: Create Connection (0x01|0x0005) plen 13
  0000: 10 4d 77 89 03 00 18 cc  02 00 00 00 01           .Mw..........
> HCI Event: Command Status (0x0f) plen 4
  0000: 00 01 05 04                                       ....
> HCI Event: Link Key Request (0x17) plen 6
  0000: 10 4d 77 89 03 00                                 .Mw...
< HCI Command: Link Key Request Reply (0x01|0x000b) plen 22
  0000: 10 4d 77 89 03 00 cf 9c  aa d5 ec 39 4b 8b b5 f2  .Mw........9K...
  0010: a9 7b 52 4c 2d 26                                 .{RL-&
> HCI Event: Command Complete (0x0e) plen 10
  0000: 01 0b 04 00 10 4d 77 89  03 00                    .....Mw...
> HCI Event: Connect Complete (0x03) plen 11
  0000: 00 08 00 10 4d 77 89 03  00 01 01                 ....Mw.....
< ACL data: handle 0x0008 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 3 scid 0x0040
< HCI Command: Write Link Policy Settings (0x02|0x000d) plen 4
  0000: 08 00 0f 00                                       ....
> HCI Event: Connection Packet Type Changed (0x1d) plen 5
  0000: 00 08 00 18 cc                                    .....
> HCI Event: Command Complete (0x0e) plen 6
  0000: 01 0d 08 00 08 00                                 ......
> HCI Event: Number of Completed Packets (0x13) plen 5
  0000: 01 08 00 01 00                                    .....
Can't connect RFCOMM channel: Resource temporarily unavailable
bash-2.05a# < HCI Command: Disconnect (0x01|0x0006) plen 3
  0000: 08 00 13                                          ...
> HCI Event: Command Status (0x0f) plen 4
  0000: 00 01 06 04                                       ....
> HCI Event: Disconn Complete (0x05) plen 4
  0000: 00 08 00 16                                       ....

If I leave out the channel (2) it claims it can't connect to the SDP server, 
because of timeout.
Currently the only thing working is 'hciconfig' and 'hcitool scan'. By the way 
'hciconfig -a' reports :

hci0:   Type: USB
        BD Address: 00:0B:0D:31:73:A4 ACL MTU: 120:20  SCO MTU: 64:0
        UP RUNNING PSCAN ISCAN
        RX bytes:6958 acl:1 sco:0 events:401 errors:0
        TX bytes:3897 acl:37 sco:0 commands:205 errors:0
        Features: 0xff 0xff 0x05 0x38 0x18 0x18 0x00 0x00
        Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
        Link policy: RSWITCH HOLD SNIFF PARK
        Link mode: SLAVE ACCEPT
        Name: 'BlueZ (0)'
        Class: 0x3e0100
        Service Classes: Networking, Rendering, Capturing
        Device Class: Computer, Uncategorized
        HCI Ver: 1.2 (0x2) HCI Rev: 0x0 LMP Ver: 1.2 (0x2) LMP Subver: 0x757
        Manufacturer: Silicon Wave (11)

Any thougths ?

Carlos A. R. Azevedo


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
