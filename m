Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Date: Thu, 14 Sep 2017 13:44:02 +0200
From: Sebastian Reichel <sre@kernel.org>
To: linux-bluetooth@vger.kernel.org
Cc: pulseaudio-discuss@lists.freedesktop.org
Subject: Bose QC35 HFP/HSP MTU size
Message-ID: <20170914114402.qbfwd3ceosrrgzqp@earth>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="a2pcb5jslwx6wzdu"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


--a2pcb5jslwx6wzdu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

Bose QC35 are affected by the attached upgrade notice
=66rom Pulseaudio 11. The workaround fixes the problem.

-- Sebastian

> https://www.freedesktop.org/wiki/Software/PulseAudio/Notes/11.0/
>
> Improved bluetooth MTU configuration
>
> The packet size (a.k.a. MTU, "maximum transmission unit") that
> PulseAudio uses with the bluetooth HSP profile was previously
> always configured to be 48 bytes. That worked with most hardware,
> but some adapters require a different packet size. Now PulseAudio
> asks the kernel what packet size should be used, which fixes the
> problem.
>
> However, a new problem appeared: some adapters that used to work
> with 48 byte packet size don't any more work with the size that
> the kernel tells PulseAudio to use. If you find that HSP audio
> stopped working when upgrading to PulseAudio 11.0, you can revert
> to the old behaviour by passing option "autodetect_mtu=3Dno" to
> module-bluetooth-discover in /etc/pulse/default.pa. If that fixes
> the problem, then please report the problem to the BlueZ and/or
> PulseAudio developers, so that the kernel can be fixed.

--a2pcb5jslwx6wzdu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlm6a38ACgkQ2O7X88g7
+prNtxAAjlYZ8y4rGj+FVl8JK2m+sMhnHXjjciEnaR1RGkPvBEu85ZGueM+a3/P5
MLyaWou4KhLc+jp0VOfuPhMzyH2DKfMXgevK8W2Serthlf3tTFlpzTvkDi+UdNKF
iGAuAQLrWfAmhC3CIfQ3FN831JJG5qgKs5I5tNiOEt2tzWNBk60HVKMS8ulOh9dI
HrCHWyAJbLnR+95+DypY6R1ROAOlxkE9d3v0ufXkVmrEnlaLbNElyuM7MmbXK93U
Hf614whiACoLQx6UDHEykFE89fu3vnCUWae6pqWuxnEt22g7hc1kkOnO4gH3r54F
NEhByzEIzzjhLMvXGbdyea2TKREI4V+6NXYalUOftdMQLn+0Dplsv9ZXIFhMqwjL
lXQ38O39ksFeZ0DFbjho1d1pV+Eg+zNiCOYuNGJxcWTYnx2lL6Q16+GzsHZoMbRH
Pxs2GXSjHZhYPN3RyLdPwzFt55oqJX9s0v+boerxfDdiXF4rzM/sCpS5wAKED33Y
lO+G74W9Pz6TEGq8EVYkLNdqUYHfj4Y17E3Hroxm/aXMUl2XR6xwR39Kfi/jlWfr
QNrT7SYumF42/FJFz6TB7770VEyWdqZS7/oZ997QeELiYFPLRtZdjJOaLbg4SVz4
p9eJ5uYuEMEbGatjH0xUQJarppVcVcDjyEkZP6GMHkfKBq5rtoQ=
=bhFD
-----END PGP SIGNATURE-----

--a2pcb5jslwx6wzdu--
