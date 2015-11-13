Return-Path: <linux-wpan-owner@vger.kernel.org>
From: Michael Richardson <mcr@sandelman.ca>
To: Alexander Aring <alex.aring@gmail.com>
cc: linux-wpan@vger.kernel.org, linux-bluetooth@vger.kernel.org,
	kernel@pengutronix.de, lukasz.duda@nordicsemi.no,
	martin.gergeleit@hs-rm.de
Subject: Re: [RFC bluetooth-next 4/4] 6lowpan: iphc: add support for stateful compression
In-Reply-To: <1447262079-2509-5-git-send-email-alex.aring@gmail.com>
References: <1447262079-2509-1-git-send-email-alex.aring@gmail.com> <1447262079-2509-5-git-send-email-alex.aring@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"
Date: Fri, 13 Nov 2015 13:08:02 -0500
Message-ID: <26774.1447438082@sandelman.ca>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

--=-=-=
Content-Type: text/plain


These patches are very nice to have, I will attempt to test them out.
I am waiting for a JTAG programmer to unwedge my openmote, and then I'll
put RIOT on that, but in the meantime I'll be testing against Contiki
on Econotag.

One thing that I wanted to add was a counter per type of HC header decoded.
I seemed to recall that the was some RCU-ish way to do lock-less 64-bit
counters, but I haven't tracked down the right reference.


--
]               Never tell me the odds!                 | ipv6 mesh networks [
]   Michael Richardson, Sandelman Software Works        | network architect  [
]     mcr@sandelman.ca  http://www.sandelman.ca/        |   ruby on rails    [


--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQEVAwUBVkYnAICLcPvd0N1lAQKrUAgAikEFvnNOFMptd9YL5j4oces6/vupNRL1
cRRyBxvdpxR3vn6gxDNxON5033zmS0vRtQ5UOYjUocf/agqhIJP8YJ8W0/jxcFsN
9BZBn9sTq8vc1DM5kEpSVmbWVXYRHPe3ci4cjVF+5crBWb7opbtrwap5lIFY09BE
0mySS6CECYWtaQMxjGbmcJl0OvB3OrQ2Aqoj3/SAXs7Y+v2N51+8uY+ubqQU6a/j
IfoPlSmsLzZI95kaXGoWap6FEzmUojh/PJkLWWgQgr8MvbDjJ3CYmbcw/Li7DLhz
dqwPa+iCGkQybHwkxJkrKq7Ayv1CViqSgYvbqKiaYJ3FK2m3igj4Dw==
=KMpR
-----END PGP SIGNATURE-----
--=-=-=--
