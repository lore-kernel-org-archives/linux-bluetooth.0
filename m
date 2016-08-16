Return-Path: <sre@kernel.org>
Date: Tue, 16 Aug 2016 10:14:46 +0200
From: Sebastian Reichel <sre@kernel.org>
To: Pavel Machek <pavel@ucw.cz>
Cc: Tony Lindgren <tony@atomide.com>, Rob Herring <robh+dt@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Marcel Holtmann <marcel@holtmann.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jslaby@suse.com>, Ville Tervo <ville.tervo@iki.fi>,
	Filip =?utf-8?Q?Matijevi=C4=87?= <filip.matijevic.pz@gmail.com>,
	Aaro Koskinen <aaro.koskinen@iki.fi>,
	Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>,
	ivo.g.dimitrov.75@gmail.com, linux-bluetooth@vger.kernel.org,
	linux-serial@vger.kernel.org, linux-omap@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC 1/7] tty: serial: omap: add UPF_BOOT_AUTOCONF flag for DT
 init
Message-ID: <20160816081446.buo35qiazutq57qy@earth>
References: <1471058078-5579-1-git-send-email-sre@kernel.org>
 <1471058078-5579-2-git-send-email-sre@kernel.org>
 <20160814084956.GB21321@amd>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="22o7guaehhjjzaqt"
In-Reply-To: <20160814084956.GB21321@amd>
List-ID: <linux-bluetooth.vger.kernel.org>


--22o7guaehhjjzaqt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

On Sun, Aug 14, 2016 at 10:49:56AM +0200, Pavel Machek wrote:
> It would be nice to have a line about why it is needed,
> unfortunately include/linux/serial_core.h is not exactly helpful.
>
> Plus you'll need to sign off the patch.

I should have had another look at the long patch
descriptions before sending the patchset ;)

-- Sebastian

--22o7guaehhjjzaqt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJXsstzAAoJENju1/PIO/qaN5kP/jBiGQ/u9sk1kaJuuWv8uh2b
q7e1P8hPI+ghOsSJ4uqZfoFMMwztUgitH0xil6SFOFxyhazF1KyhEUYQ4TTqpieC
BxkwqxMkbWVFJlNWaF/LJFDdL7WadgRiP2dYkCQesjEzjVmu/xwzoidcm4lG2nGJ
wssWf4n4Ri/T7goz/VJssb1O/+V2NC5r2bf5L03282ymh1XfmJR/uGx7RUNTQgl2
NpwBa3r9LYH4CWnro1oQPjzVuAFQCfI+dsn39mdqxAJLqLt5gpSFjaZhAvO2PfHf
1cOW469bTuVm3IYIyEeFMp3B67UYt8XVEyLF7ArXWfPMZ4ip4tnGgc/U5M2H2N8o
XyaM606UhbQoyRHIKsPQFxAeMUrxH7hHPx+B5pb59Pq4t1DKb+CjgJxf1DMZgyVz
OvPyBXZDNYZB4MYocvENvh9/8m5RykWpkfDHetDgC1jJZlvkTlhP4Vw/e/gh+rk5
hLrAtla04iE00YyULKHSNftnlp1m3vEW7fwm2WH/aAKE1MtAhqFzIf7Wwp/4iyGc
B1J9sjmZkZGvCsGQXhd1kxTyblbpEeQe63JO06TP29451t2Qp3MtBtmcuGMCjpBP
H/kMwjV1nejiUXhaa20t+ZpsHjnwSXPD1BTt6Wsncx/zGGUfSHeIriv0U9dGIESI
llNB5kQwkqTJZz7Mae9r
=U1HA
-----END PGP SIGNATURE-----

--22o7guaehhjjzaqt--
