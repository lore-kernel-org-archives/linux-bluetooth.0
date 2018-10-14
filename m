Return-Path: <SRS0=msOO=M2=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C44BC7112A
	for <linux-bluetooth@archiver.kernel.org>; Sun, 14 Oct 2018 21:40:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1507A20835
	for <linux-bluetooth@archiver.kernel.org>; Sun, 14 Oct 2018 21:40:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1507A20835
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726262AbeJOFWb (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 15 Oct 2018 01:22:31 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:43773 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726084AbeJOFWb (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 15 Oct 2018 01:22:31 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 92D49807DA; Sun, 14 Oct 2018 23:40:07 +0200 (CEST)
Date:   Sun, 14 Oct 2018 23:40:07 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     Barry Byford <31baz66@gmail.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>
Subject: Re: low energy: does gatt client/server work in current version? How
 to test?
Message-ID: <20181014214007.GA17602@amd>
References: <20181001102430.GA6708@amd>
 <CAAu3APYAmr9M5NQkvqsG1-J_zn=Jiq4M18NYLx50WAAU3eb93w@mail.gmail.com>
 <CABBYNZ+R5M+gDyFZ6+fuJyXtNbvPiM7bh+BVeYQOn8oP9JJgSQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="sdtB3X0nJg68CQEu"
Content-Disposition: inline
In-Reply-To: <CABBYNZ+R5M+gDyFZ6+fuJyXtNbvPiM7bh+BVeYQOn8oP9JJgSQ@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org


--sdtB3X0nJg68CQEu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > > Using hciconfig while bluetoothd is running sounds kind-of
> > > dangerous. Stackoverflow (2) suggests using btmgmt (3) instead, and
> > > things got slightly different, but did not start to work for me. Is
> > > there documentation how to get this to work somewhere?
>=20
> Have a look at bluetoothctl first, all the necessary commands are
> there to enable to act as peripheral:

First, thanks a lot. With bluetoothctl, it indeed works.

> > > (3)
> > > sudo tools/btmgmt -i hci0 power off
> > > sudo tools/btmgmt -i hci0 le on
> > > sudo tools/btmgmt -i hci0 connectable on
> > > sudo tools/btmgmt -i hci0 name "some friendly name"
> > > sudo tools/btmgmt -i hci0 advertising on
> > > sudo tools/btmgmt -i hci0 power on
> > > tools/btgatt-server -i hci0 -s low -t public -r -v
>=20
> No need to use btmgmt, applications should use the D-Bus API which has
> pretty much everything you are doing with btmgmt.

Pretty much, yes.

There's one piece I'm missing. I need to use "random address", because
that's what other side of link wants to talk to. "privacy on" from
btmgmt does randomize address (and sets the right bit). I have not
found equivalent in bluetoothctl.

Plus... I'd really like to use "random, but fixed for given machine"
address, as this is device other side is expected to pair with.

Ideas woudl be welcome.

> > >     def up(m):
> > >         print("Starting up BLEE")
> > >         os.system("sudo ../bluez/src/bluetoothd -d -n &")
> > >         time.sleep(2)
> > >         os.system("sudo ./gatt-server &")
>=20
> bluetoothd is already acting as a GATT server.

I may have misnamed the component, but something needs to tell which
attributes to implement to bluetoothd.

Thanks,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--sdtB3X0nJg68CQEu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlvDt7cACgkQMOfwapXb+vKHdgCgh1XH+uldJQmjSZvvzUxHbT0e
EMMAoMJZPcQ8a0yG0CGTYMvCa524hy+o
=1zPn
-----END PGP SIGNATURE-----

--sdtB3X0nJg68CQEu--
