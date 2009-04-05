Return-Path: <cyrus@holtmann.org>
Message-ID: <49D8A346.1010505@pook.es>
Date: Sun, 05 Apr 2009 14:25:42 +0200
From: Stuart Pook <linux-bluetooth4@pook.es>
MIME-Version: 1.0
To: BlueZ development <linux-bluetooth@vger.kernel.org>
Subject: Belkin F8T017 Adapter requires hciconfig hci0 down/up with bluez
 4.34
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

hello

Why does my Belkin F8T017 (v2.1 + EDR) Bluetooth Adapter require a hciconfig hci0 down followed by a hciconfig hci0 up before it wants to work?

When I plug my Belkin F8T017 Bluetooth Adapter in bluetoothd (bluez 4.34) says

bluetoothd[10690]: HCI dev 0 registered
bluetoothd[10690]: child 10760 forked
bluetoothd[10690]: child 10760 exited
bluetoothd[10690]: HCI dev 0 up
bluetoothd[10690]: Starting security manager 0
bluetoothd[10690]: Can't read class of adapter on /org/bluez/10690/hci0: Unknown error 4294967291 (-5)
bluetoothd[10690]: Getting name failed with status 0x0c
bluetoothd[10690]: Can't read class of device on hci0: Input/output error (5)

and nothing works.

:; hcitool scan
Scanning ...
Inquiry failed: Connection timed out

If I do, hciconfig hci0 down, I see

bluetoothd[10690]: HCI dev 0 down
bluetoothd[10690]: Adapter /org/bluez/10690/hci0 has been disabled
bluetoothd[10690]: Stopping security manager 0

A following "hciconfig hci0 up", is able to correctly configure the adapter:

bluetoothd[10690]: HCI dev 0 up
bluetoothd[10690]: Starting security manager 0
bluetoothd[10690]: register_interface: path /org/bluez/10690/hci0
bluetoothd[10690]: Registered interface org.bluez.Service on path /org/bluez/10690/hci0
bluetoothd[10690]: headset_server_probe: path /org/bluez/10690/hci0
bluetoothd[10690]: Adding record with handle 0x10000
bluetoothd[10690]: Record pattern UUID 00000003-0000-1000-8000-00805f9
bluetoothd[10690]: Record pattern UUID 00000100-0000-1000-8000-00805f9
bluetoothd[10690]: Record pattern UUID 00001002-0000-1000-8000-00805f9
bluetoothd[10690]: Record pattern UUID 00001108-0000-1000-8000-00805f9
bluetoothd[10690]: Record pattern UUID 00001112-0000-1000-8000-00805f9
bluetoothd[10690]: Record pattern UUID 00001203-0000-1000-8000-00805f9
bluetoothd[10690]: Adding record with handle 0x10001
bluetoothd[10690]: Record pattern UUID 00000003-0000-1000-8000-00805f9
bluetoothd[10690]: Record pattern UUID 00000100-0000-1000-8000-00805f9
bluetoothd[10690]: Record pattern UUID 00001002-0000-1000-8000-00805f9
bluetoothd[10690]: Record pattern UUID 0000111e-0000-1000-8000-00805f9
bluetoothd[10690]: Record pattern UUID 0000111f-0000-1000-8000-00805f9
bluetoothd[10690]: Record pattern UUID 00001203-0000-1000-8000-00805f9
bluetoothd[10690]: a2dp_server_probe: path /org/bluez/10690/hci0
bluetoothd[10690]: SEP 0xb8ed54e0 registered: type:0 codec:0 seid:1
bluetoothd[10690]: Adding record with handle 0x10002
bluetoothd[10690]: Record pattern UUID 00000019-0000-1000-8000-00805f9
bluetoothd[10690]: Record pattern UUID 00000100-0000-1000-8000-00805f9
bluetoothd[10690]: Record pattern UUID 00001002-0000-1000-8000-00805f9
bluetoothd[10690]: Record pattern UUID 0000110a-0000-1000-8000-00805f9
bluetoothd[10690]: Record pattern UUID 0000110d-0000-1000-8000-00805f9
bluetoothd[10690]: avrcp_server_probe: path /org/bluez/10690/hci0
bluetoothd[10690]: Adding record with handle 0x10003
bluetoothd[10690]: Record pattern UUID 00000017-0000-1000-8000-00805f9
bluetoothd[10690]: Record pattern UUID 00000100-0000-1000-8000-00805f9
bluetoothd[10690]: Record pattern UUID 00001002-0000-1000-8000-00805f9
bluetoothd[10690]: Record pattern UUID 0000110c-0000-1000-8000-00805f9
bluetoothd[10690]: Record pattern UUID 0000110e-0000-1000-8000-00805f9
bluetoothd[10690]: Adding record with handle 0x10004
bluetoothd[10690]: Record pattern UUID 00000017-0000-1000-8000-00805f9
bluetoothd[10690]: Record pattern UUID 00000100-0000-1000-8000-00805f9
bluetoothd[10690]: Record pattern UUID 00001002-0000-1000-8000-00805f9
bluetoothd[10690]: Record pattern UUID 0000110e-0000-1000-8000-00805f9
bluetoothd[10690]: Creating device /org/bluez/10690/hci0/dev_00_1A_45_2F_49_98
bluetoothd[10690]: Probe drivers for /org/bluez/10690/hci0/dev_00_1A_45_2F_49_98
bluetoothd[10690]: adapter_get_device(00:1A:45:2F:49:98)
bluetoothd[10690]: Registered interface org.bluez.Audio on path /org/bluez/10690/hci0/dev_00_1A_45_2F_49_98
bluetoothd[10690]: Found Headset record
bluetoothd[10690]: Discovered Headset service on RFCOMM channel 2
bluetoothd[10690]: Registered interface org.bluez.Headset on path /org/bluez/10690/hci0/dev_00_1A_45_2F_49_98
bluetoothd[10690]: Found Handsfree record
bluetoothd[10690]: Discovered Handsfree service on RFCOMM channel 1
bluetoothd[10690]: Creating device /org/bluez/10690/hci0/dev_00_17_E5_0C_EA_70
bluetoothd[10690]: Probe drivers for /org/bluez/10690/hci0/dev_00_17_E5_0C_EA_70
bluetoothd[10690]: adapter_get_device(00:17:E5:0C:EA:70)
bluetoothd[10690]: Registered interface org.bluez.Audio on path /org/bluez/10690/hci0/dev_00_17_E5_0C_EA_70
bluetoothd[10690]: audio handle_uuid: server not enabled for 00001112-0000-1000-8000-00805f9b34fb (0x1112)
bluetoothd[10690]: audio handle_uuid: server not enabled for 0000111f-0000-1000-8000-00805f9b34fb (0x111f)
bluetoothd[10690]: Found AV Target
bluetoothd[10690]: Registered interface org.bluez.Control on path /org/bluez/10690/hci0/dev_00_17_E5_0C_EA_70
bluetoothd[10690]: Found AV Target
bluetoothd[10690]: Changing service classes to 0x480104
bluetoothd[10690]: Adapter /org/bluez/10690/hci0 has been enabled
bluetoothd[10690]: Computer is classified as desktop
bluetoothd[10690]: Current device class is 0x480104
bluetoothd[10690]: Setting 0x000104 for major/minor device class
bluetoothd[10690]: Changing major/minor class to 0x480104

Now hcitool scan works fine

:; hcitool scan
Scanning ...
	00:03:C9:D4:34:E9	n/a
	00:1D:F6:A5:A8:08	Ln in thesky


This not a new problem. I have had this problem ever since I bought my F8T017 in October 2008. http://marc.info/?l=linux-bluetooth&m=122333510701175&w=2

: root; lsusb -vd 050d:0017

Bus 001 Device 041: ID 050d:0017 Belkin Components 
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               2.00
  bDeviceClass          224 Wireless
  bDeviceSubClass         1 Radio Frequency
  bDeviceProtocol         1 Bluetooth
  bMaxPacketSize0        64
  idVendor           0x050d Belkin Components
  idProduct          0x0017 
  bcdDevice            2.91
  iManufacturer           1 Broadcom Corp
  iProduct                2 BLUETOOTH USB +EDR ADAPTER Class 1 v2.1 UHE
  iSerial                 3 000A3A8494D9
  bNumConfigurations      1
  Configuration Descriptor:
    bLength                 9
    bDescriptorType         2
    wTotalLength          216
    bNumInterfaces          4
    bConfigurationValue     1
    iConfiguration          0 
    bmAttributes         0xa0
      (Bus Powered)
      Remote Wakeup
    MaxPower                2mA
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
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0020  1x 32 bytes
        bInterval               1
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x03  EP 3 OUT
        bmAttributes            1
          Transfer Type            Isochronous
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0020  1x 32 bytes
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
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0040  1x 64 bytes
        bInterval               1
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x03  EP 3 OUT
        bmAttributes            1
          Transfer Type            Isochronous
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0040  1x 64 bytes
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
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0040  1x 64 bytes
        bInterval               1
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x03  EP 3 OUT
        bmAttributes            1
          Transfer Type            Isochronous
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0040  1x 64 bytes
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
      bInterfaceProtocol      0 
      iInterface              0 
      ** UNRECOGNIZED:  07 21 07 88 13 40 00
Device Status:     0x0000
  (Bus Powered)

: root; uname -a
Linux kooka 2.6.28-1-686 #1 SMP Mon Feb 23 03:13:24 UTC 2009 i686 GNU/Linux

-- 
If the From address bounces, please see http://www.pook.it/.
