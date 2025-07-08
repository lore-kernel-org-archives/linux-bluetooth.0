Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58AC12E5403
	for <linux-bluetooth@vger.kernel.org>; Tue,  8 Jul 2025 17:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751995180; cv=none; b=YnI8tFJbkG8bOAhPPkHQ8FvWeYEnL/p9T1Vm1lqIEXCRkBn8Qo4N8LwQtiX5iNZ+zwaAAB0aLWgp3baVF0VwPyjqj6AQSJ5ycgDGxqGntCsLryySjrU5vlYbVveYif8OA1mr3E+jhBCxFCJZCKo6j3GCqayv7gUoC9CFt4VoLQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751995180; c=relaxed/simple;
	bh=wcoVmHXk0IU2QN10exuZ/rg1TZr1Nc6dPHFnDxpwCzE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BTjQne1Aslngx840zTqsFPla5YBi0LbOE7a+6dAWFI0UkDlpAnRdaUBfdEcGAsiWr2iAqVx2PRpKKtNHDBD8QeqXvWD0a+ObSKrrkhPzWTCv3hWem6EdHWJs2HRnfbHQuEQkVmXq/BdZDiFI7MrqYc4/rKOoDQ/V6gOpCfAyfk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YZkDiy/X; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YZkDiy/X"
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-32f2947ab0cso21827241fa.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 08 Jul 2025 10:19:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751995176; x=1752599976; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LltXApFsPZlaVTg74mGZaMAiFZ48a56nYELhbbf+H+I=;
        b=YZkDiy/XbwjW3Af8vPKsS92+2ITVfr4aGvdaP2wESPV/zZjX3pZoN6NUr1fYjJTLQC
         4Ay7StF1uJ/Yf3VMVj3axnTeBMEcetisbA5nnpxrCmO3TD4VQ3oMDx3NRW473GoXZOxB
         LUzo0PfwSU5UcK/UNcK0L7hXpuQFg8vx9TbWcYSBHOC9/IYDWT+25QdEnUpgx3wT4v/+
         E6ET9t+g4V6hz9/NvvBVPDjb0gk169E1zQx0cgoW1yv06o0fqeDiBd5WjVIcNlwVK+qU
         sD+TXWaJoutWNlcq4dzyxC2ek07Ql2Gv5CW801DQq1y57enUGdORanLetCx+FLUKpwgp
         uGZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751995176; x=1752599976;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LltXApFsPZlaVTg74mGZaMAiFZ48a56nYELhbbf+H+I=;
        b=Y/noa7PLDIkkwL0TslTwLI46jAANEoDdRANASXo0h+3stRwqjutx/nezJ3aI8rJSx/
         GMJcesjc3VlwxJ7DZw4gWYxKngk/5YhtKVk4QjBtINaT0/lbZ7oVpffjq2HGBdcFIdg2
         i79MUm5yFylcqtLTJNv6m9IBl7ZIWem6EF1PnFRmntqVARw8Gg/kCs767XIUZ/wq/EIj
         Ji2vnCO8FXZ7OleMAAP2kx3oW52jFOx8FjlGGn4ErOPg6SYZhtKr/WMJuIuhHKHiytCj
         NPBCa/zoKHqpT5LvZcd2qxwATk8TUwy+q0noCYRjah0RQTT7PRhKeHiumyMjlZMcyuG3
         pE3g==
X-Forwarded-Encrypted: i=1; AJvYcCXQPaLFu8zniuwxt7Oks06ksQKEdbWrROVpLWO9SpNgZGhisnQii2yLSl6vKLMMx2ClXHGXUEmaFKSu0devPV8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzCQyAcLzpSl6+eHFw3db9Kf7zO5SEbebTfZBMscxhDwUH0ayX
	tzcHmbnxqALc/OszAm53naYN7fXBsXWylAN+u1ZTLLTZR1QITluXkm8qbTNfcRFSaEOreEhJgOJ
	rTjGbnuYq3U4RIVWO2a2Nf8xau5Q2qSjsxQoY
X-Gm-Gg: ASbGncsff8hdjEj39MUFl/7b4fi+kiUiFo2Wr2Yb6J8qDDv4FVuCiqT8OK5HYpQv0oB
	fucSxMu8jh014H/3fVGgwlUwBvq5wu0DU7vf/ex1aImQpAaf6hm6yKkNwpqXUBj7xLYMd9JRzQ1
	gRsEsUnfY5F40gFRH9h8AANkATQiimFzRPsso9dGNbhg==
X-Google-Smtp-Source: AGHT+IHlvFoMT+69dMMZANarM6ITq7cAMfybO+iEZvpuVwMdaqc3T+EJ5i+gZj9AxKJIT+N3/J/Prs/o/bc4sGYuJvA=
X-Received: by 2002:a05:651c:2117:b0:32a:8062:69b1 with SMTP id
 38308e7fff4ca-32e5f568c3dmr63367161fa.8.1751995176076; Tue, 08 Jul 2025
 10:19:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250708154308.238963-1-frederic.danis@collabora.com>
 <20250708154308.238963-7-frederic.danis@collabora.com> <c721fd3eca1fd4e6555ddafdf3cd640e4457c1fc.camel@iki.fi>
In-Reply-To: <c721fd3eca1fd4e6555ddafdf3cd640e4457c1fc.camel@iki.fi>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 8 Jul 2025 13:19:23 -0400
X-Gm-Features: Ac12FXzkR8N1DgQSA-wdn_GlhE7iJdR5pQcovfU7HeXJVca1v0f31yVgsQaDCYM
Message-ID: <CABBYNZJecu3+d-7cH-CajxjfSjijwfnf3P06eqZ5bdonszUbvg@mail.gmail.com>
Subject: Re: [PATCH BlueZ v3 6/7] shared/ad: Use strtoutf8 for name
To: Pauli Virtanen <pav@iki.fi>
Cc: =?UTF-8?B?RnLDqWTDqXJpYyBEYW5pcw==?= <frederic.danis@collabora.com>, 
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Pauli,

On Tue, Jul 8, 2025 at 1:13=E2=80=AFPM Pauli Virtanen <pav@iki.fi> wrote:
>
> Hi,
>
> ti, 2025-07-08 kello 17:43 +0200, Fr=C3=A9d=C3=A9ric Danis kirjoitti:
> > Truncate the string to first character before invalid UTF-8 one
> > instead of replacing non ascii characters by spaces.
> > ---
> >  src/shared/ad.c | 7 +------
> >  1 file changed, 1 insertion(+), 6 deletions(-)
> >
> > diff --git a/src/shared/ad.c b/src/shared/ad.c
> > index 3f0064dd9..6952a0dab 100644
> > --- a/src/shared/ad.c
> > +++ b/src/shared/ad.c
> > @@ -276,7 +276,6 @@ static bool ad_replace_uuid128(struct bt_ad *ad, st=
ruct iovec *iov)
> >  static bool ad_replace_name(struct bt_ad *ad, struct iovec *iov)
> >  {
> >       char utf8_name[HCI_MAX_NAME_LENGTH + 2];
> > -     int i;
> >
> >       memset(utf8_name, 0, sizeof(utf8_name));
> >       strncpy(utf8_name, (const char *)iov->iov_base, iov->iov_len);
> > @@ -284,11 +283,7 @@ static bool ad_replace_name(struct bt_ad *ad, stru=
ct iovec *iov)
> >       if (strisutf8(utf8_name, iov->iov_len))
> >               goto done;
> >
> > -     /* Assume ASCII, and replace all non-ASCII with spaces */
> > -     for (i =3D 0; utf8_name[i] !=3D '\0'; i++) {
> > -             if (!isascii(utf8_name[i]))
> > -                     utf8_name[i] =3D ' ';
> > -     }
> > +     strtoutf8(utf8_name, iov->iov_len);
>
> Looks like potential out-of-bounds access --- strtoutf8()
> may access iov->iov_base[iov->iov_len]
>
> Cf. for (size_t j =3D 1; j < size; ++j) loop in strtoutf8().
>
> Also strisutf8() has same problem here.

It does i < len though:

    while (i < len) {
        unsigned char c =3D str[i];

That said we may need to do something like:

diff --git a/src/shared/util.c b/src/shared/util.c
index 4780f26b6d59..9ba1bdc48f77 100644
--- a/src/shared/util.c
+++ b/src/shared/util.c
@@ -1987,7 +1987,7 @@ char *strtoutf8(char *str, size_t len)
                 * format.
                 */
                for (size_t j =3D 1; j < size; ++j) {
-                       if (i + j > len || (str[i + j] & 0xC0) !=3D 0x80)
+                       if (i + j >=3D len || (str[i + j] & 0xC0) !=3D 0x80=
)
                                /* Invalid UTF-8 sequence */
                                goto done;
                }

Otherwise we may access str[len] which is past the bondaries of str.

>
> >
> >       /* Remove leading and trailing whitespace characters */
> >       strstrip(utf8_name);
>
> --
> Pauli Virtanen
>


--=20
Luiz Augusto von Dentz
