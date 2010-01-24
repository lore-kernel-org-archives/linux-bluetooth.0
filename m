Return-Path: <cyrus@holtmann.org>
Message-ID: <4B5C6062.4030705@gmx.de>
Date: Sun, 24 Jan 2010 15:59:46 +0100
From: Thomas Egerer <hakke_007@gmx.de>
MIME-Version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>
CC: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/1] add configurable support for bridge forward delay
References: <4B5C554D.4030702@gmx.de> <1264343316.11653.0.camel@violet>
In-Reply-To: <1264343316.11653.0.camel@violet>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA512

Marcel Holtmann wrote:
> Hi Thomas,
> [...]
> using libsysfs is not acceptable. That library is deprecated.
Hi Marcel,

I get your point, but what's your suggestion? The ioctl is marked
deprecated, too and the problem of setting the forward delay persists.
Would it suffer your needs if I got rid of libsysfs in general and
simply use the ioctl or is there a different replacement strategy you
prefer?

Cheers,

Thomas
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iEYEAREKAAYFAktcYGIACgkQ2/ggQBUI/sn/fQCgg0rXvEVLB0W61iufCQZkKR5C
tqkAmwXu4nIi1pa226b3Gdz2YCBJL3UK
=ldEx
-----END PGP SIGNATURE-----
