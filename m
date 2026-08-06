Received: from mail-yx1-f51.google.com (mail-yx1-f51.google.com [74.125.224.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 193EE304BDF
	for <linux-bluetooth@vger.kernel.org>; Thu,  6 Aug 2026 14:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786025956; cv=pass; b=YkQq2biNzHmnB7BsBRY7sw+GdvuM1/jVo5O0SazVVKIxgSsKP3U+4alU4qAySnLwiwJFjdSQpApbsfm8eHlMNMaEYeR96QYe4sRi0ucOAKnCoItPh+XS/1EHNI0pytFh/GeMD6NUcfytT4o1J8JkridvRUt/NMSTSnqtu5JeTiQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786025956; c=relaxed/simple;
	bh=4hXhNmbOkjLR3wC1Dip1DUFmd8JbAfPKY4lJn9naL/w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uKI0mAeHblpTbXT0QsL7E2heKzsm6zyvlaWR/pbk8Sijp1rWt8yS3vxmVXHIWH2DiZkReKYQULYxptThLTWzWNFaty2QimIVpSN9UJOx+dRJ49ZtKVCILoreuOiXNs7oWKT3kHyJgDSrOCYqQch05EjDEDdlDNA/Cdp+ABUnMEA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C08PA9By; arc=pass smtp.client-ip=74.125.224.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C08PA9By"
Received: by mail-yx1-f51.google.com with SMTP id 956f58d0204a3-6611669cd16so3004239d50.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 06 Aug 2026 07:19:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786025954; cv=none;
        d=google.com; s=arc-20260327;
        b=YoJUThKDltWMaLH1HV5TrtQ+o8G6nd092aM+i95scYfLtMk38UO4c6/gjB5EQPf/9P
         YiQvx2Vg61hMYzEVApooHWdh4CkzCLCkJJI46UoPHuJi2P8j/PtHy9EvSDEYoR21UkpT
         5lCXAiwiOWaERdEGl4RYA3dwyBNgS+qc0jgtJ7B4qkAXq2zoE+4JySppCkSGpWgByhJw
         xZewyw8fkAeBh4MfJxHcrsmEmWfceBY+GLt6xgKoREtEURnR0hmzo7v2B9SzeOA5KTmp
         iGy5MM/nb6YME5R0nqzIT3Wi1NOJ2lMFeKM7YUqTaEpEZktJMAkqZ3upuGjj3XaVgGLH
         1U+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=jc7taAXFizNTlGizq5XglVyeVQmfDY247mzt8pgURnA=;
        fh=DBIRJP4DvnAE+M31BcQ50XI3CAn/idN52/MNTtsfw9E=;
        b=ezGxDJUPIwFiLyh2dBH5ec7wauZw3fp5MSHIPLn7YXdoj8YzJEivzfs7fCYYh7yZ4h
         dCJTsZZcipl3vrAqRTaEq0pMyZs/jlQrJ968LU+TxHP9udCOKJrnpIs5fd18sb6GI1wM
         4Hzl2Lza8GyUuqQSZomdh8IE+WNDVpBGvcF5+CHRRNnkiA+gb3YL+Hui0HWQaRu0bfa+
         PA6m19qFw8RJK3pvUQ1UBkGN74V5YktbWF+w3hW72JAd+1C6GZL6Ku6YFqCeNUmntbZc
         TBAVN26BtFwcK18zGHI6CjhwUN6Kn8Z9R9ZVbsOPDufXjYKYC8pp0yIOfUFsF3rkQ7fn
         xzxQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786025954; x=1786630754; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=jc7taAXFizNTlGizq5XglVyeVQmfDY247mzt8pgURnA=;
        b=C08PA9ByVDqidLULFNHqxYrExhJTPuMZt3erD3fSmGfpSidXInuqtcbkWWKiKZNEpE
         tfu/ns/rRLVB4idlNFl3Fm0z4bD1vfANtrCKhvcvP2NpVHL0pVjrr3WWTP20TWrIhzRU
         jOtqNq5iFlYg4IXafq5Q21C4KFq42C4t+E9TKIaUrU6ClzKbkSJD/btfX9mCevNASIvh
         K+rGobcUvVNLgkl93P9ku4sDNSxvKq+Xl9a2O3RToXIpNVwFFFkc1VR6oyyRyDcWuwJ/
         OHswf5jEJ9GZKmZPXQXRFGMx7/76XX9L6U1vqM4ZQVwwhWz7R7LgNdlMk7vUnNJrIbzV
         zPFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786025954; x=1786630754;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jc7taAXFizNTlGizq5XglVyeVQmfDY247mzt8pgURnA=;
        b=WxmBkUrQ38urJtqQ8FdJ0JqWSJOeKIQrq3Dy7DooLjf0Fwlcd6n0pI/fUWh+spI7Kx
         WKHNa1z/nIBjQwcSJUmRBhfBswYVg+g0l2NO3ozwqZAVTRA5D9T6sBACvSXmMjQ6CDo6
         4hGjwPtvlqr9vUcSGPIdYScwl7xH3vM/Ka7kCCMcVp5Kj1F+nUcfvaWaUQXafnUmYdfx
         W4lSPo1Il4b5FY3aRb0MITKX6y8yyZesyoYEbOQtqCBrQxz9cPyvYedXHDyR7wepZqbl
         weVPNm1IBSgRFNi+BKkjWofDRKzdMwUNhE7beZ0tPQrejZssiF63c4mpBhpP6x2fkfYu
         SGxQ==
X-Gm-Message-State: AOJu0YwX7mvThq16AZOIqgtFfw6I70KcyyAWpVOqEtQzGu77tZ9ZCyLG
	mg7paGzXLqU7K9/Xnr/i7inVE/WQkvu918uyRW8aONUHg+LP4enFsBR35ibqiP0Tya7A7ikb8oc
	H1ewf+0TaQqguGrCxubvytlNA9UXCYx9sme69Zjo=
X-Gm-Gg: AR+sD12Na+pAJXfNGk0teCEqkFl/ax2v0sTnDii3XCQUKPJVYEY8H7cvBtIUlEM/xI5
	soS05wNr1xRYIl0DIvjTm9vMkWPJ5AU8C0aT0Tuh8PYS8PcyldsaWBEhgploiEyXdz5FJd//zTq
	zwdKotvTnk4ijDfi5hIn9NrvazqjeKRoDoxc2/yLbyX7etrue4Qn1QNOql++kuELjdXRPFfFeYx
	kmsqmyW+k7EOyvhT/fxQy3el/WI5IMoegcCnUHqEplyv/rKLGtTX3YeHv7vylq/nm3miQ4J3rQu
	XXVJ2llP5/Hy6Y8ER02CdvEdjKwgEtvZJPphsOXFT/FELGzvKrqm7/Ht/MwPBCt1UI7fh1z2fPd
	QXB1E08T3xlKBRjCj2MLuq60KL/rX4G6/X4U5eXrWo7aEuQ==
X-Received: by 2002:a05:690c:498e:b0:81e:6cd1:5322 with SMTP id
 00721157ae682-820224a7cc1mr93960227b3.20.1786025953861; Thu, 06 Aug 2026
 07:19:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260804142419.2274153-1-hadess@hadess.net> <20260804142419.2274153-2-hadess@hadess.net>
 <CABBYNZKb7_6CBD_Aq27PHUqA5=_P_NeyY4qcKOjCNk-dRN6-cw@mail.gmail.com> <e534cfe2f4fa335ebeb795e1c704584d77f3e1ed.camel@hadess.net>
In-Reply-To: <e534cfe2f4fa335ebeb795e1c704584d77f3e1ed.camel@hadess.net>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 6 Aug 2026 10:19:02 -0400
X-Gm-Features: AUfX_mwctt9Oz8L_12i8M1Vr6ekV9Gr90OlY3jlH_llJyjmQsLVaHOp7WIkTwMg
Message-ID: <CABBYNZ+MErHXc4N3FYN53pQhLn6YKtrkvMm66s1dab92HOjfgw@mail.gmail.com>
Subject: Re: [BlueZ, v2 1/3] avrcp: Split off name parsing from parse_*_element()
To: Bastien Nocera <hadess@hadess.net>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Bastien,

On Thu, Aug 6, 2026 at 5:59=E2=80=AFAM Bastien Nocera <hadess@hadess.net> w=
rote:
>
> On Wed, 2026-08-05 at 13:12 -0400, Luiz Augusto von Dentz wrote:
> > Hi Bastien,
> >
> > On Tue, Aug 4, 2026 at 10:31=E2=80=AFAM Bastien Nocera <hadess@hadess.n=
et>
> > wrote:
> > >
> > > This will allow us to use the name extraction code in
> > > parse_media_element() and parse_folder_element() separately, such
> > > as in tests.
> > > ---
> > >  Makefile.plugins             |  1 +
> > >  profiles/audio/avrcp-parse.c | 47
> > > ++++++++++++++++++++++++++++++++++++
> > >  profiles/audio/avrcp-parse.h | 19 +++++++++++++++
> > >  profiles/audio/avrcp.c       | 26 +++++---------------
> > >  4 files changed, 73 insertions(+), 20 deletions(-)
> > >  create mode 100644 profiles/audio/avrcp-parse.c
> > >  create mode 100644 profiles/audio/avrcp-parse.h
> > >
> > > diff --git a/Makefile.plugins b/Makefile.plugins
> > > index ac667beda847..a505fcd6691f 100644
> > > --- a/Makefile.plugins
> > > +++ b/Makefile.plugins
> > > @@ -37,6 +37,7 @@ builtin_modules +=3D avrcp
> > >  builtin_sources +=3D profiles/audio/control.h
> > > profiles/audio/control.c \
> > >                         profiles/audio/avctp.h
> > > profiles/audio/avctp.c \
> > >                         profiles/audio/avrcp.h
> > > profiles/audio/avrcp.c \
> > > +                       profiles/audio/avrcp-parse.h
> > > profiles/audio/avrcp-parse.c \
> > >                         profiles/audio/avrcp-player.c
> > >  endif
> > >
> > > diff --git a/profiles/audio/avrcp-parse.c b/profiles/audio/avrcp-
> > > parse.c
> > > new file mode 100644
> > > index 000000000000..d3d0a070a4da
> > > --- /dev/null
> > > +++ b/profiles/audio/avrcp-parse.c
> > > @@ -0,0 +1,47 @@
> > > +// SPDX-License-Identifier: GPL-2.0-or-later
> > > +/*
> > > + *
> > > + *  BlueZ - Bluetooth protocol stack for Linux
> > > + *
> > > + *  Copyright (C) 2026  Red Hat Inc.
> > > + *
> > > + *
> > > + */
> > > +
> > > +#include "avrcp-parse.h"
> > > +#include "src/shared/util.h"
> > > +
> > > +gboolean parse_media_element_name(uint8_t *operands, uint16_t len,
> > > +                                        char *name, uint16_t
> > > *namesize)
> > > +{
> > > +       uint16_t namelen;
> > > +
> > > +       if (len < 13)
> > > +               return FALSE;
> > > +
> > > +       memset(name, 0, NAME_MAX_LEN);
> > > +       *namesize =3D get_be16(&operands[11]);
> > > +       namelen =3D MIN(*namesize, NAME_MAX_LEN - 1);
> > > +       if (namelen > 0) {
> > > +               memcpy(name, &operands[13], namelen);
> > > +               strtoutf8(name, namelen);
> > > +       }
> > > +
> > > +       return TRUE;
> > > +}
> > > +
> > > +gboolean parse_media_folder_name(uint8_t *operands, uint16_t len,
> > > +                                       char *name)
> > > +{
> > > +       uint16_t namelen;
> > > +
> > > +       if (len < 12)
> > > +               return FALSE;
> > > +
> > > +       memset(name, 0, NAME_MAX_LEN);
> > > +       namelen =3D MIN(get_be16(&operands[12]), NAME_MAX_LEN - 1);
> > > +       if (namelen > 0)
> > > +               memcpy(name, &operands[14], namelen);
> > > +
> > > +       return TRUE;
> > > +}
> >
> > Rather than creating yet another file how about hosting this under
> > shared/util.h directly? It already depends on it anyway, we could got
> > with something like strntoutf8 or a similar function that checks the
> > length, etc, actually be maybe better to do it under
> > util_iov_pull_utf8(iov, len, str, str_max_len) so we can load the pdu
> > into the iov then use iov_pull_mem, etc, to verify that we have
> > enough
> > bytes in a generic manner.
>
> That would be nice follow-up work to be done, but this patch is
> specifically about being able to test the out-of-bounds access caused
> by those 2 portions of code in patch #2.
>
> Then the fix is applied in patch #3.
>
> Finally, we could optimise/clean this up and remove that parsing code,
> but that would be in a 4th patch.

I don't think this is the best approach because test-avrcp is testing
the wrong implementation, so that needs rework. I'd go straight to
shared/util helper function which would allow us to create test cases
immediately without changing a bunch of things and removing
test-avrcp.c in the process.

--=20
Luiz Augusto von Dentz
