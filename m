Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Pavel Ruzicka <pavouk@pavouk.org>
To: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200411261152.29925.pavouk@pavouk.org>
Subject: [Bluez-users] DBT-120 firmware upgrade
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
Date: Fri, 26 Nov 2004 11:52:29 +0100

Hello,

I want to upgrade DBT-120 Ver B3 (details below).
I read instructions on http://www.holtmann.org/linux/bluetooth/dfu.html
I have downloaded BluetoothFWUpdate1.2.dmg.
On web is version 1.1, but when I try to download it, then version 1.2
is saved on to disk.

There are 3 dfu files:
md5sum and name:
--------------------------------
f1cb8ce8d3222af2bb6b512f99be62c7  DeskTop.dfu
00acbb467c76a1bca899f888fc23a779  GenericCSR.dfu
f16c41fa42e04d77a9df6ae8c2d40c82  Portable.dfu

Is this right GenericCSR.dfu for DBT-120 B3?
I mean correct md5sum.

I know, that flashing with btdfu is without warranty, but do you think that it 
will works?

Best regards,

Pavoel Ruzicka

Dongle details:
---------------------
# hciconfig hci0 version
hci0:   Type: USB
        BD Address: 00:0D:88:XX:XX:XX ACL MTU: 192:8  SCO MTU: 64:8
        HCI Ver: 1.1 (0x1) HCI Rev: 0x1bb LMP Ver: 1.1 (0x1) LMP Subver: 0x1bb
        Manufacturer: Cambridge Silicon Radio (10)
# hciconfig hci0 revision
hci0:   Type: USB
        BD Address: 00:0D:88:8E:B9:F0 ACL MTU: 192:8  SCO MTU: 64:8
        HCI 15.3
        Chip version: BlueCore02
        Max key size: 56 bit
        SCO mapping:  HCI
-------------------------


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
