Return-Path: <jeffs@fairwayacademy.org>
From: Jeff Sutherland <jeffs@fairwayacademy.org>
To: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [Bluez-users] Timeout message from kernel
Date: Sat, 14 Feb 2004 08:59:22 -0500
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
References: <200402121636.02074.jeffs@fairwayacademy.org> <200402132310.53881.jeffs@fairwayacademy.org> <1076748792.18588.152.camel@pegasus>
In-Reply-To: <1076748792.18588.152.camel@pegasus>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <200402140859.36255.jeffs@fairwayacademy.org>
List-ID: <bluez-users.lists.sourceforge.net>

=2D----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Saturday 14 February 2004 03:53, Marcel Holtmann wrote:
> Hi Jeff,
>
> > > the endian stuff looks fine in the l2test.c source. What endian do the
> > > Coldfire processor use?
> >
> > Big Endian.
>
> maybe we really have some endian problems here and also in hcitool. The
> pkt_type for create_connection is for example uint16 and this explains
> why "hcitool info ..." fails. I don't have access to a machine with big
> endian, so most of the userspace tools are not fully tested.

Hello Marcel,
 I'll have access to this machine for a little while, so if you have someth=
ing=20
you'd like to try just send patches this way :-)

Regards,
=2D -Jeff
=2D --=20
Secure your email with Gnu Privacy Guard and Mozilla, the open source
cross platform solution for Windows, Linux, and Mac OS X.
See http://enigmail.mozdev.org/
=2D----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQFALinEvvyQ7TDL7JURAmSeAKCaqzUp4BvjDe2j/wzTmkcQYNeUfgCdFs2c
6++aTGGr+pMUVRcLmnRWG7E=3D
=3DRL2F
=2D----END PGP SIGNATURE-----
