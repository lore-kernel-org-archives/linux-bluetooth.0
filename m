Return-Path: <cyrus@holtmann.org>
From: John Frankish <j-frankish@slb.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
CC: Mikel Astiz <mikel.astiz.oss@gmail.com>
Subject: RE: FW: Can no longer connect to audio stream with bluez > 0.96 and
 pulseaudio-2
Date: Sat, 21 Jul 2012 08:05:02 +0000
Message-ID: <654DF80AD31A344E93DBCC6280BD6DEF8598D3CB@NL0230MBX08N1.DIR.slb.com>
References: <654DF80AD31A344E93DBCC6280BD6DEF8598D39E@NL0230MBX08N1.DIR.slb.com>
 <CANT-zCUvCc9EY6_MdjWg4qLUR90vzggPqER4=4vNBLoKzVsrQA@mail.gmail.com>
In-Reply-To: <CANT-zCUvCc9EY6_MdjWg4qLUR90vzggPqER4=4vNBLoKzVsrQA@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

> -----Original Message-----
> From: Mikel Astiz [mailto:mikel.astiz.oss@gmail.com]
> Sent: Saturday, 21 July, 2012 11:15
> To: John Frankish
> Cc: linux-bluetooth@vger.kernel.org
> Subject: Re: FW: Can no longer connect to audio stream with bluez > 0.96 and
> pulseaudio-2
> 
> Hi John,
> 
> On Sat, Jul 21, 2012 at 8:57 AM, John Frankish <j-frankish@slb.com> wrote:
> > Forgot bluetoothd output - added below
> >
> > -----Original Message-----
> > From: John Frankish
> > Sent: Friday, 20 July, 2012 21:19
> > To: linux-bluetooth@vger.kernel.org
> > Subject: Can no longer connect to audio stream with bluez > 0.96 and
> > pulseaudio-2
> >
> > Using bluez-0.96 and pulseaudio-1.xx I could use bluetooth headphones
> without problems using blueman-1.23 to connect to an a2dp sink.
> >
> > With bluez-0.99/0.101 and pulseaudio-2 I can no longer connect and
> blueman gives the following error:
> >
> > Stream setup failed
> >
> > I see that bluez has moved to the MediaEndpoint format and that I need a
> /usr/local/etc/bluetooth/audio.conf for the first time, but things still don't
> work (details below), there are no error messages to speak of, am I doing
> something wrong?
> 
> I can't tell for sure but I can reproduce similar problem with a2dp sources. I
> actually fails with some devices only, so chances are that it's due to some
> race condition.
> 
> This seems to be a regression introduced recently, which I didn't have time to
> check further.
> 
> In any case, could you provide us with the audio.conf you're using?
----------------
Here's the latest attempt at an audio.conf, which BTW, "make install" does not copy to the file system, despite "--enable-datafiles"

[General]
Enable=Source,Sink,Headset,Gateway,Control,Media

Master=true

AutoConnect=true

[Headset]
HFP=true

MaxConnected=1

FastConnectable=false

----
Note that I'm using the latest mac mini server, which seems to have an odd BT setup:

$ lsusb -vv
Bus 001 Device 003: ID 0a5c:4500 Broadcom Corp. BCM2046B1 USB 2.0 Hub (part of BCM2046 Bluetooth)
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               2.00
  bDeviceClass            9 Hub
  bDeviceSubClass         0 Unused
  bDeviceProtocol         0 Full speed (or root) hub
  bMaxPacketSize0         8
  idVendor           0x0a5c Broadcom Corp.
  idProduct          0x4500 BCM2046B1 USB 2.0 Hub (part of BCM2046 Bluetooth)
  bcdDevice            1.00
  iManufacturer           1 Apple Inc.
  iProduct                2 BRCM20702 Hub


Bus 001 Device 008: ID 05ac:8281 Apple, Inc. 
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               2.00
  bDeviceClass          255 Vendor Specific Class
  bDeviceSubClass         1 
  bDeviceProtocol         1 
  bMaxPacketSize0        64
  idVendor           0x05ac Apple, Inc.
  idProduct          0x8281 
  bcdDevice            0.38
  iManufacturer           1 Apple Inc.
  iProduct                2 Bluetooth USB Host Controller
