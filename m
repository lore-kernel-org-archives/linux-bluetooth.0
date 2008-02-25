Return-Path: <cyrus@holtmann.org>
From: "Brian J. Murrell" <brian@interlinx.bc.ca>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <d89ddf300802241225l1a352768x94afccdc2b120be6@mail.gmail.com>
References: <1203815399.8021.10.camel@pc.ilinx>
	<d89ddf300802241225l1a352768x94afccdc2b120be6@mail.gmail.com>
Date: Sun, 24 Feb 2008 20:02:16 -0500
Message-Id: <1203901336.8021.27.camel@pc.ilinx>
Mime-Version: 1.0
Subject: Re: [Bluez-users] hci_scodata_packet: hci0 SCO packet for
	unknown	connection handle 1
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1332712578=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net


--===============1332712578==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-RlaE5NCOVberKIStjGSE"


--=-RlaE5NCOVberKIStjGSE
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sun, 2008-02-24 at 13:25 -0700, Brad Midgley wrote:
> Brian

Hi Brad,

> I've added the kernel patch that is supposed to handle this problem to
> the end of the wiki page.

Is this something that can go upstream easily?

> Please let us know if it helps.

I tend to avoid patching and building kernels since I tend to follow a
distribution's development version (i.e. currently Ubuntu Hardy) which
means high kernel turnover, which means I spend too much time patching
and building kernels if I maintain a patch (series) outside of the
vendor's kernel.

Perhaps I can convince Ubuntu to roll this patch in.  If it's hoped to
be accepted upstream that might be possible.  If it's been rejected
upstream for whatever reason, Ubuntu probably won't let it in either.

> It's
> ostensibly going to be an issue if you have a bluetooth adapter
> capable of esco but your headset is not.

How do I determine if this is the case?  Just to see if we are barking
up the right tree?

Thanx!

b.


--=-RlaE5NCOVberKIStjGSE
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBHwhOYl3EQlGLyuXARAucHAKCUaPIVyObsov3paUyFcGt1S/iGewCfZZsQ
wzTzXhSr6+Mzy4w8HOyUQes=
=iZpo
-----END PGP SIGNATURE-----

--=-RlaE5NCOVberKIStjGSE--



--===============1332712578==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
--===============1332712578==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============1332712578==--
