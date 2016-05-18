Return-Path: <netdev-owner@vger.kernel.org>
From: Michael Richardson <mcr@sandelman.ca>
To: Alexander Aring <aar@pengutronix.de>
cc: linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCHv2 bluetooth-next 04/10] ndisc: add addr_len parameter to ndisc_opt_addr_space
In-Reply-To: <cdf01ed0-2cc1-667d-40ef-34dcaddce099@pengutronix.de>
References: <1461140382-4784-1-git-send-email-aar@pengutronix.de> <1461140382-4784-5-git-send-email-aar@pengutronix.de> <109698cb-18ae-abdb-34a5-1db5a2e8dc6b@stressinduktion.org> <800c5c08-c2c8-3b44-d457-cdcf6374f280@pengutronix.de> <240084aa-2751-6f24-c07b-662b19a74475@stressinduktion.org> <cdf01ed0-2cc1-667d-40ef-34dcaddce099@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"
Date: Wed, 18 May 2016 17:39:39 -0400
Message-ID: <21520.1463607579@obiwan.sandelman.ca>
Sender: netdev-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

--=-=-=
Content-Type: text/plain


Alexander Aring <aar@pengutronix.de> wrote:
    > What I did in the patch series to store short address in neighbour
    > private data, which makes everything 802.15.4 6lowpan specific.

FYI: there are a whole family of network types which have multiple
addresses (long/short).  This includes:
1) BTLE - RFC 7668 IPv6 over BLUETOOTH(R) Low Energy
2) G.9959 - RFC 7428 Transmission of IPv6 Packets over ITU-T G.9959 Networks
3) BACnet and DECT will be defined.  Some of these have 1 byte short
addresses...
4) the various LPWAN people might be able to do IPv6... we'll see.

I think that we the 802.15.4 specific stuff is fine for now, and we can
figure out it might need generalization later on.

--
]               Never tell me the odds!                 | ipv6 mesh networks [
]   Michael Richardson, Sandelman Software Works        | network architect  [
]     mcr@sandelman.ca  http://www.sandelman.ca/        |   ruby on rails    [


--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQEVAwUBVzzhGICLcPvd0N1lAQKWWgf/TXlS2bKvbLSi/OxhvcC6m4CgMMe0cOpV
zE0eh+9LwWu3oOVExakbg2BXuwgUkofz2G+uJtSozzpz4oPTV82Yr31o/CAxGxgB
NR8zTtfKpbDPY3712MlnPm8Y9Te86DHDM0asDArzxrjtS7CCqfP7p51H6aahytZk
/kIcR0C2/2E1SOJuej+mC5E1rCKvzCaMBRvom82oeyR2I34tXGcRdVxYGd8HOvTL
855eKKSBaNCmpo0pRCY8bAfllfmkiJ8QgSTCWwZbHi4hJBo4dPiJFFcTTMLe/w0M
KbiHGoVM3WNQtw8zOgFRMAlYW9QcxaD5IJyVHWlgtU1PCcTpa2BKAg==
=gmgA
-----END PGP SIGNATURE-----
--=-=-=--
