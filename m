Return-Path: <cyrus@holtmann.org>
Message-ID: <1357655616.5641.13.camel@dellpc>
Subject: usb device removed from sysfs before input children devices
From: Karl Relton <karllinuxtest.relton@ntlworld.com>
To: linux-usb@vger.kernel.org, linux-bluetooth@vger.kernel.org
Date: Tue, 08 Jan 2013 14:33:36 +0000
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On coming out of suspend my usb bluetooth adaptor is being reset by the
system.

In linux 3.7 the usb devices are being removed from the sysfs tree
first, and then the various 'child' devices (like my bluetooth mouse &
keyboard related devices) afterwards. This is causing the udev events
for the input devices to have 'orphaned' sysfs paths in the udev events.

This in turn means the Xorg evdev driver does not recognise the events,
and so doesn't see the removal of the input devices.

This has been picked by some downstream distributions, e.g. see this
thread by Google Chrome developers:

http://code.google.com/p/chromium-os/issues/detail?id=33813

Back on linux 3.2 this was not the case. The usb adaptor was reset, but
device removal was orderly: first the input devices (will full paths in
the udev events), then the usb devices walking up the tree.


To illustrate the issue, here is the output of 'udevadm monitor' in 3.7:

udevadm monitor
monitor will print the received events for:
KERNEL - the kernel uevent
KERNEL[2203.173080] remove   /devices/pci0000:00/0000:00:1a.0/usb3/3-2/3-2:1.0/bluetooth/hci0/rfkill2 (rfkill)
KERNEL[2203.173148] remove   /devices/pci0000:00/0000:00:1a.0/usb3/3-2/3-2:1.0/bluetooth/hci0 (bluetooth)
KERNEL[2203.173420] remove   /devices/pci0000:00/0000:00:1a.0/usb3/3-2/3-2:1.0 (usb)
KERNEL[2203.173451] remove   /devices/pci0000:00/0000:00:1a.0/usb3/3-2/3-2:1.1 (usb)
KERNEL[2203.173475] remove   /devices/pci0000:00/0000:00:1a.0/usb3/3-2/3-2:1.2 (usb)
KERNEL[2203.173693] remove   /devices/pci0000:00/0000:00:1a.0/usb3/3-2 (usb)
KERNEL[2213.152339] remove   /hci0/hci0:46/input14/mouse2 (input)
KERNEL[2213.160374] remove   /hci0/hci0:46/input14/event10 (input)
KERNEL[2213.168366] remove   /hci0/hci0:46/input14 (input)
KERNEL[2213.169058] remove   /hci0/hci0:46/0005:050D:0031.0005/hidraw/hidraw0 (hidraw)
KERNEL[2213.169198] remove   /hci0/hci0:46/0005:050D:0031.0005 (hid)
KERNEL[2213.169242] remove   /hci0/hci0:46 (bluetooth)
KERNEL[2218.176527] remove   /hci0/hci0:49/input13/event11 (input)
KERNEL[2218.180403] remove   /hci0/hci0:49/input13 (input)
KERNEL[2218.180481] remove   /hci0/hci0:49/0005:05AC:0256.0004/hidraw/hidraw1 (hidraw)
KERNEL[2218.180538] remove   /hci0/hci0:49/0005:05AC:0256.0004 (hid)
KERNEL[2218.182005] remove   /hci0/hci0:49 (bluetooth)

See how the usb devices are moved first, and then the input/bluetooth related stuff
with path-heads removed (paths are now /hci0/... instead of /devices/...)


Here is the equiv sequence back in 3.2:

KERNEL[158.378301] remove   /devices/pci0000:00/0000:00:1a.0/usb3/3-2/3-2:1.0/bluetooth/hci0/hci0:49/input11/mouse2 (input)
KERNEL[158.388283] remove   /devices/pci0000:00/0000:00:1a.0/usb3/3-2/3-2:1.0/bluetooth/hci0/hci0:49/input11/event11 (input)
KERNEL[158.409885] remove   /devices/pci0000:00/0000:00:1a.0/usb3/3-2/3-2:1.0/bluetooth/hci0/hci0:49/input11 (input)
KERNEL[158.411565] remove   /devices/pci0000:00/0000:00:1a.0/usb3/3-2/3-2:1.0/bluetooth/hci0/hci0:49/0005:050D:0031.0002/hidraw/hidraw1 (hidraw)
KERNEL[158.411598] remove   /devices/pci0000:00/0000:00:1a.0/usb3/3-2/3-2:1.0/bluetooth/hci0/hci0:49/0005:050D:0031.0002 (hid)
KERNEL[158.411621] remove   /devices/pci0000:00/0000:00:1a.0/usb3/3-2/3-2:1.0/bluetooth/hci0/hci0:49 (bluetooth)
KERNEL[158.436894] remove   /devices/pci0000:00/0000:00:1a.0/usb3/3-2/3-2:1.0/bluetooth/hci0/hci0:46/input10/event10 (input)
KERNEL[158.452211] remove   /devices/pci0000:00/0000:00:1a.0/usb3/3-2/3-2:1.0/bluetooth/hci0/hci0:46/input10 (input)
KERNEL[158.452628] remove   /devices/pci0000:00/0000:00:1a.0/usb3/3-2/3-2:1.0/bluetooth/hci0/hci0:46/0005:05AC:0256.0001/hidraw/hidraw0 (hidraw)
KERNEL[158.452662] remove   /devices/pci0000:00/0000:00:1a.0/usb3/3-2/3-2:1.0/bluetooth/hci0/hci0:46/0005:05AC:0256.0001 (hid)
KERNEL[158.452752] remove   /devices/pci0000:00/0000:00:1a.0/usb3/3-2/3-2:1.0/bluetooth/hci0/hci0:46 (bluetooth)
KERNEL[158.629847] remove   /devices/pci0000:00/0000:00:1a.0/usb3/3-2/3-2:1.0/bluetooth/hci0/rfkill2 (rfkill)
KERNEL[158.629920] remove   /devices/pci0000:00/0000:00:1a.0/usb3/3-2/3-2:1.0/bluetooth/hci0 (bluetooth)
KERNEL[158.635562] remove   /devices/pci0000:00/0000:00:1a.0/usb3/3-2/3-2:1.0 (usb)
KERNEL[158.635701] remove   /devices/pci0000:00/0000:00:1a.0/usb3/3-2/3-2:1.1 (usb)
KERNEL[158.635807] remove   /devices/pci0000:00/0000:00:1a.0/usb3/3-2/3-2:1.2 (usb)
KERNEL[158.637238] remove   /devices/pci0000:00/0000:00:1a.0/usb3/3-2 (usb)


The end result (for the user) is that even when the bluetooth
mouse/keyboard is re-added, Xorg ignores it - thinking it is some hoax
duplicate device. The keyboard/mouse is then non-operational.

Karl

