Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 769E52CCB4
	for <linux-bluetooth@vger.kernel.org>; Mon,  3 Jun 2024 19:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717442382; cv=none; b=bSNa38tKlMitZ92+CPxc9R0vCDmKwnqHpq31tayZokPiV9g8vc7K0TL/dBj7Q0q/pN4BRh3BVYKx0+Ll9+nZoG0hLq4qICXGy9ax7v7EuvocG1lB/4VS2du8hK6RZPTsI6RqCmoExOw/zvkpHhOkWrGesd2/oHPGv4IWydIXp7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717442382; c=relaxed/simple;
	bh=tCzwGjg5K40/T1yQbNKc1g/2WDKmf2YaYvIFivGr1YA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TG2+mPeNxmO9iN+aV74o60g/unjLZ5x6IqQF2w5wq7bfioRUd738rNjumBKDSN+emGYWqBcyn9d6hAD6h2tQQqghF2q5dYZbTY7I8ogkKpGII6tJgI8edDi4tffnZLaUNPjJsFCL0zvTYQ/jAUfvEFa1mfsP+kijmlwn4VHy4oY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AEYEzWW4; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AEYEzWW4"
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2e724bc466fso55558191fa.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 03 Jun 2024 12:19:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717442379; x=1718047179; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=USNvqm5WvNRGKKhJJ1e1P4+1h5ipgXUhPahXgxecy14=;
        b=AEYEzWW41pNOuzAMVjN46C7XhLpiJ0482VVI4hK9DP50Yl9PRL27RHuuFvB5FV5R3F
         sCcl4wkdYJO/p0Rg8Pxf5AWF77FtRx0dFC6HR+5gYd9lKu5d/YEzbKLOwDPmJUXdXadK
         7N9vz/b8eFLT4Abf5CMPdUcnZKp5cVaigR1aehvJGcmMJANszLXJbT2oz6/V3Rpqs4lX
         l0itbYyW+d+3gjR/tReHeQEbFAxnFAfyBkr0o22HQbITihFAYOCRjNlhhVnTRNdUyAdw
         C/FuR7wmRvuRZMuEJ8ncUvMf6G1TgYgtJ2e4A8c3PEPyknn28PgC/xS3qGAPnkOf3yR8
         ZAMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717442379; x=1718047179;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=USNvqm5WvNRGKKhJJ1e1P4+1h5ipgXUhPahXgxecy14=;
        b=ih4gjnIf/9tvxNhoDYkNhior4XSSta1bJi+0c970USr+aL+4/cwrUPLIs6dHNLkX/r
         uhUU2T9VLWq8t9MKeD35EKXvU3p+pvEXmYlq7yJAzogaltAMlFH9aKWXYknKXekEy0hH
         UzYLIHuRFXF4izZP4/z9CvMurW1tpcqx39CxbeKi5/Ih1fyoavrc9IKhHIT+yqpJEmu0
         LUuTplxReiVTN2DEr2BimxV7dIwkxYTEvVludgBsiPVIPhTSM/j1rJ4LTvWkElrCBLgD
         U/OFGWZLUnfjgA/lqPhWc1c37qo8jcLJBf8AgW2AMEvx2sH51Pi4YqNhm+T1EzE+Zerc
         8Vvw==
X-Forwarded-Encrypted: i=1; AJvYcCV/4vR8n0k96p7cSLhiuD01CcM8WkiI+bnteaLt61vJ7cyEOFpEDZ7jqTgMYIh5dMBOn58xdrCm6AbmSaT1kPY3wn4AuHj9yXq5PqEevYRb
X-Gm-Message-State: AOJu0YxmiHVdEcGvSDy3l4/34ALiMafKeTDXtp6p1J7AkiO84b9L51k7
	v/AugVc96G351puABjeQHPizkEdzQftUOO/20cNJ5Ekj1NPNof9HNNdFQF1kundZGjLxqOMXTAZ
	XbDeRI/QCV4dEs4n+DvtH5mWsmSI=
X-Google-Smtp-Source: AGHT+IFE7EdxSbnUDKI6YZL50O1WZLogZCK7uyf+Fhz8xr/jpsvJaxLUN5AZuK4vxnGf1EbRfX39TTQD2cWWm0ze9Sk=
X-Received: by 2002:a2e:9ccb:0:b0:2e7:174b:8c1c with SMTP id
 38308e7fff4ca-2ea951e4be1mr75797791fa.38.1717442378269; Mon, 03 Jun 2024
 12:19:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240530150057.444585-1-hadess@hadess.net> <20240530150057.444585-10-hadess@hadess.net>
 <8c979897beeb8316616bb7c15f60093be177577c.camel@iki.fi> <727c93065d8d1e56e9fcd5b5bed724d63dfbe871.camel@hadess.net>
In-Reply-To: <727c93065d8d1e56e9fcd5b5bed724d63dfbe871.camel@hadess.net>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 3 Jun 2024 15:19:25 -0400
Message-ID: <CABBYNZJB5kYZd5=jEz6sC5TOe9EMphMDBkKgHGjpTf_AH8fXdQ@mail.gmail.com>
Subject: Re: [BlueZ 9/9] avdtp: Fix manipulating struct as an array
To: Bastien Nocera <hadess@hadess.net>
Cc: Pauli Virtanen <pav@iki.fi>, linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Bastien,

On Fri, May 31, 2024 at 11:51=E2=80=AFAM Bastien Nocera <hadess@hadess.net>=
 wrote:
>
> On Thu, 2024-05-30 at 19:57 +0300, Pauli Virtanen wrote:
> > Hi,
> >
> > to, 2024-05-30 kello 16:58 +0200, Bastien Nocera kirjoitti:
> > > Don't manipulate the "req" structs as if they were flat arrays,
> > > static
> > > analysis and humans are both equally confused by this kind of
> > > usage.
> >
> > struct start_req {
> >       union {
> >               struct seid required[1];
> >               struct seid seids[0];
> >       };
> > } __attribute__ ((packed));
> >
> > and access only via req->seids?
>
> That's a good idea, I'll give it a try.
>
> > <snip>
> > > +#define
> > > REQ_GET_NTH_SEID(x)                                         \
> > > +   static struct seid
> > > *                                           \
> > > +   x##_req_get_nth_seid(struct x##_req *req, int count, int
> > > i)  \
> > > +   {
> > >     \
> > > +           if (count =3D=3D 0 || i >=3D
> > > count)                              \
> > > +                   return
> > > NULL;                                       \
> > > +           if (i =3D=3D
> > > 1)                                          \
> > > +                   return &req-
> > > >first_seid;                        \
> > > +           return &req-
> > > >other_seids[i];                            \
> >
> > (i =3D=3D 0) and [i - 1]?
>
> *facepalm*
>
> Yes, this will need a v2, thanks for spotting that.

Ive applied the set except for this one, please resend once you are
done with the suggested changes.

--=20
Luiz Augusto von Dentz
