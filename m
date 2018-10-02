Return-Path: <SRS0=6kNt=MO=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52207C43143
	for <linux-bluetooth@archiver.kernel.org>; Tue,  2 Oct 2018 12:09:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1F7F2082A
	for <linux-bluetooth@archiver.kernel.org>; Tue,  2 Oct 2018 12:09:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1F7F2082A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727510AbeJBSwz (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 2 Oct 2018 14:52:55 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:48536 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727434AbeJBSwy (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 2 Oct 2018 14:52:54 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 357DF80775; Tue,  2 Oct 2018 14:09:53 +0200 (CEST)
Date:   Tue, 2 Oct 2018 14:09:52 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Barry Byford <31baz66@gmail.com>
Cc:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Bluez mailing list <linux-bluetooth@vger.kernel.org>,
        marcel@holtmann.org
Subject: Re: low energy: does gatt client/server work in current version? How
 to test?
Message-ID: <20181002120952.GA27177@amd>
References: <20181001102430.GA6708@amd>
 <CAAu3APYAmr9M5NQkvqsG1-J_zn=Jiq4M18NYLx50WAAU3eb93w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="ew6BAiZeqk4r7MaW"
Content-Disposition: inline
In-Reply-To: <CAAu3APYAmr9M5NQkvqsG1-J_zn=Jiq4M18NYLx50WAAU3eb93w@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org


--ew6BAiZeqk4r7MaW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> There has been a discussion on the mailing previously that covered some o=
f this.
>=20
> Is there anything in this thread that helps:
> https://marc.info/?t=3D149208458400001&r=3D1&w=3D2

Thanks for the pointer; it indeed tells me how it is suppossed to
work. (It does not, but now I understand that advertising is quite
separate from the gatt protocol).

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--ew6BAiZeqk4r7MaW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAluzYBAACgkQMOfwapXb+vKA0wCglQXnC/tGQ0qSz7CxmGBsr0Um
2HMAoLzj0Uj9fVUwuNVwVe+Me6USFMmH
=FYie
-----END PGP SIGNATURE-----

--ew6BAiZeqk4r7MaW--
