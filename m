Return-Path: <S9702510@student.rmit.edu.au>
Subject: Re: Re: [Bluez-users] nokia 7610 and LAN access
Reply-To: s9702510@student.rmit.edu.au
From: "Sean Turnbull" <S9702510@student.rmit.edu.au>
To: bluez-users@lists.sourceforge.net
CC: marcel@holtmann.org
Date: Thu, 07 Apr 2005 21:40:47 +1000
MIME-Version: 1.0
Message-ID: <1112874047.6722a81cS9702510@student.rmit.edu.au>
Content-Type: text/plain; charset="ISO-8859-1"
List-ID: <bluez-users.lists.sourceforge.net>

-----Original Message-----
From: Sean Turnbull <sean@sean-turnbull.ph.rmit.edu.au>
To: Sean Turnbull <s9702510@student.rmit.edu.au>
Date: Thu, 7 Apr 2005 21:38:06 +1000 (EST)
Subject: Re: [Bluez-users] nokia 7610 and LAN access (fwd)

Hi Sean,

> I used to use a nokia 3650 and was able to connect my uni LAN through the=
 phone using serial profile and mrouter (ppp). Since the 7610 doesn't hav=
e that, and only the DUN profile, does anyone have an idea if it can be d=
one?

check with sdptool what services the 7610 offers.

Regards

Marcel


Services included are:
Service Name: Hands-Free Audio Gateway
Service RecHandle: 0x1002a
Service Class ID List:
  "Handfree Audio Gateway" (0x111f)
  "Generic Audio" (0x1203)
Protocol Descriptor List:
  "L2CAP" (0x0100)
  "RFCOMM" (0x0003)
    Channel: 1
Language Base Attr List:
  code_ISO639: 0x454e
  encoding:    0x6a
  base_offset: 0x100
Profile Descriptor List:
  "Handfree Audio Gateway" (0x111f)
    Version: 0x0101

Service Name: OBEX File Transfer
Service RecHandle: 0x1002b
Service Class ID List:
  "OBEX File Transfer" (0x1106)
Protocol Descriptor List:
  "L2CAP" (0x0100)
  "RFCOMM" (0x0003)
    Channel: 10
  "OBEX" (0x0008)
Language Base Attr List:
  code_ISO639: 0x454e
  encoding:    0x6a
  base_offset: 0x100
Profile Descriptor List:
  "OBEX File Transfer" (0x1106)
    Version: 0x0100

Service Name: SyncMLClient
Service RecHandle: 0x1002c
Service Class ID List:
  "Error: This is UUID-128" (0x00000002-0000-1000-8000-0002ee000002)
Protocol Descriptor List:
  "L2CAP" (0x0100)
  "RFCOMM" (0x0003)
    Channel: 11
  "OBEX" (0x0008)
Language Base Attr List:
  code_ISO639: 0x454e
  encoding:    0x6a
  base_offset: 0x100
Profile Descriptor List:
  "Error: This is UUID-128" (0x00000002-0000-1000-8000-0002ee000002)
    Version: 0x0100

Service Name: Nokia OBEX PC Suite Services
Service RecHandle: 0x1002d
Service Class ID List:
  "Error: This is UUID-128" (0x00005005-0000-1000-8000-0002ee000001)
Protocol Descriptor List:
  "L2CAP" (0x0100)
  "RFCOMM" (0x0003)
    Channel: 12
  "OBEX" (0x0008)
Language Base Attr List:
  code_ISO639: 0x454e
  encoding:    0x6a
  base_offset: 0x100
Profile Descriptor List:
  "Error: This is UUID-128" (0x00005005-0000-1000-8000-0002ee000001)
    Version: 0x0100

Service Name: OBEX Object Push
Service RecHandle: 0x1002e
Service Class ID List:
  "OBEX Object Push" (0x1105)
Protocol Descriptor List:
  "L2CAP" (0x0100)
  "RFCOMM" (0x0003)
    Channel: 9
  "OBEX" (0x0008)
Language Base Attr List:
  code_ISO639: 0x454e
  encoding:    0x6a
  base_offset: 0x100
Profile Descriptor List:
  "OBEX Object Push" (0x1105)
    Version: 0x0100

Service Name: Dial-Up Networking
Service RecHandle: 0x1002f
Service Class ID List:
  "Dialup Networking" (0x1103)
Protocol Descriptor List:
  "L2CAP" (0x0100)
  "RFCOMM" (0x0003)
    Channel: 13
Language Base Attr List:
  code_ISO639: 0x454e
  encoding:    0x6a
  base_offset: 0x100
Profile Descriptor List:
  "Dialup Networking" (0x1103)
    Version: 0x0100


sean
