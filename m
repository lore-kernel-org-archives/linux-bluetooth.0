Return-Path: <David.Laight@ACULAB.COM>
From: David Laight <David.Laight@ACULAB.COM>
To: 'Joe Perches' <joe@perches.com>, Pavel Machek <pavel@ucw.cz>
CC: Marcel Holtmann <marcel@holtmann.org>, "trivial@kernel.org"
	<trivial@kernel.org>, "Gustavo F. Padovan" <gustavo@padovan.org>, "Johan
 Hedberg" <johan.hedberg@gmail.com>, "David S. Miller" <davem@davemloft.net>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] bluetooth.h: __ variants of u8 and friends are not
 neccessary inside kernel
Date: Thu, 6 Oct 2016 13:00:19 +0000
Message-ID: <063D6719AE5E284EB5DD2968C1650D6DB01E4056@AcuExch.aculab.com>
References: <20161003085640.GA8130@amd>
         <368810F9-519C-44B5-85D4-1815273438BF@holtmann.org>
         <1475689996.6105.11.camel@perches.com> <20161005191103.GA25972@amd>
         <1475694934.1941.1.camel@perches.com>
         <063D6719AE5E284EB5DD2968C1650D6DB01E3EAB@AcuExch.aculab.com>
 <1475753929.1914.2.camel@perches.com>
In-Reply-To: <1475753929.1914.2.camel@perches.com>
Content-Type: text/plain; charset="Windows-1252"
MIME-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>

From: Joe Perches
> Sent: 06 October 2016 12:39
> On Thu, 2016-10-06 at 09:41 +0000, David Laight wrote:
> > From: Joe Perches
> > > No worries, and bool is the same ,size as u8.
> > That is not guaranteed at all.
> > One of the ARM ABI defined bool to be the size of int.
>=20
> Really?  What kernel has sizeof(_Bool) !=3D 1 ?

Probably none, but I know systems have used larger bool.
I found this:
> with egcs-2.90.29 980515 (egcs-1.0.3 release) on alphaev56-dec-osf4.0d

>  bool  =3D 8
>  short =3D 2
>  int   =3D 4=20
>  long  =3D 8

I'm pretty sure something newer than an old alpha ABI used 4 byte bool.

	David
