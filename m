Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A3222E8B95
	for <linux-bluetooth@vger.kernel.org>; Mon,  8 Sep 2025 21:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757367181; cv=none; b=nc2pDsLHHOP/FY1hPHEth3TgqRRawHw8KpphrFFFqCg8tLGHkbrCmau+xcfYbDY/M406wyUw8AYcYTLQHE8KOAiexWky5wDxfusqNdQpcxIOLIQJGXDNX4pXGww+6ZHB9IgulmHCN1Dhm5/kMFixtynQm2GshgrqD9RKbdHlaxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757367181; c=relaxed/simple;
	bh=/6hO2LCAOi/ZJuN8q+oiHJc26KrccoioyQyN6/YHteY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=usofsRXX17Pg/fNGSHJGeiaH44T4baivvlj9UXvJclFgDBoWKq9rvk87aOH49Y3O0jm+s1A+OXbLAMBhTJMaZE3+K4dsiprAoPrNwpmmzo9nR5hWlZiPGqdDzfq6VAu+TrW5opl6sLZAEmg91SX4fppefTRe/2vMb/NHXrqZS2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=noNOipus; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="noNOipus"
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-33ca74c62acso16855321fa.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 08 Sep 2025 14:32:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757367177; x=1757971977; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nmvO+sfHK1kwOwJ4u/HJO+BHX/Gfm2u4OTyaKWy/y50=;
        b=noNOipuse7WKgEShZfkQyJ6QqAqsoopjy6coe1S4MEHFr+nm71HdbHRFNCZ8UcQ90V
         80qCbK1dpnRGqhv6iZVrJcpkQO6ZQ52V51Gm8eOLFnG109RjlmnwcHGVcSLHmfpShlCV
         TUuPyWEMuKA4QscWl8JC4aiTyejI8iohzNfLUxH5AwylC9HMjQ3Acwh3VlhShQoNL5cj
         hhMmY/Ysr7ipyleVGoZa9mFL9YdJJiwgss1YycZrhBmoowQlU/IuNqbx6GVCWSdwA+xh
         B3PqEoHLGUZGoV75+HysN7yI0Gt+fPapBlfP0QlRQGCHyHv2jFyvNAYjScx/4UZgeTHI
         h0LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757367177; x=1757971977;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nmvO+sfHK1kwOwJ4u/HJO+BHX/Gfm2u4OTyaKWy/y50=;
        b=v2DlX2m1qrMqRqImBggVQlhBpPh7vvmMHOTzc7TfKfNihXe4mLRah6DCpm8RmwXDvH
         NyBDGT5eTDVsgCr9BI5KKrdP/URnp3aoMC7h177Eqgll3hPJDttdSUwB1zPKYoheSXY1
         qzvm5ummxLF7tvq0KEQx/fEtA+k9eQT9EEl6TRLn6yIS15vX33MW1yEcLv/jp1L4uvBN
         z7PDzBjLuanpPMjU+GkaQyACXhYVnF9E2Nho8jmpQiwZ7AJwUi2QZcoYGBgV9NE2ZfJn
         O4ehDNGwN+NehWq2Zav3ZrY+kn2wjSYhxcxPPD2BaJBNyiYeS4leLuyF2iaeRXPI0JUQ
         VV4g==
X-Gm-Message-State: AOJu0Yyynq+CqRSJzO3IK0wcq1sflJkf+aezZT27GYVwG1qd3hX8ZT1M
	nUsbZOBjGmBx2SJZfkrTTXC5tXDbvAWXK/Uv7CfXbQS8Wy79kFZhYj8/7fYK37Wm0O9aZi2F0x/
	6Zr0rVRXWCBYcJx/d1TYsIaa8Oa/1tefwyhhyGbwlSw==
X-Gm-Gg: ASbGncvmdUfEr+wXM7NYWcWeq+FF0NKVwdsJOAEz0Q3g8hMlYPUPdMHzyhcl9zUJIYQ
	vzJ6bSkWgj0K68xBkGHHLgpdbfd86Kdqa6MzLGpIzLBYTXJer/Hq8QTfHX+5ndNFyUF9VOaU2Xk
	T5mnmlEiFyLl3lJ3fCIxkpjP8g6JCSJmRWKkb/9D8ydW/Tn4PRZNev5bKf9OwWjL8cG3IlwH1iR
	tAuKaYqsxKm9dzbEk0WX4capi2+19wh/sfcs8okWNqjgw==
X-Google-Smtp-Source: AGHT+IF6uOEwCg4swg2O3cc0SPQ1NhlEZzbWPwwfqrPpZKy9MSXiobRjkdFnxzhGWtjD7IFBBvOnhX4RMuaKNxXAwdk=
X-Received: by 2002:a05:651c:b0b:b0:337:f9dc:d81e with SMTP id
 38308e7fff4ca-33b4d8cb121mr25478491fa.17.1757367177060; Mon, 08 Sep 2025
 14:32:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250904163343.688862-1-luiz.dentz@gmail.com> <9cdb3f9d63725c9146a4b6060dca58d7989e6fac.camel@hadess.net>
In-Reply-To: <9cdb3f9d63725c9146a4b6060dca58d7989e6fac.camel@hadess.net>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 8 Sep 2025 17:32:45 -0400
X-Gm-Features: Ac12FXxyjFQQZGY1OF9UZWqo9h_2qSwXw7393xl-t6b9e1nNSftZd6ck_TzraHk
Message-ID: <CABBYNZ+QEUQ2wCD8h4E6Aez2fB228_pnxz00E5gqy0hRXbY4-Q@mail.gmail.com>
Subject: Re: [PATCH BlueZ v2] main.conf: Add FilterDiscoverable option
To: Bastien Nocera <hadess@hadess.net>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Bastien,

On Mon, Sep 8, 2025 at 7:30=E2=80=AFAM Bastien Nocera <hadess@hadess.net> w=
rote:
>
> On Thu, 2025-09-04 at 12:33 -0400, Luiz Augusto von Dentz wrote:
> > From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> >
> > This adds FilterDiscoverable option which can be use to control if
> > devices in non-discoverable mode shall be filtered or not, the
> > default
> > is true to adhere to core spec:
>
> This needs more explanation as to where the filter is defined.
>
> What happens if no filter is defined and FilterDiscoverable is set to
> true?

Well that is the current behavior where non-discoverable devices are
not enumerated, the behavior of filters are bypass the discoverable
flag:

When discovery filter is set, Device objects will be created as new
devices with matching criteria are discovered regardless of they are
connectable or discoverable which enables listening to non-connectable
and non-discoverable devices.
[]https://gist.github.com/Vudentz/0e7b34b596c7bf91e4bfd76fe46f9662


> In which circumstances would a system builder, integrator or admin want
> to set this to false?

Id wouldn't recommend setting to false except if the system is being
used with specific use case that requires to ignore the remote
discoverable settings or for testing bad or unintended behavior, well
perhaps it would have been clearer if I just include the above in the
documentation.

>
> >  9.2. Discovery modes and procedures
> >
> >  All devices shall be in either non-discoverable mode or one of the
> >  discoverable modes. A device in the discoverable mode shall be in
> >  either the general discoverable mode or the limited discoverable
> > mode.
> >  A device in the non-discoverable mode is not discoverable. Devices
> >  operating in either the general discoverable mode or the limited
> >  discoverable mode can be found by the discovering device.
> > ---
> >  src/adapter.c | 4 +++-
> >  src/btd.h     | 1 +
> >  src/main.c    | 4 ++++
> >  src/main.conf | 5 +++++
> >  4 files changed, 13 insertions(+), 1 deletion(-)
> >
> > diff --git a/src/adapter.c b/src/adapter.c
> > index 549a6c0b8324..dc5ba65d73fa 100644
> > --- a/src/adapter.c
> > +++ b/src/adapter.c
> > @@ -7239,8 +7239,10 @@ static bool device_is_discoverable(struct
> > btd_adapter *adapter,
> >
> >       if (bdaddr_type =3D=3D BDADDR_BREDR || adapter-
> > >filtered_discovery)
> >               discoverable =3D true;
> > -     else
> > +     else if (btd_opts.filter_discoverable)
> >               discoverable =3D eir->flags & (EIR_LIM_DISC |
> > EIR_GEN_DISC);
> > +     else
> > +             discoverable =3D true;
> >
> >       /*
> >        * Mark as not discoverable if no client has requested
> > discovery and
> > diff --git a/src/btd.h b/src/btd.h
> > index 18a5eb88696a..5c952bf17956 100644
> > --- a/src/btd.h
> > +++ b/src/btd.h
> > @@ -142,6 +142,7 @@ struct btd_opts {
> >       bool            refresh_discovery;
> >       bool            experimental;
> >       bool            testing;
> > +     bool            filter_discoverable;
> >       struct queue    *kernel;
> >
> >       uint16_t        did_source;
> > diff --git a/src/main.c b/src/main.c
> > index a542d0fc50b0..1c7390e6329d 100644
> > --- a/src/main.c
> > +++ b/src/main.c
> > @@ -91,6 +91,7 @@ static const char *supported_options[] =3D {
> >       "Testing",
> >       "KernelExperimental",
> >       "RemoteNameRequestRetryDelay",
> > +     "FilterDiscoverable",
> >       NULL
> >  };
> >
> > @@ -1062,6 +1063,8 @@ static void parse_general(GKeyFile *config)
> >       parse_config_u32(config, "General",
> > "RemoteNameRequestRetryDelay",
> >                                       &btd_opts.name_request_retry
> > _delay,
> >                                       0, UINT32_MAX);
> > +     parse_config_bool(config, "General", "FilterDiscoverable",
> > +                                             &btd_opts.filter_dis
> > coverable);
> >  }
> >
> >  static void parse_gatt_cache(GKeyFile *config)
> > @@ -1239,6 +1242,7 @@ static void init_defaults(void)
> >       btd_opts.refresh_discovery =3D TRUE;
> >       btd_opts.name_request_retry_delay =3D
> > DEFAULT_NAME_REQUEST_RETRY_DELAY;
> >       btd_opts.secure_conn =3D SC_ON;
> > +     btd_opts.filter_discoverable =3D true;
> >
> >       btd_opts.defaults.num_entries =3D 0;
> >       btd_opts.defaults.br.page_scan_type =3D 0xFFFF;
> > diff --git a/src/main.conf b/src/main.conf
> > index 86759d53c1f2..55618be5c923 100644
> > --- a/src/main.conf
> > +++ b/src/main.conf
> > @@ -148,6 +148,11 @@
> >  # The value is in seconds. Default is 300, i.e. 5 minutes.
> >  #RemoteNameRequestRetryDelay =3D 300
> >
> > +# Filter out non-discoverable devices based on discoverable flags
> > (General or
> > +# Limited).
> > +# Defaults to true
> > +#FilterDiscoverable =3D true
> > +
> >  [BR]
> >  # The following values are used to load default adapter parameters
> > for BR/EDR.
> >  # BlueZ loads the values into the kernel before the adapter is
> > powered if the



--=20
Luiz Augusto von Dentz
