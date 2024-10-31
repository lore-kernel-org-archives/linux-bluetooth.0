Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F4FA1C2DA4
	for <linux-bluetooth@vger.kernel.org>; Thu, 31 Oct 2024 21:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730409062; cv=none; b=IfPHBtSITgrkDyJDbjlwpNu1YF+J2rwPPhafdRPfsGYWMSIrNRacDk4ttu+Cco6BCmaUwYrb4aXwzXh1zm2fb96BNfxnBJ949uLbxW2EYcCjmqTLCxktIa99icVOC1aY1ah8KzxTzlyZshRrlRSHtJU3dnOOsRvEm04jwilR5NE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730409062; c=relaxed/simple;
	bh=jE0MEM+lSKoKms0s4FHuIha24ipwszopeDBoFHp6SCk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Za586oTGyENYjrL7hGmHxLa3BgyjRcAlRSSCsRFOFfIPIocg+A+y1nLt/8h7xVH6NjKZvcB2gd0oU5LnYpoQ+dKYkY9DRbLtCKg4iigj4vIjabTZhBRJjBTGCjFXnusws1v1e8tsEqTT88S9LVFeBsvYsx8QoT17BvLuUPuYEmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MDeBYQyE; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MDeBYQyE"
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2fb4af0b6beso22451461fa.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 31 Oct 2024 14:10:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730409054; x=1731013854; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tnFOMCgCCUqVz/e3xfGSZ4WxhltUSIfjmzBBDVRplpE=;
        b=MDeBYQyEStPpYUMkKbrIcxoSwvQX9EBzx7kpp1GlUOPGL/LbdrVUehD7PGrxdDeG+g
         kQF4hjlhdXhjnXz9KWJS40Te34r9tqJcRYSHtdW8v/U0WXCvFnKpPMUw59C4hJh6lZR3
         8UnXsFNR5SAKP1mSOWzDUz5Qlhdk1vQxTU5yZQ4WdZceEEzq3Cc9kXR+yTDvYUocES0J
         WQj7/qIvJM+2Tm+BNCuPSslYaoVGDGMUlWA4vcAdHFmVj33HY3hT5rnSWan+broZ9Jip
         68eMSWEdxB9OJCnafIo3/DBVIfA4BxTwzkBhtjMWrFbiNjQ53WQcyq/3XwsDTWLPh/jv
         UMwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730409054; x=1731013854;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tnFOMCgCCUqVz/e3xfGSZ4WxhltUSIfjmzBBDVRplpE=;
        b=dAGyJIjrigk7k5Irq+S6rhojHTPJWIIQcyqXopulci+ibdQHh+XvNBBhjQ3HvTkhTx
         rMucac6SoELo5kg+TQePHeCcsz89UeEUVb7R95uWNgDTtdm/5vfNdtAX/oHYTtOEnntI
         MfkzBRBJWke7FKGJ4BsP0xprS8OoRWAiH2P/EeWQb9vkK4imXR0OK96gQ4DYuu6OvOdt
         dlGUn2+TlZRfmFoHO9hxmhpJq+t9RMlt2foJetGChQi6u9AHWbD24xK9ix88W71TvGcR
         ivyyFyvSbjjX/KOD/fCieqECZu84thI68bcufSGh0PjYkDOB+McxrxjBvLMBpJ5l9lbB
         kpgg==
X-Gm-Message-State: AOJu0Yxm+o0AunSYq4ljFL4HwFtgzR28U4z2LWcG7tGP/v2j44zLz4AY
	vA+M1NLDP+qH5pmrUlBWph7MHm+iNg7o6wDq+vL7Xt+DqyQqqBwGjJCVZwL5fIRYsY9koJ6Vgw0
	IKDNazfos1PX2shP4Sd4iirn/aqQ=
X-Google-Smtp-Source: AGHT+IGY9QpIP4NQ43NM+e7tHnWauXLU+7JARFU3yYt5O5VwrwkWyGchEITiHq6OJnNp9L2W9Y1dj888lwTldnPRew8=
X-Received: by 2002:a05:651c:2123:b0:2fa:c0c2:d311 with SMTP id
 38308e7fff4ca-2fedb794b2dmr11939761fa.5.1730409054120; Thu, 31 Oct 2024
 14:10:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241031120259.Bluez.v1.1.Ia122d85386d6c2fc69f5b3d7ea7a7169f73756e4@changeid>
In-Reply-To: <20241031120259.Bluez.v1.1.Ia122d85386d6c2fc69f5b3d7ea7a7169f73756e4@changeid>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 31 Oct 2024 17:10:42 -0400
Message-ID: <CABBYNZJD57tZQy=Frm701bO5S8LKre-6Rr2Ha85PF-zbYiDA-Q@mail.gmail.com>
Subject: Re: [Bluez PATCH v1] textfile: Fix possible bad memory access in find_key
To: Howard Chung <howardchung@google.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Howard,

On Thu, Oct 31, 2024 at 12:04=E2=80=AFAM Howard Chung <howardchung@google.c=
om> wrote:
>
> From: Yun-Hao Chung <howardchung@google.com>
>
> If the searched key is a prefix of the first key in the textfile,
> the code will assume it's not the first line which is wrong.

We might want to include a backtrace if there is one.

> ---
> This is reproduced by fuzzer: https://issues.oss-fuzz.com/issues/42515619
>
>  src/textfile.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/src/textfile.c b/src/textfile.c
> index 313098f38..8188d2ebe 100644
> --- a/src/textfile.c
> +++ b/src/textfile.c
> @@ -127,10 +127,10 @@ static inline char *find_key(char *map, size_t size=
, const char *key, size_t len
>         while (ptrlen > len + 1) {
>                 int cmp =3D (icase) ? strncasecmp(ptr, key, len) : strncm=
p(ptr, key, len);
>                 if (cmp =3D=3D 0) {
> -                       if (ptr =3D=3D map && *(ptr + len) =3D=3D ' ')
> -                               return ptr;
> -
> -                       if ((*(ptr - 1) =3D=3D '\r' || *(ptr - 1) =3D=3D =
'\n') &&
> +                       if (ptr =3D=3D map) {
> +                               if (*(ptr + len) =3D=3D ' ')
> +                                       return ptr;
> +                       } else if ((*(ptr - 1) =3D=3D '\r' || *(ptr - 1) =
=3D=3D '\n') &&
>                                                         *(ptr + len) =3D=
=3D ' ')
>                                 return ptr;
>                 }
> --
> 2.47.0.163.g1226f6d8fa-goog
>


--=20
Luiz Augusto von Dentz
