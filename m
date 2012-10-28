Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=utf-8; format=flowed; delsp=yes
To: linux-bluetooth@vger.kernel.org
Date: Sun, 28 Oct 2012 20:46:49 +0200
Subject: Crashing bluetoothd when keyboard enters sleep mode / stand-by
MIME-Version: 1.0
From: "Patkos Csaba" <patkoscsaba@gmail.com>
Message-ID: <op.wmwjsbelgqbfom@localhost>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

When my keyboard enters stand-by and disconnects from the computer I see  
high cpu usage by bluetoothd. Sometimes, not always, if I don't wake up  
the keyboard, bluetoothd will crash leaving this in /var/log/messages:

Oct 28 18:04:49 localhost kernel: [27658.431018] hid-generic  
0005:045E:077C.0013: unknown main item tag 0x0
Oct 28 18:04:49 localhost kernel: [27658.431243] input: Microsoft Sculpt  
Touch Mouse as  
/devices/pci0000:00/0000:00:1d.1/usb3/3-1/3-1:1.0/bluetooth/hci0/hci0:45/input32
Oct 28 18:04:49 localhost kernel: [27658.431438] hid-generic  
0005:045E:077C.0013: input,hidraw3: BLUETOOTH HID v1.1e Mouse [Microsoft  
Sculpt Touch Mouse] on 00:15:83:3D:0A:57


There are no such problems with the mouse, which, as well as the keyboard,  
enters stand-by if not used. I have bluez 4.101 provided by Sabayon Linux.

I don't know if it is related, but there is also a problem with the  
keyboard state after starting bluetoothd. The initial state of the  
keyboard is "disconnected" which is correct. After hitting a key the  
keyboard tries to connect, state changes to "connected" but keyboard  
doesn't work and nothing is printed in the logs. If I do a disconnect from  
the KDE's bluedevil interface, or from the console by running "hcitool dc  
7C:1E:52:A8:47:74" and than hit a key again, the keyboard is correctly  
detected and working.

I have this bluetooth keyboard:

Oct 28 18:04:49 localhost kernel: [27658.427978] hid-generic  
0005:045E:0762.0012: unknown main item tag 0x0
Oct 28 18:04:49 localhost kernel: [27658.428887] input: Microsoft  
Bluetooth Mobile Keyboard 6000 as  
/devices/pci0000:00/0000:00:1d.1/usb3/3-1/3-1:1.0/bluetooth/hci0/hci0:42/input31
Oct 28 18:04:49 localhost kernel: [27658.429030] hid-generic  
0005:045E:0762.0012: input,hidraw2: BLUETOOTH HID v0.13 Keyboard  
[Microsoft Bluetooth Mobile Keyboard 6000] on 00:15:83:3D:0A:57

With this bluetooth mouse:

Oct 28 18:04:49 localhost kernel: [27658.431018] hid-generic  
0005:045E:077C.0013: unknown main item tag 0x0
Oct 28 18:04:49 localhost kernel: [27658.431243] input: Microsoft Sculpt  
Touch Mouse as  
/devices/pci0000:00/0000:00:1d.1/usb3/3-1/3-1:1.0/bluetooth/hci0/hci0:45/input32
Oct 28 18:04:49 localhost kernel: [27658.431438] hid-generic  
0005:045E:077C.0013: input,hidraw3: BLUETOOTH HID v1.1e Mouse [Microsoft  
Sculpt Touch Mouse] on 00:15:83:3D:0A:57

Running on this usb-bluetooth adapter:

localhost ~ # lsusb -v
Bus 003 Device 002: ID 0a12:0001 Cambridge Silicon Radio, Ltd Bluetooth  
Dongle (HCI mode)
Device Descriptor:
   bLength                18
   bDescriptorType         1
   bcdUSB               2.00
   bDeviceClass          224 Wireless
   bDeviceSubClass         1 Radio Frequency
   bDeviceProtocol         1 Bluetooth
   bMaxPacketSize0        64
   idVendor           0x0a12 Cambridge Silicon Radio, Ltd
   idProduct          0x0001 Bluetooth Dongle (HCI mode)
   bcdDevice           31.64
   iManufacturer           0
   iProduct                0
   iSerial                 0
   bNumConfigurations      1
   Configuration Descriptor:
     bLength                 9
     bDescriptorType         2
     wTotalLength          177
     bNumInterfaces          2
     bConfigurationValue     1
     iConfiguration          0
     bmAttributes         0xc0
       Self Powered
     MaxPower                0mA
     Interface Descriptor:
       bLength                 9
       bDescriptorType         4
       bInterfaceNumber        0
       bAlternateSetting       0
       bNumEndpoints           3
       bInterfaceClass       224 Wireless
       bInterfaceSubClass      1 Radio Frequency
       bInterfaceProtocol      1 Bluetooth
       iInterface              0
       Endpoint Descriptor:
         bLength                 7
         bDescriptorType         5
         bEndpointAddress     0x81  EP 1 IN
         bmAttributes            3
           Transfer Type            Interrupt
           Synch Type               None
           Usage Type               Data
         wMaxPacketSize     0x0010  1x 16 bytes
         bInterval               1
       Endpoint Descriptor:
         bLength                 7
         bDescriptorType         5
         bEndpointAddress     0x02  EP 2 OUT
         bmAttributes            2
           Transfer Type            Bulk
           Synch Type               None
           Usage Type               Data
         wMaxPacketSize     0x0040  1x 64 bytes
         bInterval               1
       Endpoint Descriptor:
         bLength                 7
         bDescriptorType         5
         bEndpointAddress     0x82  EP 2 IN
         bmAttributes            2
           Transfer Type            Bulk
           Synch Type               None
           Usage Type               Data
         wMaxPacketSize     0x0040  1x 64 bytes
         bInterval               1
     Interface Descriptor:
       bLength                 9
       bDescriptorType         4
       bInterfaceNumber        1
       bAlternateSetting       0
       bNumEndpoints           2
       bInterfaceClass       224 Wireless
       bInterfaceSubClass      1 Radio Frequency
       bInterfaceProtocol      1 Bluetooth
       iInterface              0
       Endpoint Descriptor:
         bLength                 7
         bDescriptorType         5
         bEndpointAddress     0x03  EP 3 OUT
         bmAttributes            1
           Transfer Type            Isochronous
           Synch Type               None
           Usage Type               Data
         wMaxPacketSize     0x0000  1x 0 bytes
         bInterval               1
       Endpoint Descriptor:
         bLength                 7
         bDescriptorType         5
         bEndpointAddress     0x83  EP 3 IN
         bmAttributes            1
           Transfer Type            Isochronous
           Synch Type               None
           Usage Type               Data
         wMaxPacketSize     0x0000  1x 0 bytes
         bInterval               1
     Interface Descriptor:
       bLength                 9
       bDescriptorType         4
       bInterfaceNumber        1
       bAlternateSetting       1
       bNumEndpoints           2
       bInterfaceClass       224 Wireless
       bInterfaceSubClass      1 Radio Frequency
       bInterfaceProtocol      1 Bluetooth
       iInterface              0
       Endpoint Descriptor:
         bLength                 7
         bDescriptorType         5
         bEndpointAddress     0x03  EP 3 OUT
         bmAttributes            1
           Transfer Type            Isochronous
           Synch Type               None
           Usage Type               Data
         wMaxPacketSize     0x0009  1x 9 bytes
         bInterval               1
       Endpoint Descriptor:
         bLength                 7
         bDescriptorType         5
         bEndpointAddress     0x83  EP 3 IN
         bmAttributes            1
           Transfer Type            Isochronous
           Synch Type               None
           Usage Type               Data
         wMaxPacketSize     0x0009  1x 9 bytes
         bInterval               1
     Interface Descriptor:
       bLength                 9
       bDescriptorType         4
       bInterfaceNumber        1
       bAlternateSetting       2
       bNumEndpoints           2
       bInterfaceClass       224 Wireless
       bInterfaceSubClass      1 Radio Frequency
       bInterfaceProtocol      1 Bluetooth
       iInterface              0
       Endpoint Descriptor:
         bLength                 7
         bDescriptorType         5
         bEndpointAddress     0x03  EP 3 OUT
         bmAttributes            1
           Transfer Type            Isochronous
           Synch Type               None
           Usage Type               Data
         wMaxPacketSize     0x0011  1x 17 bytes
         bInterval               1
       Endpoint Descriptor:
         bLength                 7
         bDescriptorType         5
         bEndpointAddress     0x83  EP 3 IN
         bmAttributes            1
           Transfer Type            Isochronous
           Synch Type               None
           Usage Type               Data
         wMaxPacketSize     0x0011  1x 17 bytes
         bInterval               1
     Interface Descriptor:
       bLength                 9
       bDescriptorType         4
       bInterfaceNumber        1
       bAlternateSetting       3
       bNumEndpoints           2
       bInterfaceClass       224 Wireless
       bInterfaceSubClass      1 Radio Frequency
       bInterfaceProtocol      1 Bluetooth
       iInterface              0
       Endpoint Descriptor:
         bLength                 7
         bDescriptorType         5
         bEndpointAddress     0x03  EP 3 OUT
         bmAttributes            1
           Transfer Type            Isochronous
           Synch Type               None
           Usage Type               Data
         wMaxPacketSize     0x0019  1x 25 bytes
         bInterval               1
       Endpoint Descriptor:
         bLength                 7
         bDescriptorType         5
         bEndpointAddress     0x83  EP 3 IN
         bmAttributes            1
           Transfer Type            Isochronous
           Synch Type               None
           Usage Type               Data
         wMaxPacketSize     0x0019  1x 25 bytes
         bInterval               1
     Interface Descriptor:
       bLength                 9
       bDescriptorType         4
       bInterfaceNumber        1
       bAlternateSetting       4
       bNumEndpoints           2
       bInterfaceClass       224 Wireless
       bInterfaceSubClass      1 Radio Frequency
       bInterfaceProtocol      1 Bluetooth
       iInterface              0
       Endpoint Descriptor:
         bLength                 7
         bDescriptorType         5
         bEndpointAddress     0x03  EP 3 OUT
         bmAttributes            1
           Transfer Type            Isochronous
           Synch Type               None
           Usage Type               Data
         wMaxPacketSize     0x0021  1x 33 bytes
         bInterval               1
       Endpoint Descriptor:
         bLength                 7
         bDescriptorType         5
         bEndpointAddress     0x83  EP 3 IN
         bmAttributes            1
           Transfer Type            Isochronous
           Synch Type               None
           Usage Type               Data
         wMaxPacketSize     0x0021  1x 33 bytes
         bInterval               1
     Interface Descriptor:
       bLength                 9
       bDescriptorType         4
       bInterfaceNumber        1
       bAlternateSetting       5
       bNumEndpoints           2
       bInterfaceClass       224 Wireless
       bInterfaceSubClass      1 Radio Frequency
       bInterfaceProtocol      1 Bluetooth
       iInterface              0
       Endpoint Descriptor:
         bLength                 7
         bDescriptorType         5
         bEndpointAddress     0x03  EP 3 OUT
         bmAttributes            1
           Transfer Type            Isochronous
           Synch Type               None
           Usage Type               Data
         wMaxPacketSize     0x0031  1x 49 bytes
         bInterval               1
       Endpoint Descriptor:
         bLength                 7
         bDescriptorType         5
         bEndpointAddress     0x83  EP 3 IN
         bmAttributes            1
           Transfer Type            Isochronous
           Synch Type               None
           Usage Type               Data
         wMaxPacketSize     0x0031  1x 49 bytes
         bInterval               1
Device Status:     0x0001
   Self Powered




-- 
ing. Patkós Csaba
Software Developer @ Syneto SRL (http://www.syneto.net)
Member of The Romanian Mandriva Users Group (http://www.mandrivausrs.ro)
----
I use Dropbox. Do you? http://db.tt/IqeKInu
