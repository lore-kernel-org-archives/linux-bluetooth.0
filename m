Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B78CC823D1
	for <linux-bluetooth@vger.kernel.org>; Sat,  7 Dec 2024 11:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733571301; cv=none; b=fkJKN2YDH29etT7aMgs0Lct3LG7awIXYwUDoIkBL0PPVlUuVs+zVum9KnhDKlKhOwI9lGVtdOP0StLATiNscEjpeX7m4P0B/+Z71d65k3qnMVzacMmecSmxgXyRcPZ6hn9BoR04jNhc52xggH4ba145kibKgvsvsHixoODhp6bI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733571301; c=relaxed/simple;
	bh=eiGT7zHHee/X42S2kAG8infSNWcxtCx4MLqq1hwk/v4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kYqAOlkFgcrnt4BK0UIsrZscnw24wz8y9PX3jkPPH8EDOoC/YN01FdSD8/o7kRG9068vHFicTUbsbaVom1KsqPdIH3JANkCDT8LQPMa3/pjZmDTLm71w9e9aC4CUXhZZ9elJH/ecWZle/GBgUB14yCCQ/1APLdbsnKrPwwUBhUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id 422E0C0004;
	Sat,  7 Dec 2024 11:34:51 +0000 (UTC)
Message-ID: <a31b37122fa7db68ca381bb0836941d7a1d200ee.camel@hadess.net>
Subject: Re: [PATCH BlueZ] Leave config files writable for owner
From: Bastien Nocera <hadess@hadess.net>
To: Fiona Klute <fiona.klute@gmx.de>, Luiz Augusto von Dentz
	 <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Sat, 07 Dec 2024 12:34:50 +0100
In-Reply-To: <b6a7a2b6-fdb7-46b5-8990-86450c79949d@gmx.de>
References: <20241205133233.1738092-1-fiona.klute@gmx.de>
	 <CABBYNZJE_zK-enNFyHG4-8dCksj3TxAZRQZ4Q+OxibksnSKoZg@mail.gmail.com>
	 <d37768fdcd33092f0bcbb4e4e417ccb6b9a1a2f8.camel@hadess.net>
	 <b6a7a2b6-fdb7-46b5-8990-86450c79949d@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.2 (3.54.2-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-GND-Sasl: hadess@hadess.net

On Fri, 2024-12-06 at 12:53 +0100, Fiona Klute wrote:
> Am 06.12.24 um 10:46 schrieb Bastien Nocera:
> > On Thu, 2024-12-05 at 10:00 -0500, Luiz Augusto von Dentz wrote:
> > > Hi Bastian, Emil,
> > >=20
> > > On Thu, Dec 5, 2024 at 8:35=E2=80=AFAM Fiona Klute <fiona.klute@gmx.d=
e>
> > > wrote:
> > > >=20
> > > > This is needed both so the owner can adjust config as needed,
> > > > and
> > > > for
> > > > distribution builds to be able to move/delete files as part of
> > > > the
> > > > build without adjusting permissions themselves. Limiting writes
> > > > from
> > > > the running service needs to be done in the systemd unit
> > > > (already
> > > > the
> > > > case) or init script.
> > > >=20
> > > > See also:
> > > > https://lore.kernel.org/linux-bluetooth/4d1206df-598b-4a68-8655-749=
81b62ecca@gmx.de/T/
> > > > ---
> > > > =C2=A0=C2=A0Makefile.am | 2 +-
> > > > =C2=A0=C2=A01 file changed, 1 insertion(+), 1 deletion(-)
> > > >=20
> > > > diff --git a/Makefile.am b/Makefile.am
> > > > index 297d0774c..29018a91c 100644
> > > > --- a/Makefile.am
> > > > +++ b/Makefile.am
> > > > @@ -32,7 +32,7 @@ confdir =3D $(sysconfdir)/bluetooth
> > > > =C2=A0=C2=A0statedir =3D $(localstatedir)/lib/bluetooth
> > > >=20
> > > > =C2=A0=C2=A0bluetoothd-fix-permissions:
> > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 install -dm555 $(DESTDIR)$(co=
nfdir)
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 install -dm755 $(DESTDIR)$(co=
nfdir)
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 install -dm700 $(D=
ESTDIR)$(statedir)
> > > >=20
> > > > =C2=A0=C2=A0if DATAFILES
> > > > --
> > > > 2.45.2
> > >=20
> > > Any comments regarding these changes, shall we also use 0755 in
> > > the
> > > systemd service?
> >=20
> > That's fine, although the changes are really academic, as root/the
> > owner can write and move those files just fine, even without
> > explicit
> > write permissions.
>=20
> With chmod, yes. A build process that expects created directories to
> be
> writable for the user running the build fails. Sure, it'd be possible
> to
> add a workaround, but it's better to fix the issue at the source.

Please mention in the commit message that this is to fix problems with
build systems that run as non-root.

> > The point made about the stopping the running daemon from writing
> > to
> > /etc is on point though, which could be fixed by something like:
> > diff --git a/src/bluetooth.service.in b/src/bluetooth.service.in
> > index 8ebe89bec682..ddaa9d444eed 100644
> > --- a/src/bluetooth.service.in
> > +++ b/src/bluetooth.service.in
> > @@ -15,7 +15,7 @@ LimitNPROC=3D1
> >=20
> > =C2=A0 # Filesystem lockdown
> > =C2=A0 ProtectHome=3Dtrue
> > -ProtectSystem=3Dstrict
> > +ProtectSystem=3Dfull
> > =C2=A0 PrivateTmp=3Dtrue
> > =C2=A0 ProtectKernelTunables=3Dtrue
> > =C2=A0 ProtectControlGroups=3Dtrue
> >=20
> > See
> > https://www.freedesktop.org/software/systemd/man/latest/systemd.exec.ht=
ml#ProtectSystem=3D
> As I understand the documentation there "strict" implies "full":
>=20
> > If true, mounts the /usr/ and the boot loader directories (/boot
> > and /efi) read-only for processes invoked by this unit. If set to
> > "full", the /etc/ directory is mounted read-only, too. If set to
> > "strict" the entire file system hierarchy is mounted read-only,
> > except for the API file system subtrees /dev/, /proc/ and /sys/
> > (protect these directories using PrivateDevices=3D,
> > ProtectKernelTunables=3D, ProtectControlGroups=3D).
>=20
> So switching from strict to full would actually weaken protection,
> though /etc should be read-only either way.

Right, I had that backwards.
