Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 079D0B64C
	for <linux-bluetooth@vger.kernel.org>; Tue,  7 Nov 2023 08:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="QdM/+Q/9"
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4189E12B
	for <linux-bluetooth@vger.kernel.org>; Tue,  7 Nov 2023 00:37:34 -0800 (PST)
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com [209.85.208.200])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 959203F2E3
	for <linux-bluetooth@vger.kernel.org>; Tue,  7 Nov 2023 08:37:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1699346252;
	bh=JkwBSYCWKBilrEeCoyM5THDT7/2NYhD973KGnQ+iKYA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type;
	b=QdM/+Q/9srD7erLWw/s0IUIhkJ48B7S7L+/aquTDmyXBIaF9DQ7j0gjEGMuJqbWUc
	 xTKdGNOSZOeK9XJma5xSjLkPd59Ut2xAwIn4EPw91+XwFK2YUlYtip8rHujkbQMFXV
	 XmxZopSein5lduCXIBvkhjDZkxt9ePrIl9Yuy3l2SxIYsKG3as1GHktcL69NJ7BOBs
	 4y3xAmMHCIdyLEq7SnfpnmZur8slaFERsE9innzv84laH1SCsbDGBfE3zYAhUr2vHy
	 Z9cHe6UtknEvmdJm1s2Aq4gwofk4ngIbgJYIaM1bMmguQesXpbc5+fTD2oAMY5gWqf
	 Da0ZzPl9slYJw==
Received: by mail-lj1-f200.google.com with SMTP id 38308e7fff4ca-2c6f3cd892cso54376361fa.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 07 Nov 2023 00:37:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699346252; x=1699951052;
        h=mime-version:organization:references:in-reply-to:message-id:subject
         :cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JkwBSYCWKBilrEeCoyM5THDT7/2NYhD973KGnQ+iKYA=;
        b=wFyh/n2iNUvJMYPWb97gJlBXA6kkK7SKTXs9CuGLdh3d5k7wp7hOtPJhdqG0DSBjHs
         WM4AkFud/GWsN3Eht0x/Vwplne/4U0pFaBqvWphH2PWLO6gxDZeQ7uIIL2VAx3OX0EG0
         7AWBGeoNTWcqT6mmRw4Crj3B2lZvX7PQoWpsp+5hoNSpRce/nMMbT6WiKpYBty+LGY7l
         h6cAHny5KyozeYAx/3Efx2iCOqUI7uQTbDP1XBVzQLplghtWibdPftGaenzix2VaMXDM
         urx/Zxk7588RZB9Sp6Z8BeMrwbQZ0XYw17j868SPNW9cxQuM60XFlCT7EZfk3tU/m5nA
         QIXg==
X-Gm-Message-State: AOJu0YzOmdDgevRmXy7qxzXqvwM75Z+saPPpOPaX3Kt9V2ff+k+Nus3H
	BjLYfG4nQ/nhG1k9/X6kBKhkguJHIBqWBIoyFgbuOnooqSerIZYTgzVcakME7BDYjAK46mtb2sR
	R5CxNhv0Z93an0pTR/D3YMoHyeOVCWNCyMMRp/8n7YXWWMMrHLsDgYbN4
X-Received: by 2002:a2e:7d0b:0:b0:2c5:c31:eeac with SMTP id y11-20020a2e7d0b000000b002c50c31eeacmr24539433ljc.15.1699346251878;
        Tue, 07 Nov 2023 00:37:31 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFi4q+TwJnf91wfBd8W21/sKU8HopBUaFY2V5ca3Q+T81DYFFUPN9xDgNZWfPY73NJRWzdd8w==
X-Received: by 2002:a2e:7d0b:0:b0:2c5:c31:eeac with SMTP id y11-20020a2e7d0b000000b002c50c31eeacmr24539425ljc.15.1699346251539;
        Tue, 07 Nov 2023 00:37:31 -0800 (PST)
Received: from smeagol ([195.13.248.78])
        by smtp.gmail.com with ESMTPSA id l24-20020a2e9098000000b002bc3fbe9fd5sm1423236ljg.55.2023.11.07.00.37.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Nov 2023 00:37:31 -0800 (PST)
Date: Tue, 7 Nov 2023 10:37:27 +0200
From: Juerg Haefliger <juerg.haefliger@canonical.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v2] shared/shell: Fix --init-script commandline option
Message-ID: <20231107103727.3ca230ee@smeagol>
In-Reply-To: <CABBYNZKkRtuTfT002ehf1QVq_enbJn_MhBnnAkNgxsMy5MJu_w@mail.gmail.com>
References: <20231027055423.13617-1-juerg.haefliger@canonical.com>
	<20231030065341.8998-1-juerg.haefliger@canonical.com>
	<CABBYNZKkRtuTfT002ehf1QVq_enbJn_MhBnnAkNgxsMy5MJu_w@mail.gmail.com>
Organization: Canonical Ltd
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/8KkkfoPLmUw5r3G4.=v4rp.";
 protocol="application/pgp-signature"; micalg=pgp-sha512

--Sig_/8KkkfoPLmUw5r3G4.=v4rp.
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Luiz,

> Hi Juerg,
>=20
> On Mon, Oct 30, 2023 at 2:54=E2=80=AFAM Juerg Haefliger
> <juerg.haefliger@canonical.com> wrote:
> >
> > The newly added option -i/--init-script introduced a short option
> > namespace collision with btmgmt's --index, both of which use '-i'.
> >
> > As a result, a provided --index is treated as a file name:
> >
> > $ sudo btmgmt --index 0 info =20
>=20
> Perhaps we could remove this --index since btmgmt supports setting the
> index via select command; it doesn't seem very useful to have 2
> different forms of selecting the index.

That would break a potentially large number of existing scripts, which is b=
ad.
--index has been around for a long time and is also supported by other bluez
commands. It would require some warning first that it's going away to give
people time to transition.

I'd rather fix the new option which hasn't been released yet and introduced
this regression.

...Juerg

=20
> > Unable to open 0: No such file or directory (2)
> >
> > Fix this by using '-s' for --init-script.
> >
> > Fixes: https://github.com/bluez/bluez/issues/639
> > Signed-off-by: Juerg Haefliger <juerg.haefliger@canonical.com>
> >
> > ---
> > v2:
> >   - Replace reference to broken commit with reference to github issue.
> > ---
> >  src/shared/shell.c | 8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)
> >
> > diff --git a/src/shared/shell.c b/src/shared/shell.c
> > index db79c882ca3a..fbccff5b54d9 100644
> > --- a/src/shared/shell.c
> > +++ b/src/shared/shell.c
> > @@ -1128,7 +1128,7 @@ static void rl_init(void)
> >  static const struct option main_options[] =3D {
> >         { "version",    no_argument, 0, 'v' },
> >         { "help",       no_argument, 0, 'h' },
> > -       { "init-script", required_argument, 0, 'i' },
> > +       { "init-script", required_argument, 0, 's' },
> >         { "timeout",    required_argument, 0, 't' },
> >         { "monitor",    no_argument, 0, 'm' },
> >         { "zsh-complete",       no_argument, 0, 'z' },
> > @@ -1169,9 +1169,9 @@ void bt_shell_init(int argc, char **argv, const s=
truct bt_shell_opt *opt)
> >         if (opt) {
> >                 memcpy(options + offset, opt->options,
> >                                 sizeof(struct option) * opt->optno);
> > -               snprintf(optstr, sizeof(optstr), "+mhvi:t:%s", opt->opt=
str);
> > +               snprintf(optstr, sizeof(optstr), "+mhvs:t:%s", opt->opt=
str);
> >         } else
> > -               snprintf(optstr, sizeof(optstr), "+mhvi:t:");
> > +               snprintf(optstr, sizeof(optstr), "+mhvs:t:");
> >
> >         data.name =3D strrchr(argv[0], '/');
> >         if (!data.name)
> > @@ -1193,7 +1193,7 @@ void bt_shell_init(int argc, char **argv, const s=
truct bt_shell_opt *opt)
> >                         data.argv =3D &cmplt;
> >                         data.mode =3D 1;
> >                         goto done;
> > -               case 'i':
> > +               case 's':
> >                         if (optarg)
> >                                 data.init_fd =3D open(optarg, O_RDONLY);
> >                         if (data.init_fd < 0)
> > --
> > 2.39.2
> > =20
>=20
>=20


--Sig_/8KkkfoPLmUw5r3G4.=v4rp.
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEhZfU96IuprviLdeLD9OLCQumQrcFAmVJ90cACgkQD9OLCQum
Qre9rw//TugVkvtdhBQUusdabmENd157jJDHsSkMPDNUhcjX5LHIOFU0lxT4g55O
2H2VI1beG/C+H0/49VlG+7QTpS55yJtO04HnvZK9SUMeTh2pxCQNb1vj9Wttfi0/
x1boepnFnTNRbgcyW/nHGGDqkirPGYE2UMKUpjvs11rA7sz3EEzp39vgphZk5RXf
XX+fPTyak6+3CGDVaUoF74ZHcJtkmxgSofGNS5Kp2W3G3+29xf84kKdZys1sN72K
jIIxsXH56MqG+9FpaREPJWnDUGA3USSVqmkYyblZcr0N0rvFKe+VkkBqmnvF3Ra9
c/aUsja1sGfOmXXxVq9Ohfncp7GFrq/i6Xq8g+RaWBCkIrgG3ozeJH5ZoUaLvxmE
uA2/4slMWalIu888AWYnsYXYx5Cl3fEMADtBf7reQnOFPf1ucONbUNe8h1hCFxbs
YLiCBuBABwYCo42hg3dC9onCSPqQMtosjPIHEE4zRlU9OuzqNp4sg3AGfNDuM5jV
yiisNJbWkKQTOgs623VYatTvW78ZqY/INcr5Th9zK5VLA3bW6R/dzLO5KRZEZTwC
M/lcuM+qKua59pM+HfPVfiQ1yUDh2/3M/SdU1ATaIb68AmZ+D7Diu08TeCAYPxPY
+3FpiyqeV88+Fj3v1LKnyqKBOpQbvkb2x+bHftvF20IKkAVkhkQ=
=G3Qb
-----END PGP SIGNATURE-----

--Sig_/8KkkfoPLmUw5r3G4.=v4rp.--
