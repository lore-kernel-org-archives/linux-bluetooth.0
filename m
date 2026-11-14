Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.67.36.66
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794676000;
	b=1de2H/cPIsZQX+dPrDvGfrDtOMz/GHZm4cwANVRF4UHkAG8LqfNv3h4G9WFUpNpdN+2t
	 V9GD+jPk25oFPwtKYsGxK+k0T5Sifh2b5+6ebhLHofgwXbl5rPLeOpFq88ACjWn/R8ZIZ
	 02BrKWkhBMNMO1K5+tAlDmBsfIk1g+Et/5mAMvz8mr2cByQP20xuqapqKhLKbZZjQPGEr
	 ZhTh63pBzT4cLJRKA3OIrUshpT+GUZaXCw87nUw9nfpfY5fQa0rokFQ9emJU/u1ZjtMP2
	 eDhmewIWdOlWLw9cB3M7ytyHAE2To2YSdL86f9Y50NP/Js0S7dNuGjbm+G1Cbe1WZCw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794676000;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Message-ID:Subject:
	 From:To:Cc:Date:In-Reply-To:References:Autocrypt:Content-Type:
	 MIME-Version:OpenPGP;
	bh=bZSuAPjJ+v3XkKNzimjkiEXtH8QqSAUW7r+KOR1UNck=;
	b=3Vz2D4HAFiPCjeACGsvhIYvSjuOVY53AAHuzIxOGKNAhva9gsN6/xjDybHKdtpNmCc5p
	 bhlAy6im4QjqajKhHKIIqxdERKmud+HhOegIWHC39boRIPHyst/IkizPkyUeTgArkA6/H
	 dSuNMTw/MbwHaooZFGUdd9VYk0D4U4xLxKuVmGlYoUSTj2kAp33USumCyuVwLSkUxZj4I
	 9frfk5Af4V1yvqO1ISXBCxw0XTwpcrp1hH74n7eA7QEk/ah38pNCGj7Uz00l2e/PfEkQo
	 ihAIQlA04wArzm7BHT4URBbwQL2269KoyJm5UO6oQhjKtLtHffQTrW7SeoHZY76RSKg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=posteo.de;
	spf=pass smtp.mailfrom=posteo.de;
	dkim=pass header.d=posteo.de header.i=@posteo.de header.a=rsa-sha256 header.s=1984.8680eb header.b=SyohQEom;
	arc=none smtp.remote-ip=185.67.36.66
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C272F606A327
	for <linux-bluetooth@vger.kernel.org>; Sat, 14 Nov 2026 17:06:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C272F606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=posteo.de header.i=@posteo.de header.a=rsa-sha256 header.s=1984.8680eb header.b=SyohQEom
Received: from submission (posteo.de [185.67.36.169]) 
	by mout02.posteo.de (Postfix) with ESMTPS id B227E240103
	for <linux-bluetooth@vger.kernel.org>; Sat, 14 Nov 2026 18:06:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.de;
	s=1984.8680eb; t=1794675997;
	bh=bZSuAPjJ+v3XkKNzimjkiEXtH8QqSAUW7r+KOR1UNck=;
	h=Message-ID:Subject:From:To:Cc:Date:Autocrypt:Content-Type:
	 MIME-Version:OpenPGP:From;
	b=SyohQEomfPbKxQQTxZA1xxZuZfKgxDnij1Cx+/FcptINrcPxH84phY9S3OLo5zDvv
	 QyFR8J26RyiC+fdrKBwZsBuTjSGh7Kn1iyLsZyN84bQiAJ6tu3HbjQY/8Edvcd4i3c
	 dxE4gLARWHv2QRjQvI9TczQQPaH72FPtixvSWYi4ydneVBn6cu4rdXmWuz/LozCwZ5
	 iReniHrWwE2iaOSR7dG/WgI4OP9ksNaAjzGvHa/AGJm/2D7Y84dLe3IhMPj3f8O6jG
	 Gmy9kHM9n4qjtBcpnVtGXbKQlf6/g9WVHsz+sAacweKn9h7rW8gr9f43fZ5fFfAGw4
	 tRCXhSwXrVI/w==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4jRgWv2qdFz6tsb;
	Sat, 14 Nov 2026 18:06:35 +0100 (CET)
Message-ID: <fc05ed7435e2fa282a163f99110048f6cfe56b6a.camel@posteo.de>
Subject: Re: [PATCH 0/1] Bluetooth: hci_mrvl: Fix duplicate serdev open/close
From: Markus Probst <markus.probst@posteo.de>
To: Michael McAllister <me@michaelmcallister.org>, luiz.dentz@gmail.com, 
	marcel@holtmann.org, Loic Poulain <loic.poulain@oss.qualcomm.com>, Sascha
 Hauer	 <s.hauer@pengutronix.de>, Stefan Eichenberger
 <stefan.eichenberger@toradex.com>,  Gongwei Li <ligongwei@kylinos.cn>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>, Vitor Soares	
 <vitor.soares@toradex.com>, Hiago De Franco <hiago.franco@toradex.com>, 
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Sat, 14 Nov 2026 17:06:37 +0000
In-Reply-To: <179467295518.97469.12346516231160594592.marvell-serdev-v1-0@michaelmcallister.org>
References: <341e56b1ff7d8a5b109e26e30dfed61faa54d603.camel@posteo.de>
	 <179467295518.97469.12346516231160594592.marvell-serdev-v1-0@michaelmcallister.org>
Autocrypt: addr=markus.probst@posteo.de; prefer-encrypt=mutual;
 keydata=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
 jfGillcaQOqFZ3WwVqyzG1BUfTow==
Content-Type: multipart/signed; micalg="pgp-sha256";
	protocol="application/pgp-signature"; boundary="=-RNNjEGgBFzqiQk7v4Asd"
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
OpenPGP: url=https://posteo.de/keys/markus.probst@posteo.de.asc; preference=encrypt


--=-RNNjEGgBFzqiQk7v4Asd
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, 2026-11-14 at 16:15 +0000, Michael McAllister wrote:
> Hi Markus, thanks for flagging this!
>=20
> You're right, hci_serdev already opens and closes the port, so the extra
> calls in the Marvell driver aren't needed. This removes them as a
> separate fix.
>=20
> I've build-tested it and checked that the duplicate-open reproducer
> passes with the fix, but I don't have Marvell hardware to test on.
>=20
> Thanks,
> Michael

Hi,

Thanks for the patch!

I added some more people from the git history (incl. from existing
device trees that have this hardware) to CC here in the hope that they
can test it.

If nobody tests it, there is still be linux-next. But its generally
better if it gets tested once before that.

Thanks
- Markus Probst

--=-RNNjEGgBFzqiQk7v4Asd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQJPBAABCAA5FiEEgnQYxPSsWOdyMMRzNHYf+OetQ9IFAmr4lRUbFIAAAAAABAAO
bWFudTIsMi41KzEuMTIsMiwyAAoJEDR2H/jnrUPSezoP/15HddtPh5s0xtRmwOIH
HO6Alam6NRspxv2Cm8w7W0IdS0V/u/Krq+kCnCUHkiOZYgu6zzdeEVojPZ2TO5My
XcMeCBcEvECy6rf2D28D2JaAh2kc+44XGeA5mfak5rTNY22SrV7xRsjlo4Z4JSFq
kQQLlvalZgdn76/PKZjckFxurFiJwP40u+xmIQMqz9qu8kqeE6Cdm6Ars+sH0TCQ
B0YnMFWNZ5ZhDZa02RAKKU+IsIZaSWE+BDur9NmHFJW2MeVNuIVFdWpmMnRyzfcQ
i3DlwKY9dJvLauSVlsQqWo9Ajbnv5Vo3UXPSdIfSeP5nXq+PtuCxTJCIh5VyFjr3
aPzp5P0UHjnRkmPTrbBp59fSRZYHubvzRt6TtkVg+Zw86BXRC9A5yLIyObBz3Vfc
OZ37sCEksO988toNsB+5zVP9tGnZTLOW9u9NKB2+L/aY5ujYoZcIS5sUgZ2TA+SN
/8gnRxg8zboTkikXOS1fnD/KsinX/7umogR9kB6wCXCeHCrM+bQuqpAHsp/Q403W
Kg4HPPfQqJ3vzMUOqdDkYsbq4wEJ7w94GO1CWkwMQ0ZEy5tIWtRrHLUdSdzEdhuB
73XK5KocJMJEiGauz87RcxYznJHlAtlaSAKcc3YxbBgyfbchlz4xrkRn608UDYVk
0vbwWmlOtais7onDKnwUM8T+
=dMnd
-----END PGP SIGNATURE-----

--=-RNNjEGgBFzqiQk7v4Asd--
