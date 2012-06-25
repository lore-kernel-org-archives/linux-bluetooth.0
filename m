Return-Path: <cyrus@holtmann.org>
Message-ID: <1340616791.5461.55.camel@thor.local>
Subject: Re: [PATCH] bluetooth: opcode field of sent commands is little
 endian.
From: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@daenzer.net>
To: David Laight <David.Laight@ACULAB.COM>
Cc: Marcel Holtmann <marcel@holtmann.org>, linux-bluetooth@vger.kernel.org,
	Johan Hedberg <johan.hedberg@intel.com>, linuxppc-dev@ozlabs.org
Date: Mon, 25 Jun 2012 11:33:11 +0200
In-Reply-To: <AE90C24D6B3A694183C094C60CF0A2F6026B6F62@saturn3.aculab.com>
References: <AE90C24D6B3A694183C094C60CF0A2F6026B6F62@saturn3.aculab.com>
Content-Type: text/plain; charset="ISO-8859-1"
Mime-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>

On Mon, 2012-06-25 at 10:20 +0100, David Laight wrote:=20
> > > > Fine with me, though FWIW that not only doesn't use
> > > > __constant_cpu_to_le16() but actually swaps the non-constant value.
> > >=20
> > > Don't see what point you are trying to make here. Swapping the value
> > > from the actual command structure is always fine with me.
> >=20
> > The point is that the result of swapping a constant value is just
> > another constant value, whereas the fix in mainline swaps a value from
> > memory. Not a big deal.
>=20
> Surely, but surely, the definition of cpu_to_le16() uses
> gcc 'magic' to determine that the argument is a constant
> and then automatically selects the 'constant' form.

It can only do that if the argument is constant in the first place
though. :)


--=20
Earthling Michel D=E4nzer           |                   http://www.amd.com
Libre software enthusiast         |          Debian, X and DRI developer
