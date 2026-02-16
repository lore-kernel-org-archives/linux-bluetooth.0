Received: from mail-yx1-f43.google.com (mail-yx1-f43.google.com [74.125.224.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A0363101D0
	for <linux-bluetooth@vger.kernel.org>; Mon, 16 Feb 2026 14:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771252969; cv=pass; b=RmpeR14CsVvSBxDXvD+NwiUOvYpJZ9H89P2LOYsc5EyTvoItgM0/vIxG+cAC7FZTj4/xtsRDQ1yrA/cXwWeGgA8UHedR/xQLTU8QLvzvF7MrzXIg0rTe8Sbf9MtvLaNxwjdrbwRg46AMMd+UaqamD6mLscuUCweKd43Ku1rHVs8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771252969; c=relaxed/simple;
	bh=XBkx+Le/VL5fOGobaeGgvww14fMl9gL739W43wtAqkU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QQ4mbNsDpntnrAGhtM02wYyGgf6ih9m+Ry4rxE13elqXleG1xuukMmt0eMsQjiBbLO/u33Ez0mb0uIMttVtZHJ5Fq8IlCZGq5bvJl5c7Sa1bHFQdnGh8NLpMXwMwQzyUZ1au7umP8vf+0qVK9h3BdKKBNm9ctqShzvB8Ihx9h1I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P9Iw1uQU; arc=pass smtp.client-ip=74.125.224.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P9Iw1uQU"
Received: by mail-yx1-f43.google.com with SMTP id 956f58d0204a3-649d4690174so2554940d50.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 16 Feb 2026 06:42:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771252967; cv=none;
        d=google.com; s=arc-20240605;
        b=F1pkupO4+dswap81Ku8GjYIsTjf1X4dw+irwEjlddpkZW04aoVkUqnnGPF82hvin37
         a7C4xHHKyM6p00A7OGTICe/tUzrYn0a/obDZT0veR0xPh4lvaIGBoo5oRIqaifi+jqH7
         IaepzbU1YC6yXjynrSna+eGz+pDqNQ/Bw5zfMqUY7VqB0d7M/9LTLPEZ1toWxBngzAf8
         1dX4hYOWrh9r+DQWj8Osd3+b2N665fjPmTTkK5MX22IL0pMRrcyEQln7g4f8XR0+GRii
         eGw+j/l29AflBTcC7bNkhiLYLAurwyeLHG6XvE+0A1ds0dmQSz54YgAILWuDbFPZpcK6
         P84Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=BNHOkvGbPVPUUble4hAoelysx2wePhbly6yMs8Q3jLg=;
        fh=fAVvqa29TMCSLQ1BWo+IkeTh9vOt2h2EvlnFWIq0DOI=;
        b=RYHHwbAqwMDnZpIGc3MQFb01jVX519QyMlR1OtnKrl5t4CziHzRw7hpZv07kWpTTfh
         opx5WAJ/iCKgoIp2WFAInTo+sj+dlurRFMHPrJpeNMjh8ODl42/WVhoAIDPUjv/mDOIE
         pCOsKEwQVI8yeeuFy9SM/M8gnx1LX/hC3P8LjGwnMtRhVxQFcSpa8Xmx2H0V5LghwDuk
         0ChFriIizyw9TJPIwQfzWWNXey6JGZ1unxBvsiYKA16cKvxCnYzPYN/FPeBfEuO18E+y
         gbi8xceUjQf0WFf3PL/0cc5XiBxi3m5WzJKBJ2tv1mH/nUOLsFWk9g0NcdWRwSqyywk/
         x5fg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771252967; x=1771857767; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BNHOkvGbPVPUUble4hAoelysx2wePhbly6yMs8Q3jLg=;
        b=P9Iw1uQUucpxp8lcO1B/87l0j73tyGkk6Cy6klY44XjOVg4cXSUpx6Rpd8qeyCY4lg
         8PTpG88ZtxJo8AWW6m9hL7tl4nBtM02hJAGicjVVjVk5Kxw7X+m9KfBzXGCNxEd9UByk
         06qL4rCXOZCpugiqNehfDozE90ddkWvBkY+PMGMBJs4cpqOMT61+8Gk9krZtNChN5bwS
         SBjWD0MH8a3qZmbSc81Eyt4K6Z2HcWTn7rxL4aqOUeW6UexyMTMR46DKucVnJr//dRz6
         kYomfYJgJwb++x1s4P24cOEEE6XE5RwmdS9N0xvYuCtKG8WHBRs3P1hvaXByIyycLtRd
         cnwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771252967; x=1771857767;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BNHOkvGbPVPUUble4hAoelysx2wePhbly6yMs8Q3jLg=;
        b=W0K0YNTtj45xoeo74j/aC5TINk5D3hMJfTl2P/pTEugLz37mepjW3N0SYs71WgVADu
         Z2pvxjj+d3iCSBFjQuNl5/gpHPGnZDnDtZRu6ElrixK9IMLkMOlF8/+G66u7AL9Iuqwr
         9jE5GCpfww6DQl+3OFFYSXaGaRnwUh4FIIjLPQavTUM6rhqbC21GJLcAi/bF60U/CWo+
         6On9RFuvZTjE/UaaeHu71PyDkcIzR3LbLk761qq4LJLjrr9UOeyvNI+0laMvejbcDyli
         zx7eg5K1KEZPlmvuR75LBudu4sCo4MyNay+3akn8eYglE09DgW6xeGxHxhZ1F3QJrlm5
         AD6Q==
X-Gm-Message-State: AOJu0Yx/0hG1W4/iN0vPxOTDzAere7WphGhV/VjpSBJ3YRQGDPFaP1N/
	FJU45FkJgRIQNVjPhyLyUh38aKyAZqxJVx9qu2jO2IlalAy7neOr1Rap/2gVSx9vj/UfkUXiG9b
	XBoxIf4emW8ClNMmVHnkV+XM+6zF0ChxddQ==
X-Gm-Gg: AZuq6aI4CpZkBV/vVCmJDXGgrypTE+Vvj3ifA4AbmXZhH5NiQaQay3HRhg3PoUH1NIp
	BI3UtAY6eOwebiLqByyt/B+xsom0HI3HEvQeRxdEXyyOiNvjyCNh05Z+iqVCibcBkiJ7G9rTZXE
	pvyPQfwG19a66U5hVY5g9OE9sujJA5dUOjKOhAzFnuE1iz+2aqOP+z8GTIE3xe/FOSk/NuBI27g
	kfMKIItk155Nqx8+fRcCkEETEEk1ii+VK4G2Is+bSi0z7UeRCK+LohlPvTP5zxRMWyo254fzIfA
	ZRVAPLMU5Ea4fM1X9IAgWVegMlCqETcdJi/hlkQQrq+laaFvnWBNHYdh/lIzDGXZm8oaFQ==
X-Received: by 2002:a53:5004:0:b0:649:38be:34bc with SMTP id
 956f58d0204a3-64c21b86077mr4629839d50.89.1771252967004; Mon, 16 Feb 2026
 06:42:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0b3d55690ff2f0ed72271f2760ace8f76a81fb43.1771160059.git.pav@iki.fi>
 <9728aa9a3d9bbd8034ea9760eb6206e44e859eb4.camel@iki.fi>
In-Reply-To: <9728aa9a3d9bbd8034ea9760eb6206e44e859eb4.camel@iki.fi>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 16 Feb 2026 09:42:36 -0500
X-Gm-Features: AZwV_Qij78HkkhKJ5GhVk3o9GcQ1qbUHOit-2-tdptOjU-0kEFNjBk91vpy1oyc
Message-ID: <CABBYNZK2ZUzxo0jhm4RpD3xBqtBQqvFvmMbLNSFcCjC444_W5Q@mail.gmail.com>
Subject: Re: [PATCH BlueZ] a2dp: start connecting sink profile before source
To: Pauli Virtanen <pav@iki.fi>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Pauli,

On Mon, Feb 16, 2026 at 3:18=E2=80=AFAM Pauli Virtanen <pav@iki.fi> wrote:
>
> su, 2026-02-15 kello 14:54 +0200, Pauli Virtanen kirjoitti:
> > Since cdcd845f87ee the order in which profiles with the same priority a=
re
> > connected is the same order as btd_profile_register() is called, instea=
d
> > of being the opposite order.
> >
> > When initiating connections, we want to prefer a2dp-sink profile over
> > a2dp-source, as connecting both at the same time does not work
> > currently.
> >
> > So swap the order of registration, to restore the previous behavior.
>
> Or maybe it's better to be more explicit, as in following -> v2
>
> diff --git a/profiles/audio/a2dp.c b/profiles/audio/a2dp.c
> index 7a37003a2..1e6300657 100644
> --- a/profiles/audio/a2dp.c
> +++ b/profiles/audio/a2dp.c
> @@ -3769,6 +3769,8 @@ static struct btd_profile a2dp_source_profile =3D {
>
>         .adapter_probe  =3D a2dp_sink_server_probe,
>         .adapter_remove =3D a2dp_sink_server_remove,
> +
> +       .after_services =3D BTD_PROFILE_UUID_CB(NULL, A2DP_SINK_UUID),
>  };

+1, This might work better to prevent future changes to the order.

>  static struct btd_profile a2dp_sink_profile =3D {
>
> >
> > Fixes: https://github.com/bluez/bluez/issues/1898
> > ---
> >  profiles/audio/a2dp.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/profiles/audio/a2dp.c b/profiles/audio/a2dp.c
> > index 7a37003a2..7216ed017 100644
> > --- a/profiles/audio/a2dp.c
> > +++ b/profiles/audio/a2dp.c
> > @@ -3796,8 +3796,8 @@ static struct btd_adapter_driver media_driver =3D=
 {
> >  static int a2dp_init(void)
> >  {
> >       btd_register_adapter_driver(&media_driver);
> > -     btd_profile_register(&a2dp_source_profile);
> >       btd_profile_register(&a2dp_sink_profile);
> > +     btd_profile_register(&a2dp_source_profile);
> >
> >       return 0;
> >  }
>
> --
> Pauli Virtanen
>
>


--=20
Luiz Augusto von Dentz
