Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
Cc: Vojtech Pavlik <vojtech@suse.cz>, Greg Kroah-Hartman <greg@kroah.com>
Content-Type: multipart/mixed; boundary="=-bi0x6HHc1zPkx7lF1hcO"
Message-Id: <1079963694.2663.247.camel@pegasus>
Mime-Version: 1.0
Subject: [Bluez-devel] Renaming USB HID driver
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Mon, 22 Mar 2004 14:54:54 +0100


--=-bi0x6HHc1zPkx7lF1hcO
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi Folks,

my plan is to move the HID parser out of the USB subsystem and provide a
general HID parser implementation under drivers/hid/ which could then be
used by the USB and the Bluetooth subsystem drivers. To avoid any naming
conflict due and after the development I suggest to rename the USB HID
module from hid.ko to usbhid.ko (see attached patch).

I know that renaming a kernel module in a stable series is not a good
idea, but doing it now will help us in the long term. However people
which are using hotplug won't even notice it, because the kernel knows
the right module name. And if the transition is finished we can simply
remove the HID parser code from usbhid and everything will still work.

In the end it should look like this:

	drivers/hid/hid.ko		HID parser (input+hiddev+ff)
	drivers/usb/input/usbhid.ko	USB HID transport layer
	net/bluetooth/hidp/hidp.ko	Bluetooth HID protocol

Comments?

Regards

Marcel


--=-bi0x6HHc1zPkx7lF1hcO
Content-Disposition: attachment; filename=patch
Content-Type: text/plain; name=patch; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

===== drivers/usb/input/Kconfig 1.13 vs edited =====
--- 1.13/drivers/usb/input/Kconfig	Fri Feb 27 00:32:51 2004
+++ edited/drivers/usb/input/Kconfig	Mon Mar 22 14:42:37 2004
@@ -21,7 +21,7 @@
 	  If unsure, say Y.
 
 	  To compile this driver as a module, choose M here: the
-	  module will be called hid.
+	  module will be called usbhid.
 
 comment "Input core support is needed for USB HID input layer or HIDBP support"
 	depends on USB && INPUT=n
===== drivers/usb/input/Makefile 1.17 vs edited =====
--- 1.17/drivers/usb/input/Makefile	Fri Feb 27 13:51:51 2004
+++ edited/drivers/usb/input/Makefile	Mon Mar 22 14:32:15 2004
@@ -3,32 +3,32 @@
 #
 
 # Multipart objects.
-hid-objs	:= hid-core.o
+usbhid-objs	:= hid-core.o
 
 # Optional parts of multipart objects.
 
 ifeq ($(CONFIG_USB_HIDDEV),y)
-	hid-objs        += hiddev.o
+	usbhid-objs	+= hiddev.o
 endif
 ifeq ($(CONFIG_USB_HIDINPUT),y)
-	hid-objs        += hid-input.o
+	usbhid-objs	+= hid-input.o
 endif
 ifeq ($(CONFIG_HID_PID),y)
-	hid-objs	+= pid.o
+	usbhid-objs	+= pid.o
 endif
 ifeq ($(CONFIG_LOGITECH_FF),y)
-	hid-objs	+= hid-lgff.o
+	usbhid-objs	+= hid-lgff.o
 endif
 ifeq ($(CONFIG_THRUSTMASTER_FF),y)
-	hid-objs	+= hid-tmff.o
+	usbhid-objs	+= hid-tmff.o
 endif
 ifeq ($(CONFIG_HID_FF),y)
-	hid-objs	+= hid-ff.o
+	usbhid-objs	+= hid-ff.o
 endif
 
 obj-$(CONFIG_USB_AIPTEK)	+= aiptek.o
 obj-$(CONFIG_USB_ATI_REMOTE)	+= ati_remote.o
-obj-$(CONFIG_USB_HID)		+= hid.o
+obj-$(CONFIG_USB_HID)		+= usbhid.o
 obj-$(CONFIG_USB_KBD)		+= usbkbd.o
 obj-$(CONFIG_USB_KBTAB)		+= kbtab.o
 obj-$(CONFIG_USB_MOUSE)		+= usbmouse.o

--=-bi0x6HHc1zPkx7lF1hcO--



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
