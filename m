Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] phone+heaset
From: Marcel Holtmann <marcel@holtmann.org>
To: =?ISO-8859-1?Q?Jo=E3o?= Santos <jsantos_pt@hotmail.com>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <Sea2-F67d4kbAoqKLn1000424f3@hotmail.com>
References: <Sea2-F67d4kbAoqKLn1000424f3@hotmail.com>
Content-Type: text/plain
Message-Id: <1075136664.25442.90.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Mon, 26 Jan 2004 18:04:24 +0100

Hi Joao,

> > > >ACL data: handle 0x0028 flags 0x02 dlen 21
> > >     L2CAP(d): cid 0x41 len 17 [psm 1]
> > >         SDP SA Req: tid 0x53 len 0xc
> > >           hndl 0x804f738
> > >           max 0xff
> > >           aid(s) 0x0302 ((null))
> > >           cont 00
> > > < ACL data: handle 0x0028 flags 0x02 dlen 14
> > >     L2CAP(d): cid 0x41 len 10 [psm 1]
> > >         SDP SA Rsp: tid 0x53 len 0x5
> > >           cnt 0x2
> > >
> > >           cont 00
> >
> >it seems that your problem is here. The SDP record must be correct
> >otherwise it won't work.
> 
> Thanks for answer my last question.
> could you explain me better what's the problem, i think i 'm doing it right:

it requests the attribute 0x0302 and it is not in your record. This is
the record for the HBH-10. Look at it and compare.

Sequence
        Attribute 0x0000 - Service record handle
                UINT32 0x00010000
        Attribute 0x0001 - Service class ID list
                Sequence
                        UUID16 0x1203 - Generic Audio
                        UUID16 0x1108 - Headset
        Attribute 0x0004 - Protocol descriptor list
                Sequence
                        Sequence
                                UUID16 0x0100 - L2CAP
                        Sequence
                                UUID16 0x0003 - RFCOMM
                                UINT8 0x06
        Attribute 0x0009 - Bluetooth profile descriptor list
                Sequence
                        Sequence
                                UUID16 0x1108 - Headset
                                UINT16 0x0100
        Attribute 0x0100
                String Headset
        Attribute 0x0302
                Bool True

Regards

Marcel




-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
