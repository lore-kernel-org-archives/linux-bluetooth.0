Return-Path: <cijoml@volny.cz>
From: "Michal Semler (volny.cz)" <cijoml@volny.cz>
Reply-To: cijoml@volny.cz
To: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [Bluez-users] MS Wireless keyboard scans remapping
Date: Tue, 28 Oct 2003 21:05:53 +0100
References: <200310280847.39317.cijoml@volny.cz> <20031028084018.GA1875@smartdata.ch> <1067366086.24043.153.camel@pegasus>
In-Reply-To: <1067366086.24043.153.camel@pegasus>
Cc: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Message-Id: <200310282105.53460.cijoml@volny.cz>
List-ID: <bluez-users.lists.sourceforge.net>

Dne =FAt 28. =F8=EDjna 2003 19:34 Marcel Holtmann napsal(a):
> Hi Olivier,
>
> > > my keyboard works now fine, but I found keys which doesn't. Looks like
> > > MS changed scan codes for them.
> >
> > I have had this kind of problem with a Logitech diNovo Media Desktop
> > (http://www.logitech.com/bluetooth/). My main problems where that some
> > keys are not mapped correctly in the bthid-0.6 of Peter, and the code
> > for the mouse buttons is not OK. (at least with my Logitech Bluetooth
> > mouse).
> >
> > The problem with the keys is that my keyboard is a swiss french one, and
> > the code of Peter has some keys missing. I have take the mapping from
> > the USB driver, and it is now working great. :-)
> >
> > I have send my patches to Peter, but I have receive no answer. So, I
> > have attached my previous email to him. Try the patches to see if this
> > correct also your problem.
>
> this is another reason, why we should reuse the USB HID parser for the
> Bluetooth keyboards and mice ;)

Hi Marcel,

Don't remember support these keys :)

Stand by
> ACL data: handle 0x0029 flags 0x02 dlen 7
    L2CAP(d): cid 0x41 len 3 [psm 0]
      A1 03 02

=46unctionkey F
> ACL data: handle 0x0029 flags 0x02 dlen 7
    L2CAP(d): cid 0x41 len 3 [psm 0]
      A1 05 03

windows key opens properties
> ACL data: handle 0x0029 flags 0x02 dlen 14
    L2CAP(d): cid 0x41 len 10 [psm 0]
      A1 01 00 00 65 00 00 00 00 00


colona key |
> ACL data: handle 0x0029 flags 0x02 dlen 14
    L2CAP(d): cid 0x41 len 10 [psm 0]
      A1 01 00 00 32 00 00 00 00 00

other key in german version marked like criminal key #=20
> ACL data: handle 0x0029 flags 0x02 dlen 14
    L2CAP(d): cid 0x41 len 10 [psm 0]
      A1 01 00 00 64 00 00 00 00 00

Michal
