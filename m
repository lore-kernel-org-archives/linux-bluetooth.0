Return-Path: <hdegoede@redhat.com>
Subject: Re: [PATCH] bluetooth: btusb: Add support for BCM2045 HCI with
 vend:prod ids set to 0000:0000
To: Christopher Williamson <home@chrisaw.com>
Cc: Marcel Holtmann <marcel@holtmann.org>,
 "Gustavo F. Padovan" <gustavo@padovan.org>,
 Johan Hedberg <johan.hedberg@gmail.com>, linux-bluetooth@vger.kernel.org
References: <20170706140845.11508-1-hdegoede@redhat.com>
 <B5854943-47D2-494F-9D56-80226FE66F38@holtmann.org>
From: Hans de Goede <hdegoede@redhat.com>
Message-ID: <09f20b44-290f-3bbf-b52e-22c3b76cfc7a@redhat.com>
Date: Thu, 6 Jul 2017 18:43:33 +0200
MIME-Version: 1.0
In-Reply-To: <B5854943-47D2-494F-9D56-80226FE66F38@holtmann.org>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-bluetooth.vger.kernel.org>

Hi all,

Christopher, can you do: "sudo cat /sys/kernel/debug/usb/devices"
and copy and paste the contents in a reply to this mail
(using reply-to-all) ?

On 06-07-17 17:22, Marcel Holtmann wrote:
> Hi Hans,
> 
>> The GPD Pocket is shipping with a BCM2045 USB HCI with its vend:prod
>> ids set to 0000:0000 and also has its interface class set to 255 (Vendor
>> Specific Class).
>>
>> Which, well sucks. Luckily it does advertise usable manufacturer and
>> product strings, so this commit adds 0000:0000 to the usb_device_id
>> table, with a special flag of BTUSB_BCM2045_0000_0000, if this flag
>> is set btusb_probe will check the strings and if they don't match
>> return -ENODEV.
>>
>> This is not pretty, but it fixes bluetooth not working under Linux.
> 
> can you send around /sys/kernel/debug/usb/devices for this device.

As you can see I've just asked the reported to provide this :)

I already have lsusb -v output for the btusb device:

Bus 001 Device 003: ID 0000:0000
Device Descriptor:
   bLength                18
   bDescriptorType         1
   bcdUSB               2.00
   bDeviceClass          255 Vendor Specific Class
   bDeviceSubClass         1
   bDeviceProtocol         1
   bMaxPacketSize0        64
   idVendor           0x0000
   idProduct          0x0000
   bcdDevice            1.12
   iManufacturer           1 Broadcom Corp
   iProduct                2 BCM2045A0
   iSerial                 3 AC83F30677CB
   bNumConfigurations      1
   Configuration Descriptor:
     bLength                 9
     bDescriptorType         2
     wTotalLength          218
     bNumInterfaces          4
     bConfigurationValue     1
     iConfiguration          0
     bmAttributes         0x80
       (Bus Powered)
     MaxPower              100mA
     Interface Descriptor:
       bLength                 9
       bDescriptorType         4
       bInterfaceNumber        0
       bAlternateSetting       0
       bNumEndpoints           3
       bInterfaceClass       255 Vendor Specific Class
       bInterfaceSubClass      1
       bInterfaceProtocol      1
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
         bEndpointAddress     0x82  EP 2 IN
         bmAttributes            2
           Transfer Type            Bulk
           Synch Type               None
           Usage Type               Data
         wMaxPacketSize     0x0040  1x 64 bytes
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
     Interface Descriptor:
       bLength                 9
       bDescriptorType         4
       bInterfaceNumber        1
       bAlternateSetting       0
       bNumEndpoints           2
       bInterfaceClass       255 Vendor Specific Class
       bInterfaceSubClass      1
       bInterfaceProtocol      1
       iInterface              0
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
     Interface Descriptor:
       bLength                 9
       bDescriptorType         4
       bInterfaceNumber        1
       bAlternateSetting       1
       bNumEndpoints           2
       bInterfaceClass       255 Vendor Specific Class
       bInterfaceSubClass      1
       bInterfaceProtocol      1
       iInterface              0
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
     Interface Descriptor:
       bLength                 9
       bDescriptorType         4
       bInterfaceNumber        1
       bAlternateSetting       2
       bNumEndpoints           2
       bInterfaceClass       255 Vendor Specific Class
       bInterfaceSubClass      1
       bInterfaceProtocol      1
       iInterface              0
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
     Interface Descriptor:
       bLength                 9
       bDescriptorType         4
       bInterfaceNumber        1
       bAlternateSetting       3
       bNumEndpoints           2
       bInterfaceClass       255 Vendor Specific Class
       bInterfaceSubClass      1
       bInterfaceProtocol      1
       iInterface              0
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
     Interface Descriptor:
       bLength                 9
       bDescriptorType         4
       bInterfaceNumber        1
       bAlternateSetting       4
       bNumEndpoints           2
       bInterfaceClass       255 Vendor Specific Class
       bInterfaceSubClass      1
       bInterfaceProtocol      1
       iInterface              0
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
     Interface Descriptor:
       bLength                 9
       bDescriptorType         4
       bInterfaceNumber        1
       bAlternateSetting       5
       bNumEndpoints           2
       bInterfaceClass       255 Vendor Specific Class
       bInterfaceSubClass      1
       bInterfaceProtocol      1
       iInterface              0
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
     Interface Descriptor:
       bLength                 9
       bDescriptorType         4
       bInterfaceNumber        2
       bAlternateSetting       0
       bNumEndpoints           2
       bInterfaceClass       255 Vendor Specific Class
       bInterfaceSubClass    255 Vendor Specific Subclass
       bInterfaceProtocol    255 Vendor Specific Protocol
       iInterface              0
       Endpoint Descriptor:
         bLength                 7
         bDescriptorType         5
         bEndpointAddress     0x84  EP 4 IN
         bmAttributes            2
           Transfer Type            Bulk
           Synch Type               None
           Usage Type               Data
         wMaxPacketSize     0x0020  1x 32 bytes
         bInterval               1
       Endpoint Descriptor:
         bLength                 7
         bDescriptorType         5
         bEndpointAddress     0x04  EP 4 OUT
         bmAttributes            2
           Transfer Type            Bulk
           Synch Type               None
           Usage Type               Data
         wMaxPacketSize     0x0020  1x 32 bytes
         bInterval               1
     Interface Descriptor:
       bLength                 9
       bDescriptorType         4
       bInterfaceNumber        3
       bAlternateSetting       0
       bNumEndpoints           0
       bInterfaceClass       254 Application Specific Interface
       bInterfaceSubClass      1 Device Firmware Update
       bInterfaceProtocol      1
       iInterface              0
       Device Firmware Upgrade Interface Descriptor:
         bLength                             9
         bDescriptorType                    33
         bmAttributes                        5
           Will Not Detach
           Manifestation Tolerant
           Upload Unsupported
           Download Supported
         wDetachTimeout                   5000 milliseconds
         wTransferSize                      64 bytes
         bcdDFUVersion                   1.10
Device Status:     0x0000
   (Bus Powered)

Regards,

Hans
