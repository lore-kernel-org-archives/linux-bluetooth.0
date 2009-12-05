Return-Path: <cyrus@holtmann.org>
Subject: Re: Wiimote pairing?
From: Bastien Nocera <hadess@hadess.net>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
In-Reply-To: <1260024658.3041.14.camel@violet>
References: <1260021437.3311.1899.camel@localhost.localdomain>
	 <1260024658.3041.14.camel@violet>
Content-Type: text/plain; charset="ISO-8859-1"
Date: Sat, 05 Dec 2009 15:02:23 +0000
Message-ID: <1260025343.3311.1907.camel@localhost.localdomain>
Mime-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>

On Sat, 2009-12-05 at 15:50 +0100, Marcel Holtmann wrote:
> Hi Bastien,
> 
> > I was under the impression that the Wiimote simply didn't use a PIN
> > code, but it seems there's a way to pair it and associate it with a
> > particular host by doing:
> > http://wiibrew.org/wiki/Wiimote#Sync_Button
> > 
> > I looked through my dongles, and couldn't find one that would allow me
> > to pass the modified host address as a PIN code as they all have "00" as
> > part of the address.
> > 
> > bluetoothd uses strings everywhere for PIN code handling. It would be
> > possible to change the RequestPinCode to also allow:
> > {string,len} RequestPinCode(object device)
> > without modifying the current behaviour.
> 
> that is no really how D-Bus would handle strings. From a D-Bus point of
> view, the only way would be using a Byte array.

Yeah, true. so:
ByteArray RequestPinCode(object device)
(in addition to the current one)

I would think it should be pretty easy to fix by passing the length
along with the pin "char *" internally.

> Potentially we could allow implementing a passkey agent as a plugin and
> then you could implement special handling via a plugin. Problem then
> again is how to identify that it is a Wiimote. Or did they actually
> added a PnP SDP record to it. It has been so long that I hacked on these
> devices.

This is the output of sdptool browse on a Wiimote (though I'd rather
have the work-arounds in the front-end):

Browsing 00:1F:C5:5E:B4:EB ...
Service RecHandle: 0x0
Service Class ID List:
  "SDP Server" (0x1000)
Protocol Descriptor List:
  "L2CAP" (0x0100)
    PSM: 1
  "SDP" (0x0001)
Language Base Attr List:
  code_ISO639: 0x656e
  encoding:    0x6a
  base_offset: 0x100
Profile Descriptor List:
  "" (0x0100)
    Version: 0x0100

Service Name: Nintendo RVL-CNT-01
Service Description: Nintendo RVL-CNT-01
Service Provider: Nintendo
Service RecHandle: 0x10000
Service Class ID List:
  "Human Interface Device" (0x1124)
Protocol Descriptor List:
  "L2CAP" (0x0100)
    PSM: 17
  "HIDP" (0x0011)
Language Base Attr List:
  code_ISO639: 0x656e
  encoding:    0x6a
  base_offset: 0x100
Profile Descriptor List:
  "Human Interface Device" (0x1124)
    Version: 0x0100

Service RecHandle: 0x10001
Service Class ID List:
  "PnP Information" (0x1200)
Protocol Descriptor List:
  "L2CAP" (0x0100)
    PSM: 1
  "SDP" (0x0001)
Profile Descriptor List:
  "PnP Information" (0x1200)
    Version: 0x0100

Cheers
