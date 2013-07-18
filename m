Return-Path: <cyrus@holtmann.org>
Message-ID: <51E7ED11.7010103@boh.de>
Date: Thu, 18 Jul 2013 15:26:41 +0200
From: =?UTF-8?B?SsO2cmcgRXNzZXI=?= <jackfritt@boh.de>
MIME-Version: 1.0
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: 057c:3800 BlueFRITZ! Bluetooth Stick broken since 2.6.something
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi list,

don´t know if it is wrong to post under the same topic which is more 
than one year old.
Ref to it is here.
http://www.spinics.net/lists/linux-bluetooth/msg18763.html
There was never an answer to the latest question from Michael if there 
will be a solution.

I also tried to get this to run with my latest kernel 3.10 under debian 
7 without success.
Will there be a solution or should I open my real trashbin?(other sticks 
are working so far for me) :)

Let me know if you need more info´s on that.

Thx,
Joerg

My syslog says:
Jul 18 15:11:10 debian-capi kernel: [ 64.808373] usb 1-3: new full-speed 
USB device number 5 using ohci_hcd
Jul 18 15:11:10 debian-capi kernel: [ 65.277828] usb 1-3: New USB device 
found, idVendor=057c, idProduct=3800
Jul 18 15:11:10 debian-capi kernel: [ 65.277834] usb 1-3: New USB device 
strings: Mfr=1, Product=2, SerialNumber=3
Jul 18 15:11:10 debian-capi kernel: [ 65.277838] usb 1-3: Product: 
Bluetooth Device
Jul 18 15:11:10 debian-capi kernel: [ 65.277841] usb 1-3: Manufacturer: 
Bluetooth Device
Jul 18 15:11:10 debian-capi kernel: [ 65.277844] usb 1-3: SerialNumber: 
CC1C8D0E0400
Jul 18 15:11:10 debian-capi bluetoothd[2199]: HCI dev 0 registered
Jul 18 15:11:10 debian-capi bluetoothd[2199]: Listening for HCI events 
on hci0
Jul 18 15:11:11 debian-capi bluetoothd[2894]: Can't init device hci0: 
Invalid request code (56)

debian-capi:~# lsusb -v -d 057c:3800

Bus 001 Device 005: ID 057c:3800 AVM GmbH BlueFRITZ! Bluetooth Stick
Device Descriptor:
bLength 18
bDescriptorType 1
bcdUSB 1.10
bDeviceClass 255 Vendor Specific Class
bDeviceSubClass 255 Vendor Specific Subclass
bDeviceProtocol 255 Vendor Specific Protocol
bMaxPacketSize0 64
idVendor 0x057c AVM GmbH
idProduct 0x3800 BlueFRITZ! Bluetooth Stick
bcdDevice 15.00
iManufacturer 1 Bluetooth Device
iProduct 2 Bluetooth Device
iSerial 3 CC1C8D0E0400
bNumConfigurations 1
Configuration Descriptor:
bLength 9
bDescriptorType 2
wTotalLength 177
bNumInterfaces 2
bConfigurationValue 1
iConfiguration 0
bmAttributes 0xa0
(Bus Powered)
Remote Wakeup
MaxPower 200mA
Interface Descriptor:
bLength 9
bDescriptorType 4
bInterfaceNumber 0
bAlternateSetting 0
bNumEndpoints 3
bInterfaceClass 255 Vendor Specific Class
bInterfaceSubClass 255 Vendor Specific Subclass
bInterfaceProtocol 255 Vendor Specific Protocol
iInterface 0
Endpoint Descriptor:
bLength 7
bDescriptorType 5
bEndpointAddress 0x81 EP 1 IN
bmAttributes 3
Transfer Type Interrupt
Synch Type None
Usage Type Data
wMaxPacketSize 0x0010 1x 16 bytes
bInterval 1
Endpoint Descriptor:
bLength 7
bDescriptorType 5
bEndpointAddress 0x82 EP 2 IN
bmAttributes 2
Transfer Type Bulk
Synch Type None
Usage Type Data
wMaxPacketSize 0x0040 1x 64 bytes
bInterval 0
Endpoint Descriptor:
bLength 7
bDescriptorType 5
bEndpointAddress 0x02 EP 2 OUT
bmAttributes 2
Transfer Type Bulk
Synch Type None
Usage Type Data
wMaxPacketSize 0x0040 1x 64 bytes
bInterval 0
Interface Descriptor:
bLength 9
bDescriptorType 4
bInterfaceNumber 1
bAlternateSetting 0
bNumEndpoints 2
bInterfaceClass 255 Vendor Specific Class
bInterfaceSubClass 255 Vendor Specific Subclass
bInterfaceProtocol 255 Vendor Specific Protocol
iInterface 0
Endpoint Descriptor:
bLength 7
bDescriptorType 5
bEndpointAddress 0x83 EP 3 IN
bmAttributes 1
Transfer Type Isochronous
Synch Type None
Usage Type Data
wMaxPacketSize 0x0000 1x 0 bytes
bInterval 1
Endpoint Descriptor:
bLength 7
bDescriptorType 5
bEndpointAddress 0x03 EP 3 OUT
bmAttributes 1
Transfer Type Isochronous
Synch Type None
Usage Type Data
wMaxPacketSize 0x0000 1x 0 bytes
bInterval 1
Interface Descriptor:
bLength 9
bDescriptorType 4
bInterfaceNumber 1
bAlternateSetting 1
bNumEndpoints 2
bInterfaceClass 255 Vendor Specific Class
bInterfaceSubClass 255 Vendor Specific Subclass
bInterfaceProtocol 255 Vendor Specific Protocol
iInterface 0
Endpoint Descriptor:
bLength 7
bDescriptorType 5
bEndpointAddress 0x83 EP 3 IN
bmAttributes 1
Transfer Type Isochronous
Synch Type None
Usage Type Data
wMaxPacketSize 0x0009 1x 9 bytes
bInterval 1
Endpoint Descriptor:
bLength 7
bDescriptorType 5
bEndpointAddress 0x03 EP 3 OUT
bmAttributes 1
Transfer Type Isochronous
Synch Type None
Usage Type Data
wMaxPacketSize 0x0009 1x 9 bytes
bInterval 1
Interface Descriptor:
bLength 9
bDescriptorType 4
bInterfaceNumber 1
bAlternateSetting 2
bNumEndpoints 2
bInterfaceClass 255 Vendor Specific Class
bInterfaceSubClass 255 Vendor Specific Subclass
bInterfaceProtocol 255 Vendor Specific Protocol
iInterface 0
Endpoint Descriptor:
bLength 7
bDescriptorType 5
bEndpointAddress 0x83 EP 3 IN
bmAttributes 1
Transfer Type Isochronous
Synch Type None
Usage Type Data
wMaxPacketSize 0x0011 1x 17 bytes
bInterval 1
Endpoint Descriptor:
bLength 7
bDescriptorType 5
bEndpointAddress 0x03 EP 3 OUT
bmAttributes 1
Transfer Type Isochronous
Synch Type None
Usage Type Data
wMaxPacketSize 0x0011 1x 17 bytes
bInterval 1
Interface Descriptor:
bLength 9
bDescriptorType 4
bInterfaceNumber 1
bAlternateSetting 3
bNumEndpoints 2
bInterfaceClass 255 Vendor Specific Class
bInterfaceSubClass 255 Vendor Specific Subclass
bInterfaceProtocol 255 Vendor Specific Protocol
iInterface 0
Endpoint Descriptor:
bLength 7
bDescriptorType 5
bEndpointAddress 0x83 EP 3 IN
bmAttributes 1
Transfer Type Isochronous
Synch Type None
Usage Type Data
wMaxPacketSize 0x0019 1x 25 bytes
bInterval 1
Endpoint Descriptor:
bLength 7
bDescriptorType 5
bEndpointAddress 0x03 EP 3 OUT
bmAttributes 1
Transfer Type Isochronous
Synch Type None
Usage Type Data
wMaxPacketSize 0x0019 1x 25 bytes
bInterval 1
Interface Descriptor:
bLength 9
bDescriptorType 4
bInterfaceNumber 1
bAlternateSetting 4
bNumEndpoints 2
bInterfaceClass 255 Vendor Specific Class
bInterfaceSubClass 255 Vendor Specific Subclass
bInterfaceProtocol 255 Vendor Specific Protocol
iInterface 0
Endpoint Descriptor:
bLength 7
bDescriptorType 5
bEndpointAddress 0x83 EP 3 IN
bmAttributes 1
Transfer Type Isochronous
Synch Type None
Usage Type Data
wMaxPacketSize 0x0021 1x 33 bytes
bInterval 1
Endpoint Descriptor:
bLength 7
bDescriptorType 5
bEndpointAddress 0x03 EP 3 OUT
bmAttributes 1
Transfer Type Isochronous
Synch Type None
Usage Type Data
wMaxPacketSize 0x0021 1x 33 bytes
bInterval 1
Interface Descriptor:
bLength 9
bDescriptorType 4
bInterfaceNumber 1
bAlternateSetting 5
bNumEndpoints 2
bInterfaceClass 255 Vendor Specific Class
bInterfaceSubClass 255 Vendor Specific Subclass
bInterfaceProtocol 255 Vendor Specific Protocol
iInterface 0
Endpoint Descriptor:
bLength 7
bDescriptorType 5
bEndpointAddress 0x83 EP 3 IN
bmAttributes 1
Transfer Type Isochronous
Synch Type None
Usage Type Data
wMaxPacketSize 0x0031 1x 49 bytes
bInterval 1
Endpoint Descriptor:
bLength 7
bDescriptorType 5
bEndpointAddress 0x03 EP 3 OUT
bmAttributes 1
Transfer Type Isochronous
Synch Type None
Usage Type Data
wMaxPacketSize 0x0031 1x 49 bytes
bInterval 1
Device Status: 0x0000
(Bus Powered)
debian-capi:~#

