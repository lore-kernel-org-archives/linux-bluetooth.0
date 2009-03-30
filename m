Return-Path: <cyrus@holtmann.org>
Date: Mon, 30 Mar 2009 01:03:39 -0400
From: jayjwa <jayjwa@atr2.ath.cx>
To: linux-bluetooth <linux-bluetooth@vger.kernel.org>
Subject: Re: Newbie, can't find device
In-Reply-To: <200903262205.52669.gene.heskett@verizon.net>
Message-ID: <alpine.LNX.2.00.0903292339240.32436@nge2.ngu.pk>
References: <200903252037.03024.gene.heskett@verizon.net> <200903261157.28413.gene.heskett@verizon.net> <alpine.LNX.2.00.0903262001290.27577@nge2.ngu.pk> <200903262205.52669.gene.heskett@verizon.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


On Thu, 26 Mar 2009, Gene Heskett wrote:

>> The dongle on the kubuntu box isn't ready/supported/working. You should see
>> it by scanning, and I've never had to do a manual 'hciconfig hci0 up' at
>> any time. If it's a USB congle, does it show with 'lsusb'? When you plug it
>> in, what kernel messages do you get? Are the bluez/dbus/usb systems all
>> complete on that box?
>>
> UNK at this point.  I'll ssh into it and find out:
> gene@goat:~$ lsusb
> Bus 002 Device 004: ID 0e5e:6622  That is the devices make:prod ID
>
> gene@goat:~$ sudo lsusb -v| grep -A75 'Bus 002 Device 004:'
> Bus 002 Device 004: ID 0e5e:6622
> Device Descriptor:
>  bLength                18
>  bDescriptorType         1
>  bcdUSB               1.10
>  bDeviceClass          224 Wireless
>  bDeviceSubClass         1 Radio Frequency
>  bDeviceProtocol         1 Bluetooth
>  bMaxPacketSize0        16
>  idVendor           0x0e5e
>  idProduct          0x6622
>  bcdDevice            1.34
>  iManufacturer           0
>  iProduct                0
>  iSerial                 0
>  bNumConfigurations      1
>  Configuration Descriptor:
>    bLength                 9
>    bDescriptorType         2
>    wTotalLength          108
>    bNumInterfaces          2
>    bConfigurationValue     1
>    iConfiguration          0
>    bmAttributes         0x80
>      (Bus Powered)
>    MaxPower              100mA
>    Interface Descriptor:
>      bLength                 9
>      bDescriptorType         4
>      bInterfaceNumber        0
>      bAlternateSetting       0
>      bNumEndpoints           3
>      bInterfaceClass       224 Wireless
>      bInterfaceSubClass      1 Radio Frequency
>      bInterfaceProtocol      1 Bluetooth
>      iInterface              0
>      Endpoint Descriptor:
>        bLength                 7
>        bDescriptorType         5
>        bEndpointAddress     0x81  EP 1 IN
>        bmAttributes            3
>          Transfer Type            Interrupt
>          Synch Type               None
>          Usage Type               Data
>        wMaxPacketSize     0x0010  1x 16 bytes
>        bInterval               1
>      Endpoint Descriptor:
>        bLength                 7
>        bDescriptorType         5
>        bEndpointAddress     0x82  EP 2 IN
>        bmAttributes            2
>          Transfer Type            Bulk
>          Synch Type               None
>          Usage Type               Data
>        wMaxPacketSize     0x0040  1x 64 bytes
>        bInterval               0
>      Endpoint Descriptor:
>        bLength                 7
>        bDescriptorType         5
>        bEndpointAddress     0x02  EP 2 OUT
>        bmAttributes            2
>          Transfer Type            Bulk
>          Synch Type               None
>          Usage Type               Data
>        wMaxPacketSize     0x0040  1x 64 bytes
>        bInterval               0
>    Interface Descriptor:
>      bLength                 9
>      bDescriptorType         4
>      bInterfaceNumber        1
>      bAlternateSetting       0
>      bNumEndpoints           2
>      bInterfaceClass       224 Wireless
>      bInterfaceSubClass      1 Radio Frequency
>      bInterfaceProtocol      1 Bluetooth
>      iInterface              0
> cannot read device status, Connection timed out (110)
> can't get device qualifier: Connection timed out
> can't get debug descriptor: Connection timed out
> cannot read device status, Connection timed out (110)

That's not good. The command should complete normally. You seem to be missing 
about half the data mine displays for this type of device. I'm no USB device 
expert, but I'd guess the root of the problem is the bluetooth adapter itself.

My listing starts like this:

Bus 004 Device 002: ID 050d:0121 Belkin Components F5D5050 100Mbps Ethernet
Device Descriptor:
   bLength                18
   bDescriptorType         1
   bcdUSB               2.00
   bDeviceClass          224 Wireless
   bDeviceSubClass         1 Radio Frequency
   bDeviceProtocol         1 Bluetooth
   bMaxPacketSize0        64
   idVendor           0x050d Belkin Components
   idProduct          0x0121 F5D5050 100Mbps Ethernet
   bcdDevice            1.00
   iManufacturer           1 Broadcom Corp
   iProduct                2 BELKIN BLUETOOTH USB ADAPTER CL. 1
   iSerial                 0
   bNumConfigurations      1


and ends with:

     Interface Descriptor:
       bLength                 9
       bDescriptorType         4
       bInterfaceNumber        3
       bAlternateSetting       0
       bNumEndpoints           0
       bInterfaceClass       254 Application Specific Interface
       bInterfaceSubClass      1 Device Firmware Update
       bInterfaceProtocol      0
       iInterface              0
       ** UNRECOGNIZED:  07 21 05 88 13 40 00
Device Status:     0x0000
   (Bus Powered)


