Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Ruben Jenster <rjenster@web.de>
To: bluez-devel@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200503241706.45605.rjenster@web.de>
Subject: [Bluez-devel] usb-2.0 hub problem
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Thu, 24 Mar 2005 17:06:45 +0000

Trying to transmit some audio data to my headset fails, when the bluetooth 
dongle is attached to a usb-2.0 hub. I allready commited a bug to the kernel 
bugtracker but there no one is able to help me.

http://bugme.osdl.org/show_bug.cgi?id=4358

The dongle works perfectly when attached directly to the motherbord.
When attaching it to the usb-2.0 hub I get the following message:

usb 3-3.1: new full speed USB device using ehci_hcd and address 5
Bluetooth: Core ver 2.7
NET: Registered protocol family 31
Bluetooth: HCI device and connection manager initialized
Bluetooth: HCI socket layer initialized
Bluetooth: HCI USB driver ver 2.8
usbcore: registered new driver hci_usb
Bluetooth: L2CAP ver 2.7
Bluetooth: L2CAP socket layer initialized
Bluetooth: RFCOMM ver 1.5
Bluetooth: RFCOMM socket layer initialized
Bluetooth: RFCOMM TTY layer initialized
hci_cmd_task: hci0 command tx timeout
hci_usb_isoc_rx_submit: hci0 isoc rx submit failed urb cf315c14 err -12
hci_usb_isoc_rx_submit: hci0 isoc rx submit failed urb cf315c14 err -12


Maybe someone here is able to help me.

Regards

Ruben


-------------------------------------------------------
This SF.net email is sponsored by Microsoft Mobile & Embedded DevCon 2005
Attend MEDC 2005 May 9-12 in Vegas. Learn more about the latest Windows
Embedded(r) & Windows Mobile(tm) platforms, applications & content.  Register
by 3/29 & save $300 http://ads.osdn.com/?ad_id=6883&alloc_id=15149&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
