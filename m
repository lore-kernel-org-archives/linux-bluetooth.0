Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <16dd70ff0502111208f70575c@mail.gmail.com>
From: Cristian Tapus <cristian.tapus@gmail.com>
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] Bluetooth problem under FC3 on a D600
In-Reply-To: <1108123347.18099.14.camel@pegasus>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
References: <16dd70ff050211012063a9c6f5@mail.gmail.com>
	 <1108123347.18099.14.camel@pegasus>
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
Date: Fri, 11 Feb 2005 12:08:32 -0800

Marcel,

Thanks for your prompt reply. 
The bluetooth device that I have is an onboard bluetooth device that came
with my Dell Latitude D600 laptop. At the end of this email you can find the
output of lsusb -v for this particular device. 
By default, after I reboot the laptop, the class is set to 0
With that class, here is the hcidump -X
The ouput below is for the two commands above: hciconfig -a and hcitool scan
After I set the class to 0x120104 I get the same output and behavior from
hcidump -X

Cheers,

Cristian


[crt@localhost etc]$ sudo hciconfig -a
Password:
hci0:   Type: USB
        BD Address: <addr> ACL MTU: 192:8  SCO MTU: 64:8
        UP RUNNING PSCAN ISCAN
        RX bytes:95 acl:0 sco:0 events:11 errors:0
        TX bytes:31 acl:0 sco:0 commands:8 errors:0
        Features: 0xff 0xff 0x8f 0x78 0x18 0x18 0x00 0x80
        Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
        Link policy:
        Link mode: SLAVE ACCEPT
        Name: 'CSR - bc2'
        Class: 0x000000
        Service Classes: Unspecified
        Device Class: Miscellaneous,
        HCI Ver: 1.2 (0x2) HCI Rev: 0x4f2 LMP Ver: 1.2 (0x2) LMP Subver: 0x4f2
        Manufacturer: Cambridge Silicon Radio (10)


[crt@localhost etc]$ sudo hcitool scan
Password:
Scanning ...


[crt@localhost etc]$ sudo hcidump -X
HCIDump - HCI packet analyzer ver 1.11
device: hci0 snap_len: 1028 filter: 0xffffffff
> HCI Event: Vendor (0xff) plen 7
  0000: cd 03 00 04 00 00 00                              .......
< HCI Command: Read Local Name (0x03|0x0014) plen 0
> HCI Event: Command Complete (0x0e) plen 252
  0000: 01 14 0c 00 43 53 52 20 2d 20 62 63 32 00 00 00   ....CSR - bc2...
  0010: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00   ................
  0020: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00   ................
  0030: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00   ................
  0040: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00   ................
  0050: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00   ................
  0060: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00   ................
  0070: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00   ................
  0080: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00   ................
  0090: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00   ................
  00a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00   ................
  00b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00   ................
  00c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00   ................
  00d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00   ................
  00e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00   ................
  00f0: 00 00 00 00 00 00 00 00 00 00 00 00               ............
< HCI Command: Read Class of Device (0x03|0x0023) plen 0
> HCI Event: Command Complete (0x0e) plen 7
  0000: 01 23 0c 00 00 00 00                              .#.....
< HCI Command: Read Local Version Information (0x04|0x0001) plen 0
> HCI Event: Command Complete (0x0e) plen 12
  0000: 01 01 10 00 02 f2 04 02 0a 00 f2 04               ............
< HCI Command: Inquiry (0x01|0x0001) plen 5
  0000: 33 8b 9e 08 64                                    3...d
> HCI Event: Command Status (0x0f) plen 4
  0000: 00 01 01 04                                       ....
> HCI Event: Vendor (0xff) plen 7
    CSR: VM (channel 13)
    0000: 03 00 04 00 00 00                                 ......
> HCI Event: Vendor (0xff) plen 7
    CSR: VM (channel 13)
    0000: 03 00 04 00 00 00                                 ......
> HCI Event: Vendor (0xff) plen 7
    CSR: VM (channel 13)
    0000: 03 00 04 00 00 00                                 ......
> HCI Event: Vendor (0xff) plen 7
    CSR: VM (channel 13)
    0000: 03 00 04 00 00 00                                 ......
> HCI Event: Vendor (0xff) plen 7
    CSR: VM (channel 13)
    0000: 03 00 04 00 00 00                                 ......
> HCI Event: Vendor (0xff) plen 7
    CSR: VM (channel 13)
    0000: 03 00 04 00 00 00                                 ......
> HCI Event: Vendor (0xff) plen 7
    CSR: VM (channel 13)
    0000: 03 00 04 00 00 00                                 ......
> HCI Event: Vendor (0xff) plen 7
    CSR: VM (channel 13)
    0000: 03 00 04 00 00 00                                 ......
> HCI Event: Vendor (0xff) plen 7
    CSR: VM (channel 13)
    0000: 03 00 04 00 00 00                                 ......
> HCI Event: Vendor (0xff) plen 7
    CSR: VM (channel 13)
    0000: 03 00 04 00 00 00                                 ......
> HCI Event: Inquiry Complete (0x01) plen 1
  0000: 00                                                .


[crt@localhost etc]$ sudo lsusb -vv

Bus 002 Device 002: ID 413c:8000 Dell Computer Corp.
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               2.00
  bDeviceClass          224 Wireless
  bDeviceSubClass         1 Radio Frequency
  bDeviceProtocol         1 Bluetooth
  bMaxPacketSize0        64
  idVendor           0x413c Dell Computer Corp.
  idProduct          0x8000
  bcdDevice           12.66
  iManufacturer           0
  iProduct                0
  iSerial                 0
  bNumConfigurations      1
  Configuration Descriptor:
    bLength                 9
    bDescriptorType         2
    wTotalLength          193
    bNumInterfaces          3
    bConfigurationValue     1
    iConfiguration          0
    bmAttributes         0xe0
      Self Powered
      Remote Wakeup
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
          Synch Type               none
          Usage Type               Data
        wMaxPacketSize     0x0010  bytes 16 once
        bInterval               1
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x02  EP 2 OUT
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               none
          Usage Type               Data
        wMaxPacketSize     0x0040  bytes 64 once
        bInterval               1
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x82  EP 2 IN
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               none
          Usage Type               Data
        wMaxPacketSize     0x0040  bytes 64 once
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
          Synch Type               none
          Usage Type               Data
        wMaxPacketSize     0x0000  bytes 0 once
        bInterval               1
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x83  EP 3 IN
        bmAttributes            1
          Transfer Type            Isochronous
          Synch Type               none
          Usage Type               Data
        wMaxPacketSize     0x0000  bytes 0 once
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
          Synch Type               none
          Usage Type               Data
        wMaxPacketSize     0x0009  bytes 9 once
        bInterval               1
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x83  EP 3 IN
        bmAttributes            1
          Transfer Type            Isochronous
          Synch Type               none
          Usage Type               Data
        wMaxPacketSize     0x0009  bytes 9 once
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
          Synch Type               none
          Usage Type               Data
        wMaxPacketSize     0x0011  bytes 17 once
        bInterval               1
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x83  EP 3 IN
        bmAttributes            1
          Transfer Type            Isochronous
          Synch Type               none
          Usage Type               Data
        wMaxPacketSize     0x0011  bytes 17 once
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
          Synch Type               none
          Usage Type               Data
        wMaxPacketSize     0x0019  bytes 25 once
        bInterval               1
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x83  EP 3 IN
        bmAttributes            1
          Transfer Type            Isochronous
          Synch Type               none
          Usage Type               Data
        wMaxPacketSize     0x0019  bytes 25 once
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
          Synch Type               none
          Usage Type               Data
        wMaxPacketSize     0x0021  bytes 33 once
        bInterval               1
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x83  EP 3 IN
        bmAttributes            1
          Transfer Type            Isochronous
          Synch Type               none
          Usage Type               Data
        wMaxPacketSize     0x0021  bytes 33 once
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
          Synch Type               none
          Usage Type               Data
        wMaxPacketSize     0x0031  bytes 49 once
        bInterval               1
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x83  EP 3 IN
        bmAttributes            1
          Transfer Type            Isochronous
          Synch Type               none
          Usage Type               Data
        wMaxPacketSize     0x0031  bytes 49 once
        bInterval               1
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        2
      bAlternateSetting       0
      bNumEndpoints           0
      bInterfaceClass       254 Application Specific Interface
      bInterfaceSubClass      1 Device Firmware Update
      bInterfaceProtocol      0
      iInterface              0
  unknown device class descriptor: 07 21 07 88 13 ff 03


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
