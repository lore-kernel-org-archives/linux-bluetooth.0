Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <c004c40d0710311812u50795ca4wa3a8f3a6b2848ec0@mail.gmail.com>
Date: Thu, 1 Nov 2007 02:12:44 +0100
From: "Raul Siles" <raul.siles@gmail.com>
To: bluez-devel@lists.sourceforge.net
MIME-Version: 1.0
Subject: [Bluez-devel] How to confirm if a device has DFU support (dfutool)?
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

Hi everyone,
I'm trying to backup the firmware from a Conceptronic CBT100U USB
Bluetooth dongle using dfutool, and the message I get after selecting
the device is:

# dfutool -dhci0 archive file.dfu
...
 "Can't identify device with DFU mode"
#

I understand this could mean this chip manufacturer does NOT support DFU,
although it is a CSR-based device, and mostly all CSR based modules and dongles
support DFU. How can I confirm if DFU is supported?

Sorry but I couldn't find any info on the net (apart from the dfutool
source code). From a quick code overview, it seems usb_find_devices()
fails to find the device.

The device revision details do not confirm it is a ROM-only device
(Thanks Marcel for the suggestion):

# hciconfig hci0 revision
hci0:   Type: USB
        BD Address: 00:10:60:A6:0C:BC ACL MTU: 192:8 SCO MTU: 64:8
        HCI 16.4
        Chip version: BlueCore02-External
        Max key size: 56 bit
        SCO mapping:  HCI

Thanks!
--
RS

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
