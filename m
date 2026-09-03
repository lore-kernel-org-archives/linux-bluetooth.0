Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A433E429818
	for <linux-bluetooth@vger.kernel.org>; Thu,  3 Sep 2026 08:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788423561; cv=none; b=nR6CSlltcYC6ZFpFB4xWYBlPwWEQIp8cnrbIEkbOBqejyHzALFhUZmCl6OAauxucLmNNTUKdxYce9oxzFGnWKUQ4TybqOWZMVcvJGeu+SC8I9x8mPs6ZslylBCBNEXVHMoL7cE0FJ1sAPv3EcRgsIOqMARzOO9H7JBlCKsQZzdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788423561; c=relaxed/simple;
	bh=/cQg6aP71U2dSKBSDUph3rsQWGZfyuy4E3jBAnzYzR8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jcjZ9xFBHhrmytkVqZH1KPj+iczXRwSqgZJC9VPRrGop9/WMLUHIInMvKYIE0EbFl50E863nw2OCixUlIPayAE140imoyo9bNC4AL4RNcWgfIfhkapMrrPU/bwulTwnyyTVP5IRsp7DrW4YTbhX6EMp6QljH83GJs1vsvKYpTaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id 25DD73E97F;
	Thu,  3 Sep 2026 08:19:16 +0000 (UTC)
Message-ID: <1654183666f442926c1301e1733567216b307981.camel@hadess.net>
Subject: Re: [BlueZ PATCH 2/3] profiles/audio: Support MCS track position
 writes
From: Bastien Nocera <hadess@hadess.net>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>, raghu447
	 <raghavendra.rao@collabora.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Thu, 03 Sep 2026 10:19:15 +0200
In-Reply-To: <CABBYNZL=tUS6mW6FtKu2=BPqLqb6+CP6FE-S7LWLntPauxus2w@mail.gmail.com>
References: <20260831061144.7767-1-raghavendra.rao@collabora.com>
	 <20260831061144.7767-3-raghavendra.rao@collabora.com>
	 <CABBYNZL=tUS6mW6FtKu2=BPqLqb6+CP6FE-S7LWLntPauxus2w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44) 
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-GND-Sasl: hadess@hadess.net
X-GND-Score: -100
X-GND-Cause: dmFkZTGy/wP8aDPXnQAoWv4T5WNYQ5ZHiS4oNHNAdF4IiSOc+ZWtAk0EBy8VX5FhiilOTHvqmLksGGXNCJSjKX2WZdeWzjxCc6/QY+Xg4cNUrjfGITrPtS56gQjv6rxNQjreBjWosteI/wC2XqFy7OQOITrdWD4UmILhPL/+8VPmcVFLd7iofIIegp497qKOUSzS3dOlNLNLCEDLj8ZnoWjiUkyrdug6F46m9hgcjsr0gbvveSrpQ0KDClHds+F/fYpd8Z18pSSKhaFQQxP9CnSpg9Xl7FV5NYttWOjdm5xONoIdP4bBCqTd984MY5hUa+RxJ33wD3x4v5Mssr6Vn2ZAHq8bNWVdMtg0NfsFoHewJjAreTDe3l5iloUsGUmYyuaG67islvqgSg08TLuyX+3xJgEgd3pxUcRNx2tODgml59A0CinaAIrD9P17syUL4XCrhDUSDSUFJojFZIUtzURlbjG0U7V4vNDkvbHh1FTk1Qhi29jor15V10bnMlwAKIISFfD0Q053sz9Giomz3d7AZQkYzm8UyvDHSlbZc5yBHdATFCAXqdDia/PfK6Jux55Yom/111RrI2bZWCeOsvSTFKgxsdSddn6aYyxezwM5k2NmEz1e8lUEgnlpn4LdOgbzUCPrGYgEk3SKW2Vq339LDuL1yeimyFcSBVZ1/lDH8YZiRA
X-GND-State: clean

On Wed, 2026-09-02 at 11:35 -0400, Luiz Augusto von Dentz wrote:
> Hi Raghu,
>=20
> On Mon, Aug 31, 2026 at 2:13=E2=80=AFAM raghu447
> <raghavendra.rao@collabora.com> wrote:
> >=20
> > From: raghavendra <raghavendra.rao@collabora.com>
> >=20
> > This is needed to Pass PTS GMCS/SR/SP/BV-02-C test.
> > ---
> > =C2=A0profiles/audio/mcp.c | 20 ++++++++++++++++++--
> > =C2=A01 file changed, 18 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/profiles/audio/mcp.c b/profiles/audio/mcp.c
> > index 4df388a22..fc9d2dc73 100644
> > --- a/profiles/audio/mcp.c
> > +++ b/profiles/audio/mcp.c
> > @@ -835,8 +835,24 @@ static uint16_t
> > mcs_playing_order_supported(void *data)
> >=20
> > =C2=A0static bool mcs_set_track_position(void *data, int32_t value)
> > =C2=A0{
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* TODO: add support to setting p=
osition in
> > org.bluez.MediaPlayer */
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return false;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct mcs_instance *mcs =3D data=
;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct player_link *p =3D mcs_get=
_active(mcs);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int64_t position =3D value;
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!p)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 return false;
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (value < 0) {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 int32_t duration =3D mcs_track_duration(mcs);
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 if (duration =3D=3D BT_MCS_DURATION_UNAVAILABLE)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return fals=
e;
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 position +=3D duration;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>=20
> Are the seek and position values in different units? We should
> probably document why we are having to multiply it bellow.

I'd recommend using variable names like
"position_msec/position_usec/etc." and declaring constants for things
like converting between what the hardware uses and the code uses, like
glib's G_USEC_PER_SEC.

Cheers

>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return local_player_seek(p->lp, (=
position * 10 -
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 local_player_get_position(p->lp)) *
> > 1000);
> > =C2=A0}
> >=20
> > =C2=A0static bool mcs_set_playing_order(void *data, uint8_t value)
> >=20
>=20
