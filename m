Return-Path: <d_gujarathi@hotmail.com>
From: "Deepesh S Gujarathi" <d_gujarathi@hotmail.com>
To: "Marcel Holtmann" <marcel@holtmann.org>
Cc: "BlueZ Mailing List" <bluez-devel@lists.sourceforge.net>
References: <Law11-OE56C4Mkg3fDM00007728@hotmail.com> <1071150458.27256.16.camel@pegasus>
Subject: Re: [Bluez-devel] HID testing
Date: Fri, 12 Dec 2003 17:18:13 +0530
MIME-Version: 1.0
Content-Type: text/plain;
	charset="Windows-1252"
Message-ID: <Law11-OE38c8X3gjv5O000087de@hotmail.com>
List-ID: <bluez-devel.lists.sourceforge.net>

Hi Marcel,

thanks for the detailed reply

> What kind of Bluetooth chip do you use?

I am using the Ericsson Bluetooth module on a custom made eval board...

> Please use "sdptest" from libs2/test CVS to show us the SDP record of
> your HID device.
currently I donot have the sdptest program, but I have pasted below the
output
from the sdptool, dunno whether it would be of any help.

------------------------------------------------------
Searching for HID on 00:50:F2:E5:89:15 ...
 ID------------> 0
Attribute Identifier : 0x0 - ServiceRecordHandle
  Integer : 0x10000
 ID------------> 1
Attribute Identifier : 0x1 - ServiceClassIDList
  Data Sequence
    UUID16 : 0x1124
 ID------------> 4
Attribute Identifier : 0x4 - ProtocolDescriptorList
  Data Sequence
    Data Sequence
      UUID16 : 0x0100 - L2CAP
      Channel/Port (Integer) : 0x11
    Data Sequence
      UUID16 : 0x0011 - HIDP
 ID------------> 6
Attribute Identifier : 0x6 - LanguageBaseAttributeIDList
  Data Sequence
    Integer : 0x656e
    Integer : 0x6a
    Integer : 0x100
 ID------------> 9
Attribute Identifier : 0x9 - BluetoothProfileDescriptorList
  Data Sequence
    Data Sequence
      UUID16 : 0x1124
      Version (Integer) : 0x100
 ID------------> d
Attribute Identifier : 0xd - AdditionalProtocolDescriptorLists
  Data Sequence
    Data Sequence
      Data Sequence
        UUID16 : 0x0100 - L2CAP
        Integer : 0x13
      Data Sequence
        UUID16 : 0x0011 - HIDP
Attribute Identifier : 0x100
Text as STring:----------> 0xAVALENT MOUSE
Attribute Identifier : 0x101
Text as STring:----------> 0xTHREE BUTTON MOUSE
Attribute Identifier : 0x102
Text as STring:----------> 0xAVALENT
Attribute Identifier : 0x200
  Integer : 0x100
 ID------------> 201
Attribute Identifier : 0x201 - HIDProfileVersion
  Integer : 0x111
 ID------------> 202
Attribute Identifier : 0x202 - HIDDeviceSubClass
  Integer : 0x80
 ID------------> 203
Attribute Identifier : 0x203 - HIDCountryCode
  Integer : 0x33
 ID------------> 204
Attribute Identifier : 0x204 - HIDVirtualCable
  Integer : 0x1
 ID------------> 205
Attribute Identifier : 0x205 - HIDReconnectInitiate
  Integer : 0x1
 ID------------> 206
Attribute Identifier : 0x206 - HIDDescriptorList
  Data Sequence
    Data Sequence
      Integer : 0x22
Attribute Identifier : 0x207
 Data Sequence
  Data Sequence
      Integer : 0x409
      Integer : 0x100
ID------------> 208
Attribute Identifier : 0x208 - HIDSDPDisable
  Integer : 0x0
 ID------------> 209
Attribute Identifier : 0x209 - HIDBatteryPower
  Integer : 0x1
 ID------------> 20a
Attribute Identifier : 0x20a - HIDRemoteWake
  Integer : 0x1
 ID------------> 20b
Attribute Identifier : 0x20b - HIDParserVersion
  Integer : 0x100
 ID------------> 20e
Attribute Identifier : 0x20e - HIDBootDevice
  Integer : 0x1
------------------------------------------------------

I will post the results of sdptest soon

thanks
Saturn
