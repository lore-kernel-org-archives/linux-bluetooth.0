Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Subject: RE: [rfc]btusb with SCO support
Date: Wed, 20 Aug 2008 07:39:36 +0100
Message-ID: <B710AFF518DE29459D5752E7B15256D7D08101@souexc02.eu.nice.com>
In-Reply-To: <Pine.LNX.4.44L0.0808191453440.3391-100000@iolanthe.rowland.org>
References: <1219169986.7591.169.camel@violet.holtmann.net>
    <Pine.LNX.4.44L0.0808191453440.3391-100000@iolanthe.rowland.org>
From: "Dave Higton" <DAVE.HIGTON@nice.com>
To: "Alan Stern" <stern@rowland.harvard.edu>, "Marcel Holtmann"
    <marcel@holtmann.org>
Cc: "Oliver Neukum" <oliver@neukum.org>, <linux-bluetooth@vger.kernel.org>,
    <linux-usb@vger.kernel.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Alan Stern wrote:

> On Tue, 19 Aug 2008, Marcel Holtmann wrote:
>=20
> > Our problem is only that we are using a workqueue and can't make any
> > assumption when we get scheduled. This is obviously not=20
> perfect, but it
> > seems there is nothing much that can be done.
> >=20
> > I think the specification is simply bad and we have to live with it.
>=20
> I guess so.
>=20
> Since these are isoc URBs anyway, shouldn't you simply drop them until
> the new altsetting is ready?  That's a lot easier than trying to keep
> track of them and deferring them (which doesn't make much sense for
> Isochronous data).

If they were scheduled before an altsetting change, they must be plain
wrong for the new altsetting - and indeed the new altsetting could be
0, in which case they wouldn't be sent anyway.  So it seems to me that
they should be dropped.

The only difference it makes, from the POV of the outside world, is an
ever so slight change in the time the stream is switched off.

Dave



***************************************************************************=
***************************************************************************=
***************************************************************************=
****************

NICE CTI Systems UK Limited ("NICE") is registered in England under company=
 number, 3403044.  The registered office of NICE is at Tollbar Way, Hedge E=
nd, Southampton, Hampshire SO30 2ZP.

Confidentiality: This communication and any attachments are intended for th=
e above-named persons only and may be confidential and/or legally privilege=
d. Any opinions expressed in this communication are not necessarily those o=
f NICE. If this communication has come to you in error you must take no act=
ion based on it, nor must you copy or show it to anyone; please delete/dest=
roy and inform the sender by e-mail immediately.

Monitoring: NICE may monitor incoming and outgoing e-mails.

Viruses:  Although we have taken steps toward ensuring that this e-mail and=
 attachments are free from any virus, we advise that in keeping with good c=
omputing practice the recipient should ensure they are actually virus free.

***************************************************************************=
***************************************************************************=
***************************************************************************=
*******************

=20
