Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
Content-Type: text/plain
Message-Id: <1069670448.16352.151.camel@pegasus>
Mime-Version: 1.0
Subject: [Bluez-devel] HID kernel modification
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Mon, 24 Nov 2003 11:40:48 +0100

Hi Folks,

the kernel side HID parser from the USB subsystem is working very good
with almost every USB input device. The current transport layer for the
parser is USB and this is hardcoded into the complete driver. Starting
with Bluetooth HID this limitation should be removed, because Bluetooth
and USB can share the same HID parser.

The Bluetooth HID implementation can't be in the kernel only, because we
need information from the SDP records of the HID device. And pushing SDP
into the kernel is not a good idea. So all SDP stuff and connection
handling is being done in the userspace program bthid. The underlaying
transport protocol HIDP is also handled by this program. The code for
bthid already exists in the CVS repository utils2 and is built on top of
the new Bluetooth library and the new SDP code. We have now the HID
descriptor and the HID reports and we must feed these into the kernel
side HID parser to generate the input events. The HID descriptor has
only to be send once, while a HID report is generated on every key
click, mouse movement etc.

My idea is to build up a general interface for writing HID drivers in
userspace and then use it for the Bluetooth HID. I like to establish a
HID control character device (/dev/hidctl c 10 224) that have two modes.
After opening this device, it is in HID descriptor mode and every write
operation will set the HID descriptor. The read operation does nothing
and in normal cases only one write is needed. After that we issue a
create ioctl to register to the HID parser with the HID descriptor and
the device is switched to HID report input mode. Now every write will be
a report from a Bluetooth device for example and every read gives us an
report that we have to send back to the Bluetooth device. With a release
ioctl we can switch the device back into HID descriptor input mode. The
parameters for the create ioctl should contain name, vendor, product and
version information which can be retrieved from the SDP records and
pushed into the HID parser and input subsystem to let the already known
quirks work if some devices have broken HID implementations.

Comments?

Regards

Marcel




-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
