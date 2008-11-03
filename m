Return-Path: <cyrus@holtmann.org>
From: =?iso-8859-15?q?Isa=EDas_Mart=EDnez_Yelmo?= <isaiasmy@gmail.com>
To: Mario Limonciello <mario_limonciello@dell.com>
Subject: Re: Dell 365 Bluetooth
Date: Mon, 3 Nov 2008 21:58:21 +0100
Cc: linux-bluetooth@vger.kernel.org
References: <200811031947.40187.isaiasmy@gmail.com>
	<490F4B17.9070703@dell.com>
In-Reply-To: <490F4B17.9070703@dell.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset=iso-8859-15
Message-Id: <200811032158.21654.isaiasmy@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

El Monday 03 November 2008 20:03:51 Mario Limonciello escribió:
> Isaías Martínez Yelmo wrote:
> > Hello,
> >
> > I would like to ask if there is some future plan to support the new
> > bluetooth device Dell 365 Bluetooth.  As far as I know, this is a new
> > device included on new Dell Latitudes e4200/e4300 and I have not found
> > any information related with it yet. This is the information that i have
> > obtained from lsusb, just to provide all the information that I have:
> >
> > Bus 001 Device 006: ID 413c:8160 Dell Computer Corp.
> > Device Descriptor:
> >   bLength                18
> >   bDescriptorType         1
> >   bcdUSB               2.00
> >   bDeviceClass          224 Wireless
> >   bDeviceSubClass         1 Radio Frequency
> >   bDeviceProtocol         1 Bluetooth
> >   bMaxPacketSize0        64
> >   idVendor           0x413c Dell Computer Corp.
> >   idProduct          0x8160
> >   bcdDevice            1.73
> >   iManufacturer           1 Dell Computer Corp
> >   iProduct                2 Dell Wireless 365 Bluetooth Module
> >   iSerial                 0
> >   bNumConfigurations      1
> >   Configuration Descriptor:
> >     bLength                 9
> >     bDescriptorType         2
> >     wTotalLength          216
> >     bNumInterfaces          4
> >     bConfigurationValue     1
> >     iConfiguration          0
> >     bmAttributes         0xe0
> >       Self Powered
> >       Remote Wakeup
> >     MaxPower              100mA
> >     Interface Descriptor:
> >       bLength                 9
> >       bDescriptorType         4
> >       bInterfaceNumber        0
> >       bAlternateSetting       0
> >       bNumEndpoints           3
> >       bInterfaceClass       224 Wireless
> >       bInterfaceSubClass      1 Radio Frequency
> >       bInterfaceProtocol      1 Bluetooth
> >       iInterface              0
> >       Endpoint Descriptor:
> >         bLength                 7
> >         bDescriptorType         5
> >         bEndpointAddress     0x81  EP 1 IN
> >         bmAttributes            3
> >           Transfer Type            Interrupt
> >           Synch Type               None
> >           Usage Type               Data
> >         wMaxPacketSize     0x0010  1x 16 bytes
> >         bInterval               1
> >       Endpoint Descriptor:
> >         bLength                 7
> >         bDescriptorType         5
> >         bEndpointAddress     0x82  EP 2 IN
> >         bmAttributes            2
> >           Transfer Type            Bulk
> >           Synch Type               None
> >           Usage Type               Data
> >         wMaxPacketSize     0x0040  1x 64 bytes
> >         bInterval               1
> >       Endpoint Descriptor:
> >         bLength                 7
> >         bDescriptorType         5
> >         bEndpointAddress     0x02  EP 2 OUT
> >         bmAttributes            2
> >           Transfer Type            Bulk
> >           Synch Type               None
> >           Usage Type               Data
> >         wMaxPacketSize     0x0040  1x 64 bytes
> >         bInterval               1
> >     Interface Descriptor:
> >       bLength                 9
> >       bDescriptorType         4
> >       bInterfaceNumber        1
> >       bAlternateSetting       0
> >       bNumEndpoints           2
> >       bInterfaceClass       224 Wireless
> >       bInterfaceSubClass      1 Radio Frequency
> >       bInterfaceProtocol      1 Bluetooth
> >       iInterface              0
> >       Endpoint Descriptor:
> >         bLength                 7
> >         bDescriptorType         5
> >         bEndpointAddress     0x83  EP 3 IN
> >         bmAttributes            1
> >           Transfer Type            Isochronous
> >           Synch Type               None
> >           Usage Type               Data
> >         wMaxPacketSize     0x0000  1x 0 bytes
> >         bInterval               1
> >       Endpoint Descriptor:
> >         bLength                 7
> >         bDescriptorType         5
> >         bEndpointAddress     0x03  EP 3 OUT
> >         bmAttributes            1
> >           Transfer Type            Isochronous
> >           Synch Type               None
> >           Usage Type               Data
> >         wMaxPacketSize     0x0000  1x 0 bytes
> >         bInterval               1
> >     Interface Descriptor:
> >       bLength                 9
> >       bDescriptorType         4
> >       bInterfaceNumber        1
> >       bAlternateSetting       1
> >       bNumEndpoints           2
> >       bInterfaceClass       224 Wireless
> >       bInterfaceSubClass      1 Radio Frequency
> >       bInterfaceProtocol      1 Bluetooth
> >       iInterface              0
> >       Endpoint Descriptor:
> >         bLength                 7
> >         bDescriptorType         5
> >         bEndpointAddress     0x83  EP 3 IN
> >         bmAttributes            1
> >           Transfer Type            Isochronous
> >           Synch Type               None
> >           Usage Type               Data
> >         wMaxPacketSize     0x0009  1x 9 bytes
> >         bInterval               1
> >       Endpoint Descriptor:
> >         bLength                 7
> >         bDescriptorType         5
> >         bEndpointAddress     0x03  EP 3 OUT
> >         bmAttributes            1
> >           Transfer Type            Isochronous
> >           Synch Type               None
> >           Usage Type               Data
> >         wMaxPacketSize     0x0009  1x 9 bytes
> >         bInterval               1
> >     Interface Descriptor:
> >       bLength                 9
> >       bDescriptorType         4
> >       bInterfaceNumber        1
> >       bAlternateSetting       2
> >       bNumEndpoints           2
> >       bInterfaceClass       224 Wireless
> >       bInterfaceSubClass      1 Radio Frequency
> >       bInterfaceProtocol      1 Bluetooth
> >       iInterface              0
> >       Endpoint Descriptor:
> >         bLength                 7
> >         bDescriptorType         5
> >         bEndpointAddress     0x83  EP 3 IN
> >         bmAttributes            1
> >           Transfer Type            Isochronous
> >           Synch Type               None
> >           Usage Type               Data
> >         wMaxPacketSize     0x0011  1x 17 bytes
> >         bInterval               1
> >       Endpoint Descriptor:
> >         bLength                 7
> >         bDescriptorType         5
> >         bEndpointAddress     0x03  EP 3 OUT
> >         bmAttributes            1
> >           Transfer Type            Isochronous
> >           Synch Type               None
> >           Usage Type               Data
> >         wMaxPacketSize     0x0011  1x 17 bytes
> >         bInterval               1
> >     Interface Descriptor:
> >       bLength                 9
> >       bDescriptorType         4
> >       bInterfaceNumber        1
> >       bAlternateSetting       3
> >       bNumEndpoints           2
> >       bInterfaceClass       224 Wireless
> >       bInterfaceSubClass      1 Radio Frequency
> >       bInterfaceProtocol      1 Bluetooth
> >       iInterface              0
> >       Endpoint Descriptor:
> >         bLength                 7
> >         bDescriptorType         5
> >         bEndpointAddress     0x83  EP 3 IN
> >         bmAttributes            1
> >           Transfer Type            Isochronous
> >           Synch Type               None
> >           Usage Type               Data
> >         wMaxPacketSize     0x0020  1x 32 bytes
> >         bInterval               1
> >       Endpoint Descriptor:
> >         bLength                 7
> >         bDescriptorType         5
> >         bEndpointAddress     0x03  EP 3 OUT
> >         bmAttributes            1
> >           Transfer Type            Isochronous
> >           Synch Type               None
> >           Usage Type               Data
> >         wMaxPacketSize     0x0020  1x 32 bytes
> >         bInterval               1
> >     Interface Descriptor:
> >       bLength                 9
> >       bDescriptorType         4
> >       bInterfaceNumber        1
> >       bAlternateSetting       4
> >       bNumEndpoints           2
> >       bInterfaceClass       224 Wireless
> >       bInterfaceSubClass      1 Radio Frequency
> >       bInterfaceProtocol      1 Bluetooth
> >       iInterface              0
> >       Endpoint Descriptor:
> >         bLength                 7
> >         bDescriptorType         5
> >         bEndpointAddress     0x83  EP 3 IN
> >         bmAttributes            1
> >           Transfer Type            Isochronous
> >           Synch Type               None
> >           Usage Type               Data
> >         wMaxPacketSize     0x0040  1x 64 bytes
> >         bInterval               1
> >       Endpoint Descriptor:
> >         bLength                 7
> >         bDescriptorType         5
> >         bEndpointAddress     0x03  EP 3 OUT
> >         bmAttributes            1
> >           Transfer Type            Isochronous
> >           Synch Type               None
> >           Usage Type               Data
> >         wMaxPacketSize     0x0040  1x 64 bytes
> >         bInterval               1
> >     Interface Descriptor:
> >       bLength                 9
> >       bDescriptorType         4
> >       bInterfaceNumber        1
> >       bAlternateSetting       5
> >       bNumEndpoints           2
> >       bInterfaceClass       224 Wireless
> >       bInterfaceSubClass      1 Radio Frequency
> >       bInterfaceProtocol      1 Bluetooth
> >       iInterface              0
> >       Endpoint Descriptor:
> >         bLength                 7
> >         bDescriptorType         5
> >         bEndpointAddress     0x83  EP 3 IN
> >         bmAttributes            1
> >           Transfer Type            Isochronous
> >           Synch Type               None
> >           Usage Type               Data
> >         wMaxPacketSize     0x0040  1x 64 bytes
> >         bInterval               1
> >       Endpoint Descriptor:
> >         bLength                 7
> >         bDescriptorType         5
> >         bEndpointAddress     0x03  EP 3 OUT
> >         bmAttributes            1
> >           Transfer Type            Isochronous
> >           Synch Type               None
> >           Usage Type               Data
> >         wMaxPacketSize     0x0040  1x 64 bytes
> >         bInterval               1
> >     Interface Descriptor:
> >       bLength                 9
> >       bDescriptorType         4
> >       bInterfaceNumber        2
> >       bAlternateSetting       0
> >       bNumEndpoints           2
> >       bInterfaceClass       255 Vendor Specific Class
> >       bInterfaceSubClass    255 Vendor Specific Subclass
> >       bInterfaceProtocol    255 Vendor Specific Protocol
> >       iInterface              0
> >       Endpoint Descriptor:
> >         bLength                 7
> >         bDescriptorType         5
> >         bEndpointAddress     0x84  EP 4 IN
> >         bmAttributes            2
> >           Transfer Type            Bulk
> >           Synch Type               None
> >           Usage Type               Data
> >         wMaxPacketSize     0x0020  1x 32 bytes
> >         bInterval               1
> >       Endpoint Descriptor:
> >         bLength                 7
> >         bDescriptorType         5
> >         bEndpointAddress     0x04  EP 4 OUT
> >         bmAttributes            2
> >           Transfer Type            Bulk
> >           Synch Type               None
> >           Usage Type               Data
> >         wMaxPacketSize     0x0020  1x 32 bytes
> >         bInterval               1
> >     Interface Descriptor:
> >       bLength                 9
> >       bDescriptorType         4
> >       bInterfaceNumber        3
> >       bAlternateSetting       0
> >       bNumEndpoints           0
> >       bInterfaceClass       254 Application Specific Interface
> >       bInterfaceSubClass      1 Device Firmware Update
> >       bInterfaceProtocol      0
> >       iInterface              0
> >       ** UNRECOGNIZED:  07 21 07 88 13 40 00
> > Device Status:     0x0001
> >   Self Powered
> >
> > My distro is Ubuntu Intrepid:
> >
> > 2.6.27-7-generic #1 SMP x86_64 GNU/Linux
> >
> > Thank you very mucho for your attention.
> >
> > Cheers,
> >
> > Isaías
>
> Isaías:
>
> As far as I'm aware, this device should be supported.  The latest
> hid2hci patches (which landed in Intrepid already) will get it into hci
> mode.  You might need to mess with a reset quirk though (try modprobe
> options btusb=1), but i've not verified this.  If setting this modprobe
> option makes it work, we can submit a kernel quirk for it.
>
> Regards

Hello,

I'm not very sure on how to enable the option that you mention, sorry. I've 
include in /etc/modprobe.d/options the next line:

options btusb=1

but I don't know if this is right. The dmesg command shows these lines related 
with hid2hci:

[   12.458741] usb 1-1.2: usbfs: process 2746 (hid2hci) did not claim 
interface 0 before use
[   24.365796] usb 1-1.2: usbfs: process 5909 (hid2hci) did not claim 
interface 0 before use

Perhaps, it could be relevant.

Let me know, if I have to enable the option in other way.

Regards,

Isaias

-- 
Isaías Martínez Yelmo
