Return-Path: <SRS0=6kNt=MO=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4CF8C43143
	for <linux-bluetooth@archiver.kernel.org>; Tue,  2 Oct 2018 12:26:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 830F22064E
	for <linux-bluetooth@archiver.kernel.org>; Tue,  2 Oct 2018 12:26:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 830F22064E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727625AbeJBTJi (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 2 Oct 2018 15:09:38 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:49052 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727510AbeJBTJi (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 2 Oct 2018 15:09:38 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 1D27980775; Tue,  2 Oct 2018 14:26:32 +0200 (CEST)
Date:   Tue, 2 Oct 2018 14:26:31 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     Barry Byford <31baz66@gmail.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>
Subject: Re: low energy: does gatt client/server work in current version? How
 to test?
Message-ID: <20181002122631.GB27177@amd>
References: <20181001102430.GA6708@amd>
 <CAAu3APYAmr9M5NQkvqsG1-J_zn=Jiq4M18NYLx50WAAU3eb93w@mail.gmail.com>
 <CABBYNZ+R5M+gDyFZ6+fuJyXtNbvPiM7bh+BVeYQOn8oP9JJgSQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="zx4FCpZtqtKETZ7O"
Content-Disposition: inline
In-Reply-To: <CABBYNZ+R5M+gDyFZ6+fuJyXtNbvPiM7bh+BVeYQOn8oP9JJgSQ@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org


--zx4FCpZtqtKETZ7O
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > > dangerous. Stackoverflow (2) suggests using btmgmt (3) instead, and
> > > things got slightly different, but did not start to work for me. Is
> > > there documentation how to get this to work somewhere?
>=20
> Have a look at bluetoothctl first, all the necessary commands are
> there to enable to act as peripheral:

Thanks for the pointer. How are you getting the help? It looks to me
like machine is having fun with me:

[bluetooth]# help advertise
Too many arguments
[bluetooth]# advertise
Missing on/off/type argument
[bluetooth]# advertise help
Invalid argument help

Aha. "menu advertise" is the magic command.

Is this expected?

[bluetooth]# uuids advertise on
[bluetooth]#

Aha, thanks for hints. This looks like missing piece of puzzle... and
yes, communication seems to work now.

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--zx4FCpZtqtKETZ7O
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAluzY/cACgkQMOfwapXb+vIadQCfZCRhoqYDEHrOd7b+YZWyC1Dj
msAAn10p8YTX3sAFECEeQo2a+I+wRzv2
=2EI4
-----END PGP SIGNATURE-----

--zx4FCpZtqtKETZ7O--
