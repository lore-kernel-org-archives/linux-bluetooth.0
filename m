Return-Path: <mitch@0bits.com>
Message-ID: <3FDF5C36.7080605@0bits.com>
Date: Tue, 16 Dec 2003 19:25:42 +0000
From: Mitch <mitch@0bits.com>
MIME-Version: 1.0
To: marcel@holtmann.org, bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] NEC usb bluetooth support
Content-Type: multipart/mixed;
 boundary="------------080807010300080408040807"
List-ID: <bluez-users.lists.sourceforge.net>

This is a multi-part message in MIME format.
--------------080807010300080408040807
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi Marcel,

Yup i do have an entry (see below), and i've managed to get it to load, but by
hacking the hci_usb.c to remove the lines

  	/* Check number of endpoints */
	if (intf->altsetting[0].desc.bNumEndpoints < 3)
		return -EIO;

It looks like since there's multiple interface descriptors for the device (see
attachment), and bNumEndpoints is only equal to 3 in one of them, then the test
fails and returns EIO. I don't know if this check should be removed altogether since
we subsequently iterate thru all the interfaces to get the endpoints.

hciconfig shows me 2 interfaces - is this correct ?

# hciconfig
hci0:	Type: USB
	BD Address: 00:00:00:00:00:00 ACL MTU: 0:0  SCO MTU: 0:0
	DOWN
	RX bytes:0 acl:0 sco:0 events:0 errors:0
	TX bytes:0 acl:0 sco:0 commands:0 errors:0

hci1:	Type: USB
	BD Address: 00:00:00:00:00:00 ACL MTU: 0:0  SCO MTU: 0:0
	DOWN
	RX bytes:0 acl:0 sco:0 events:0 errors:0
	TX bytes:0 acl:0 sco:0 commands:0 errors:0



T:  Bus=07 Lev=01 Prnt=01 Port=01 Cnt=01 Dev#=  2 Spd=12  MxCh= 0
D:  Ver= 1.10 Cls=e0(unk. ) Sub=01 Prot=01 MxPS= 8 #Cfgs=  1
P:  Vendor=0400 ProdID=0807 Rev= 1.00
C:* #Ifs= 2 Cfg#= 1 Atr=80 MxPwr=500mA
I:  If#= 0 Alt= 0 #EPs= 3 Cls=e0(unk. ) Sub=01 Prot=01 Driver=hci_usb
E:  Ad=81(I) Atr=03(Int.) MxPS=  64 Ivl=1ms
E:  Ad=82(I) Atr=02(Bulk) MxPS=  64 Ivl=0ms
E:  Ad=02(O) Atr=02(Bulk) MxPS=  64 Ivl=0ms
I:  If#= 1 Alt= 0 #EPs= 2 Cls=e0(unk. ) Sub=01 Prot=01 Driver=hci_usb
E:  Ad=83(I) Atr=01(Isoc) MxPS=   0 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=   0 Ivl=1ms
I:  If#= 1 Alt= 1 #EPs= 2 Cls=00(>ifc ) Sub=00 Prot=00 Driver=hci_usb
E:  Ad=83(I) Atr=01(Isoc) MxPS=   9 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=   9 Ivl=1ms
I:  If#= 1 Alt= 2 #EPs= 2 Cls=e0(unk. ) Sub=01 Prot=01 Driver=hci_usb
E:  Ad=83(I) Atr=01(Isoc) MxPS=  17 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=  17 Ivl=1ms
I:  If#= 1 Alt= 3 #EPs= 2 Cls=e0(unk. ) Sub=01 Prot=01 Driver=hci_usb
E:  Ad=83(I) Atr=01(Isoc) MxPS=  25 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=  25 Ivl=1ms
I:  If#= 1 Alt= 4 #EPs= 2 Cls=e0(unk. ) Sub=01 Prot=01 Driver=hci_usb
E:  Ad=83(I) Atr=01(Isoc) MxPS=  33 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=  33 Ivl=1ms
I:  If#= 1 Alt= 5 #EPs= 2 Cls=e0(unk. ) Sub=01 Prot=01 Driver=hci_usb
E:  Ad=83(I) Atr=01(Isoc) MxPS=  49 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=  49 Ivl=1ms


-------- Original Message --------
Subject: Re: [Bluez-users] NEC usb bluetooth support
Date: Tue, 16 Dec 2003 20:06:24 +0100
From: Marcel Holtmann <marcel@holtmann.org>
To: Mitch <Mitch@0bits.com>
CC: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
References: <3FDF2875.9030706@0Bits.COM>

Hi Mitch,

> Just bought one of these, but doesn't seem to work on 2.6.0-test11.
> syslog spews out:
> 
>   Bluetooth: HCI socket layer initialized
>   Bluetooth: HCI USB driver ver 2.4
>   hci_usb: probe of 7-2:1.1 failed with error -5
>   drivers/usb/core/usb.c: registered new driver hci_usb
> 
> Tried adding the device id's to hci_usb.c in vain.
> 
> Any ideas to get this beast working ?

your dongle should work out of the box. Have you tried 2.4.23?

Do you have a /proc/bus/usb/devices for us? It should show you something
like this

	T:  Bus=04 Lev=01 Prnt=01 Port=00 Cnt=01 Dev#=  7 Spd=12  MxCh= 0
	D:  Ver= 1.10 Cls=e0(unk. ) Sub=01 Prot=01 MxPS=64 #Cfgs=  1
	P:  Vendor=0a12 ProdID=0001
	C:* #Ifs= 3 Cfg#= 1 Atr=c0 MxPwr=  0mA
	I:  If#= 0 Alt= 0 #EPs= 3 Cls=e0(unk. ) Sub=01 Prot=01 Driver=hci_usb
	E:  Ad=81(I) Atr=03(Int.) MxPS=  16 Ivl=1ms
	E:  Ad=02(O) Atr=02(Bulk) MxPS=  64 Ivl=0ms
	E:  Ad=82(I) Atr=02(Bulk) MxPS=  64 Ivl=0ms

Regards

Marcel




--------------080807010300080408040807
Content-Type: text/plain;
 name="bluez.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="bluez.txt"


Bus 007 Device 002: ID 0400:0807 National Semiconductor Corp. 
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               1.10
  bDeviceClass          224 Wireless
  bDeviceSubClass         1 Radio Frequency
  bDeviceProtocol         1 Bluetooth
  bMaxPacketSize0         8
  idVendor           0x0400 National Semiconductor Corp.
  idProduct          0x0807 
  bcdDevice            1.00
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
    bmAttributes         0x80
    MaxPower              500mA
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
          Synch Type               none
        wMaxPacketSize         64
        bInterval               1
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x82  EP 2 IN
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               none
        wMaxPacketSize         64
        bInterval               0
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x02  EP 2 OUT
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               none
        wMaxPacketSize         64
        bInterval               0
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
        bEndpointAddress     0x83  EP 3 IN
        bmAttributes            1
          Transfer Type            Isochronous
          Synch Type               none
        wMaxPacketSize          0
        bInterval               1
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x03  EP 3 OUT
        bmAttributes            1
          Transfer Type            Isochronous
          Synch Type               none
        wMaxPacketSize          0
        bInterval               1
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        1
      bAlternateSetting       1
      bNumEndpoints           2
      bInterfaceClass         0 (Defined at Interface level)
      bInterfaceSubClass      0 
      bInterfaceProtocol      0 
      iInterface              0 
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x83  EP 3 IN
        bmAttributes            1
          Transfer Type            Isochronous
          Synch Type               none
        wMaxPacketSize          9
        bInterval               1
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x03  EP 3 OUT
        bmAttributes            1
          Transfer Type            Isochronous
          Synch Type               none
        wMaxPacketSize          9
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
        bEndpointAddress     0x83  EP 3 IN
        bmAttributes            1
          Transfer Type            Isochronous
          Synch Type               none
        wMaxPacketSize         17
        bInterval               1
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x03  EP 3 OUT
        bmAttributes            1
          Transfer Type            Isochronous
          Synch Type               none
        wMaxPacketSize         17
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
        bEndpointAddress     0x83  EP 3 IN
        bmAttributes            1
          Transfer Type            Isochronous
          Synch Type               none
        wMaxPacketSize         25
        bInterval               1
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x03  EP 3 OUT
        bmAttributes            1
          Transfer Type            Isochronous
          Synch Type               none
        wMaxPacketSize         25
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
        bEndpointAddress     0x83  EP 3 IN
        bmAttributes            1
          Transfer Type            Isochronous
          Synch Type               none
        wMaxPacketSize         33
        bInterval               1
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x03  EP 3 OUT
        bmAttributes            1
          Transfer Type            Isochronous
          Synch Type               none
        wMaxPacketSize         33
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
        bEndpointAddress     0x83  EP 3 IN
        bmAttributes            1
          Transfer Type            Isochronous
          Synch Type               none
        wMaxPacketSize         49
        bInterval               1
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x03  EP 3 OUT
        bmAttributes            1
          Transfer Type            Isochronous
          Synch Type               none
        wMaxPacketSize         49
        bInterval               1
  Language IDs: (length=4)
     0409 English(US)


--------------080807010300080408040807--
