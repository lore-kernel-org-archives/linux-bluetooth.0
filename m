Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] No communication with USB BT device
From: Marcel Holtmann <marcel@holtmann.org>
To: Rob Shepherd <robshep@informatics.bangor.ac.uk>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <40D19CD8.20503@informatics.bangor.ac.uk>
References: <40D19CD8.20503@informatics.bangor.ac.uk>
Content-Type: text/plain
Message-Id: <1087487697.4309.65.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Thu, 17 Jun 2004 17:54:57 +0200

Hi Rob,

> No HCI connection is possible with my Belkin Bluetooth module. (CSR chip)
> 
> __System__
> 
> Linux kernel 2.6.7
> 
> bluez-libs-2.7
> bluez-utils-2.7
> bluez-pin-0.23
> bluez-hcidump-1.8
> 
> __output__
> 
> $ dmesg | grep -i usb
> sbcore: registered new driver usbfs
> usbcore: registered new driver hub
> USB Universal Host Controller Interface driver v2.2
> uhci_hcd 0000:00:07.2: Intel Corp. 82371AB/EB/MB PIIX4 USB
> uhci_hcd 0000:00:07.2: new USB bus registered, assigned bus number 1
> hub 1-0:1.0: USB hub found
> usbcore: registered new driver usblp
> drivers/usb/class/usblp.c: v0.13: USB Printer Device Class driver
> Initializing USB Mass Storage driver...
> usbcore: registered new driver usb-storage
> USB Mass Storage support registered.
> usbcore: registered new driver usbhid
> drivers/usb/input/hid-core.c: v2.0:USB HID core driver
> usb 1-1: new full speed USB device using address 2
> Bluetooth: HCI USB driver ver 2.6
> usbcore: registered new driver hci_usb
> 
> __Order of events__
> 
> Boot system
> insert dongle [no hotplug system running]
> modprobe hci_usb
> /etc/init.d/bluetooth start [HIDP complains (ignoring)]
> 
> hciconfig shows...[no device params read from device]
> 
> hci0:   Type: USB
>          BD Address: 00:00:00:00:00:00 ACL MTU: 0:0  SCO MTU: 0:0
>          DOWN
>          RX bytes:0 acl:0 sco:0 events:0 errors:0
>          TX bytes:6 acl:0 sco:0 commands:2 errors:0
> 
> hciconfig hci0 up times out.
> 
> hcidump show a hci_rlsf command but no response from chip.
> 
> This device works fine with Widcomm drivers/stack/application
> 
> when same machine is booted into windows XP (shudder)
> 
> Where might I be going wrong, What else could I try?

what does /proc/bus/usb/devices and lspci say?

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by The 2004 JavaOne(SM) Conference
Learn from the experts at JavaOne(SM), Sun's Worldwide Java Developer
Conference, June 28 - July 1 at the Moscone Center in San Francisco, CA
REGISTER AND SAVE! http://java.sun.com/javaone/sf Priority Code NWMGYKND
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
