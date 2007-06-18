Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Date: Mon, 18 Jun 2007 19:28:19 +0300
From: Mikko Tuumanen <mijutu@utu.fi>
To: bluez-users@lists.sourceforge.net
Message-id: <20070618162819.GK30167@sorvankyla.yok.utu.fi>
MIME-version: 1.0
Subject: [Bluez-users] Are Gembird and Targus usb bluetooth dongles going to
	be supported?
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

Hello.

I have a "Gembird" (0a12:0001) and a 
"Targus" (0a5c:4503, 0a5c:4502, 0a5c:2100, 0a5c:4500)
usb bluetooth dongle at work.

The Gembird attaches and detaches when connected:
usb 4-2: new full speed USB device using uhci_hcd and address 25
usb 4-2: configuration #1 chosen from 1 choice
hub 4-0:1.0: port 2 disabled by hub (EMI?), re-enabling...
usb 4-2: USB disconnect, address 25
usb 4-2: new full speed USB device using uhci_hcd and address 26
usb 4-2: device descriptor read/64, error -71
usb 4-2: device descriptor read/64, error -71
usb 4-2: new full speed USB device using uhci_hcd and address 27
usb 4-2: device descriptor read/64, error -71
usb 4-2: device descriptor read/64, error -84
usb 4-2: new full speed USB device using uhci_hcd and address 28
usb 4-2: device descriptor read/8, error -75
usb 4-2: device descriptor read/8, error -71
usb 4-2: new full speed USB device using uhci_hcd and address 29
usb 4-2: device descriptor read/8, error -75
usb 4-2: device descriptor read/8, error -71

Later after keeping the gembird connected for a while:
usb 5-4.3: new full speed USB device using ehci_hcd and address 49
hub 5-4:1.0: Cannot enable port 3.  Maybe the USB cable is bad?
hub 5-4:1.0: Cannot enable port 3.  Maybe the USB cable is bad?
hub 5-4:1.0: Cannot enable port 3.  Maybe the USB cable is bad?
hub 5-4:1.0: Cannot enable port 3.  Maybe the USB cable is bad?
usb 5-4.3: new full speed USB device using ehci_hcd and address 53
hub 5-4:1.0: Cannot enable port 3.  Maybe the USB cable is bad?
hub 5-4:1.0: Cannot enable port 3.  Maybe the USB cable is bad?
hub 5-4:1.0: Cannot enable port 3.  Maybe the USB cable is bad?
hub 5-4:1.0: Cannot enable port 3.  Maybe the USB cable is bad?
usb 5-4.3: new full speed USB device using ehci_hcd and address 57
usb 5-4.3: configuration #1 chosen from 1 choice
hci_usb_isoc_rx_submit: hci0 isoc rx submit failed urb ffff8100c6b66a28 err -28
hci_usb_isoc_rx_submit: hci0 isoc rx submit failed urb ffff8100c6b66a28 err -28
usb 5-4.3: USB disconnect, address 57
usb 5-4.3: new full speed USB device using ehci_hcd and address 58
hub 5-4:1.0: Cannot enable port 3.  Maybe the USB cable is bad?
hub 5-4:1.0: Cannot enable port 3.  Maybe the USB cable is bad?
hub 5-4:1.0: Cannot enable port 3.  Maybe the USB cable is bad?
hub 5-4:1.0: Cannot enable port 3.  Maybe the USB cable is bad?
usb 5-4.3: new full speed USB device using ehci_hcd and address 62
usb 5-4.3: new full speed USB device using ehci_hcd and address 63
hub 5-4:1.0: Cannot enable port 3.  Maybe the USB cable is bad?
hub 5-4:1.0: Cannot enable port 3.  Maybe the USB cable is bad?
hub 5-4:1.0: Cannot enable port 3.  Maybe the USB cable is bad?
hub 5-4:1.0: Cannot enable port 3.  Maybe the USB cable is bad?
usb 5-4.3: new full speed USB device using ehci_hcd and address 67
usb 5-4.3: configuration #1 chosen from 1 choice
hci_usb_isoc_rx_submit: hci0 isoc rx submit failed urb ffff8100c683ec28 err -28
hci_usb_isoc_rx_submit: hci0 isoc rx submit failed urb ffff8100c683ec28 err -28
usb 5-4.3: USB disconnect, address 67


Targus connects and gets kdebluetooth stuck:
usb 4-2: new full speed USB device using uhci_hcd and address 30
usb 4-2: configuration #1 chosen from 1 choice
hub 4-2:1.0: USB hub found
hub 4-2:1.0: 3 ports detected
usb 4-2.1: new full speed USB device using uhci_hcd and address 31
usb 4-2.1: configuration #1 chosen from 1 choice
usb 4-2.2: new full speed USB device using uhci_hcd and address 32
usb 4-2.2: configuration #1 chosen from 1 choice
input: Broadcom Corp BCM92045DG-Flash_UHE as /class/input/input13
input: USB HID v1.11 Keyboard [Broadcom Corp BCM92045DG-Flash_UHE] on usb-0000:00:1d.3-2.2
usb 4-2.3: new full speed USB device using uhci_hcd and address 33
usb 4-2.3: configuration #1 chosen from 1 choice
input: Broadcom Corp BCM92045DG-Flash_UHE as /class/input/input14
input: USB HID v1.11 Mouse [Broadcom Corp BCM92045DG-Flash_UHE] on usb-0000:00:1d.3-2.3
tsdev (compaq touchscreen emulation) is scheduled for removal.
See Documentation/feature-removal-schedule.txt for details.

kdebluetooth won't even show the tooltip until I remove the targus.

I've put a picture of the gembird and lsusb -v outputs
here:
http://users.utu.fi/mijutu/bugreports/bluez/
There is also a billionton.txt, a lsusb -v from a bluetooth
device that works correctly.

Is there any chance that either of these will start working with
bluez?

What information should I provide to be more helpful?



-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
