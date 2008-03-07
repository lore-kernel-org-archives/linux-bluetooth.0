Return-Path: <cyrus@holtmann.org>
Message-ID: <bd3fd7dd0803070750j52c5d313k6c04735a68583f32@mail.gmail.com>
Date: Fri, 7 Mar 2008 10:50:44 -0500
From: "Jeff Fouchard" <jfouchard@gmail.com>
To: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Subject: [Bluez-users] BCM 2045 Issues
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Hello,

My BCM 2045 Device worked correctly up until last night.  Now on
insertion I only get two USB HID devices.  Inserting the usb_hci
module with reset=1 does not seem to work.  I have been using the
stock Gutsy kernel, but have updated to the Hardy kernel with the same
results. After some (a lot) of research the device seems to be stuck
in HID mode, but I have no idea how to bring it out.  hid2hci does not
detect anything connected to switch. Works fine on another computer
running WindowsXP. hcitool lists no devices.  Some outputs that may be
useful:

lsusb
Bus 002 Device 004: ID 058f:6362 Alcor Micro Corp.
Bus 002 Device 001: ID 0000:0000
Bus 001 Device 005: ID 0a5c:4503 Broadcom Corp.
Bus 001 Device 004: ID 0a5c:4502 Broadcom Corp.
Bus 001 Device 003: ID 0a5c:4500 Broadcom Corp.
Bus 001 Device 002: ID 046d:c01d Logitech, Inc.
Bus 001 Device 001: ID 0000:0000

Syslog on insertion:
Mar  7 10:45:05 ubuntu-server kernel: [ 1061.935885] usb 1-8: new full
speed USB device using ohci_hcd and address 6
Mar  7 10:45:05 ubuntu-server kernel: [ 1062.156870] usb 1-8:
configuration #1 chosen from 1 choice
Mar  7 10:45:05 ubuntu-server kernel: [ 1062.159784] hub 1-8:1.0: USB hub found
Mar  7 10:45:05 ubuntu-server kernel: [ 1062.162765] hub 1-8:1.0: 3
ports detected
Mar  7 10:45:05 ubuntu-server NetworkManager: <debug>
[1204904705.787912] nm_hal_device_added(): New device added (hal udi
is '/org/freedesktop/Hal/devices/usb_device_a5c_4500_noserial').
Mar  7 10:45:05 ubuntu-server NetworkManager: <debug>
[1204904705.874234] nm_hal_device_added(): New device added (hal udi
is '/org/freedesktop/Hal/devices/usb_device_ffffffff_ffffffff_noserial').
Mar  7 10:45:06 ubuntu-server kernel: [ 1062.496316] usb 1-8.2: new
full speed USB device using ohci_hcd and address 7
Mar  7 10:45:06 ubuntu-server kernel: [ 1062.616255] usb 1-8.2:
configuration #1 chosen from 1 choice
Mar  7 10:45:06 ubuntu-server kernel: [ 1062.626343] input: Broadcom
Corp BCM2045B3 ROM as
/devices/pci0000:00/0000:00:02.0/usb1/1-8/1-8.2/1-8.2:1.0/input/input8
Mar  7 10:45:06 ubuntu-server NetworkManager: <debug>
[1204904706.245200] nm_hal_device_added(): New device added (hal udi
is '/org/freedesktop/Hal/devices/usb_device_a5c_4502_noserial').
Mar  7 10:45:06 ubuntu-server kernel: [ 1062.666928] input,hidraw1:
USB HID v1.11 Keyboard [Broadcom Corp BCM2045B3 ROM] on
usb-0000:00:02.0-8.2
Mar  7 10:45:06 ubuntu-server NetworkManager: <debug>
[1204904706.316702] nm_hal_device_added(): New device added (hal udi
is '/org/freedesktop/Hal/devices/usb_device_a5c_4502_noserial_if0').
Mar  7 10:45:06 ubuntu-server NetworkManager: <debug>
[1204904706.384743] nm_hal_device_added(): New device added (hal udi
is '/org/freedesktop/Hal/devices/usb_device_a5c_4502_noserial_if0_logicaldev_input').
Mar  7 10:45:06 ubuntu-server kernel: [ 1062.875800] usb 1-8.3: new
full speed USB device using ohci_hcd and address 8
Mar  7 10:45:06 ubuntu-server kernel: [ 1062.995745] usb 1-8.3:
configuration #1 chosen from 1 choice
Mar  7 10:45:06 ubuntu-server NetworkManager: <debug>
[1204904706.622069] nm_hal_device_added(): New device added (hal udi
is '/org/freedesktop/Hal/devices/usb_device_a5c_4503_noserial').
Mar  7 10:45:06 ubuntu-server kernel: [ 1063.006826] input: Broadcom
Corp BCM2045B3 ROM as
/devices/pci0000:00/0000:00:02.0/usb1/1-8/1-8.3/1-8.3:1.0/input/input9
Mar  7 10:45:06 ubuntu-server kernel: [ 1063.046402] input,hidraw2:
USB HID v1.11 Mouse [Broadcom Corp BCM2045B3 ROM] on
usb-0000:00:02.0-8.3
Mar  7 10:45:06 ubuntu-server NetworkManager: <debug>
[1204904706.691654] nm_hal_device_added(): New device added (hal udi
is '/org/freedesktop/Hal/devices/usb_device_a5c_4503_noserial_if0').
Mar  7 10:45:06 ubuntu-server NetworkManager: <debug>
[1204904706.775762] nm_hal_device_added(): New device added (hal udi
is '/org/freedesktop/Hal/devices/usb_device_a5c_4503_noserial_if0_logicaldev_input').


Any assistance would be greatly welcomed, as I'm a might bit confused
as to why it would just stop working.

Thanks,
Jeff

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
