Return-Path: <giochi@telvia.it>
Message-ID: <1971820044523102014464@telvia.it>
From: giochi@telvia.it
To: marcel@holtmann.org
Cc: bluez-users@lists.sourceforge.net
Subject: Re: Re: [Bluez-users] rfcomm problem
Date: Fri, 23 Apr 2004 12:20:14 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
List-ID: <bluez-users.lists.sourceforge.net>

Hi Marcel  and thanks for your reply.
Now I'm not at home and I can't try 
hcitool info 00:0A:28:B1:9C:6E I'll send to yoou this night.

rfcomm that I use is the right one: it comes from bluez-utils...

Regards,
Fabrizio




----- Original Message -----
From: Marcel Holtmann <marcel@holtmann.org>
Sent: Friday, April 23, 2004 7:15:39 AM
To: giochi <giochi@telvia.it>
Subject: Re: [Bluez-users] rfcomm problem

> Hi,
> 
> > Alls work fine till the rfcomm initialization:
> > 
> > root@bizio:~# rfcomm bind 0 00:0A:28:B1:9C:6E 8
> > Wrong number of parameters.
> > root@bizio:~# rfcomm bind 0 00:0A:28:B1:9C:6E 9
> > Wrong number of parameters.
> > root@bizio:~# rfcomm bind 0                    
> > Device USSP not registered: No such device
> 
> you used the wrong rfcomm utility. Don't install my old rfcomm code. You
> only have to install bluez-utils and everything will be in place.
> 
> > root@bizio:~# hcitool inq
> > Inquiring ...
> >         00:0A:28:B1:9C:6E       clock offset: 0x3ea0    class: 0x000100
> > root@bizio:~# hcitool scann
> > Scanning ...
> >         00:0A:28:B1:9C:6E       Motorola Phone
> 
> Please do a "hcitool info 00:0A:28:B1:9C:6E" (as root) for me so I can
> add your Motorola mobile phone to my hardware list.
> 
> > root@bizio:~# sdptool browse 00:0A:28:B1:9C:6E
> > Browsing 00:0A:28:B1:9C:6E ...
> > Service RecHandle: 0x0
> > Service Class ID List:
> >   "SDP Server" (0x1000)
> > Protocol Descriptor List:
> >   "L2CAP" (0x0100)
> >   "SDP" (0x0001)
> > Profile Descriptor List:
> >   "" (0x1000)
> >     Version: 0x0100
> > 
> > ...
> > Service Name: OBEX Object Push
> > Service Description: OBEX Object Push
> > Service Provider: Motorola
> > Service RecHandle: 0x10008
> > Service Class ID List:
> >   "OBEX Object Push" (0x1105)
> > Protocol Descriptor List:
> >   "L2CAP" (0x0100)
> >   "RFCOMM" (0x0003)
> >     Channel: 8
> >   "OBEX" (0x0008)
> > Language Base Attr List:
> >   code_ISO639: 0x656e
> >   encoding:    0x6a
> >   base_offset: 0x100
> >   code_ISO639: 0x6672
> >   encoding:    0x6a
> >   base_offset: 0xd800
> >   code_ISO639: 0x6465
> >   encoding:    0x6a
> >   base_offset: 0xd803
> >   code_ISO639: 0x6974
> >   encoding:    0x6a
> >   base_offset: 0xd806
> >   code_ISO639: 0x6573
> >   encoding:    0x6a
> >   base_offset: 0xd809
> >   code_ISO639: 0x6e6c
> >   encoding:    0x6a
> >   base_offset: 0xd80c
> >   code_ISO639: 0x7472
> >   encoding:    0x6a
> >   base_offset: 0xd80f
> >   code_ISO639: 0x7074Profile Descriptor List:
> >   "OBEX Object Push" (0x1105)
> >     Version: 0x0100
> > 
> > Service Name: OBEX file transfer
> > Service Description: OBEX file transfer
> > Service Provider: Motorola
> > Service RecHandle: 0x10009
> > Service Class ID List:
> >   "OBEX File Transfer" (0x1106)
> > Protocol Descriptor List:
> >   "L2CAP" (0x0100)
> >   "RFCOMM" (0x0003)
> >     Channel: 9
> >   "OBEX" (0x0008)
> > Language Base Attr List:
> >   code_ISO639: 0x656e
> >   encoding:    0x6a
> >   base_offset: 0x100
> >   code_ISO639: 0x6672
> >   encoding:    0x6a
> >   base_offset: 0xd800
> >   code_ISO639: 0x6465
> >   encoding:    0x6a
> >   base_offset: 0xd803
> >   code_ISO639: 0x6974
> >   encoding:    0x6a
> >   base_offset: 0xd806
> >   code_ISO639: 0x6573
> >   encoding:    0x6a
> >   base_offset: 0xd809
> >   code_ISO639: 0x6e6c
> >   encoding:    0x6a
> >   base_offset: 0xd80c
> >   code_ISO639: 0x7472
> >   encoding:    0x6a
> >   base_offset: 0xd812
> >   encoding:    0x6a
> >   base_offset: 0xd80f
> >   code_ISO639: 0x7074
> >   encoding:    0x6a
> >   base_offset: 0xd812
> > Profile Descriptor List:
> >   "OBEX File Transfer" (0x1106)
> >     Version: 0x0100
> > 
> > So, as appears 8 and 9 channels are designed for OBEX.
> > When I found these channels I type:
> > sdptool add --channel=9 OPUSH
> > sdptool add --channel=8 OPUSH
> 
> This is not needed unless you wan't to receive OBEX connection from your
> phone. And in that case you also have to run somekind of OBEX push or
> file transfer daemon.
> 
> Regards
> 
> Marcel
> 
> 
> 
> 
> -------------------------------------------------------
> This SF.net email is sponsored by: The Robotic Monkeys at ThinkGeek
> For a limited time only, get FREE Ground shipping on all orders of $35
> or more. Hurry up and shop folks, this offer expires April 30th!
> http://www.thinkgeek.com/freeshipping/?cpg=12297
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users
