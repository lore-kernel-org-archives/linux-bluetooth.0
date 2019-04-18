Return-Path: <SRS0=fj53=SU=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6098C10F0E
	for <linux-bluetooth@archiver.kernel.org>; Thu, 18 Apr 2019 19:01:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91DA1214DA
	for <linux-bluetooth@archiver.kernel.org>; Thu, 18 Apr 2019 19:01:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732589AbfDRTB7 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 18 Apr 2019 15:01:59 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:51333 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725785AbfDRTB7 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 18 Apr 2019 15:01:59 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 8EAC480812; Thu, 18 Apr 2019 21:01:48 +0200 (CEST)
Date:   Thu, 18 Apr 2019 21:01:56 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: Gatt server with random address does not work (everything is ok
 with public address)
Message-ID: <20190418190156.GA32561@amd>
References: <20190416193241.GA10277@amd>
 <CABBYNZK92AH7fnQJ7ikz=nvroVN9AKQDNZ07es2V52kRP0RL=g@mail.gmail.com>
 <20190417203730.GA25856@amd>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="r5Pyd7+fXNt84Ff3"
Content-Disposition: inline
In-Reply-To: <20190417203730.GA25856@amd>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org


--r5Pyd7+fXNt84Ff3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > > I adapted example-gatt-server for a project... and it works ok
> > > (thanks), as long as public address is used. I could not configure
> > > random address in main.conf, so I'm doing it with btmgmt:
> >=20
> > Have you tried setting Privacy =3D device?
> > https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/src/main.conf#n=
71
>=20
> I tried playing with privacy, but could not get it to work. But that
> was some time ago, and I could have messed it up.

With privacy =3D device, bluetoothd does not have enough keys, so it
does _not_ turn it on.

Bluetooth daemon 5.50
=2E..
No IRK stored
Failed to open crypto
Failed to set privacy: rejected.

I guess there are instructions somewhere how to set it up, but I'd
really like static random address, not this.

Best regards,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--r5Pyd7+fXNt84Ff3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAly4yaQACgkQMOfwapXb+vL2KgCfWglDY2NVDo6NfqyPNbVVJYsp
cM8AoISBiwxcztUYe0+quCMi7+sEVfTc
=0aj4
-----END PGP SIGNATURE-----

--r5Pyd7+fXNt84Ff3--
