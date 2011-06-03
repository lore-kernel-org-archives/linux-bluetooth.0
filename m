Return-Path: <cyrus@holtmann.org>
From: Peter Hurley <peter@hurleysoftware.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
CC: Peter Hurley <peter@hurleysoftware.com>
Date: Fri, 3 Jun 2011 16:53:03 -0400
Subject: [PATCH] Corrected udev rule for Logitech devices
Message-ID: <1307134383.2622.89.camel@THOR>
Content-Type: text/plain; charset=US-ASCII
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The *real* history of this file is a nightmare. Now that it's
back in the bluez project, fix the problems that were added
while it was in udev.

1) Only hiddev* devices provide the ioctl interface hid2hci uses
to switch from HID->HCI for --method=logitech-hid.  (inquiring
minds can look in the kernel git tree at drivers/hid/usbhid/hiddev.c)
2) hidraw* devices don't belong to subsystem=usb (they are
subsystem=hidraw).  This means that the udev rule that matched based on
hidraw* would never have been run anyway because of the early-out
subsystem!=usb on line 4.

This fix is going to cause major regressions in distros because there
is currently no way provided by bluez to *NOT* run hid2hci.

Many, many users (and maintainers) mistakenly believe that because
the keyboard and mouse works when the vid/pid of their device is matched
by the hidraw* rule, that "bluetooth" must be working. Of course, what's
really happening is the keyboard and mouse are working as HID input
devices instead.

Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
---
 scripts/bluetooth-hid2hci.rules |    4 +---
 1 files changed, 1 insertions(+), 3 deletions(-)

diff --git a/scripts/bluetooth-hid2hci.rules b/scripts/bluetooth-hid2hci.rules
index 3b36629..0687c8a 100644
--- a/scripts/bluetooth-hid2hci.rules
+++ b/scripts/bluetooth-hid2hci.rules
@@ -11,9 +11,7 @@ ATTR{bInterfaceClass}=="03", ATTR{bInterfaceSubClass}=="01", ATTR{bInterfaceProt
   RUN+="hid2hci --method=dell --devpath=%p", ENV{HID2HCI_SWITCH}="1"
 
 # Logitech devices
-KERNEL=="hiddev*", ATTRS{idVendor}=="046d", ATTRS{idProduct}=="c70[35e]", \
-  RUN+="hid2hci --method=logitech-hid --devpath=%p"
-KERNEL=="hidraw*", ATTRS{idVendor}=="046d", ATTRS{idProduct}=="c70[4abc]|c71[34bc]", \
+KERNEL=="hiddev*", ATTRS{idVendor}=="046d", ATTRS{idProduct}=="c70[345abce]|c71[34bc]", \
   RUN+="hid2hci --method=logitech-hid --devpath=%p"
 
 ENV{DEVTYPE}!="usb_device", GOTO="hid2hci_end"
-- 
1.7.4.1

