Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4053583CD6
	for <linux-bluetooth@vger.kernel.org>; Wed,  7 Aug 2024 15:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723045882; cv=none; b=tteDfJH/OTJWN3X87q8kfsdAJi5Qp2ayUEwH4PTCQrs57kvC4neSNv6ApZJhvV9R+FvP8C0Hx8lMKCYJo4MfGqTVFeU0E1EfWPrzqFMfI/KYRpHH3/6/fcS9n8C9W2AT9u0qptDczmY5LHOrqRMj8U6tXYWF3XQ+X9Ud1P6MoIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723045882; c=relaxed/simple;
	bh=V4E+rmy0PtxBkgmeD9Wfzk70ERMgiK9ODTujs/QkN8U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O07v5pqHA7FN0o+mN1+JftZQYtF/3I5nnElfeUv66IIURk/Z09woOJtekpICPrjD+40E28cjNkyiLN9qOpXxB0aWK3up9RfrnDUU14YpsOnw7UJotBhBjAqenQ27T7drGE3yrGk5Gyo06PYfPeh0bF0KDlMm/Qij0gupPChBpUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c5plHpVi; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c5plHpVi"
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2f029e9c9cfso29511211fa.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 07 Aug 2024 08:51:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723045878; x=1723650678; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZIW5BxIbtrE+/wthEjnA55FgDpYFa3d2nGGufayyXy8=;
        b=c5plHpViRhmIXPjwZWg2otQdR0FMddog8gOfA6xYLkSI9zSImZoQKyLGULsfxVy/As
         BEXR8GFAztPaNE6oaIgD1lyvVKMqjCJDMHtN6Tks7xPBs9NOP318zD0lCNCJ5PWYxzF7
         5HRU6hgjPJcNXmkR8oxFwf+yAN5Y+eDQbmmiEh9GQZEkYwrXRZfVH9Ga+LNyhGMosrYL
         TCdCjDs/3uF1bH8P29rBT9yRvFsAp/jwMgCITrRcrpSjBbu0nA5QcFlyrz7kk7jhoMrI
         r+nlQrc9Tr/EfJ6MX//vwzmWUZtgoqnuvn/cRbwDey/IgK0MFqyV9XQ4qpJ/ZXz3Y0Ze
         MVXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723045878; x=1723650678;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZIW5BxIbtrE+/wthEjnA55FgDpYFa3d2nGGufayyXy8=;
        b=Ytn4cem2a88zyIPAl1/MgieJQRae70dDtjtoqYHZQyedLUpQoDFx/xsAggese1BeuC
         RhYbdtYpaImc594sTKyWvPoejrymoYpwnaQHS+xmwYY6kQuRBVIUw2fQIk3ZCFb97p1W
         +sOBhhdWtDMWSyUO9aC4ylS0CwtYJKi2TRpmA5KKyh/r/FVVztRyOmaTS2e2BbpibtWR
         2B/HJGW/q9rT8qbVkVi6NjGlEANnMIAsFupdM0efzcB2N0r8Tn0Rvdp0/qwg6ZQ/pGZh
         h1ja/QrQztktx1maADCTX9Exka2tF/ATuW4MxpzcMyX6KtKR8PqHDSSQB9VO411gl0kU
         pexw==
X-Gm-Message-State: AOJu0YxVLNMLo63qID+Bsb0Q93tRKy5113zGXanNLajFx9cNWoNuvQSN
	ed/H87AQaa6l/pByOTbUWwX9EbXuQbrZf/jJWbfcFKsjP2ZkLpPrYPrqlBRL6YD2CaUn0hhFiJH
	3nfS6wMTfIT+MRF/YoKbMthfgZeXE/jw/
X-Google-Smtp-Source: AGHT+IH8Z0UQ8tLEDpbiY5CixRC/s862ZbukxSt3Y3Yh6wIz9QZiXxNKXtcoYcokwFvCyxaCxgWH1KcJ8xQ0BJJXtl8=
X-Received: by 2002:a2e:884a:0:b0:2ec:4093:ec7 with SMTP id
 38308e7fff4ca-2f15ab29329mr151331651fa.30.1723045877868; Wed, 07 Aug 2024
 08:51:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240805140840.1606239-1-hadess@hadess.net> <20240805140840.1606239-7-hadess@hadess.net>
 <CABBYNZLeuUw5nO-nw65nccSCKXcf-KLMxqDfPTObk-S3NP+tTQ@mail.gmail.com> <a86fa1676c72005cd77faabf65f9553242ea7a45.camel@hadess.net>
In-Reply-To: <a86fa1676c72005cd77faabf65f9553242ea7a45.camel@hadess.net>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 7 Aug 2024 11:51:05 -0400
Message-ID: <CABBYNZLQn+2pNQOQXmm_MZ_v1JnyeHENmo7UeybiF7GcpWvSdQ@mail.gmail.com>
Subject: Re: [BlueZ 6/8] shared/gatt-db: Fix possible buffer overrun
To: Bastien Nocera <hadess@hadess.net>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Bastien,

On Wed, Aug 7, 2024 at 11:39=E2=80=AFAM Bastien Nocera <hadess@hadess.net> =
wrote:
>
> On Tue, 2024-08-06 at 15:08 -0400, Luiz Augusto von Dentz wrote:
> > Hi Bastien,
> >
> > On Mon, Aug 5, 2024 at 10:09=E2=80=AFAM Bastien Nocera <hadess@hadess.n=
et>
> > wrote:
> > >
> > > uuid_to_le() returns one of the possible values from bt_uuid_len().
> > > bt_uuid_len() returns "type / 8".
> > > type is a value between 0 and 128, but could be something else
> > > depending on the validity of the UUID that's parsed. So an invalid
> > > value of type between 128 and 256 would trigger an overrun.
> > >
> > > Add a check to make sure that an invalid type isn't used to
> > > calculate
> > > the length.
> > >
> > > Error: OVERRUN (CWE-119): [#def6] [important]
> > > bluez-5.77/src/shared/gatt-db.c:612:2: assignment: Assigning: "len"
> > > =3D "uuid_to_le(uuid, value)". The value of "len" is now between 0
> > > and 31 (inclusive).
> > > bluez-5.77/src/shared/gatt-db.c:614:2: overrun-buffer-arg:
> > > Overrunning array "value" of 16 bytes by passing it to a function
> > > which accesses it at byte offset 30 using argument "len" (which
> > > evaluates to 31).
> > > 612|    len =3D uuid_to_le(uuid, value);
> > > 613|
> > > 614|->  service->attributes[0] =3D new_attribute(service, handle,
> > > type, value,
> > > 615|
> > >      len);
> > > 616|    if (!service->attributes[0]) {
> > > ---
> > >  src/shared/gatt-db.c | 11 ++++++++---
> > >  1 file changed, 8 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/src/shared/gatt-db.c b/src/shared/gatt-db.c
> > > index b35763410d17..cd0eba6bf1d0 100644
> > > --- a/src/shared/gatt-db.c
> > > +++ b/src/shared/gatt-db.c
> > > @@ -560,9 +560,14 @@ static int uuid_to_le(const bt_uuid_t *uuid,
> > > uint8_t *dst)
> > >                 return bt_uuid_len(uuid);
> > >         }
> > >
> > > -       bt_uuid_to_uuid128(uuid, &uuid128);
> > > -       bswap_128(&uuid128.value.u128, dst);
> > > -       return bt_uuid_len(&uuid128);
> > > +       if (uuid->type =3D=3D BT_UUID32 ||
> >
> > BT_UUID32 is not really valid in LE, so Id leave this check to be:
> >
> > switch (uuid->type) {
> > case BT_UUID16:
> >         put_le16(uuid->value.u16, dst);
> >         return bt_uuid_len(uuid);
> > case BT_UUID128:
> >          bt_uuid_to_uuid128(uuid, &uuid128);
> >          bswap_128(&uuid128.value.u128, dst);
> >          return bt_uuid_len(&uuid128);
> > }
> >
> > return 0;
> >
> > We do however have bt_uuid_to_le with the only difference being that
> > it is more generic and it doesn't return the actual bytes written to
> > the dst, anyway we could replace the code above with:
> >
> > diff --git a/src/shared/gatt-db.c b/src/shared/gatt-db.c
> > index b35763410d17..71976de48569 100644
> > --- a/src/shared/gatt-db.c
> > +++ b/src/shared/gatt-db.c
> > @@ -553,16 +553,9 @@ bool gatt_db_isempty(struct gatt_db *db)
> >
> >  static int uuid_to_le(const bt_uuid_t *uuid, uint8_t *dst)
> >  {
> > -       bt_uuid_t uuid128;
> > +       bt_uuid_to_le(uuid, dst);
> >
> > -       if (uuid->type =3D=3D BT_UUID16) {
> > -               put_le16(uuid->value.u16, dst);
> > -               return bt_uuid_len(uuid);
> > -       }
> > -
> > -       bt_uuid_to_uuid128(uuid, &uuid128);
> > -       bswap_128(&uuid128.value.u128, dst);
> > -       return bt_uuid_len(&uuid128);
> > +       return bt_uuid_len(uuid) =3D=3D 4 ? 16 : bt_uuid_len(uuid);
>
> Or this with error checking?
>
> static int uuid_to_le(const bt_uuid_t *uuid, uint8_t *dst)
> {
>         if (bt_uuid_to_le(uuid, dst) < 0)
>                 return 0;
>         return bt_uuid_len(uuid) =3D=3D 4 ? 16 : bt_uuid_len(uuid);
> }

Yep, we should check the return of bt_uuid_to_le.

> >  }
> >
> >
> > > +           uuid->type =3D=3D BT_UUID128) {
> > > +               bt_uuid_to_uuid128(uuid, &uuid128);
> > > +               bswap_128(&uuid128.value.u128, dst);
> > > +               return bt_uuid_len(&uuid128);
> > > +       }
> > > +
> > > +       return 0;
> > >  }
> > >
> > >  static bool le_to_uuid(const uint8_t *src, size_t len, bt_uuid_t
> > > *uuid)
> > > --
> > > 2.45.2
> > >
> > >
> >
> >
>


--=20
Luiz Augusto von Dentz
