Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Problems with a Broadcom USB Bluetooth Adapter
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <422860FF.9080202@gmail.com>
References: <422860FF.9080202@gmail.com>
Content-Type: text/plain
Message-Id: <1109943266.8058.35.camel@pegasus>
Mime-Version: 1.0
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
Date: Fri, 04 Mar 2005 14:34:26 +0100

Hi Fabio,

> I'm trying to use my bluetooth adapter with a Linux box (Debian Sarge, 
> with kernel 2.6.10), but I found some problems.
> 
> When I plug the adapter into the usb slot, the KDE Information Center 
> can see the new hardware as BCM2033 Bluetooth (class 224, usb version 
> 1.01, vendor id 0xa5c Broadcom, product id 0x2033 BCM2033 Bluetooth, 
> revision 0.a0, speed 12 Mbit/s). Anyway, I also installed (through 
> apt-get) KBluetoothD, but when I run it I get an error message saying: 
> "No working Bluetooth adapter found. Only local services will be 
> displayed". I also tried the hciconfig utility from root console, but 
> the output is nothing.
> 
> My kernel is the 2.6.10 version, recompiled by me (I needed to do this 
> because I experienced many problems with the ACPI support). I think all 
> necessary modules are presents; the command "modprobe -l | grep 
> bluetooth" give me:
> 
> /lib/modules/2.6.10/kernel/drivers/bluetooth/hci_uart.ko
> /lib/modules/2.6.10/kernel/drivers/bluetooth/bfusb.ko
> /lib/modules/2.6.10/kernel/drivers/bluetooth/bcm203x.ko
> /lib/modules/2.6.10/kernel/drivers/bluetooth/hci_vhci.ko
> /lib/modules/2.6.10/kernel/drivers/bluetooth/hci_usb.ko
> /lib/modules/2.6.10/kernel/net/bluetooth/bluetooth.ko
> /lib/modules/2.6.10/kernel/net/bluetooth/l2cap.ko
> /lib/modules/2.6.10/kernel/net/bluetooth/sco.ko
> /lib/modules/2.6.10/kernel/net/bluetooth/rfcomm/rfcomm.ko
> /lib/modules/2.6.10/kernel/net/bluetooth/bnep/bnep.ko
> 
> The command "lsmod" give me (mixed with other things):
> 
> bluetooth              43780  5 hci_usb,rfcomm,l2cap
> bcm203x                 4736  0
> firmware_class          7936  1 bcm203x
> usbcore               117624  6 bcm203x,hci_usb,ndiswrapper,usbhid,ohci_hcd
> usbhid                 40512  0
> ohci_hcd               32776  0
> 
> I also paste here the dmesg output, starting from the time when I plug 
> the adapter:
> 
> hub 1-0:1.0: state 5 ports 4 chg fff0 evt 0002
> ohci_hcd 0000:00:02.0: GetStatus roothub.portstatus [0] = 0x00010101 CSC 
> PPS CCS
> hub 1-0:1.0: port 1, status 0101, change 0001, 12 Mb/s
> hub 1-0:1.0: debounce: port 1: total 100ms stable 100ms status 0x101
> ohci_hcd 0000:00:02.0: GetStatus roothub.portstatus [0] = 0x00100103 
> PRSC PPS PES CCS
> usb 1-1: new full speed USB device using ohci_hcd and address 3
> ohci_hcd 0000:00:02.0: GetStatus roothub.portstatus [0] = 0x00100103 
> PRSC PPS PES CCS
> usb 1-1: new device strings: Mfr=0, Product=0, SerialNumber=0
> usb 1-1: hotplug
> usb 1-1: adding 1-1:1.0 (config #1, interface 0)
> usb 1-1:1.0: hotplug
> usb 1-1: adding 1-1:1.1 (config #1, interface 1)
> usb 1-1:1.1: hotplug
> usb 1-1: adding 1-1:1.2 (config #1, interface 2)
> usb 1-1:1.2: hotplug
> Bluetooth: HCI USB driver ver 2.7
> hci_usb 1-1:1.0: usb_probe_interface
> hci_usb 1-1:1.0: usb_probe_interface - got id
> hci_usb 1-1:1.1: usb_probe_interface
> hci_usb 1-1:1.1: usb_probe_interface - got id
> hci_usb 1-1:1.2: usb_probe_interface
> hci_usb 1-1:1.2: usb_probe_interface - got id
> usbcore: registered new driver hci_usb
> bcm203x: Unknown symbol release_firmware
> bcm203x: Unknown symbol request_firmware
> Bluetooth: Broadcom Blutonium firmware driver ver 1.0
> bcm203x 1-1:1.0: usb_probe_interface
> bcm203x 1-1:1.0: usb_probe_interface - got id
> bcm203x_probe: Mini driver request failed
> bcm203x: probe of 1-1:1.0 failed with error -5
> bcm203x 1-1:1.1: usb_probe_interface
> bcm203x 1-1:1.1: usb_probe_interface - got id
> bcm203x 1-1:1.2: usb_probe_interface
> bcm203x 1-1:1.2: usb_probe_interface - got id
> usbcore: registered new driver bcm203x

install the bluez-firmware package.

Regards

Marcel




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
