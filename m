Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
Content-Type: text/plain
Message-Id: <1075138576.25442.128.camel@pegasus>
Mime-Version: 1.0
Subject: [Bluez-devel] Future kernel development
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
Date: Mon, 26 Jan 2004 18:36:16 +0100

Hi Folks,

the resync with the kernel 2.6 series is finished and all outstanding
patches and fixes are merged into 2.6.2-rc1. Now the Bluetooth subsystem
of the 2.4 and 2.6 series share mostly the same code base. I don't have
any plans to send Marcelo further updates for the 2.4 tree and of course
he wouldn't accept them either. The -mh patch for the upcoming 2.4.25
contains only a CAPI and a HID update. And until now, nobody reported
any outstanding bugs with Bluetooth and the 2.4.x kernel.

>>From now on all new stuff should go into 2.6 first, before we even think
of backporting it to 2.4. I started with the integration into the driver
model and the sysfs. And currently it looks like this:

/sys/class/bluetooth/
|-- hci0
|   |-- address
|   |-- device -> ../../../devices/pci0000:00/0000:00:1e.0/0000:02:0c.0/usb2/2-2/2-2:1.0
|   |-- driver -> ../../../bus/usb/drivers/hci_usb
|   |-- flags
|   |-- inquiry_cache
|   |-- name
|   `-- type
`-- hci1
    |-- address
    |-- device -> ../../../devices/pci0000:00/0000:00:1e.0/0000:02:0c.1/usb3/3-1/3-1:1.0
    |-- driver -> ../../../bus/usb/drivers/bfusb
    |-- flags
    |-- inquiry_cache
    |-- name
    `-- type

At the moment only a small number of attributes are exported, but in
general we can export everything we like. So my question is what makes
sense to export?

The way for the Bluetooth core and driver model is very clear. If it
comes to L2CAP or RFCOMM I have no idea how to fit this in at the
moment. So any comments are very welcome.

Regards

Marcel




-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
