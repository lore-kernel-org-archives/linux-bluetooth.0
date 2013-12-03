Return-Path: <cyrus@holtmann.org>
Message-ID: <529E4CAB.6010703@babioch.de>
Date: Tue, 03 Dec 2013 22:27:07 +0100
From: Karol Babioch <karol@babioch.de>
MIME-Version: 1.0
To: linux-bluetooth@vger.kernel.org
Subject: tools: Parsing commands is lenient?
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="vKJnssAJGhnt7DgM6OAo0i1Ewx0tC4x1t"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--vKJnssAJGhnt7DgM6OAo0i1Ewx0tC4x1t
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi,

I've stumbled across something, which is probably a feature, but I
couldn't find it documented anywhere, so I'm going to bring it up anyway.=


The parsing of the "command" field for (at least) the tools "hcitool"
and "sdptool" is quite inaccurate. For example when I want to scan for
Bluetooth devices, I would use something like:

[johnpatcher@vpcs ~]$ hcitool scan
Scanning ...

This works great, but so does the following, too:

[johnpatcher@vpcs ~]$ hcitool scan123
Scanning ...

So, it seems that basically you can append whatever you want to a
command, as long as the command itself is valid.

First of all, I'm not sure whether it is actually a good idea to be
lenient when it comes down to parsing a command. I guess most of you are
around *nix systems even longer than me, but at least I'm used to some
sort of an error message as soon as I goof up a command on the console.
At least, theoretically speaking, one could come up with some scenarios,
where this could go terribly wrong when some commands are added and/or
changed.

Secondly, I think that this sort of behavior should actually be
documented when this is and/or was an explicit consideration, for
instance within the man page(s) of the appropriate tools.

Maybe I'm making too much of a fuss about this, but at least I was
*really* surprised by this. I just want to make sure that this isn't
something that was overlooked and/or introduced by a stupid
carelessness, but rather was a conscious decision.

Best regards,
Karol Babioch


--vKJnssAJGhnt7DgM6OAo0i1Ewx0tC4x1t
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSnkyrAAoJEHSaZc1HnzIVfOcP/0wxTRIbFnqgUoTpY6p3VihN
9MvaB0JvNROTKk8hQgXUkVjmXmEGmUE6+3ddSpC3HSskxWNr3SRvajOmmsrqOvsD
FfDSmbmp80zAwktPJ1Yn2hB7RJHZjWEp4i1pQpECG2mJY3FES2dOUF4oCSQPh4Sv
TAjUA8ZxglzGcqpV+F+Ijzhcm+pkymPPHbGIada460/FoWRng3p329ucbjbO8wWY
KWVsldrkgeHT8ikjlhgSMAumy1oK3Gj3BLtj1QNgFcWcs5XXgdeuAN/bsKOX/FZH
6rf3kMMUdDDTCdQA4TC5QvdZpfyb90FcrUL80HJhJfqodfnXes2NBvEN//B4woOx
/bNozYcGlea3964QSAKzmYG1NEw5PC9526ay+EcRVan7pwb0LsP7kuKFdLrdcs2X
dEUkaGz0ecy+ImRalrcn2JW4af3LArh4mhJyT0t0DsR4AiYN/nGhYGmthMcmRZSA
mnzaMH3nODdft+XAyFC6lzwsVHSH/m3K+YbPm0rnZcg82RVjs3ASRjaGA7f7OA7U
R47tdzRXXVQSwkHqfLazxuxFN0+fNqD4ppnp8AZiohGH/0KESWd1h+8rhqUJwWQ8
WnMrZUjB4VaInn1Z9XrTMUL0khnRQw/K8F9p5ktUpcYnbTKSkfr5W0E3/0PssKtu
1RXRgg+s+U46PuX86JmM
=PibO
-----END PGP SIGNATURE-----

--vKJnssAJGhnt7DgM6OAo0i1Ewx0tC4x1t--
