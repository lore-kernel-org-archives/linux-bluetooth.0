Return-Path: <jsantos_pt@hotmail.com>
From: "João Santos" <jsantos_pt@hotmail.com>
To: marcel@holtmann.org
Cc: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] phone+heaset
Date: Mon, 26 Jan 2004 16:55:35 +0000
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <Sea2-F67d4kbAoqKLn1000424f3@hotmail.com>
List-ID: <bluez-users.lists.sourceforge.net>

Hi Marcel,

> > >ACL data: handle 0x0028 flags 0x02 dlen 21
> >     L2CAP(d): cid 0x41 len 17 [psm 1]
> >         SDP SA Req: tid 0x53 len 0xc
> >           hndl 0x804f738
> >           max 0xff
> >           aid(s) 0x0302 ((null))
> >           cont 00
> > < ACL data: handle 0x0028 flags 0x02 dlen 14
> >     L2CAP(d): cid 0x41 len 10 [psm 1]
> >         SDP SA Rsp: tid 0x53 len 0x5
> >           cnt 0x2
> >
> >           cont 00
>
>it seems that your problem is here. The SDP record must be correct
>otherwise it won't work.

Thanks for answer my last question.
could you explain me better what's the problem, i think i 'm doing it right:

[root@olivia jsantos]# sdptool browse local
Browsing FF:FF:FF:00:00:00 ...
Service Name: SDP Server
Service Description: Bluetooth service discovery server
Service Provider: BlueZ
Service RecHandle: 0x0
Service Class ID List:
  "SDP Server" (0x1000)
Protocol Descriptor List:
  "L2CAP" (0x0100)
    PSM: 1
    Version: 0x0001
Language Base Attr List:
  code_ISO639: 0x656e
  encoding:    0x6a
  base_offset: 0x100

Service Name: Public Browse Group Root
Service Description: Root of public browse hierarchy
Service Provider: BlueZ
Service RecHandle: 0x804cd30
Service Class ID List:
  "Browse Group Descriptor" (0x1001)
Language Base Attr List:
  code_ISO639: 0x656e
  encoding:    0x6a
  base_offset: 0x100

Service Name: Headset
Service RecHandle: 0x804f728
Service Class ID List:
  "Headset" (0x1108)
  "Generic Audio" (0x1203)
Protocol Descriptor List:
  "L2CAP" (0x0100)
  "RFCOMM" (0x0003)
    Channel: 12
Profile Descriptor List:
  "Headset" (0x1108)
    Version: 0x0100



[root@olivia jsantos]# sdptool search HSET
Inquiring ...
Searching for HSET on 00:60:57:15:8A:A9 ...
Service Name: Audio Gateway
Service RecHandle: 0x10002
Service Class ID List:
  "Headset Audio Gateway" (0x1112)
  "Generic Audio" (0x1203)
Protocol Descriptor List:
  "L2CAP" (0x0100)
  "RFCOMM" (0x0003)
    Channel: 12
Language Base Attr List:
  code_ISO639: 0x656e
  encoding:    0x6a
  base_offset: 0x100
Profile Descriptor List:
  "Headset" (0x1108)
    Version: 0x0100


Thanks in advance,
Regards,

João Santos

_________________________________________________________________
Find high-speed ‘net deals — comparison-shop your local providers here. 
https://broadband.msn.com
