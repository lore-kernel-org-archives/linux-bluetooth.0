Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <ee588a540711011225n2aa96580r8ba08556808db334@mail.gmail.com>
Date: Thu, 1 Nov 2007 20:25:23 +0100
From: "Xose Vazquez Perez" <xose.vazquez@gmail.com>
To: linux-usb-users@lists.sf.net, bluez-devel@lists.sf.net
MIME-Version: 1.0
Subject: [Bluez-devel] Belkin F8T012 usb/bluetooth does not work
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

hi,

when I plug the Belkin device I see at dmesg:

usb 2-2: new full speed USB device using uhci_hcd and address 13
usb 2-2: configuration #1 chosen from 1 choice
Bluetooth: HCI USB driver ver 2.9
usbcore: registered new interface driver hci_usb
pegasus: v0.6.14 (2006/09/27), Pegasus/Pegasus II USB Ethernet driver

but the device doesn't work, and # lsusb hangs forever.

After I remove the device I see a lot of errors:

pegasus 2-2:1.2: get_registers, status -19
pegasus 2-2:1.2: get_registers, status -19
pegasus 2-2:1.2: get_registers, status -19
pegasus 2-2:1.2: get_registers, status -19
pegasus 2-2:1.2: get_registers, status -19
pegasus 2-2:1.2: get_registers, status -19
pegasus 2-2:1.2: get_registers, status -19
pegasus 2-2:1.2: get_registers, status -19
pegasus 2-2:1.2: get_registers, status -19
pegasus 2-2:1.2: get_registers, status -19
pegasus 2-2:1.2: get_registers, status -19
pegasus 2-2:1.2: get_registers, status -19
pegasus 2-2:1.2: get_registers, status -19
pegasus 2-2:1.2: get_registers, status -19
pegasus 2-2:1.2: get_registers, status -19
pegasus 2-2:1.2: get_registers, status -19
pegasus 2-2:1.2: get_registers, status -19
pegasus 2-2:1.2: get_registers, status -19
pegasus 2-2:1.2: get_registers, status -19
pegasus 2-2:1.2: get_registers, status -19


Also my Fedora 7 with kernel 2.6.23.1 does not boot
if I left the device plugin inside a usb connector.
I must remove it to boot.

what's wrong with the driver ? any idea ?

-thanks-

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
