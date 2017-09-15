Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: "O'Connor, Daniel" <darius@dons.net.au>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Date: Fri, 15 Sep 2017 14:55:48 +0930
Subject: Playstation 4 Media Remote
Message-Id: <C9C62981-6AFE-42D0-9112-B7CA8F9D92D1@dons.net.au>
To: linux-bluetooth@vger.kernel.org
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,
I am attempting to get a PS4 media remote (made by PDP: http://pdp.com/en/universal-media-remote-for-ps4) working under Linux (Kodi to be specific).

It does connect OK but it only shows a limited subset of controls, ie..
Input driver version is 1.0.1
Input device ID: bus 0x5 vendor 0xa12 product 0x16 version 0x1
Input device name: "PDP Universal Remote"
Supported events:
  Event type 0 (EV_SYN)
  Event type 1 (EV_KEY)
    Event code 304 (BTN_A)
    Event code 305 (BTN_B)
    Event code 306 (BTN_C)
    Event code 307 (BTN_X)
    Event code 308 (BTN_Y)
    Event code 309 (BTN_Z)
    Event code 310 (BTN_TL)
    Event code 311 (BTN_TR)
    Event code 312 (BTN_TL2)
    Event code 313 (BTN_TR2)
    Event code 314 (BTN_SELECT)
    Event code 315 (BTN_START)
    Event code 316 (BTN_MODE)
    Event code 317 (BTN_THUMBL)
  Event type 3 (EV_ABS)
    Event code 16 (ABS_HAT0X)
      Value      0
      Min       -1
      Max        1
    Event code 17 (ABS_HAT0Y)
      Value      0
      Min       -1
      Max        1
  Event type 4 (EV_MSC)
    Event code 4 (MSC_SCAN)

Thos buttons do work but actually useful stuff like 'enter', play/pause, etc seem to do nothing.

I had a look at hid_sony.c and it does seem to do some mangling for the PS3 remote and I wonder if something similar is needed here - does anyone have a clue?

The sdptool --records output is as follows...
[mediapc 21:43] ~ >sdptool records --tree 3e:09:ec:6f:c2:0a
Attribute Identifier : 0x0 - ServiceRecordHandle
  Integer : 0x10000
Attribute Identifier : 0x1 - ServiceClassIDList
  Data Sequence
    UUID16 : 0x1124 - HumanInterfaceDeviceService (HID)
Attribute Identifier : 0x4 - ProtocolDescriptorList
  Data Sequence
    Data Sequence
      UUID16 : 0x0100 - L2CAP
      Channel/Port (Integer) : 0x11
    Data Sequence
      UUID16 : 0x0011 - HIDP
Attribute Identifier : 0x5 - BrowseGroupList
  Data Sequence
    UUID16 : 0x1002 - PublicBrowseGroup
Attribute Identifier : 0x6 - LanguageBaseAttributeIDList
  Data Sequence
    Code ISO639 (Integer) : 0x656e
    Encoding (Integer) : 0x6a
    Base Offset (Integer) : 0x100
Attribute Identifier : 0x9 - BluetoothProfileDescriptorList
  Data Sequence
    Data Sequence
      UUID16 : 0x1124 - HumanInterfaceDeviceService (HID)
      Version (Integer) : 0x100
Attribute Identifier : 0xd - AdditionalProtocolDescriptorLists
  Data Sequence
    Data Sequence
      Data Sequence
        UUID16 : 0x0100 - L2CAP
        Integer : 0x13
      Data Sequence
        UUID16 : 0x0011 - HIDP
Attribute Identifier : 0x100
  Data : 50 44 50 20 55 6e 69 76 65 72 73 61 6c 20 4d 65 64 69 61 20 52 65 6d 6f 74 65 00
Attribute Identifier : 0x101
  Data : 50 44 50 20 55 6e 69 76 65 72 73 61 6c 20 4d 65 64 69 61 20 52 65 6d 6f 74 65 00
Attribute Identifier : 0x102
  Data : 50 44 50 00
Attribute Identifier : 0x200 - DeviceReleaseNum
  Integer : 0x1
Attribute Identifier : 0x201 - ParserVersion
  Integer : 0x111
Attribute Identifier : 0x202 - DeviceSubclass
  Integer : 0xc
Attribute Identifier : 0x203 - CountryCode
  Integer : 0x21
Attribute Identifier : 0x204 - VirtualCable
  Integer : 0x1
Attribute Identifier : 0x205 - ReconnectInitiate
  Integer : 0x1
Attribute Identifier : 0x206 - DescriptorList
  Data Sequence
    Data Sequence
      Integer : 0x22
      Data : 05 01 09 05 a1 01 85 01 09 39 15 00 25 07 35 00 46 3b 01 65 14 75 04 95 01 81 42 65 00 05 09 19 01 29 0e 15 00 25 01 75 01 95 0e 81 02 06 00 ff 09 20 75 06 95 01 81 02 06 00 ff 09 21 75 08 95 06 81 02 85 03 0a 83 a7 95 09 b1 02 c0 06 f0 ff 09 40 a1 01 85 f0 09 47 95 3f b1 02 85 f1 09 48 95 3f b1 02 85 f2 09 49 95 0f b1 02 85 f3 0a 01 47 95 07 b1 02 c0 00
Attribute Identifier : 0x207 - LangIDBaseList
  Data Sequence
    Data Sequence
      Integer : 0x409
      Integer : 0x100
Attribute Identifier : 0x209 - BatteryPower
  Integer : 0x1
Attribute Identifier : 0x20b - ProfileVersion
  Integer : 0x100
Attribute Identifier : 0x20d - NormallyConnectable
  Integer : 0x0
Attribute Identifier : 0x20e - BootDevice
  Integer : 0x0

Attribute Identifier : 0x0 - ServiceRecordHandle
  Integer : 0x10001
Attribute Identifier : 0x1 - ServiceClassIDList
  Data Sequence
    UUID16 : 0x1200 - PnPInformation
Attribute Identifier : 0x4 - ProtocolDescriptorList
  Data Sequence
    Data Sequence
      UUID16 : 0x0100 - L2CAP
      Channel/Port (Integer) : 0x1
    Data Sequence
      UUID16 : 0x0001 - SDP
Attribute Identifier : 0x6 - LanguageBaseAttributeIDList
  Data Sequence
    Code ISO639 (Integer) : 0x656e
    Encoding (Integer) : 0x6a
    Base Offset (Integer) : 0x100
Attribute Identifier : 0x9 - BluetoothProfileDescriptorList
  Data Sequence
    Data Sequence
      UUID16 : 0x1200 - PnPInformation
      Version (Integer) : 0x100
Attribute Identifier : 0x101
  Data : 48 49 44 5f 47 61 6d 65 70 61 64 00
Attribute Identifier : 0x200 - SpecificationID
  Integer : 0x103
Attribute Identifier : 0x201 - VendorID
  Integer : 0xa12
Attribute Identifier : 0x202 - ProductID
  Integer : 0x16
Attribute Identifier : 0x203 - Version
  Integer : 0x1
Attribute Identifier : 0x204 - PrimaryRecord
  Integer : 0x1
Attribute Identifier : 0x205 - VendorIDSource
  Integer : 0x2

(if it helps :)

Any help appreciated (including a better place to post this!)

Thanks.

--
Daniel O'Connor
"The nice thing about standards is that there
are so many of them to choose from."
 -- Andrew Tanenbaum
GPG Fingerprint - 5596 B766 97C0 0E94 4347 295E E593 DC20 7B3F CE8C

