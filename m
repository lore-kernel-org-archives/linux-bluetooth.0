Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Trejkaz Xaoza <trejkaz@trypticon.org>
Reply-To: trejkaz@trypticon.org
To: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1470818.Ys251amHFU";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Message-Id: <200411021947.00702.trejkaz@trypticon.org>
Subject: [Bluez-users] Re: Device class resetting itself after device is removed
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
Date: Tue, 2 Nov 2004 19:46:54 +1100

--nextPart1470818.Ys251amHFU
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Marcel Holtmann wrote:
>> Yup, looks healthy so far:
>>=20
>> [100] trejkaz@raven:~> ps -ef|grep hcid
>> root      6821     1  0 Nov01 ?        00:00:00 hcid: processing events =
                =20
>=20
> if it still doesn"t work, you may have to restart it to use your new
> settings.

Okay, I just solved it.

I was missing a semicolon somewhere at the end of the options section of th=
e=20
configuration file.  For some reason hcid didn't see this as an error, but=
=20
just plodded on without the configuration set.  *facepalm*

My bad.

TX

=2D-=20
             Email: Trejkaz Xaoza <trejkaz@xaoza.net>
          Web site: http://xaoza.net/
         Jabber ID: trejkaz@jabber.xaoza.net
   GPG Fingerprint: 9EEB 97D7 8F7B 7977 F39F  A62C B8C7 BC8B 037E EA73

--nextPart1470818.Ys251amHFU
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQBBh0mEuMe8iwN+6nMRAtmFAJ0SDGX225FVLjJVVgEeMReq61T8DwCdFl+8
zv7IqLXdEkIrxrT1O68a0Yw=
=Y4br
-----END PGP SIGNATURE-----

--nextPart1470818.Ys251amHFU--


-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
