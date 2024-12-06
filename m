Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65C421B4F08
	for <linux-bluetooth@vger.kernel.org>; Fri,  6 Dec 2024 09:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733478411; cv=none; b=pMlnllUx+o2sQzi19TDE+8Dmz5G9cBxFU3Px1yyMbmNz13o+iYf9HOh2rdXmNtRnoQOopW7c3v8AxhXRfbt/D9u5C4kX0YauiKlvEZf8KLOl7VrArCdI3Blo5tgo0AV7K2xfZLcZ+WTpnwFafB/v4Demqapu/zTfNyMuthNAo5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733478411; c=relaxed/simple;
	bh=sDYexEphELghwPY2Xk+P7bN9MqZsroGF4TTQ5evDmFc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kX6Blq8PnH2F0iLJJMYrqifwCb25lqmfiolbvTVrPUD7Fj1RIHHE5/vmrdpF+DYD+NAi5b1kxb/UGgBUyTjpYri1xUMmlAku6gK7fxt7N7Brcym1mgYhUWAnLAjadYXTsZl0wo78nKqbsSVv0dLmRnpmP5xEW2G0G8MLBJ2UbC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id 75264FF809;
	Fri,  6 Dec 2024 09:46:40 +0000 (UTC)
Message-ID: <d37768fdcd33092f0bcbb4e4e417ccb6b9a1a2f8.camel@hadess.net>
Subject: Re: [PATCH BlueZ] Leave config files writable for owner
From: Bastien Nocera <hadess@hadess.net>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>, Fiona Klute
	 <fiona.klute@gmx.de>
Cc: linux-bluetooth@vger.kernel.org, Emil Velikov
 <emil.velikov@collabora.com>
Date: Fri, 06 Dec 2024 10:46:40 +0100
In-Reply-To: <CABBYNZJE_zK-enNFyHG4-8dCksj3TxAZRQZ4Q+OxibksnSKoZg@mail.gmail.com>
References: <20241205133233.1738092-1-fiona.klute@gmx.de>
	 <CABBYNZJE_zK-enNFyHG4-8dCksj3TxAZRQZ4Q+OxibksnSKoZg@mail.gmail.com>
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

On Thu, 2024-12-05 at 10:00 -0500, Luiz Augusto von Dentz wrote:
> Hi Bastian, Emil,
>=20
> On Thu, Dec 5, 2024 at 8:35=E2=80=AFAM Fiona Klute <fiona.klute@gmx.de>
> wrote:
> >=20
> > This is needed both so the owner can adjust config as needed, and
> > for
> > distribution builds to be able to move/delete files as part of the
> > build without adjusting permissions themselves. Limiting writes
> > from
> > the running service needs to be done in the systemd unit (already
> > the
> > case) or init script.
> >=20
> > See also:
> > https://lore.kernel.org/linux-bluetooth/4d1206df-598b-4a68-8655-74981b6=
2ecca@gmx.de/T/
> > ---
> > =C2=A0Makefile.am | 2 +-
> > =C2=A01 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/Makefile.am b/Makefile.am
> > index 297d0774c..29018a91c 100644
> > --- a/Makefile.am
> > +++ b/Makefile.am
> > @@ -32,7 +32,7 @@ confdir =3D $(sysconfdir)/bluetooth
> > =C2=A0statedir =3D $(localstatedir)/lib/bluetooth
> >=20
> > =C2=A0bluetoothd-fix-permissions:
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 install -dm555 $(DESTDIR)$(confdi=
r)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 install -dm755 $(DESTDIR)$(confdi=
r)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 install -dm700 $(DESTDIR)$(s=
tatedir)
> >=20
> > =C2=A0if DATAFILES
> > --
> > 2.45.2
>=20
> Any comments regarding these changes, shall we also use 0755 in the
> systemd service?

That's fine, although the changes are really academic, as root/the
owner can write and move those files just fine, even without explicit
write permissions.

The point made about the stopping the running daemon from writing to
/etc is on point though, which could be fixed by something like:
diff --git a/src/bluetooth.service.in b/src/bluetooth.service.in
index 8ebe89bec682..ddaa9d444eed 100644
--- a/src/bluetooth.service.in
+++ b/src/bluetooth.service.in
@@ -15,7 +15,7 @@ LimitNPROC=3D1
=20
 # Filesystem lockdown
 ProtectHome=3Dtrue
-ProtectSystem=3Dstrict
+ProtectSystem=3Dfull
 PrivateTmp=3Dtrue
 ProtectKernelTunables=3Dtrue
 ProtectControlGroups=3Dtrue

See
https://www.freedesktop.org/software/systemd/man/latest/systemd.exec.html#P=
rotectSystem=3D

Cheers
