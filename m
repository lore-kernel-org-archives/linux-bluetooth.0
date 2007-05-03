Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <cd3ff4f20705022352u3451a87eub2e03a33f7bcf535@mail.gmail.com>
Date: Thu, 3 May 2007 10:52:48 +0400
From: heecks <heecks@gmail.com>
To: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Subject: [Bluez-users] Device not detected (HP nx9420 / Kubuntu Feisty)
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

Hi,

I can't see my bluetooth device on my HP nx9420 laptop with Kubuntu
Feisty 7.04. Everything works well under Windows.

Here are some informations :

xav@xav-laptop:/$ uname -a
Linux xav-laptop 2.6.20-15-generic #2 SMP Sun Apr 15 07:36:31 UTC 2007
i686 GNU/Linux

xav@xav-laptop:/$ hciconfig -a

xav@xav-laptop:/$ hcitool scan
Device is not available: No such device

xav@xav-laptop:/$ hcitool inq
Inquiring ...
Inquiry failed.: No such device

xav@xav-laptop:/$ hcitool dev
Devices:

xav@xav-laptop:/$ lsusb
Bus 002 Device 001: ID 0000:0000
Bus 003 Device 002: ID 1267:0210 Logic3 / SpectraVideo plc
Bus 003 Device 001: ID 0000:0000
Bus 005 Device 001: ID 0000:0000
Bus 004 Device 001: ID 0000:0000
Bus 001 Device 001: ID 0000:0000

xav@xav-laptop:/$ lspci | grep USB
00:1d.0 USB Controller: Intel Corporation 82801G (ICH7 Family) USB
UHCI #1 (rev 01)
00:1d.1 USB Controller: Intel Corporation 82801G (ICH7 Family) USB
UHCI #2 (rev 01)
00:1d.2 USB Controller: Intel Corporation 82801G (ICH7 Family) USB
UHCI #3 (rev 01)
00:1d.3 USB Controller: Intel Corporation 82801G (ICH7 Family) USB
UHCI #4 (rev 01)
00:1d.7 USB Controller: Intel Corporation 82801G (ICH7 Family) USB2
EHCI Controller (rev 01)

xav@xav-laptop:/$ lsmod | egrep "hci|blue"
bluetooth              55908  4 rfcomm,l2cap
sdhci                  18700  0
mmc_core               26756  1 sdhci
ahci                   22020  3
libata                125720  3 ata_piix,ata_generic,ahci
uhci_hcd               25360  0
ohci1394               36528  0
ieee1394              299448  2 sbp2,ohci1394
ehci_hcd               34188  0
usbcore               134280  4 usbhid,uhci_hcd,ehci_hcd

xav@xav-laptop:/$ dmesg | grep Blue
[   45.348000] Bluetooth: Core ver 2.11
[   45.348000] Bluetooth: HCI device and connection manager initialized
[   45.348000] Bluetooth: HCI socket layer initialized
[   45.528000] Bluetooth: L2CAP ver 2.8
[   45.528000] Bluetooth: L2CAP socket layer initialized
[   45.584000] Bluetooth: RFCOMM socket layer initialized
[   45.584000] Bluetooth: RFCOMM TTY layer initialized
[   45.584000] Bluetooth: RFCOMM ver 1.8


I'm stucked here... What can I do ?

Thank you for your time.
Regards.
--
Xavier

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
