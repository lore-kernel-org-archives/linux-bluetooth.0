Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <AANLkTinwD7W66qfpxQWJ62UPwSJjF+msYNwac90SEEu=@mail.gmail.com>
References: <AANLkTi=CufNvvAr0w2JfsG8b3ddgAsHh31pRANoW+z1r@mail.gmail.com>
	<20110125030703.GA2833@joana>
	<AANLkTinkEr1FcmZAyvS68=nU-SR8QpfYi5z=Pmqe6V-H@mail.gmail.com>
	<AANLkTinwD7W66qfpxQWJ62UPwSJjF+msYNwac90SEEu=@mail.gmail.com>
Date: Tue, 25 Jan 2011 08:54:55 -0600
Message-ID: <AANLkTimsOmtL3tKBLSXNR1b96-BiLvAYBcCQYxHomDZk@mail.gmail.com>
Subject: Re: Refusing SCO from non-connected headset
From: Mike <puffy.taco@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: "Gustavo F. Padovan" <padovan@profusion.mobi>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Mon, Jan 24, 2011 at 9:38 PM, Mike <puffy.taco@gmail.com> wrote:
> On Mon, Jan 24, 2011 at 9:07 PM, Gustavo F. Padovan
> <padovan@profusion.mobi> wrote:
>> Hi Mike,
>>
>> * Mike <puffy.taco@gmail.com> [2011-01-24 20:35:51 -0600]:
>>
>>> I get the following error when I try to dial a phone number from my
>>> cell phone and am connected using HFP:
>>>
>>> bluetoothd[14651]: audio/main.c:sco_server_cb() Refusing SCO from
>>> non-connected headset
>>
>> Please post full logs of bluetoothd -nd
>
> Log is pasted below.  One thing to note, if I comment out the section
> of audio/main.c that is the "if (device->headset) {" block (around
> line 102), then the connection goes through as a gateway.  I can then
> see SCO packets scroll by in hcidump, though pulseaudio does not seem
> to notice so I have no way of playing that audio.  The log though is
> of unaltered source.
>

Here is a log of sdptool browse on the device.  Still trying to figure
out why "device->headset" is set, because it doesn't support that
profile.  A grep through this log for 1108 only shows up under a
"Profile Descriptor List" category.

Browsing 00:17:E3:3B:4F:DD ...
Service RecHandle: 0x0
Service Class ID List:
  "SDP Server" (0x1000)
Protocol Descriptor List:
  "L2CAP" (0x0100)
  "SDP" (0x0001)
Profile Descriptor List:
  "SDP Server" (0x1000)
    Version: 0x0100

Service Name: Dialup Networking Gateway
Service Description: Dialup Networking Gateway
Service Provider: /a/mobile/system/cl.gif
Service RecHandle: 0x10001
Service Class ID List:
  "Dialup Networking" (0x1103)
Protocol Descriptor List:
  "L2CAP" (0x0100)
  "RFCOMM" (0x0003)
    Channel: 1
Language Base Attr List:
  code_ISO639: 0x656e
  encoding:    0x6a
  base_offset: 0x100
  code_ISO639: 0x6672
  encoding:    0x6a
  base_offset: 0xc800
  code_ISO639: 0x6573
  encoding:    0x6a
  base_offset: 0xc803
  code_ISO639: 0x7074
  encoding:    0x6a
  base_offset: 0xc806
Profile Descriptor List:
  "Dialup Networking" (0x1103)
    Version: 0x0100

Service Name: Voice Gateway
Service Description: Headset Audio Gateway
Service Provider: /a/mobile/system/cl.gif
Service RecHandle: 0x10003
Service Class ID List:
  "Headset Audio Gateway" (0x1112)
  "Generic Audio" (0x1203)
Protocol Descriptor List:
  "L2CAP" (0x0100)
  "RFCOMM" (0x0003)
    Channel: 3
Language Base Attr List:
  code_ISO639: 0x656e
  encoding:    0x6a
  base_offset: 0x100
  code_ISO639: 0x6672
  encoding:    0x6a
  base_offset: 0xc800
  code_ISO639: 0x6573
  encoding:    0x6a
  base_offset: 0xc803
  code_ISO639: 0x7074
  encoding:    0x6a
  base_offset: 0xc806
Profile Descriptor List:
  "Headset" (0x1108)
    Version: 0x0100

Service Name: Handsfree Voice Gateway
Service Description: Handsfree Voice Gateway
Service Provider: /a/mobile/system/cl.gif
Service RecHandle: 0x10007
Service Class ID List:
  "Handsfree Audio Gateway" (0x111f)
  "Generic Audio" (0x1203)
Protocol Descriptor List:
  "L2CAP" (0x0100)
  "RFCOMM" (0x0003)
    Channel: 7
Language Base Attr List:
  code_ISO639: 0x656e
  encoding:    0x6a
  base_offset: 0x100
  code_ISO639: 0x6672
  encoding:    0x6a
  base_offset: 0xc800
  code_ISO639: 0x6573
  encoding:    0x6a
  base_offset: 0xc803
  code_ISO639: 0x7074
  encoding:    0x6a
  base_offset: 0xc806
Profile Descriptor List:
  "Handsfree" (0x111e)
    Version: 0x0105

Service Name: OBEX Object Push
Service Description: OBEX Object Push
Service Provider: /a/mobile/system/cl.gif
Service RecHandle: 0x10008
Service Class ID List:
  "OBEX Object Push" (0x1105)
Protocol Descriptor List:
  "L2CAP" (0x0100)
  "RFCOMM" (0x0003)
    Channel: 8
  "OBEX" (0x0008)
Language Base Attr List:
  code_ISO639: 0x656e
  encoding:    0x6a
  base_offset: 0x100
  code_ISO639: 0x6672
  encoding:    0x6a
  base_offset: 0xc800
  code_ISO639: 0x6573
  encoding:    0x6a
  base_offset: 0xc803
  code_ISO639: 0x7074
  encoding:    0x6a
  base_offset: 0xc806
Profile Descriptor List:
  "OBEX Object Push" (0x1105)
    Version: 0x0100

Service Name: OBEX File Transfer
Service Description: OBEX File Transfer
Service Provider: /a/mobile/system/cl.gif
Service RecHandle: 0x10009
Service Class ID List:
  "OBEX File Transfer" (0x1106)
Protocol Descriptor List:
  "L2CAP" (0x0100)
  "RFCOMM" (0x0003)
    Channel: 9
  "OBEX" (0x0008)
Language Base Attr List:
  code_ISO639: 0x656e
  encoding:    0x6a
  base_offset: 0x100
  code_ISO639: 0x6672
  encoding:    0x6a
  base_offset: 0xc800
  code_ISO639: 0x6573
  encoding:    0x6a
  base_offset: 0xc803
  code_ISO639: 0x7074
  encoding:    0x6a
  base_offset: 0xc806
Profile Descriptor List:
  "OBEX File Transfer" (0x1106)
    Version: 0x0100

Service Name: Image Push
Service Description: Image Push
Service Provider: /a/mobile/system/cl.gif
Service RecHandle: 0x1000a
Service Class ID List:
  "Imaging Responder" (0x111b)
Protocol Descriptor List:
  "L2CAP" (0x0100)
  "RFCOMM" (0x0003)
    Channel: 10
  "OBEX" (0x0008)
Language Base Attr List:
  code_ISO639: 0x656e
  encoding:    0x6a
  base_offset: 0x100
  code_ISO639: 0x6672
  encoding:    0x6a
  base_offset: 0xc800
  code_ISO639: 0x6573
  encoding:    0x6a
  base_offset: 0xc803
  code_ISO639: 0x7074
  encoding:    0x6a
  base_offset: 0xc806
Profile Descriptor List:
  "Imaging" (0x111a)
    Version: 0x0100

Service Name: Audio Source
Service Description: Audio Source
Service Provider: /a/mobile/system/cl.gif
Service RecHandle: 0x1000d
Service Class ID List:
  "Audio Source" (0x110a)
Protocol Descriptor List:
  "L2CAP" (0x0100)
    PSM: 25
  "AVDTP" (0x0019)
    uint16: 0x100
Language Base Attr List:
  code_ISO639: 0x656e
  encoding:    0x6a
  base_offset: 0x100
  code_ISO639: 0x6672
  encoding:    0x6a
  base_offset: 0xc800
  code_ISO639: 0x6573
  encoding:    0x6a
  base_offset: 0xc803
  code_ISO639: 0x7074
  encoding:    0x6a
  base_offset: 0xc806
Profile Descriptor List:
  "Advanced Audio" (0x110d)
    Version: 0x0100

Service Name: Audio Video Remote Control Target
Service Description: Audio Video Remote Control Target
Service Provider: /a/mobile/system/cl.gif
Service RecHandle: 0x1000e
Service Class ID List:
  "AV Remote Target" (0x110c)
Protocol Descriptor List:
  "L2CAP" (0x0100)
    PSM: 23
  "AVCTP" (0x0017)
    uint16: 0x100
Language Base Attr List:
  code_ISO639: 0x656e
  encoding:    0x6a
  base_offset: 0x100
  code_ISO639: 0x6672
  encoding:    0x6a
  base_offset: 0xc800
  code_ISO639: 0x6573
  encoding:    0x6a
  base_offset: 0xc803
  code_ISO639: 0x7074
  encoding:    0x6a
  base_offset: 0xc806
Profile Descriptor List:
  "AV Remote Target" (0x110c)
    Version: 0x0100

Service Name: SyncML Data Synchronization
Service Description: SyncML Data Synchronization
Service Provider: /a/mobile/system/cl.gif
Service RecHandle: 0x10010
Service Class ID List:
  UUID 128: 00000002-0000-1000-8000-0002ee000002
Protocol Descriptor List:
  "L2CAP" (0x0100)
  "RFCOMM" (0x0003)
    Channel: 12
  "OBEX" (0x0008)
Language Base Attr List:
  code_ISO639: 0x656e
  encoding:    0x6a
  base_offset: 0x100
  code_ISO639: 0x6672
  encoding:    0x6a
  base_offset: 0xc800
  code_ISO639: 0x6573
  encoding:    0x6a
  base_offset: 0xc803
  code_ISO639: 0x7074
  encoding:    0x6a
  base_offset: 0xc806
