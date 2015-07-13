Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?I=C3=B1aki=20Arenaza?= <iarenaza@mondragon.edu>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?I=C3=B1aki=20Arenaza?= <iarenaza@mondragon.edu>
Subject: [PATCH 0/1] device: Some devices send HSP UUIDs in the wrong order
Date: Mon, 13 Jul 2015 23:32:48 +0200
Message-Id: <1436823169-32164-1-git-send-email-iarenaza@mondragon.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

[Please, CC me as I am not subscribed to the list.]

Hi all, 

Some devices behave contrary to what Erratum #3507 [1] says for the
v1.2 Headset Profile (HSP). They report HEADSET_HS_UUID as the first
value of the ServiceClassIDList attribute, and HSP_HS_UUID as the
second one. At leat one of those devices is the Energy Wireles BT 3
Ruby Red (from Energy Sistem).

[1] See section 6.15 of
    https://www.bluetooth.org/docman/handlers/downloaddoc.ashx?doc_id=231555

To make sure the issue is due to the headset and not to the Bluetooth
controller firmware, I have tested it with two differente computers
having two different controllers.

Below are the full details of the headset model, the two computer
models, the Bluetooth controller models, the raw output from sdptool
before applying the proposed patch (it's exactly the same in both
computers, so I'm attaching the details just once), and the output
from bluetoothctl when pairing the headset before and after applying
the patch (again the same on both computers, so attaching it once).

If I don't apply the patch, the headset is not recognized as an HSP
device and is not usable from Pulseaudio (I can just use the A2DP mode
of it). With the patch applied, it is correctly detected and can be
used either in A2DP or HSP mode in Pulseaudio.

Full Details
============
 
1.- Bluetooth headset model:

  Energy Wireles BT 3 Ruby Red (from Energy Sistem)

2.- First computer model:

  Hewlett-Packard HP ZBook 14/198F, BIOS L71 Ver. 01.30 12/09/2014

3.- Bluetooth adapter info for first computer model:

  root@osgiliath# lsusb -v -d "8087:07dc"
  Bus 001 Device 006: ID 8087:07dc Intel Corp. 
  Device Descriptor:
    bLength                18
    bDescriptorType         1
    bcdUSB               2.00
    bDeviceClass          224 Wireless
    bDeviceSubClass         1 Radio Frequency
    bDeviceProtocol         1 Bluetooth
    bMaxPacketSize0        64
    idVendor           0x8087 Intel Corp.
    idProduct          0x07dc 
    bcdDevice            0.01
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
      bmAttributes         0xe0
        Self Powered
        Remote Wakeup
      MaxPower              100mA
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

4. Second computer model:

  Hewlett-Packard HP Elitebook 6930p/30DB, BIOS 68CPU Ver. F.20 12/02/2011

5.- Bluetooth adapter info for second computer model:

  root@debian# lsusb -v -d "03f0:171d"
  Bus 001 Device 003: ID 03f0:171d Hewlett-Packard Bluetooth 2.0 Interface [Broadcom BCM2045]
  Device Descriptor:
    bLength                18
    bDescriptorType         1
    bcdUSB               2.00
    bDeviceClass          224 Wireless
    bDeviceSubClass         1 Radio Frequency
    bDeviceProtocol         1 Bluetooth
    bMaxPacketSize0        64
    idVendor           0x03f0 Hewlett-Packard
    idProduct          0x171d Bluetooth 2.0 Interface [Broadcom BCM2045]
    bcdDevice            1.00
    iManufacturer           1 Broadcom Corp
    iProduct                2 HP Integrated Module
    iSerial                 0 
    bNumConfigurations      1
    Configuration Descriptor:
      bLength                 9
      bDescriptorType         2
      wTotalLength          216
      bNumInterfaces          4
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
        Device Firmware Upgrade Interface Descriptor:
          bLength                             7
          bDescriptorType                    33
          bmAttributes                        7
            Will Not Detach
            Manifestation Tolerant
            Upload Supported
            Download Supported
          wDetachTimeout                   5000 milliseconds
          wTransferSize                      64 bytes
  Device Status:     0x0001
    Self Powered

6.- SDP info from the headset, before applying the patch:

  root@osgiliath# hciconfig hci0 up
  root@osgiliath# sdptool browse --raw DC:2C:26:10:1F:D8
  Sequence
          Attribute 0x0000 - ServiceRecordHandle
                  UINT32 0x00010000
          Attribute 0x0001 - ServiceClassIDList
                  Sequence
                          UUID16 0x1200 - PnPInformation
          Attribute 0x0005 - BrowseGroupList
                  Sequence
                          UUID16 0x1002 - PublicBrowseGroup
          Attribute 0x0200
                  UINT16 0x0103
          Attribute 0x0201
                  UINT16 0x000f
          Attribute 0x0202
                  UINT16 0x0000
          Attribute 0x0203
                  UINT16 0x0000
          Attribute 0x0204
                  Bool True
          Attribute 0x0205
                  UINT16 0x0001
          Attribute 0x8001
                  UINT16 0x0001
  Service Search failed: Invalid argument
  Sequence
          Attribute 0x0000 - ServiceRecordHandle
                  UINT32 0x00010001
          Attribute 0x0001 - ServiceClassIDList
                  Sequence
                          UUID16 0x1131 - Headset (HSP)
                          UUID16 0x1108 - Headset
                          UUID16 0x1203 - GenericAudio
          Attribute 0x0004 - ProtocolDescriptorList
                  Sequence
                          Sequence
                                  UUID16 0x0100 - L2CAP
                          Sequence
                                  UUID16 0x0003 - RFCOMM
                                  UINT8 0x01
          Attribute 0x0005 - BrowseGroupList
                  Sequence
                          UUID16 0x1002 - PublicBrowseGroup
          Attribute 0x0009 - BluetoothProfileDescriptorList
                  Sequence
                          Sequence
                                  UUID16 0x1108 - Headset
                                  UINT16 0x0102
          Attribute 0x0100
                  Data 48 53 50 20 73 65 72 76 69 63 65 00 00
          Attribute 0x0302
                  Bool True
  Sequence
          Attribute 0x0000 - ServiceRecordHandle
                  UINT32 0x00010002
          Attribute 0x0001 - ServiceClassIDList
                  Sequence
                          UUID16 0x111e - Handsfree
                          UUID16 0x1203 - GenericAudio
          Attribute 0x0004 - ProtocolDescriptorList
                  Sequence
                          Sequence
                                  UUID16 0x0100 - L2CAP
                          Sequence
                                  UUID16 0x0003 - RFCOMM
                                  UINT8 0x02
          Attribute 0x0005 - BrowseGroupList
                  Sequence
                          UUID16 0x1002 - PublicBrowseGroup
          Attribute 0x0009 - BluetoothProfileDescriptorList
                  Sequence
                          Sequence
                                  UUID16 0x111e - Handsfree
                                  UINT16 0x0106
          Attribute 0x0100
                  Data 48 46 50 20 73 65 72 76 69 63 65 00 00
          Attribute 0x0311
                  UINT16 0x00bf
  Sequence
          Attribute 0x0000 - ServiceRecordHandle
                  UINT32 0x00010003
          Attribute 0x0001 - ServiceClassIDList
                  Sequence
                          UUID16 0x110c - RemoteControlTarget
          Attribute 0x0004 - ProtocolDescriptorList
                  Sequence
                          Sequence
                                  UUID16 0x0100 - L2CAP
                                  UINT16 0x0017
                          Sequence
                                  UUID16 0x0017 - AVCTP
                                  UINT16 0x0103
          Attribute 0x0005 - BrowseGroupList
                  Sequence
                          UUID16 0x1002 - PublicBrowseGroup
          Attribute 0x0009 - BluetoothProfileDescriptorList
                  Sequence
                          Sequence
                                  UUID16 0x110e - RemoteControl
                                  UINT16 0x0104
          Attribute 0x000d - AdditionalProtocolDescriptorLists
                  Sequence
                          Sequence
                                  Sequence
                                          UUID16 0x0100 - L2CAP
                                          UINT16 0x001b
                                  Sequence
                                          UUID16 0x0017 - AVCTP
                                          UINT16 0x0103
          Attribute 0x0311
                  UINT16 0x0002
  Sequence
          Attribute 0x0000 - ServiceRecordHandle
                  UINT32 0x00010004
          Attribute 0x0001 - ServiceClassIDList
                  Sequence
                          UUID16 0x110e - RemoteControl
                          UUID16 0x110f - RemoteControlController
          Attribute 0x0004 - ProtocolDescriptorList
                  Sequence
                          Sequence
                                  UUID16 0x0100 - L2CAP
                                  UINT16 0x0017
                          Sequence
                                  UUID16 0x0017 - AVCTP
                                  UINT16 0x0103
          Attribute 0x0005 - BrowseGroupList
                  Sequence
                          UUID16 0x1002 - PublicBrowseGroup
          Attribute 0x0009 - BluetoothProfileDescriptorList
                  Sequence
                          Sequence
                                  UUID16 0x110e - RemoteControl
                                  UINT16 0x0104
          Attribute 0x000d - AdditionalProtocolDescriptorLists
                  Sequence
                          Sequence
                                  Sequence
                                          UUID16 0x0100 - L2CAP
                                          UINT16 0x001b
                                  Sequence
                                          UUID16 0x0017 - AVCTP
                                          UINT16 0x0103
          Attribute 0x0311
                  UINT16 0x0003
  Sequence
          Attribute 0x0000 - ServiceRecordHandle
                  UINT32 0x00010005
          Attribute 0x0001 - ServiceClassIDList
                  Sequence
                          UUID16 0x110b - AudioSink
          Attribute 0x0004 - ProtocolDescriptorList
                  Sequence
                          Sequence
                                  UUID16 0x0100 - L2CAP
                                  UINT16 0x0019
                          Sequence
                                  UUID16 0x0019 - AVDTP
                                  UINT16 0x0103
          Attribute 0x0005 - BrowseGroupList
                  Sequence
                          UUID16 0x1002 - PublicBrowseGroup
          Attribute 0x0009 - BluetoothProfileDescriptorList
                  Sequence
                          Sequence
                                  UUID16 0x110d - AdvancedAudio
                                  UINT16 0x0103
          Attribute 0x0100
                  Data 41 64 76 61 6e 63 65 64 20 61 75 64 69 6f 20 73 65 72 76 69 63 65 00 00
          Attribute 0x0311
                  UINT16 0x0001
  
7.- Bluetooth discovery, pairing and configuration, before applying
    the patch:

  root@osgiliath# /usr/sbin/bluetoothd &
  root@osgiliath# bluetoothctl
  [NEW] Controller AC:FD:CE:02:8D:AB osgiliath [default]
  [bluetooth]# power on
  Changing power on succeeded
  [CHG] Controller AC:FD:CE:02:8D:AB Powered: yes
  [bluetooth]# scan on
  Discovery started
  [CHG] Controller AC:FD:CE:02:8D:AB Discovering: yes
  [NEW] Device DC:2C:26:10:1F:D8 Energy BT 3
  [CHG] Device DC:2C:26:10:1F:D8 RSSI: -49
  [bluetooth]# pair DC:2C:26:10:1F:D8 
  Attempting to pair with DC:2C:26:10:1F:D8
  [CHG] Device DC:2C:26:10:1F:D8 Connected: yes
  [CHG] Device DC:2C:26:10:1F:D8 Modalias: bluetooth:v000Fp0000d0000
  [CHG] Device DC:2C:26:10:1F:D8 UUIDs:
          0000110b-0000-1000-8000-00805f9b34fb
          0000110c-0000-1000-8000-00805f9b34fb
          0000110e-0000-1000-8000-00805f9b34fb
          0000111e-0000-1000-8000-00805f9b34fb
          00001131-0000-1000-8000-00805f9b34fb
          00001200-0000-1000-8000-00805f9b34fb
  [CHG] Device DC:2C:26:10:1F:D8 Paired: yes
  Pairing successful
  [bluetooth]# scan off
  [CHG] Device DC:2C:26:10:1F:D8 RSSI is nil
  [CHG] Controller AC:FD:CE:02:8D:AB Discovering: no
  Discovery stopped
  [CHG] Device DC:2C:26:10:1F:D8 Connected: no
  [bluetooth]# info DC:2C:26:10:1F:D8 
  Device DC:2C:26:10:1F:D8
          Name: Energy BT 3
          Alias: Energy BT 3
          Class: 0x240404
          Icon: audio-card
          Paired: yes
          Trusted: no
          Blocked: no
          Connected: no
          LegacyPairing: no
          UUID: Audio Sink                (0000110b-0000-1000-8000-00805f9b34fb)
          UUID: A/V Remote Control Target (0000110c-0000-1000-8000-00805f9b34fb)
          UUID: A/V Remote Control        (0000110e-0000-1000-8000-00805f9b34fb)
          UUID: Handsfree                 (0000111e-0000-1000-8000-00805f9b34fb)
          UUID: Headset HS                (00001131-0000-1000-8000-00805f9b34fb)
          UUID: PnP Information           (00001200-0000-1000-8000-00805f9b34fb)
          Modalias: bluetooth:v000Fp0000d0000
  [bluetooth]# exit

8. SDP info from the headset (after applying the patch). Nothing
   changes, as expected:

  root@osgiliath# sdptool browse --raw DC:2C:26:10:1F:D8
  Sequence
          Attribute 0x0000 - ServiceRecordHandle
                  UINT32 0x00010000
          Attribute 0x0001 - ServiceClassIDList
                  Sequence
                          UUID16 0x1200 - PnPInformation
          Attribute 0x0005 - BrowseGroupList
                  Sequence
                          UUID16 0x1002 - PublicBrowseGroup
          Attribute 0x0200
                  UINT16 0x0103
          Attribute 0x0201
                  UINT16 0x000f
          Attribute 0x0202
                  UINT16 0x0000
          Attribute 0x0203
                  UINT16 0x0000
          Attribute 0x0204
                  Bool True
          Attribute 0x0205
                  UINT16 0x0001
          Attribute 0x8001
                  UINT16 0x0001
  Service Search failed: Invalid argument
  Sequence
          Attribute 0x0000 - ServiceRecordHandle
                  UINT32 0x00010001
          Attribute 0x0001 - ServiceClassIDList
                  Sequence
                          UUID16 0x1131 - Headset (HSP)
                          UUID16 0x1108 - Headset
                          UUID16 0x1203 - GenericAudio
          Attribute 0x0004 - ProtocolDescriptorList
                  Sequence
                          Sequence
                                  UUID16 0x0100 - L2CAP
                          Sequence
                                  UUID16 0x0003 - RFCOMM
                                  UINT8 0x01
          Attribute 0x0005 - BrowseGroupList
                  Sequence
                          UUID16 0x1002 - PublicBrowseGroup
          Attribute 0x0009 - BluetoothProfileDescriptorList
                  Sequence
                          Sequence
                                  UUID16 0x1108 - Headset
                                  UINT16 0x0102
          Attribute 0x0100
                  Data 48 53 50 20 73 65 72 76 69 63 65 00 00
          Attribute 0x0302
                  Bool True
  Sequence
          Attribute 0x0000 - ServiceRecordHandle
                  UINT32 0x00010002
          Attribute 0x0001 - ServiceClassIDList
                  Sequence
                          UUID16 0x111e - Handsfree
                          UUID16 0x1203 - GenericAudio
          Attribute 0x0004 - ProtocolDescriptorList
                  Sequence
                          Sequence
                                  UUID16 0x0100 - L2CAP
                          Sequence
                                  UUID16 0x0003 - RFCOMM
                                  UINT8 0x02
          Attribute 0x0005 - BrowseGroupList
                  Sequence
                          UUID16 0x1002 - PublicBrowseGroup
          Attribute 0x0009 - BluetoothProfileDescriptorList
                  Sequence
                          Sequence
                                  UUID16 0x111e - Handsfree
                                  UINT16 0x0106
          Attribute 0x0100
                  Data 48 46 50 20 73 65 72 76 69 63 65 00 00
          Attribute 0x0311
                  UINT16 0x00bf
  Sequence
          Attribute 0x0000 - ServiceRecordHandle
                  UINT32 0x00010003
          Attribute 0x0001 - ServiceClassIDList
                  Sequence
                          UUID16 0x110c - RemoteControlTarget
          Attribute 0x0004 - ProtocolDescriptorList
                  Sequence
                          Sequence
                                  UUID16 0x0100 - L2CAP
                                  UINT16 0x0017
                          Sequence
                                  UUID16 0x0017 - AVCTP
                                  UINT16 0x0103
          Attribute 0x0005 - BrowseGroupList
                  Sequence
                          UUID16 0x1002 - PublicBrowseGroup
          Attribute 0x0009 - BluetoothProfileDescriptorList
                  Sequence
                          Sequence
                                  UUID16 0x110e - RemoteControl
                                  UINT16 0x0104
          Attribute 0x000d - AdditionalProtocolDescriptorLists
                  Sequence
                          Sequence
                                  Sequence
                                          UUID16 0x0100 - L2CAP
                                          UINT16 0x001b
                                  Sequence
                                          UUID16 0x0017 - AVCTP
                                          UINT16 0x0103
          Attribute 0x0311
                  UINT16 0x0002
  Sequence
          Attribute 0x0000 - ServiceRecordHandle
                  UINT32 0x00010004
          Attribute 0x0001 - ServiceClassIDList
                  Sequence
                          UUID16 0x110e - RemoteControl
                          UUID16 0x110f - RemoteControlController
          Attribute 0x0004 - ProtocolDescriptorList
                  Sequence
                          Sequence
                                  UUID16 0x0100 - L2CAP
                                  UINT16 0x0017
                          Sequence
                                  UUID16 0x0017 - AVCTP
                                  UINT16 0x0103
          Attribute 0x0005 - BrowseGroupList
                  Sequence
                          UUID16 0x1002 - PublicBrowseGroup
          Attribute 0x0009 - BluetoothProfileDescriptorList
                  Sequence
                          Sequence
                                  UUID16 0x110e - RemoteControl
                                  UINT16 0x0104
          Attribute 0x000d - AdditionalProtocolDescriptorLists
                  Sequence
                          Sequence
                                  Sequence
                                          UUID16 0x0100 - L2CAP
                                          UINT16 0x001b
                                  Sequence
                                          UUID16 0x0017 - AVCTP
                                          UINT16 0x0103
          Attribute 0x0311
                  UINT16 0x0003
  Sequence
          Attribute 0x0000 - ServiceRecordHandle
                  UINT32 0x00010005
          Attribute 0x0001 - ServiceClassIDList
                  Sequence
                          UUID16 0x110b - AudioSink
          Attribute 0x0004 - ProtocolDescriptorList
                  Sequence
                          Sequence
                                  UUID16 0x0100 - L2CAP
                                  UINT16 0x0019
                          Sequence
                                  UUID16 0x0019 - AVDTP
                                  UINT16 0x0103
          Attribute 0x0005 - BrowseGroupList
                  Sequence
                          UUID16 0x1002 - PublicBrowseGroup
          Attribute 0x0009 - BluetoothProfileDescriptorList
                  Sequence
                          Sequence
                                  UUID16 0x110d - AdvancedAudio
                                  UINT16 0x0103
          Attribute 0x0100
                  Data 41 64 76 61 6e 63 65 64 20 61 75 64 69 6f 20 73 65 72 76 69 63 65 00 00
          Attribute 0x0311
                  UINT16 0x0001

9.- Bluetooth discovery, pairing and configuration, after applying
    the patch. As we can see, the HSP UUID is now recognized, and the
    additional HSP HS UUID has disappeared.
    
  root@osgiliath:/var/lib/bluetooth# bluetoothctl 
  [NEW] Controller AC:FD:CE:02:8D:AB osgiliath [default]
  [bluetooth]# power on
  Changing power on succeeded
  [CHG] Controller AC:FD:CE:02:8D:AB Powered: yes
  [bluetooth]# scan on
  Discovery started
  [NEW] Device DC:2C:26:10:1F:D8 Energy BT 3
  [bluetooth]# pair DC:2C:26:10:1F:D8 
  Attempting to pair with DC:2C:26:10:1F:D8
  [CHG] Device DC:2C:26:10:1F:D8 Connected: yes
  [CHG] Device DC:2C:26:10:1F:D8 Modalias: bluetooth:v000Fp0000d0000
  [CHG] Device DC:2C:26:10:1F:D8 UUIDs:
          00001108-0000-1000-8000-00805f9b34fb
          0000110b-0000-1000-8000-00805f9b34fb
          0000110c-0000-1000-8000-00805f9b34fb
          0000110e-0000-1000-8000-00805f9b34fb
          0000111e-0000-1000-8000-00805f9b34fb
          00001200-0000-1000-8000-00805f9b34fb
  [CHG] Device DC:2C:26:10:1F:D8 Paired: yes
  Pairing successful
  [bluetooth]# scan off
  [CHG] Device DC:2C:26:10:1F:D8 RSSI is nil
  [CHG] Controller AC:FD:CE:02:8D:AB Discovering: no
  Discovery stopped
  [CHG] Device DC:2C:26:10:1F:D8 Connected: no
  [bluetooth]# info DC:2C:26:10:1F:D8 
  Device DC:2C:26:10:1F:D8
          Name: Energy BT 3
          Alias: Energy BT 3
          Class: 0x240404
          Icon: audio-card
          Paired: yes
          Trusted: no
          Blocked: no
          Connected: no
          LegacyPairing: no
          UUID: Headset                   (00001108-0000-1000-8000-00805f9b34fb)
          UUID: Audio Sink                (0000110b-0000-1000-8000-00805f9b34fb)
          UUID: A/V Remote Control Target (0000110c-0000-1000-8000-00805f9b34fb)
          UUID: A/V Remote Control        (0000110e-0000-1000-8000-00805f9b34fb)
          UUID: Handsfree                 (0000111e-0000-1000-8000-00805f9b34fb)
          UUID: PnP Information           (00001200-0000-1000-8000-00805f9b34fb)
          Modalias: bluetooth:v000Fp0000d0000
  [bluetooth]# exit
  
Iñaki Arenaza (1):
  device: Some devices send HSP UUIDs in the wrong order

 lib/uuid.h   |  1 +
 src/device.c | 17 +++++++++++++++++
 2 files changed, 18 insertions(+)

-- 
2.1.4
