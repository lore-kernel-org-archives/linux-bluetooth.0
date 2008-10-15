Return-Path: <cyrus@holtmann.org>
Message-ID: <48F6639E.40701@dell.com>
Date: Wed, 15 Oct 2008 16:41:50 -0500
From: Mario Limonciello <mario_limonciello@dell.com>
MIME-Version: 1.0
CC: BlueZ development <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH] Fix Apple Wireless keyboard pairing?
References: <1224032783.5268.1418.camel@cookie.hadess.net>	 <48F63904.6090902@dell.com> <1224106339.5268.3642.camel@cookie.hadess.net>
In-Reply-To: <1224106339.5268.3642.camel@cookie.hadess.net>
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigAE5AB3FB93AB52E631114F7F"
To: unlisted-recipients:; (no To-header on input)
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigAE5AB3FB93AB52E631114F7F
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Bastien:

Yeah, I'll definitely agree these keyboards are quite finicky to get
paired.  I was initially hoping your patch would help that, but then
realized it won't affect mine.  It seems that the only way I've gotten
them to improve is if I remove any other devices that were paired with
them previously from the proximity and try to find a good combination of
pressing buttons in the GUI and pressing the power button on the keyboard=
=2E

I  think the poster to that bug has the older pre-broadcom series of
this hardware, which would explain the similar ID to the mighty mouse.

Regards

Bastien Nocera wrote:
> On Wed, 2008-10-15 at 13:40 -0500, Mario Limonciello wrote:
>  =20
>> Hi Bastien:
>>
>> I've got one of these Aluminum BT keyboards, but it's MAC address is
>> quite different:
>>
>> 00:1B:63:FA:CD:5A Apple Wireless Keyboard
>>
>> Where did you get your data from indicating that it shared the same
>> prefix as the mighty mouse?
>>    =20
>
> Some of them would. See bug report at:
> https://bugzilla.redhat.com/show_bug.cgi?id=3D466988
>
> Pairing keyboards still doesn't work as expected, but I should get some=

> hardware soon to fix that.
>
> Cheers
>
>  =20

--=20
Mario Limonciello
*Dell | Linux Engineering*
mario_limonciello@dell.com


--------------enigAE5AB3FB93AB52E631114F7F
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iEYEARECAAYFAkj2Y54ACgkQ2CrZjkA73YtrEgCdFwr29/CW2ZrN86mp9eKJ+aGp
fiwAnRKX409FrVRx2mmaZ86WKAOjiIdW
=//NA
-----END PGP SIGNATURE-----

--------------enigAE5AB3FB93AB52E631114F7F--
