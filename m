Received: from mail-yx1-f52.google.com (mail-yx1-f52.google.com [74.125.224.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21BA93BD643
	for <linux-bluetooth@vger.kernel.org>; Wed,  5 Aug 2026 16:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785948255; cv=pass; b=C39OaZIiqcK8glse1qVBT5azuUVXkGUEN7PD/hLGJBF+SFXfkxQiqbTFNJzVmktRtyErZY8v+6YGVo+NxFyiX4hurud42wR+bWATUhoTbXESNkUbQUJXkO4x3qyNyf3trdmRpiSGM8pVLYfUk4TCMSABwlk64I1Q3MCmZXkKaNo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785948255; c=relaxed/simple;
	bh=dnlr0vm4gt+oXDZuihMuHe5vB3r3Y1CjRHIpgSXuVhY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YO3buhKAniOFwFE3fWWlvnHkywrytmTyMo1Satq+bIL0AV30snbx6LqKLHCBdhVjDZ3WWoNoEcxOTf49O2Y0rgq4VHz/rxEwfk65QrABMXexRSIfDXI4mDzehPXeYr/61iodDH6i3YIpj1U5YCqNnA6wKCmcHAHd+Ci3cKg2zuc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XwszXaEQ; arc=pass smtp.client-ip=74.125.224.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XwszXaEQ"
Received: by mail-yx1-f52.google.com with SMTP id 956f58d0204a3-668296d0ff3so1656831d50.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 05 Aug 2026 09:44:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785948253; cv=none;
        d=google.com; s=arc-20260327;
        b=qJoGXNcRMTJwAjg8o40DscArdzG8LqmmhusSv48KCuE+GKq5zwaU3a+fwleMRvZQ0+
         nE6tXK4tWhqT4KzS2V9Sx+Heu1HeK3z4gOJuOx88Xr2zTjLIqrZGcZ9I5cFxTxdbmu/F
         LCFUZWY9txAi6G3UC8Eob1s9oFOMma2hrq8pNzWXgOcPAQQ//wJ2uor17SYKVw0tCm7R
         47QQ+hxBSAt+nRaoN0LXgsvPddEpZffNceHikPtR/8PsUoTx2D5/vMHiOAD0PcvgmxoU
         MW0hLELBtZEMMPAQ13aPfqzT2v3FU2BY5NIXv8Ku7yGWi+zNyHN9fiWdPYO0+58faAcl
         8Ifg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=lwzrvm4OnIwwb9wB6xFivMZEKkykQj/6iHbkvXX9SHs=;
        fh=ArdDmUQzzfkt7diMa+kfWdd+IJsnjcf7biWiU4/zryA=;
        b=nIGYwFErQZHmnxCa3WF6CH5fkkcx1/4huzw1EqEGIZqpoiMpq1GXxDWN6Z+n6WFlRn
         tnOqjrfI27q/81PIM7foYZqmkMk1OqiTWYflzBEOrKzSvI/j0dhZL9woRcqsoQYAmdy9
         j02QXoDtodi5S+V0p8xiozunwT2cVbDkMcE57uOwYlNTj3DzrnmFesYKqX8sb/K89nbB
         oyduE8rbE4QaVYy4xbe/+h0O3UAumVj+1cZOaet7lHSQrMwGtJLkI1dzIaQUthUz+t/F
         9YhSGDN8DsLiiXMjQCfHPX+rZwrPC93wywluZPbNGRR7LRo3HhL/fGfBIyajv/wvyylw
         PecA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785948253; x=1786553053; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=lwzrvm4OnIwwb9wB6xFivMZEKkykQj/6iHbkvXX9SHs=;
        b=XwszXaEQVwPII3HDjFxOLyCcxxZOVK7BuOLfJKJVpbWkxri7alZn6FxdykAZk5r7JO
         U1Gxp/+1pa6P+aOHiAjcbyyUxp+Xuvbkx8AqNp7h0Fau8vQCk/dVSpkcDZGqEOZ7T2VI
         IOK1l0+dILkPtQl3WThr3C7mmLF8X9kxib0WrkCRFPRP5kI+7WsFlNY5E95tmiXIqKgL
         CjYyS3ns7ghVPLKnX05vH+/ALlLlyJNLkjIi1BpSmaQVDzK204LMStO+JEYD3hAzBaD6
         HNkdgBNwGrXTI6YfGo/fLYDBJ1G8i4NttjKR2ekBdHfBO0FKSn9/9TyeDGzxCh+ODL9Y
         XG6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785948253; x=1786553053;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lwzrvm4OnIwwb9wB6xFivMZEKkykQj/6iHbkvXX9SHs=;
        b=qb4tWRF5NlT6eo7Y+Z+OAviYvI7WF/yiRAlaBik3iOU3uoqzeN/t2dUduIiVHf8d3h
         Fe5CmiTXNsc1QFk5owSECFRvjsVCwt+autttbo4T/2jfl/cK8jPBJxs1ogaTHDiosSgY
         ztjjJabrVf1aIFWSywdEMkMsArwDL2MWghgSGPSIcW1zuPada4GpAfaCZRLKApDB1lhp
         4g1HIs3jrMZOSqvIBwpuqXQ8+UjeqihSWldVaKoLLRSwUw9B3+KTsC2kgjNZPWUCXfzX
         rxnYM0UGb+p2YO6oE2AEU8mp+fFPM21Ln7wjl8s4EkF1EMdC54juNlWYOs9ixdD7AfzU
         JPcQ==
X-Gm-Message-State: AOJu0YxzHbHQUCAg+aT99oy+0CwBeVWKcDzWPhHMZl4/XTpFvg9uDiyd
	FPqBMJg2ZotZXizDyUQg8FzvSU3dXqASuQFhFP0xQqZBWYYdIzcretcm5bbvDcBlkNao/Cj8hS2
	etaO/1ZApbQ3/Qzw53TD3OyPROIdn3yw=
X-Gm-Gg: AR+sD10/R4ILh4OFFAxPV0Gv0kgWfasmfMmgthq/1ZJ8px5CGyPcfVJ0E6yKt9V0olb
	LYNUKb2FFoNL4+q0vMaBrVSRcvQdxNRWiFPNzs0xL4BHT3c7pcdY5xuVx7plnj+mCH8A7qaRMUb
	p74VZ38stKZSJhEjU1m0Po6tG1Nez9WSJwlswrB7pIe4nMuQ30dbP4zLgh0uO1YZs6Be7MgJLyc
	KbhnLqKcVY1OsakypHmwrLEYmsKRZQ9BjDo/spvyibHH7PaiACaFBq/0L6Lm3JYYw8qAMFbn6rs
	t/aVaRbJoy5TBG+TXcA54L3qFTQ+REWJE1RASOglYdBaDRQJ76QTzTkLX1iguoyA5AeOgMozDB3
	cX3ZLcf76kQ6smaEQi2caEBnd70lSo3RvnDg=
X-Received: by 2002:a05:690e:1688:b0:667:689d:531c with SMTP id
 956f58d0204a3-6699a893edamr4293742d50.5.1785948252808; Wed, 05 Aug 2026
 09:44:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260804142419.2274153-1-hadess@hadess.net> <20260804142419.2274153-3-hadess@hadess.net>
 <CABBYNZKoj_jr=msyTAiQ+AcV9Xf4MjCAjvcq0pDf8bWPBoypyQ@mail.gmail.com> <45bc30093210c94efca124c980135176c2375c90.camel@hadess.net>
In-Reply-To: <45bc30093210c94efca124c980135176c2375c90.camel@hadess.net>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 5 Aug 2026 12:44:01 -0400
X-Gm-Features: AUfX_my83vofyzPgl6e3BbGxgiF-AAfmPxcsf6OuHdzm2dFVAcnOPZfJZi1Xq8Q
Message-ID: <CABBYNZ+MYf9AxCm-nWEqf0qOGxScsU=Ghb0OrvuT2SdjGvD6ZA@mail.gmail.com>
Subject: Re: [BlueZ, v2 2/3] unit: Adapt poc_*_oob.c test into a new test
To: Bastien Nocera <hadess@hadess.net>
Cc: linux-bluetooth@vger.kernel.org, 
	Elman Shahbazov <shahbazovelman97@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Bastien,

On Wed, Aug 5, 2026 at 3:59=E2=80=AFAM Bastien Nocera <hadess@hadess.net> w=
rote:
>
> On Tue, 2026-08-04 at 12:46 -0400, Luiz Augusto von Dentz wrote:
> > Hi Bastien,
> >
> > On Tue, Aug 4, 2026 at 10:31=E2=80=AFAM Bastien Nocera <hadess@hadess.n=
et>
> > wrote:
> > >
> > > Adapt poc_avrcp_oob.c and poc_folder_oob.c into unit tests.
> > >
> > > Co-authored-by: Elman Shahbazov <shahbazovelman97@gmail.com>
> > > ---
> > >  Makefile.am           |  9 +++++
> > >  unit/test-avrcp-sec.c | 76
> > > +++++++++++++++++++++++++++++++++++++++++++
> > >  2 files changed, 85 insertions(+)
> > >  create mode 100644 unit/test-avrcp-sec.c
> > >
> > > diff --git a/Makefile.am b/Makefile.am
> > > index 19c468d3a504..e3baa4155c1f 100644
> > > --- a/Makefile.am
> > > +++ b/Makefile.am
> > > @@ -660,6 +660,15 @@ unit_test_avrcp_SOURCES =3D unit/test-avrcp.c \
> > >  unit_test_avrcp_LDADD =3D lib/libbluetooth-internal.la \
> > >                                 src/libshared-glib.la $(GLIB_LIBS)
> > >
> > > +unit_tests +=3D unit/test-avrcp-sec
> > > +
> > > +unit_test_avrcp_sec_SOURCES =3D unit/test-avrcp-sec.c \
> > > +                       profiles/audio/avrcp-parse.c \
> > > +                       profiles/audio/avrcp-parse.h \
> > > +                       src/log.h src/log.c
> > > +unit_test_avrcp_sec_LDADD =3D lib/libbluetooth-internal.la \
> > > +                               src/libshared-glib.la $(GLIB_LIBS)
> >
> > Any reason why this couldn't live inside test-avrcp.c?
>
> Because most of the code in test-avrcp.c is mocked in unit/avrcp-
> lib.[ch] and conflicts with code from profiles/audio/avrcp.c. I really
> did try...

Ok, well then perhaps we should start testing what we really use in
the avrcp plugin rather than the removed Android code, or we could
have a bigger task: converting this type of code to src/shared/avrcp.c
(e.g. bt_avrcp) so it can be unit tested.

> I can change the name of the test if needed.

I'm not concerned about the name, I'm concerned about the number of
unit test files which could otherwise be in a single file instead of
duplicating a lot of context.

> >
> > >  unit_tests +=3D unit/test-hfp
> > >
> > >  unit_test_hfp_SOURCES =3D unit/test-hfp.c
> > > diff --git a/unit/test-avrcp-sec.c b/unit/test-avrcp-sec.c
> > > new file mode 100644
> > > index 000000000000..a100b2d68e35
> > > --- /dev/null
> > > +++ b/unit/test-avrcp-sec.c
> > > @@ -0,0 +1,76 @@
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
> > > +#ifdef HAVE_CONFIG_H
> > > +#include <config.h>
> > > +#endif
> > > +
> > > +#include <glib.h>
> > > +
> > > +#include "src/shared/util.h"
> > > +#include "src/shared/tester.h"
> > > +#include "src/log.h"
> > > +
> > > +#include "profiles/audio/avrcp-parse.h"
> > > +
> > > +static void avrcp_element_name_oob(gconstpointer data)
> > > +{
> > > +       char name[255];
> > > +       uint16_t namesize;
> > > +       gboolean ret;
> > > +
> > > +       /* Crafting a malicious payload.
> > > +        * Actual packet length (len) =3D 14 bytes */
> > > +       uint8_t malicious_packet[14] =3D {0};
> > > +
> > > +       /* Specify namesize =3D 1000 (0x03E8 in Big Endian) at offset
> > > 11 */
> > > +       malicious_packet[11] =3D 0x03;
> > > +       malicious_packet[12] =3D 0xE8;
> > > +
> > > +       /* Launching the PoC. We transmit a 14-byte packet, but
> > > namesize=3D1000... */
> > > +       ret =3D parse_media_element_name(malicious_packet,
> > > sizeof(malicious_packet),
> > > +                                      name, &namesize);
> > > +       if (ret)
> > > +               tester_test_passed();
> > > +       else
> > > +               tester_test_failed();
> > > +}
> > > +
> > > +static void avrcp_folder_name_oob(gconstpointer data)
> > > +{
> > > +       char name[255];
> > > +       gboolean ret;
> > > +
> > > +       /* Crafting a malicious payload.
> > > +        * Actual packet length (len) =3D 14 bytes */
> > > +       uint8_t malicious_packet[14] =3D {0};
> > > +
> > > +       /* Specify namesize =3D 1000 (0x03E8 in Big Endian) at offset
> > > 12 */
> > > +       malicious_packet[12] =3D 0x03;
> > > +       malicious_packet[13] =3D 0xE8;
> > > +
> > > +       /* Launching the PoC. We transmit a 14-byte packet, but
> > > namesize=3D1000... */
> > > +       ret =3D parse_media_folder_name(malicious_packet,
> > > sizeof(malicious_packet),
> > > +                                     name);
> > > +       if (ret)
> > > +               tester_test_passed();
> > > +       else
> > > +               tester_test_failed();
> > > +}
> > > +
> > > +int main(int argc, char *argv[])
> > > +{
> > > +       tester_init(&argc, &argv);
> > > +
> > > +       tester_add("/avrcp-element-name-oob", NULL, NULL,
> > > avrcp_element_name_oob, NULL);
> > > +       tester_add("/avrcp-folder-name-oob", NULL, NULL,
> > > avrcp_folder_name_oob, NULL);
> > > +
> > > +       return tester_run();
> > > +}
> > > --
> > > 2.55.0
> > >
> > >
> >



--=20
Luiz Augusto von Dentz
