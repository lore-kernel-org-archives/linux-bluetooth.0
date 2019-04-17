Return-Path: <SRS0=DUSx=ST=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C29A4C282DA
	for <linux-bluetooth@archiver.kernel.org>; Wed, 17 Apr 2019 20:37:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98B07217F4
	for <linux-bluetooth@archiver.kernel.org>; Wed, 17 Apr 2019 20:37:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732861AbfDQUhd (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 17 Apr 2019 16:37:33 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:54600 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729251AbfDQUhd (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 17 Apr 2019 16:37:33 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 12B9980940; Wed, 17 Apr 2019 22:37:22 +0200 (CEST)
Date:   Wed, 17 Apr 2019 22:37:30 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: Gatt server with random address does not work (everything is ok
 with public address)
Message-ID: <20190417203730.GA25856@amd>
References: <20190416193241.GA10277@amd>
 <CABBYNZK92AH7fnQJ7ikz=nvroVN9AKQDNZ07es2V52kRP0RL=g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="2fHTh5uZTiUOsy+g"
Content-Disposition: inline
In-Reply-To: <CABBYNZK92AH7fnQJ7ikz=nvroVN9AKQDNZ07es2V52kRP0RL=g@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org


--2fHTh5uZTiUOsy+g
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > I adapted example-gatt-server for a project... and it works ok
> > (thanks), as long as public address is used. I could not configure
> > random address in main.conf, so I'm doing it with btmgmt:
>=20
> Have you tried setting Privacy =3D device?
> https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/src/main.conf#n71

I tried playing with privacy, but could not get it to work. But that
was some time ago, and I could have messed it up.

> > #!/bin/bash
> > (
=2E..
> >     echo static-addr c2:34:56:78:90:ab
=2E..
> >     sleep .1
> >     echo power on
> > ) | sudo ../bluez/tools/btmgmt
> > sleep 2
> >
> > With random address, it does not work: lescan from other machine
> > detects right address, and I can connect, but that's it, services
> > can't be listed.
>=20
> bluetoothd don't really know that you have set a static address like
> that, anyway I don't know what exactly is not working so it very hard
> to give any instruction with such vague description of the problem.

Ok, if bluetoothd does not know I've done this, that would kind of
explain the problem.

I'm trying to run gatt-server, so I'll need to get static address to
work somehow. What is the correct way to set static address, so that
bluetoothd has chance to know about it? Do I need to patch sources for
that?

> > I'm using 4.19 kernel on one side and current -next on the other side,
> > with bluez e4cf43fc62b4e4dbabc72d4e44e095d7a9087992, Fri Sep 7
> > 16:25:44 2018.
> >
> > And it seems I'm not the only one having this problem:
> > https://stackoverflow.com/questions/50707914/setup-bluez-gatt-server-wi=
th-random-address
> >
> > Any ideas how to debug that? Does configuration with random address
> > work for you? Is there chance update to latest versions helps?
>=20
> Look at privacy, if that doesn't work then collect the journal logs
> and btmon traces, etc.

Privacy does not do exactly what I need, but I'll try.=20

Thanks a lot for help,
									Pavel

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--2fHTh5uZTiUOsy+g
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAly3jooACgkQMOfwapXb+vKNrwCgrab5u6ox5lzgErP6UnOr4OZ8
Q8MAniKjWryV6n2ol8nAFwqFuVwdE3z/
=K4wP
-----END PGP SIGNATURE-----

--2fHTh5uZTiUOsy+g--
