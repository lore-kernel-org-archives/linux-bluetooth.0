Return-Path: <jsun@docomolabs-usa.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: RE: [Bluez-devel] bluetooth services and profiles
Date: Tue, 26 Oct 2004 15:20:50 -0700
Message-ID: <7FB17951357F434FA9C14522522BA59B447F63@dcl-ex.dcml.docomolabs-usa.com>
From: "Jun Sun" <jsun@docomolabs-usa.com>
To: "Marcel Holtmann" <marcel@holtmann.org>
Cc: "BlueZ Mailing List" <bluez-devel@lists.sourceforge.net>
List-ID: <bluez-devel.lists.sourceforge.net>

Thanks for the explanation on profiles.  It helps quite a bit.

Do you know how we can supply those phone services with bluez?

For example, the web page http://mobile.linux.pt/p800/ listed the
following services for P800:

earth:~# sdptool browse 00:0A:D9:17:7F:51
Browsing 00:0A:D9:17:7F:51 ...
Service Name: Voice gateway
Service Description: Voice gateway
Service Provider: Sony Ericsson
Service RecHandle: 0x10000
Service Class ID List:
  "Headset Audio Gateway" (0x1112)
  "Generic Audio" (0x1203)
Protocol Descriptor List:
  "L2CAP" (0x0100)
  "RFCOMM" (0x0003)
    Channel: 8
Language Base Attr List:
  code_ISO639: 0x656e
  encoding:    0x6a
  base_offset: 0x100
Profile Descriptor List:
  "Headset" (0x1108)
    Version: 0x0100

Service Name: Dial-up Networking
Service Description: Dial-up Networking
Service Provider: Sony Ericsson
Service RecHandle: 0x10002
Service Class ID List:
  "Dialup Networking" (0x1103)
Protocol Descriptor List:
  "L2CAP" (0x0100)
  "RFCOMM" (0x0003)
    Channel: 2
Language Base Attr List:
  code_ISO639: 0x656e
  encoding:    0x6a
  base_offset: 0x100
Profile Descriptor List:
  "Dialup Networking" (0x1103)
    Version: 0x0100

Service Name: OBEX Object Push
Service RecHandle: 0x10003
Service Class ID List:
  "OBEX Object Push" (0x1105)
Protocol Descriptor List:
  "L2CAP" (0x0100)
  "RFCOMM" (0x0003)
    Channel: 3
  "OBEX" (0x0008)
Profile Descriptor List:
  "OBEX Object Push" (0x1105)
    Version: 0x0100

Service Name: Bluetooth Serial Port
Service Description: Bluetooth Serial Port
Service Provider: Symbian Ltd.
Service RecHandle: 0x10005
Service Class ID List:
  "Serial Port" (0x1101)
Protocol Descriptor List:
  "L2CAP" (0x0100)
  "RFCOMM" (0x0003)
    Channel: 1
Language Base Attr List:
  code_ISO639: 0x656e
  encoding:    0x6a
  base_offset: 0x100


Which part of bluetooth spec covers such service discovery?  Can I
implement similar services on top of bluez stack?  (Imagine the scenario
if I put Linux/bluez into a phone ...)

Any pointers are appreciated.  Thanks in advance.

Jun
=20



> -----Original Message-----
> From: Marcel Holtmann [mailto:marcel@holtmann.org]
> Sent: Tuesday, October 26, 2004 2:37 PM
> To: Jun Sun
> Cc: BlueZ Mailing List
> Subject: Re: [Bluez-devel] bluetooth services and profiles
>=20
> Hi Jun,
>=20
> > I saw a lot of web pages about setting up a linux box talking with a
> > Bluetooth phone.  Typically you would discover a lot of services
offered
> > by the phone.
> >
> > I am wondering what happens if you hook linux box with a second
linux
> > box.  In other words what kind of services will you find on the
Linux
> > box?  What has to be done to support those similar services on
bluez?
> >
> > Are they related to the Bluetooth profiles?  I have not seen much
about
> > Bluetooth profile support in bluez.  Do they exist?
>=20
> a Bluetooth profile is like an application. If you wanna have support
> for a specific profile in BlueZ, you need to write that application.
> However for most common Bluetooth profiles these applications exists
and
> you only have to start them.
>=20
> If you think that you always need to follow a specific profile for
data
> exchange between two Bluetooth devices, then you are wrong. BlueZ
gives
> you the power to do everything you like with Bluetooth.
>=20
> > The reason I am asking this is because there are now phones powered
by
> > Linux.  I think they support Bluetooth but I don't know if they are
> > using bluez.  I like to get an understanding on how to provide those
> > Bluetooth phone services on Linux with bluez.
>=20
> I don't know either. Maybe yes, maybe no. But as mentioned above a
> profile is the same as an application.
>=20
> Regards
>=20
> Marcel
>=20
>=20
