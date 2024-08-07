Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 010DF74E09
	for <linux-bluetooth@vger.kernel.org>; Wed,  7 Aug 2024 15:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723044940; cv=none; b=kCR9VrPAkkYfxSiP9Wt0qgdavjzsbPfOWyXF6X8XQWHvBf1fe1oc8G+73vwEeBE0tw8fmF2pbeuybvEj2LbLtLJvKlcyiVHlk9okiiLk33YPoDr5atrKMi+PJpqL8SXEBwuYExqdyqSXl6aW7rARtUZ8ZhYCRIlS7Pt0KSuZVao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723044940; c=relaxed/simple;
	bh=DEBfnioy1SVl3ULKUhZOxM+iY1PAsqsihivKzQ5glsQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CknlOCFocHRaZM1QNpLBuvRBLvSfFjN4z9syu9FEe/YiRb0m8JHfDiDwJFL5hl7BbAbBU2xKvb2M1vPyOW+ggvB+DWPlTiZOEVRlnmiN0rj5j//0Mb6ivQCfF+sY/Z9UQiq8JydTosk+TlbzFGgMZwBlsUe9SiPainaghoSmdU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id 14D6DFF809;
	Wed,  7 Aug 2024 15:35:35 +0000 (UTC)
Message-ID: <0d5041dcd25e97775843db69cfc2e20be127f32f.camel@hadess.net>
Subject: Re: [BlueZ 1/8] sdp: Ensure size doesn't overflow
From: Bastien Nocera <hadess@hadess.net>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Wed, 07 Aug 2024 17:35:35 +0200
In-Reply-To: <CABBYNZKVOpfAdsaCy4+ZS3v8KFwG8O0j2ZZJ7Fryx4JS+bnrWA@mail.gmail.com>
References: <20240805140840.1606239-1-hadess@hadess.net>
	 <20240805140840.1606239-2-hadess@hadess.net>
	 <CABBYNZKVOpfAdsaCy4+ZS3v8KFwG8O0j2ZZJ7Fryx4JS+bnrWA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-GND-Sasl: hadess@hadess.net

On Tue, 2024-08-06 at 14:38 -0400, Luiz Augusto von Dentz wrote:
> Hi Bastien,
>=20
> On Mon, Aug 5, 2024 at 10:09=E2=80=AFAM Bastien Nocera <hadess@hadess.net=
>
> wrote:
> >=20
> > Error: INTEGER_OVERFLOW (CWE-190): [#def1] [important]
> > bluez-5.77/lib/sdp.c:1685:2: tainted_data_argument: The check "sent
> > < size" contains the tainted expression "sent" which causes "size"
> > to be considered tainted.
> > bluez-5.77/lib/sdp.c:1686:3: overflow: The expression "size - sent"
> > is deemed overflowed because at least one of its arguments has
> > overflowed.
> > bluez-5.77/lib/sdp.c:1686:3: overflow_sink: "size - sent", which
> > might have underflowed, is passed to "send(session->sock, buf +
> > sent, size - sent, 0)".
> > 1684|
> > 1685|=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 while=
 (sent < size) {
> > 1686|->=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int n =3D send(session->sock, buf + sent,
> > size - sent, 0);
> > 1687|=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (n < 0)
> > 1688|=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 return -1;
> > ---
> > =C2=A0lib/sdp.c | 6 +++---
> > =C2=A01 file changed, 3 insertions(+), 3 deletions(-)
> >=20
> > diff --git a/lib/sdp.c b/lib/sdp.c
> > index 411a95b8a7d3..8a15ad803db1 100644
> > --- a/lib/sdp.c
> > +++ b/lib/sdp.c
> > @@ -1678,13 +1678,13 @@ sdp_data_t *sdp_data_get(const sdp_record_t
> > *rec, uint16_t attrId)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return NULL;
> > =C2=A0}
> >=20
> > -static int sdp_send_req(sdp_session_t *session, uint8_t *buf,
> > uint32_t size)
> > +static int sdp_send_req(sdp_session_t *session, uint8_t *buf,
> > size_t size)
> > =C2=A0{
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uint32_t sent =3D 0;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 size_t sent =3D 0;
> >=20
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 while (sent < size) {
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 int n =3D send(session->sock, buf + sent, size -
> > sent, 0);
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 if (n < 0)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 if (n < 0 || sent > SIZE_MAX - n)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 retur=
n -1;
>=20
> Not really following you here, it seems the problem is that sent + n
> could overflow causing sent to loop around but if that happens don't
> we get a problem with send syscall itself? Using size_t makes sense
> but I guess we want n to also be ssize_t then, and perhap use if (n <
> 0 || n > size - sent) logic if we cannot trust syscalls returns the
> correct number of bytes.

I don't think that the static analysis is this clever, it just wants to
make sure that bounds checking is done to avoid integer overflows.

I'm fine with quieting Coverity on my end, after fixing the data types
if that's alright with you.

Also goes for patch 8 of this series.

>=20
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 sent +=3D n;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> > --
> > 2.45.2
> >=20
> >=20
>=20
>=20

