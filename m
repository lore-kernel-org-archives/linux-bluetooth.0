Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0054519D8BE
	for <linux-bluetooth@vger.kernel.org>; Thu, 19 Jun 2025 17:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750355702; cv=none; b=A1zitAOGM400t610lPfNJc5wXM7eZVfj4GmMIa15qRg+XELJJcK1cxXx0gsRlewVbBkYCfhz3h/kYIUMOCVaG3yH4++FJ/QYnWJiSiCVY2/4sixYRUaTen2BTm/lmkcvg0ZYK0uNpwSsnqHEPHHHEVjorY74DkbnoUl1n9RG2aA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750355702; c=relaxed/simple;
	bh=mHeBcjhE/zWDrZhYLC7x8NtXCFOsZJtsNtZHnwLsWno=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lfbRROGxjEsQ53eWfVziWJOwCZi30tZ4OdHQaLEFZbCSxb2X9xuAYUx+1B907Q5SLbEzGB4TwP1OhmagndCNeSAr6Oxrm9Wjhrsp16eDvjeDWEUCHl5rHnum2ZtckcLa9YNFpCxmiTx4bZcjCt37zTcpin4qYfSOy2xYVah+mkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wab2yplB; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wab2yplB"
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-32b49ac6431so9150941fa.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 19 Jun 2025 10:54:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750355698; x=1750960498; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PA+YI7F2RevcYIjxPbLAul+wwZ2sgTFCFkEBL1AMeL8=;
        b=Wab2yplBhMXrLapo3IZlxzTQh+IZa8ERfvDUrM1BKIJwOy6KqaZYhFNFBRX0tCnC7B
         xwaKMfu5SzkZKeda6OAXNt+/2ojIbCYLoYLRtTww2Xfv7/Nnz9bxGLPIOLxzTBzBvEeH
         sl0QGJVodZ5wG6hFR0hxzSKGI2ANHs1SLr1sHprytQnT004KZQJCiZqeRRekh3hsWmkD
         8N34EzkWNMBF8Zpw8yj8SogLopZMNqBQYxcwRcDfBN9uGdkdLKux9SJhFHwh/sppy3Ws
         WlieZltewcaso1sLNLyNlWrojMsDQfGVFpbGSDLZ7VRD6UqSKuj2+/YrS0bA+tWICbqX
         MtiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750355698; x=1750960498;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PA+YI7F2RevcYIjxPbLAul+wwZ2sgTFCFkEBL1AMeL8=;
        b=wRf/TZnRUV7FBRL6uA8ZRs1PgGiwvHI/OojhpjyfSB01lD1ddHNJddZaaSTWNNjwTf
         NQycKBdjdrEwbnUWJtEPAeEoMiU/3QthHBVzhYtL+poxSpddaXRInyoXik71Fni4qlZc
         w4xkn+E5TlYoGhyClKhj8DHnWFf2MNVzsbIiPO7Gn4JR3wNSEJ+hB46S3oB+9hXbGUNR
         mgxJY7t1MAwI5K1DgLPUlGJiZLOCDpBUhKjjOQsR3pljjDdrTRGK+z4lw7FOGjKcAUxp
         prKFekmhORjqFSY8Xew0vJuDNGIepFzVQjbpe6Syt3jUNvMNEB5Y+inhpGkIw5uJ42JH
         +b/Q==
X-Gm-Message-State: AOJu0YyJtTNk4RjxK5v7phVQLn6prk9fSu14KGqn0TiyzgtuNr0kpDDi
	G4GRMD/BW6YFhqyA8GnThXNvwsHpt6XCef54fymhis1/kOaIlXDBi/OuGotyoMc9jZF6ks6irp/
	PKFyes4z6D6LeftOtd887a4H1ty70m2k=
X-Gm-Gg: ASbGncs8tcrLoACZfLF1b12I1SkGUgLgSIk7GBe60crlg3LA7MDTrO9+WkRX9Y5uZCJ
	0voE+6QXJm+MNB/5w0/rvsFGhFC4HwzZ53H2HlPF930r2ZQZaLmoTKsX31w2iw7qHC7ZYLe5vmU
	dTKsM5/zcFLwSttZrgSrSGQ7PWMsEHzqmbPpaJG0t0KQ==
X-Google-Smtp-Source: AGHT+IH0MP6s3Fs1zKyO3rEiXYRsPqbWvUGfSu23YhY7NwEpFa7x5VY64BC1eMrXJv1zAhpctjcH+xBGXetODBWMbFE=
X-Received: by 2002:a2e:bea9:0:b0:32b:7cdb:aa4d with SMTP id
 38308e7fff4ca-32b7cdbac9cmr26040171fa.31.1750355697838; Thu, 19 Jun 2025
 10:54:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250619153120.126315-1-k.samburskiy@omp.ru> <20250619153120.126315-3-k.samburskiy@omp.ru>
 <CABBYNZ+CLUV9Ny3GuXoeEuVXKtENPRdCq+jFZdriXMyksmL+8w@mail.gmail.com>
In-Reply-To: <CABBYNZ+CLUV9Ny3GuXoeEuVXKtENPRdCq+jFZdriXMyksmL+8w@mail.gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 19 Jun 2025 13:54:45 -0400
X-Gm-Features: AX0GCFs8kKxK680HUsozHwfHLSQ2pCn_IFif2tLjSUpkM5iM1O7cVTQhplzk7NQ
Message-ID: <CABBYNZLvB=9AytPKCAF9xRisxZ9FOKDoZuHpmELkeuz3b6KUaw@mail.gmail.com>
Subject: Re: [PATCH BlueZ 2/2] test-vcp: free server-side bt_vcp on test teardown
To: Kirill Samburskiy <k.samburskiy@omp.ru>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Kirill,

On Thu, Jun 19, 2025 at 1:16=E2=80=AFPM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Kirill,
>
> On Thu, Jun 19, 2025 at 11:34=E2=80=AFAM Kirill Samburskiy <k.samburskiy@=
omp.ru> wrote:
> >
> > Shutdown tester IO before freeing bt_att instance to trigger its IO
> > disconnection callbacks. This detaches bt_vcp instance created by
> > vcp_get_session function, and executes detach callback registered
> > through bt_vcp_register that frees memory used by this bt_vcp instance.
> > This prevents the test from failing in some environments.
>
> I guess this should close the following issues:
>
> https://github.com/bluez/bluez/issues/726
> https://github.com/bluez/bluez/issues/683
>
> > ---
> >  unit/test-vcp.c | 26 ++++++++++++++++++++++++--
> >  1 file changed, 24 insertions(+), 2 deletions(-)
> >
> > diff --git a/unit/test-vcp.c b/unit/test-vcp.c
> > index 6a61ea2c4..04254700b 100644
> > --- a/unit/test-vcp.c
> > +++ b/unit/test-vcp.c
> > @@ -38,6 +38,7 @@ struct test_data {
> >         struct queue *ccc_states;
> >         size_t iovcnt;
> >         struct iovec *iov;
> > +       unsigned int vcp_id;
> >  };
> >
> >  struct notify {
> > @@ -78,9 +79,9 @@ static void print_debug(const char *str, void *user_d=
ata)
> >                 tester_debug("%s%s", prefix, str);
> >  }
> >
> > -static void test_teardown(const void *user_data)
> > +static gboolean test_teardown_finish(gpointer user_data)
> >  {
> > -       struct test_data *data =3D (void *)user_data;
> > +       struct test_data *data =3D user_data;
> >
> >         bt_vcp_unref(data->vcp);
> >         bt_gatt_server_unref(data->server);
> > @@ -90,7 +91,16 @@ static void test_teardown(const void *user_data)
> >
> >         queue_destroy(data->ccc_states, free);
> >
> > +       bt_vcp_unregister(data->vcp_id);
> >         tester_teardown_complete();
> > +
> > +       return FALSE;
> > +}
> > +
> > +static void test_teardown(const void *user_data)
> > +{
> > +       tester_shutdown_io();
> > +       g_idle_add(test_teardown_finish, (void *) user_data);
> >  }
> >
> >  static bool ccc_state_match(const void *a, const void *b)
> > @@ -163,6 +173,15 @@ done:
> >                                                         sizeof(value));
> >  }
> >
> > +static void vcp_client_attached(struct bt_vcp *vcp, void *user_data)
> > +{
> > +}
> > +
> > +static void vcp_client_detached(struct bt_vcp *vcp, void *user_data)
> > +{
> > +       bt_vcp_unref(vcp);
>
> Hmm, are the multiple references to vcp that makes
> test_teardown_finish not to free on bt_vcp_unref?
>
> > +}
> > +
> >  static void test_server(const void *user_data)
> >  {
> >         struct test_data *data =3D (void *)user_data;
> > @@ -188,6 +207,9 @@ static void test_server(const void *user_data)
> >         data->vcp =3D bt_vcp_new(data->db, NULL);
> >         g_assert(data->vcp);

Looks like the above session is actually not used for anything, upon
connecting a new session will be created with corresponding bt_att and
that is why the attached callback is required, so the data->vcp
created here is useless and shall be removed, that said it does seem
like we have a similar problem in test-micp.c as well, also if we do
incorporate the tester_shutdown_io into test_result there is also a
crash on test-bap.c due to it not registering a detach callback, which
we should either ignore if that is registered as NULL or fail to
register. Anyway let me know if you need some help getting these
changes worked out, I can probably do it myself if you don't have time
to incorporate them.

> > +       data->vcp_id =3D bt_vcp_register(vcp_client_attached,
> > +                                               vcp_client_detached, NU=
LL);
> > +
> >         data->server =3D bt_gatt_server_new(data->db, att, 64, 0);
> >         g_assert(data->server);
> >
> > --
> > 2.34.1
> >
> >
>
>
> --
> Luiz Augusto von Dentz



--=20
Luiz Augusto von Dentz
