Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <BANLkTinOoLTyBFktQtT-Eb8Pe2FJxM8suA@mail.gmail.com>
References: <BANLkTinOoLTyBFktQtT-Eb8Pe2FJxM8suA@mail.gmail.com>
From: Stefan Sommer <stefan@nefan.dk>
Date: Sun, 29 May 2011 22:17:43 +0200
Message-ID: <BANLkTim912-YZeWHpdRupnJ3J6HYrGW+_A@mail.gmail.com>
Subject: Re: Scan for devices fails with ralink rt539f card
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

I didn't get any response for this. However, the workaround described
in http://ubuntuforums.org/showthread.php?t=1584388 works for this
card: boot in Windows, turn on bluetooth, turn off bluetooth/wifi in
hardware with key combination fn-12, and boot in Linux. Maybe this
could be a pointer if anyone is willing to look at the issue.

Stefan

On Sun, May 22, 2011 at 9:08 AM, Stefan Sommer <stefan@nefan.dk> wrote:
> Hi,
>
> bluetooth fails to discover devices when scanning with my rt539f
> bluetooth/wifi combo card in my laptop. That is, the btusb module
> loads, the device shows up with 'hcitool dev' but 'hcitool scan' fails
> to detect any devices. I have tried running 2.6.38 and 2.6.39rc7
> (ubuntu), and I've asked at the rt2x00 since other people affected by
> this had the idea that it could be a problem with the wifi/bluetooth
> co-existence. No luck so far, though.
>
> Thanks,
> Stefan Sommer
>
> hcidump output during scan:
> HCI sniffer - Bluetooth packet analyzer ver 1.42
> device: hci0 snap_len: 1028 filter: 0xffffffffffffffff
> 1305190041.929978 < HCI Command: Inquiry (0x01|0x0001) plen 5
>  0000: 33 8b 9e 08 00                                    3....
> 1305190041.932580 > HCI Event: Command Status (0x0f) plen 4
>  0000: 00 01 01 04                                       ....
> 1305190052.174568 > HCI Event: Inquiry Complete (0x01) plen 1
>  0000: 00
>
> (lsusb -v)
> Bus 006 Device 002: ID 148f:2000 Ralink Technology, Corp.
> Device Descriptor:
>  bLength                18
>  bDescriptorType         1
>  bcdUSB               2.00
>  bDeviceClass          224 Wireless
>  bDeviceSubClass         1 Radio Frequency
>  bDeviceProtocol         1 Bluetooth
>  bMaxPacketSize0        64
>  idVendor           0x148f Ralink Technology, Corp.
>  idProduct          0x2000
>  bcdDevice           68.17
>  iManufacturer           0
>  iProduct                2 CSR BS8510
>  iSerial                 0
>  bNumConfigurations      1
>  Configuration Descriptor:
>   bLength                 9
>   bDescriptorType         2
>   wTotalLength          177
>   bNumInterfaces          2
>   bConfigurationValue     1
>   iConfiguration          0
>   bmAttributes         0xe0
>     Self Powered
>     Remote Wakeup
>   MaxPower                0mA
>   Interface Descriptor:
>     bLength                 9
>     bDescriptorType         4
>     bInterfaceNumber        0
>     bAlternateSetting       0
>     bNumEndpoints           3
>     bInterfaceClass       224 Wireless
>     bInterfaceSubClass      1 Radio Frequency
>     bInterfaceProtocol      1 Bluetooth
>     iInterface              0
>     Endpoint Descriptor:
>       bLength                 7
>       bDescriptorType         5
>       bEndpointAddress     0x81  EP 1 IN
>       bmAttributes            3
>         Transfer Type            Interrupt
>         Synch Type               None
>         Usage Type               Data
>       wMaxPacketSize     0x0010  1x 16 bytes
>       bInterval               1
>     Endpoint Descriptor:
>       bLength                 7
>       bDescriptorType         5
>       bEndpointAddress     0x02  EP 2 OUT
>       bmAttributes            2
>         Transfer Type            Bulk
>         Synch Type               None
>         Usage Type               Data
>       wMaxPacketSize     0x0040  1x 64 bytes
>       bInterval               1
>     Endpoint Descriptor:
>       bLength                 7
>       bDescriptorType         5
>       bEndpointAddress     0x82  EP 2 IN
>       bmAttributes            2
>         Transfer Type            Bulk
>         Synch Type               None
>         Usage Type               Data
>       wMaxPacketSize     0x0040  1x 64 bytes
>       bInterval               1
>   Interface Descriptor:
>     bLength                 9
>     bDescriptorType         4
>     bInterfaceNumber        1
>     bAlternateSetting       0
>     bNumEndpoints           2
>     bInterfaceClass       224 Wireless
>     bInterfaceSubClass      1 Radio Frequency
>     bInterfaceProtocol      1 Bluetooth
>     iInterface              0
>     Endpoint Descriptor:
>       bLength                 7
>       bDescriptorType         5
>       bEndpointAddress     0x03  EP 3 OUT
>       bmAttributes            1
>         Transfer Type            Isochronous
>         Synch Type               None
>         Usage Type               Data
>       wMaxPacketSize     0x0000  1x 0 bytes
>       bInterval               1
>     Endpoint Descriptor:
>       bLength                 7
>       bDescriptorType         5
>       bEndpointAddress     0x83  EP 3 IN
>       bmAttributes            1
>         Transfer Type            Isochronous
>         Synch Type               None
>         Usage Type               Data
>       wMaxPacketSize     0x0000  1x 0 bytes
>       bInterval               1
>   Interface Descriptor:
>     bLength                 9
>     bDescriptorType         4
>     bInterfaceNumber        1
>     bAlternateSetting       1
>     bNumEndpoints           2
>     bInterfaceClass       224 Wireless
>     bInterfaceSubClass      1 Radio Frequency
>     bInterfaceProtocol      1 Bluetooth
>     iInterface              0
>     Endpoint Descriptor:
>       bLength                 7
>       bDescriptorType         5
>       bEndpointAddress     0x03  EP 3 OUT
>       bmAttributes            1
>         Transfer Type            Isochronous
>         Synch Type               None
>         Usage Type               Data
>       wMaxPacketSize     0x0009  1x 9 bytes
>       bInterval               1
>     Endpoint Descriptor:
>       bLength                 7
>       bDescriptorType         5
>       bEndpointAddress     0x83  EP 3 IN
>       bmAttributes            1
>         Transfer Type            Isochronous
>         Synch Type               None
>         Usage Type               Data
>       wMaxPacketSize     0x0009  1x 9 bytes
>       bInterval               1
>   Interface Descriptor:
>     bLength                 9
>     bDescriptorType         4
>     bInterfaceNumber        1
>     bAlternateSetting       2
>     bNumEndpoints           2
>     bInterfaceClass       224 Wireless
>     bInterfaceSubClass      1 Radio Frequency
>     bInterfaceProtocol      1 Bluetooth
>     iInterface              0
>     Endpoint Descriptor:
>       bLength                 7
>       bDescriptorType         5
>       bEndpointAddress     0x03  EP 3 OUT
>       bmAttributes            1
>         Transfer Type            Isochronous
>         Synch Type               None
>         Usage Type               Data
>       wMaxPacketSize     0x0011  1x 17 bytes
>       bInterval               1
>     Endpoint Descriptor:
>       bLength                 7
>       bDescriptorType         5
>       bEndpointAddress     0x83  EP 3 IN
>       bmAttributes            1
>         Transfer Type            Isochronous
>         Synch Type               None
>         Usage Type               Data
>       wMaxPacketSize     0x0011  1x 17 bytes
>       bInterval               1
>   Interface Descriptor:
>     bLength                 9
>     bDescriptorType         4
>     bInterfaceNumber        1
>     bAlternateSetting       3
>     bNumEndpoints           2
>     bInterfaceClass       224 Wireless
>     bInterfaceSubClass      1 Radio Frequency
>     bInterfaceProtocol      1 Bluetooth
>     iInterface              0
>     Endpoint Descriptor:
>       bLength                 7
>       bDescriptorType         5
>       bEndpointAddress     0x03  EP 3 OUT
>       bmAttributes            1
>         Transfer Type            Isochronous
>         Synch Type               None
>         Usage Type               Data
>       wMaxPacketSize     0x0019  1x 25 bytes
>       bInterval               1
>     Endpoint Descriptor:
>       bLength                 7
>       bDescriptorType         5
>       bEndpointAddress     0x83  EP 3 IN
>       bmAttributes            1
>         Transfer Type            Isochronous
>         Synch Type               None
>         Usage Type               Data
>       wMaxPacketSize     0x0019  1x 25 bytes
>       bInterval               1
>   Interface Descriptor:
>     bLength                 9
>     bDescriptorType         4
>     bInterfaceNumber        1
>     bAlternateSetting       4
>     bNumEndpoints           2
>     bInterfaceClass       224 Wireless
>     bInterfaceSubClass      1 Radio Frequency
>     bInterfaceProtocol      1 Bluetooth
>     iInterface              0
>     Endpoint Descriptor:
>       bLength                 7
>       bDescriptorType         5
>       bEndpointAddress     0x03  EP 3 OUT
>       bmAttributes            1
>         Transfer Type            Isochronous
>         Synch Type               None
>         Usage Type               Data
>       wMaxPacketSize     0x0021  1x 33 bytes
>       bInterval               1
>     Endpoint Descriptor:
>       bLength                 7
>       bDescriptorType         5
>       bEndpointAddress     0x83  EP 3 IN
>       bmAttributes            1
>         Transfer Type            Isochronous
>         Synch Type               None
>         Usage Type               Data
>       wMaxPacketSize     0x0021  1x 33 bytes
>       bInterval               1
>   Interface Descriptor:
>     bLength                 9
>     bDescriptorType         4
>     bInterfaceNumber        1
>     bAlternateSetting       5
>     bNumEndpoints           2
>     bInterfaceClass       224 Wireless
>     bInterfaceSubClass      1 Radio Frequency
>     bInterfaceProtocol      1 Bluetooth
>     iInterface              0
>     Endpoint Descriptor:
>       bLength                 7
>       bDescriptorType         5
>       bEndpointAddress     0x03  EP 3 OUT
>       bmAttributes            1
>         Transfer Type            Isochronous
>         Synch Type               None
>         Usage Type               Data
>       wMaxPacketSize     0x0031  1x 49 bytes
>       bInterval               1
>     Endpoint Descriptor:
>       bLength                 7
>       bDescriptorType         5
>       bEndpointAddress     0x83  EP 3 IN
>       bmAttributes            1
>         Transfer Type            Isochronous
>         Synch Type               None
>         Usage Type               Data
>       wMaxPacketSize     0x0031  1x 49 bytes
>       bInterval               1
> Device Status:     0x0001
>  Self Powered
>
> (lspci -v with the rt5390sta wifi driver)
> 02:00.0 Network controller: Ralink corp. Device 539f
>       Subsystem: Hewlett-Packard Company Device 1637
>       Flags: bus master, fast devsel, latency 0, IRQ 17
>       Memory at f0100000 (32-bit, non-prefetchable) [size=64K]
>       Capabilities: [40] Power Management version 3
>       Capabilities: [50] MSI: Enable- Count=1/32 Maskable- 64bit+
>       Capabilities: [70] Express Endpoint, MSI 00
>       Capabilities: [100] Advanced Error Reporting
>       Capabilities: [140] Device Serial Number 00-00-a8-85-05-da-f8-c0
>       Kernel driver in use: rt5390
>       Kernel modules: rt5390sta
>
