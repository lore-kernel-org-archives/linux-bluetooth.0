Return-Path: <h.frydrych@gmx.de>
Message-ID: <40EFABCE.7000503@gmx.de>
Date: Sat, 10 Jul 2004 10:41:50 +0200
From: Holger Frydrych <h.frydrych@gmx.de>
MIME-Version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>
CC: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
Subject: Re: [Bluez-users] Logitech diNovo hub not recognized?
References: <40EEC9CD.8030003@gmx.de> <1089396942.22528.10.camel@pegasus>	 <40EF0F10.8050302@gmx.de> <1089413516.13519.16.camel@pegasus>
In-Reply-To: <1089413516.13519.16.camel@pegasus>
Content-Type: text/plain; charset=us-ascii; format=flowed
List-ID: <bluez-users.lists.sourceforge.net>

Hi,

Marcel Holtmann wrote:
> did hid2hci showed any error messages. Is there anything in the logfiles
> or visible through dmesg. What kind of machine do you use? Do you have
> the hiddevX devices nodes?
hid2hci tells this:
  Switching device 046d:c704 to HCI mode was successful.

But this immediately results in my keyboard, mouse and MediaPad not 
working anymore, or rather they get disconnected, I suppose. So I press 
the connect button on the keyboard and then the one on the hub, just the 
hub does not react (does not start blinking) and so nothing happens. Ok, 
so I've got my old PS/2 keyboard and attached this one additionally so I 
can keep typing. I then tried 'hcitool dev' which now (after hid2hci) 
shows me the logitech hub as hci0. I then typed 'hcitool scan', it does 
not complain about missing devices, the hub starts blinking and it 
finally lists all my diNovo devices. So far, so good. Then I try to 
manually connect one of my devices (doesn't matter, which) via 'hcitool 
cc [address]', and the hub again starts blinking, but all I get in 
result is: 'Can't create connection: Input/Output error'. 'hidd 
--search' returns a similar error: 'Can't create HID control channel: 
Invalid exchange'...

hiddev device nodes are available at /dev/usb/hid, this is where the 
devfs filesystem put them into. The log files do not contain anything of 
interest (unless I missed it), they just state that hcid and hidd have 
started. dmesg does not state any error with Bluetooth, but I'll attach 
anything specific to bluetooth and USb anyway, maybe you can read 
something out of it.

------------------------------ dmesg ---------------------------------

------USB Universal Host Controller Interface driver v2.2
uhci_hcd 0000:00:11.2: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 
Controller
uhci_hcd 0000:00:11.2: irq 4, io base 0000e000
uhci_hcd 0000:00:11.2: new USB bus registered, assigned bus number 1
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
uhci_hcd 0000:00:11.3: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 
Controller (#2)
uhci_hcd 0000:00:11.3: irq 4, io base 0000e400
uhci_hcd 0000:00:11.3: new USB bus registered, assigned bus number 2
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
uhci_hcd 0000:00:11.4: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 
Controller (#3)
uhci_hcd 0000:00:11.4: irq 4, io base 0000e800
uhci_hcd 0000:00:11.4: new USB bus registered, assigned bus number 3
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
usbcore: registered new driver usblp
drivers/usb/class/usblp.c: v0.13: USB Printer Device Class driver
usbcore: registered new driver hiddev
usbcore: registered new driver usbhid
drivers/usb/input/hid-core.c: v2.0:USB HID core driver
[...]
Bluetooth: HCI USB driver ver 2.6
usbcore: registered new driver hci_usb
Bluetooth: VHCI driver ver 1.1
Bluetooth: Broadcom Blutonium firmware driver ver 1.0
usbcore: registered new driver bcm203x
[...]
Bluetooth: L2CAP ver 2.2
Bluetooth: L2CAP socket layer initialized
Bluetooth: SCO (Voice Link) ver 0.3
Bluetooth: SCO socket layer initialized
Bluetooth: RFCOMM ver 1.3
Bluetooth: RFCOMM socket layer initialized
Bluetooth: RFCOMM TTY layer initialized
Bluetooth: BNEP (Ethernet Emulation) ver 1.0
Bluetooth: HIDP (Human Interface Emulation) ver 1.0-mh1
usb 1-1: new full speed USB device using address 2
hub 1-1:1.0: USB hub found
hub 1-1:1.0: 2 ports detected
[...]
usb 1-1.1: new low speed USB device using address 3
input: USB HID v1.10 Keyboard [Logitech USB Receiver] on 
usb-0000:00:11.2-1.1
input,hiddev96: USB HID v1.10 Mouse [Logitech USB Receiver] on 
usb-0000:00:11.2-1.1
[...]
usb 1-1.2: new full speed USB device using address 4
usb 1-2: new low speed USB device using address 5
input: USB HID v1.10 Mouse [Logitech USB-PS/2 Optical Mouse] on 
usb-0000:00:11.2-2
---------------------- dmesg ----------------------------------

Interestingly, the HIDP protocol still identifies as mh1, though I 
meanwhile did supply the mh2 patch. So is this correct, or should I 
investigate more here?


> This is fine. We actually support this hub.
Good. That leaves some hope, at least :)


Best regards

Holger
