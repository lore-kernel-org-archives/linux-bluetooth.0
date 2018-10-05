Return-Path: <SRS0=1XHc=MR=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 034BAC00449
	for <linux-bluetooth@archiver.kernel.org>; Fri,  5 Oct 2018 09:15:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD89D208E7
	for <linux-bluetooth@archiver.kernel.org>; Fri,  5 Oct 2018 09:15:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD89D208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728509AbeJEQNY (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 5 Oct 2018 12:13:24 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:36930 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727809AbeJEQNY (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 5 Oct 2018 12:13:24 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id B9E558086B; Fri,  5 Oct 2018 11:15:30 +0200 (CEST)
Date:   Fri, 5 Oct 2018 11:15:30 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     Barry Byford <31baz66@gmail.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>
Subject: Re: low energy: does gatt client/server work in current version? How
 to test?
Message-ID: <20181005091530.GA17069@amd>
References: <20181001102430.GA6708@amd>
 <CAAu3APYAmr9M5NQkvqsG1-J_zn=Jiq4M18NYLx50WAAU3eb93w@mail.gmail.com>
 <CABBYNZ+R5M+gDyFZ6+fuJyXtNbvPiM7bh+BVeYQOn8oP9JJgSQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="DocE+STaALJfprDB"
Content-Disposition: inline
In-Reply-To: <CABBYNZ+R5M+gDyFZ6+fuJyXtNbvPiM7bh+BVeYQOn8oP9JJgSQ@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org


--DocE+STaALJfprDB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > > My attempt at launching server is below (using python gatt-server, (1)
> > > ). I was doing "hciconfig leadv 0" manually at some point.
> > >
> > > Using hciconfig while bluetoothd is running sounds kind-of
> > > dangerous. Stackoverflow (2) suggests using btmgmt (3) instead, and
> > > things got slightly different, but did not start to work for me. Is
> > > there documentation how to get this to work somewhere?
>=20
> Have a look at bluetoothctl first, all the necessary commands are
> there to enable to act as peripheral:

And indeed it does, and it does work when done this way.

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

Yes, that works, thanks.

As far as I understand, with bluetoothd running, neither btmgmt nor
hciconfig should be used. Unfortunately they are easy to find and
"seem" to work.

[bluetooth]# agent KeyboardDisplay
Agent is already registered
[bluetooth]# info FC:CE:56:3B:D1:6C
Device FC:CE:56:3B:D1:6C not available
[NEW] Device FC:CE:56:3B:D1:6C FC-CE-56-3B-D1-6C
[FC-CE-56-3B-D1-6C]# info FC:CE:56:3B:D1:6C
Device FC:CE:56:3B:D1:6C (random)
	Alias: FC-CE-56-3B-D1-6C
	Paired: no
	Trusted: no
	Blocked: no
	Connected: yes
	LegacyPairing: no
[FC-CE-56-3B-D1-6C]# pair FC:CE:56:3B:D1:6C
Attempting to pair with FC:CE:56:3B:D1:6C
Request passkey
[agent] Enter passkey (number in 0-999999): 000000
[FC-CE-56-3B-D1-6C]# info FC:CE:56:3B:D1:6C
Device FC:CE:56:3B:D1:6C (random)
	Alias: FC-CE-56-3B-D1-6C
	Paired: no
	Trusted: no
	Blocked: no
	Connected: yes
	LegacyPairing: no
[FC-CE-56-3B-D1-6C]# pair FC:CE:56:3B:D1:6C

If I retry the pairing, nothing happens:

[FC-CE-56-3B-D1-6C]# pair FC:CE:56:3B:D1:6C
Attempting to pair with FC:CE:56:3B:D1:6C

If I retry, it is busy:

[FC-CE-56-3B-D1-6C]# pair FC:CE:56:3B:D1:6C
Attempting to pair with FC:CE:56:3B:D1:6C
Failed to pair: org.bluez.Error.InProgress
Failed to pair: org.freedesktop.DBus.Error.NoReply
Failed to pair: org.freedesktop.DBus.Error.NoReply

I tried power cycling the device, re-connect and re-pair.

[CHG] Device FC:CE:56:3B:D1:6C Connected: no
[bluetooth]#
[CHG] Device FC:CE:56:3B:D1:6C Connected: no
[CHG] Device FC:CE:56:3B:D1:6C Connected: yes
[FC-CE-56-3B-D1-6C]# pair FC:CE:56:3B:D1:6C
Attempting to pair with FC:CE:56:3B:D1:6C
[FC-CE-56-3B-D1-6C]# info FC:CE:56:3B:D1:6C
Device FC:CE:56:3B:D1:6C (random)
	Alias: FC-CE-56-3B-D1-6C
	Paired: no
	Trusted: no
	Blocked: no
	Connected: yes
	LegacyPairing: no
[FC-CE-56-3B-D1-6C]# pair FC:CE:56:3B:D1:6C
Attempting to pair with FC:CE:56:3B:D1:6C
Failed to pair: org.bluez.Error.InProgress
[FC-CE-56-3B-D1-6C]#=20

Which does not work :-(.

Best regards,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--DocE+STaALJfprDB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlu3K7IACgkQMOfwapXb+vLj5ACbBFWsjfDtgjQlASjK5PVjgcK4
PuUAoICb5ls0h6JTkY+hLEnxN7zfpxKR
=soPp
-----END PGP SIGNATURE-----

--DocE+STaALJfprDB--
