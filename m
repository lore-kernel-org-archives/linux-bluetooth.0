Return-Path: <bluez-users-admin@lists.sourceforge.net>
To: bluez-users@lists.sourceforge.net
From: Mathis <mathis_w@gmx.net>
Message-ID: <loom.20050130T212956-606@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Subject: [Bluez-users] F8T001 version 1 and SuSE 9.2
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
Date: Sun, 30 Jan 2005 20:35:52 +0000 (UTC)

Hello,
I have SuSE Linux 9.2 installed with all updates, installed all bluez packages,
rebooted, plugged in my Belkin F8T001 USB Bluetooth dongle, KDE told me that it
found a new device, set it up -- enabling bluetooth daemon, configuring things
(left everything on default), pressed OK -- the daemon started, but nothing else
happened, I am unable to do anything...

"hcitool dev" shows:
Devices:
nothing else...

"lsusb" shows the device as being recognized by the USB subsystem, but seems
that the bluetooth subsystem is not interested in that device.

dmesg shows following (only bluetooth part):
Bluetooth: Core ver 2.6
NET: Registered protocol family 31
Bluetooth: HCI device and connection manager initialized
Bluetooth: HCI socket layer initialized
Bluetooth: L2CAP ver 2.4
Bluetooth: L2CAP socket layer initialized
Bluetooth: HIDP (Human Interface Emulation) ver 1.0
Bluetooth: RFCOMM ver 1.3
Bluetooth: RFCOMM socket layer initialized
Bluetooth: RFCOMM TTY layer initialized
usb 2-1: new full speed USB device using address 2
Bluetooth: HCI USB driver ver 2.7
usbcore: registered new driver hci_usb

Any hints?




-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
