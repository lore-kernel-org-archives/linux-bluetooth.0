Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Dimitry Andric <dimitry@andric.com>
Message-ID: <357605854.20050413213015@andric.com>
To: "Martin Rolsted Jensen" <mrj_ing@hotmail.com>
Cc: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] Missing library libgcc_s.so.1 when using hciattach etc.
In-Reply-To: <BAY20-F36757559FB4EF0ADA8D4B185340@phx.gbl>
References: <BAY20-F36757559FB4EF0ADA8D4B185340@phx.gbl>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg="pgp-sha1";
  boundary="----------4A8817E13AF3039"
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Wed, 13 Apr 2005 21:30:15 +0200

------------4A8817E13AF3039
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable

On 2005-04-13 at 20:25:36 Martin Rolsted Jensen wrote:

> root@triton1:/usr/sbin# hciattach
> hciattach: error while loading shared libraries: libgcc_s.so.1: cannot op=
en
> shared object file:
> No such file or directory

This is normal when you are using shared libraries; most of them need
the shared libgcc library, libgcc_s.so.  You should be able to find it
in your toolchain directory.  For example, if you have arm-linux-gcc,
it should be somewhere in $toolchain_dir/arm-linux/lib.

You should add it to your embedded filesystem, and don't forget to run
ldconfig afterwards!

------------4A8817E13AF3039
Content-Type: application/pgp-signature

-----BEGIN PGP MESSAGE-----
Version: GnuPG v1.4.0 (MingW32)

iD8DBQFCXXNHsF6jCi4glqMRAuFnAJ94BYIHYDsZ9KdV5rWH79ZTY7GuzwCgnC/b
GiAybBNBq/OEthxhmN2daMY=
=NlSP
-----END PGP MESSAGE-----

------------4A8817E13AF3039--



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
