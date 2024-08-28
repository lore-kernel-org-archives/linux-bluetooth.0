Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AB801741F8
	for <linux-bluetooth@vger.kernel.org>; Wed, 28 Aug 2024 14:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724856641; cv=none; b=tMK3fGHEmnvTNsmI9UybpilkQBhNiTJLe8dHIKu36IBU0jhw61u1+8MNvGUpVfCReLr1gUNJ+/CrIwgEQRm60lqag8WV+WS0WjghYZkWWVlHi0ob3WlmZyWElWKsulI78FkRaeGsHWKFYcm3bCbq61WSoxnN39to1uILeJalBSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724856641; c=relaxed/simple;
	bh=CoB1875CEGxBdDZ0HxgVQfgdRCEuncSGNCTmuF2h2Lk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A/kLvUkZY7Nnc5+FG4cSOUkpz687VtXWS3Q+YFldTzNKRRZxATkzUquXWO3bEj4HJYgGJyBoedBSHTjGnDnusKLzECpPTWb48+vUUZ0ADS5tCzCek8WHxTdX8+tGwUYKAk3qMW/WUw97oW8167mGCz7QNLtQ3SqwTEP+p6NxJ5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RRcH5gNn; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RRcH5gNn"
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2f4f24263acso90333301fa.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 28 Aug 2024 07:50:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724856637; x=1725461437; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oUxu3ERC+6OTWWsQf9puHMlDiYGzoPcLLVbKtzBdCaI=;
        b=RRcH5gNnJJalUcyv9S5YhXq7KdyUEhe6Fo+MBbx7L+f9R/rQvGAGkxWco4d4kNqebj
         +LBtl2usGNmfihsJ7Y5YDTrCEV7C2qZE/svgH59sV9HsRcESrrPbmJsncLFteXOLsbTW
         NRluFn6Ff65v/U4xd0SQ+2NNIPnH7w4SErxkF3sATclm/UJqf0s4KOY2tg+tk3nDhsaA
         ebbL/PVdDyqUoMvW6/MSvk6OHuUmTStdYlvjb5R0WMYE0LwxDmVFdpmnynovhG8fKfvc
         3JNR+GsuMOR3Oy2xhlHOQ2W+NlvrojJnJZyiCPtWtOCa76sXZM6ToxRC85oWZvJt/KwG
         TdFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724856637; x=1725461437;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oUxu3ERC+6OTWWsQf9puHMlDiYGzoPcLLVbKtzBdCaI=;
        b=Kb8cIXhw6gYYUwsAddNxGtLgrCCPZVf24jrG6hc1KH6Elnnn/GdN5LJ/ADCdtUPfil
         QLM/dUmYz9VNWFqR68qS1Mb2ZJcJ8k2HV6hBGYT/VNO4F5EVikU+CrAiYRwqgtysQMLl
         NhDfRi+VRTk/2Hxq/kWhgV+6bEhg8lLlBz89xuHofdHY+DYciWd+1ocVunMlUmjkZHht
         clfQgCS+gLTSBjHmoWGm7rmCA2SCsf6ORXJrP5baZHHw12VN5GKPDYxo5pLQgf9gaDlZ
         6xpTIpFUCGkHZawy6y63zpKlG/rVDYb+4hM04JHXV69V4h4LstIbi27lxdMWx4A4Bvy4
         bW/Q==
X-Gm-Message-State: AOJu0YwKgPAUVcEDYakJnABIrDxOi687X0BMyf85Smj4vWTMrLl8ZmHc
	w8aZqTOJ3wK+ctcMOPp6Ij/nJRO/AQ8f8WA3vVkFNe4LVf0aV8qYO5UrWjfl98g5+5+8zNUzIx0
	5VRQ4JRtOKKsJWR5mAlWPCsdfYqkBfQ==
X-Google-Smtp-Source: AGHT+IH+uwWy3PUWgV+/OLOiOD+J28PCB47xj36KtZN8arh3VARz6uWizoAkZvvcLjPd5epbZLSKk1kcSgSH9bVSre4=
X-Received: by 2002:a05:651c:210e:b0:2f5:7ed:abb0 with SMTP id
 38308e7fff4ca-2f507edace7mr116506341fa.26.1724856636368; Wed, 28 Aug 2024
 07:50:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240828041644.3331363-1-raj.khem@gmail.com> <CABBYNZ+vFe+TnsnwL01aRdkLswdYAg2H44VqSXpkC-G-pdJ3gw@mail.gmail.com>
 <CAMKF1soY46mW0brghP+d_nqfoZN3RpqqayZ+wucVXy+_KZ88+w@mail.gmail.com>
In-Reply-To: <CAMKF1soY46mW0brghP+d_nqfoZN3RpqqayZ+wucVXy+_KZ88+w@mail.gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 28 Aug 2024 10:50:24 -0400
Message-ID: <CABBYNZKKCcn2unGCpGejZwOocggXYa3h8xG9QSmdx2gdYifUTg@mail.gmail.com>
Subject: Re: [PATCH v5 BlueZ] Provide GNU basename compatible implementation
To: Khem Raj <raj.khem@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Khem,

On Wed, Aug 28, 2024 at 10:20=E2=80=AFAM Khem Raj <raj.khem@gmail.com> wrot=
e:
>
> On Wed, Aug 28, 2024 at 7:07=E2=80=AFAM Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
> >
> > Hi Khem,
> >
> > On Wed, Aug 28, 2024 at 12:17=E2=80=AFAM Khem Raj <raj.khem@gmail.com> =
wrote:
> > >
> > > Call to basename() relies on a GNU extension
> > > to take a const char * vs a char *. Let's define
> > > a trivial helper function to ensure compatibility
> > > with musl.
> > >
> > > Fixes Issue: https://github.com/bluez/bluez/issues/843
> > > ---
> > > v2: Fix code formatter reported errors
> > > v3: Make just node_name as const and keep node_dir as such
> > > v4: Fix code formatting errors
> > > v5: Redo the patch to address textrels seen on ppc32/arm
> >
> > Not really sure why you went with something completely different then
> > the util helper?
>
> util helper meant that we need to add -I option to build the utilities
> needing this function from util,h
> and this -I was causing more stuff to be included into these binaries,
> It got caught when building for ppc32
> since yocto build started failing due to textrels and I realized that
> specifying -I can open up the possibility of
> wrong includes coming from src/ dir. Thats the reason I went with the
> alternative approach which is safer
> although the function is copied twice.

Where did you see this error? Perhaps we need to include such a build
into our own CI then, anyway it seems fair enough but Id add some
comment about it, also the other possibility would be to add something
like l_path_basename to libell but I guess that comes with its own
problem since we would need to uprev the ell dependency.

>
> >
> > >  configure.ac            | 11 ++++++++++-
> > >  mesh/mesh-config-json.c |  4 +++-
> > >  mesh/missing.h          | 21 +++++++++++++++++++++
> > >  mesh/rpl.c              |  1 +
> > >  tools/hex2hcd.c         |  1 +
> > >  tools/missing.h         | 21 +++++++++++++++++++++
> > >  6 files changed, 57 insertions(+), 2 deletions(-)
> > >  create mode 100644 mesh/missing.h
> > >  create mode 100644 tools/missing.h
> > >
> > > diff --git a/configure.ac b/configure.ac
> > > index d31eb1656..f0f1ec100 100644
> > > --- a/configure.ac
> > > +++ b/configure.ac
> > > @@ -70,7 +70,16 @@ AC_CHECK_LIB(pthread, pthread_create, dummy=3Dyes,
> > >  AC_CHECK_LIB(dl, dlopen, dummy=3Dyes,
> > >                         AC_MSG_ERROR(dynamic linking loader is requir=
ed))
> > >
> > > -AC_CHECK_HEADERS(linux/types.h linux/if_alg.h linux/uinput.h linux/u=
hid.h sys/random.h)
> > > +AC_CHECK_HEADERS(string.h linux/types.h linux/if_alg.h linux/uinput.=
h linux/uhid.h sys/random.h)
> > > +
> > > +# basename may be only available in libgen.h with the POSIX behavior=
,
> > > +# not desired here
> > > +AC_CHECK_DECLS([basename], [],
> > > +                               AC_MSG_WARN([GNU basename extension n=
ot found]),
> > > +                               [#define _GNU_SOURCE 1
> > > +                                #include <string.h>
> > > +                                ])
> > > +
> > >
> > >  PKG_CHECK_MODULES(GLIB, glib-2.0 >=3D 2.28)
> > >
> > > diff --git a/mesh/mesh-config-json.c b/mesh/mesh-config-json.c
> > > index c198627c6..e3b0a1809 100644
> > > --- a/mesh/mesh-config-json.c
> > > +++ b/mesh/mesh-config-json.c
> > > @@ -28,6 +28,7 @@
> > >  #include <ell/ell.h>
> > >  #include <json-c/json.h>
> > >
> > > +#include "mesh/missing.h"
> > >  #include "mesh/mesh-defs.h"
> > >  #include "mesh/util.h"
> > >  #include "mesh/mesh-config.h"
> > > @@ -2694,7 +2695,8 @@ bool mesh_config_load_nodes(const char *cfgdir_=
name, mesh_config_node_func_t cb,
> > >
> > >  void mesh_config_destroy_nvm(struct mesh_config *cfg)
> > >  {
> > > -       char *node_dir, *node_name;
> > > +       char *node_dir;
> > > +       const char* node_name;
> > >         char uuid[33];
> > >
> > >         if (!cfg)
> > > diff --git a/mesh/missing.h b/mesh/missing.h
> > > new file mode 100644
> > > index 000000000..eaf32815e
> > > --- /dev/null
> > > +++ b/mesh/missing.h
> > > @@ -0,0 +1,21 @@
> > > +// SPDX-License-Identifier: LGPL-2.1-or-later
> > > +/*
> > > + *
> > > + *  BlueZ - Bluetooth protocol stack for Linux
> > > + *
> > > + *  Copyright (C) 2024  Khem Raj <raj.khem@gmail.com>
> > > + *
> > > + */
> > > +
> > > +#ifdef HAVE_CONFIG_H
> > > +#include <config.h>
> > > +#endif
> > > +#if !HAVE_DECL_BASENAME
> > > +#include <string.h>
> > > +static inline const char *basename(const char *path)
> > > +{
> > > +  const char *base =3D strrchr(path, '/');
> > > +
> > > +  return base ? base + 1 : path;
> > > +}
> > > +#endif
> > > diff --git a/mesh/rpl.c b/mesh/rpl.c
> > > index fb225dddd..2fa17d72f 100644
> > > --- a/mesh/rpl.c
> > > +++ b/mesh/rpl.c
> > > @@ -24,6 +24,7 @@
> > >
> > >  #include <ell/ell.h>
> > >
> > > +#include "mesh/missing.h"
> > >  #include "mesh/mesh-defs.h"
> > >
> > >  #include "mesh/node.h"
> > > diff --git a/tools/hex2hcd.c b/tools/hex2hcd.c
> > > index e6dca5a81..452ab2beb 100644
> > > --- a/tools/hex2hcd.c
> > > +++ b/tools/hex2hcd.c
> > > @@ -24,6 +24,7 @@
> > >  #include <stdlib.h>
> > >  #include <stdbool.h>
> > >  #include <sys/stat.h>
> > > +#include "tools/missing.h"
> > >
> > >  static ssize_t process_record(int fd, const char *line, uint16_t *up=
per_addr)
> > >  {
> > > diff --git a/tools/missing.h b/tools/missing.h
> > > new file mode 100644
> > > index 000000000..eaf32815e
> > > --- /dev/null
> > > +++ b/tools/missing.h
> > > @@ -0,0 +1,21 @@
> > > +// SPDX-License-Identifier: LGPL-2.1-or-later
> > > +/*
> > > + *
> > > + *  BlueZ - Bluetooth protocol stack for Linux
> > > + *
> > > + *  Copyright (C) 2024  Khem Raj <raj.khem@gmail.com>
> > > + *
> > > + */
> > > +
> > > +#ifdef HAVE_CONFIG_H
> > > +#include <config.h>
> > > +#endif
> > > +#if !HAVE_DECL_BASENAME
> > > +#include <string.h>
> > > +static inline const char *basename(const char *path)
> > > +{
> > > +  const char *base =3D strrchr(path, '/');
> > > +
> > > +  return base ? base + 1 : path;
> > > +}
> > > +#endif
> > >
> >
> >
> > --
> > Luiz Augusto von Dentz



--=20
Luiz Augusto von Dentz
