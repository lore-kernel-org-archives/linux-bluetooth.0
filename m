Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FAA816B386
	for <linux-bluetooth@vger.kernel.org>; Wed, 28 Aug 2024 14:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724854808; cv=none; b=XrkGGyc0UwIyN4BemXcct01s1Fa8C3wyZKpcqO2Q/5Upn99mc6BJSjTYvDDyMxTthEiAw+cm332qnZCJItV2rJw1x+49fQC1RVY9Hp3N/Msj4TIJZkUan+CSSEzWgjkjEgFRFaiRcNbv8fVyRmbGRBaMJ04QAFj+iGCTeEq4Ckg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724854808; c=relaxed/simple;
	bh=LAgoPKXLoF1+1x4V/OIZI2UoWW0x0FlZgBFl8Ob/5f0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Oyelxnp/fM4vyI061x/kRfP1+L6IGkvVcHLybTfUT85IR1XcI9e7BAsrJDd2gfktauOuBs5sgsS+Dlt6lId7135CUClw32yoYcAEpJXPPMeJHKSAkuIMrsKwity/3Zcax3kHrVcLZjUC20vtQD1vFhrVmV8whLKyd0EnMbMeu8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OOlXA33F; arc=none smtp.client-ip=209.85.161.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OOlXA33F"
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-5df9542f3d8so95788eaf.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 28 Aug 2024 07:20:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724854806; x=1725459606; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jJamv98FW6wOyLHUFg+vmz14hCJncPe8xCKwX4Db4TA=;
        b=OOlXA33FBxONsyzkA8Q/3Co/C2KnnwAvzeebhQ0N9V5IYLnT5So2vI7/kciQcrSNPI
         deaxNzdxLeeRqoZpnqhW6B9oNAlaVbnldz3HeAWsa6MSwdsBMvP+lz8lq21s86JGk/IU
         YGsWluzyVBr2KfefvQGVdB6TtrKfQmbzwp742FnrtKDoPEv9w/D3Of7bLNp+7KDYsAKm
         flQSsQbmuallPmvl2KTPq19L1CsybqBWTd1aJyHsMy0TKHziwcFdYEh0tmHMCO83sG3J
         uDzcWaAvYwubCeOdFEygCMlxC3OgFMVyqekZoMRq6U5jjR4yYb6gH4u7gZaV8RDJ+Bls
         UiuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724854806; x=1725459606;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jJamv98FW6wOyLHUFg+vmz14hCJncPe8xCKwX4Db4TA=;
        b=WI60BW9QfMKoAsz64GMeaQPYuyVNc4PHd1KZBD3xdYfvbQbfBtrmI9DwhEcJS/ebsJ
         zvD2620cx1uQQiIdD5rmN6m5+nFFNK2xsnOfiOEmhfwkiksbHzSdr/6rgjhle4frcFZ/
         EjAcaaA//uMn0oB7ixcBBtp0Cwcn4dwjSY1tIHevXXIiYOe4+W1+uGHQEgzh/PnRU1ns
         jWv2xhNvvqcsps/Fm/Q+4DWbP2fCB/H4RPwfqFuvl6glurWbQeoqQIwVNEieGjOvltVO
         xlgRzXHCysG5CUb+ilTAHm3S+RzRB/WPcsTITbEyKXkl2qjV+cpTf65dVHvTXuSmqc2T
         TSnQ==
X-Gm-Message-State: AOJu0YwcTK9LFAQz/NIIqSDbgEG8zOWztW1iLjCOecNBtu5lvWaJr9/B
	YKtyOML6qHGmBhNFCUHQWaYibYBJSgGuKGRmo3qPZ53A/btp8bjpyqBO1ltDNVSiUJOAepdFY9g
	3wIy4njLn3QrerbWbLxF5uT3h5sQ=
X-Google-Smtp-Source: AGHT+IHowc/5HzsABfYaEpATCFMGWOkLohdjmLU+gq8jmo9+w24WmAqAGLgnSYC7ucni5pzRp86aMhBlVlyCOYfD6zs=
X-Received: by 2002:a05:6820:168a:b0:5da:9b98:e208 with SMTP id
 006d021491bc7-5dcc6259366mr17967295eaf.5.1724854806316; Wed, 28 Aug 2024
 07:20:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240828041644.3331363-1-raj.khem@gmail.com> <CABBYNZ+vFe+TnsnwL01aRdkLswdYAg2H44VqSXpkC-G-pdJ3gw@mail.gmail.com>
In-Reply-To: <CABBYNZ+vFe+TnsnwL01aRdkLswdYAg2H44VqSXpkC-G-pdJ3gw@mail.gmail.com>
From: Khem Raj <raj.khem@gmail.com>
Date: Wed, 28 Aug 2024 07:19:40 -0700
Message-ID: <CAMKF1soY46mW0brghP+d_nqfoZN3RpqqayZ+wucVXy+_KZ88+w@mail.gmail.com>
Subject: Re: [PATCH v5 BlueZ] Provide GNU basename compatible implementation
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 28, 2024 at 7:07=E2=80=AFAM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Khem,
>
> On Wed, Aug 28, 2024 at 12:17=E2=80=AFAM Khem Raj <raj.khem@gmail.com> wr=
ote:
> >
> > Call to basename() relies on a GNU extension
> > to take a const char * vs a char *. Let's define
> > a trivial helper function to ensure compatibility
> > with musl.
> >
> > Fixes Issue: https://github.com/bluez/bluez/issues/843
> > ---
> > v2: Fix code formatter reported errors
> > v3: Make just node_name as const and keep node_dir as such
> > v4: Fix code formatting errors
> > v5: Redo the patch to address textrels seen on ppc32/arm
>
> Not really sure why you went with something completely different then
> the util helper?

util helper meant that we need to add -I option to build the utilities
needing this function from util,h
and this -I was causing more stuff to be included into these binaries,
It got caught when building for ppc32
since yocto build started failing due to textrels and I realized that
specifying -I can open up the possibility of
wrong includes coming from src/ dir. Thats the reason I went with the
alternative approach which is safer
although the function is copied twice.

>
> >  configure.ac            | 11 ++++++++++-
> >  mesh/mesh-config-json.c |  4 +++-
> >  mesh/missing.h          | 21 +++++++++++++++++++++
> >  mesh/rpl.c              |  1 +
> >  tools/hex2hcd.c         |  1 +
> >  tools/missing.h         | 21 +++++++++++++++++++++
> >  6 files changed, 57 insertions(+), 2 deletions(-)
> >  create mode 100644 mesh/missing.h
> >  create mode 100644 tools/missing.h
> >
> > diff --git a/configure.ac b/configure.ac
> > index d31eb1656..f0f1ec100 100644
> > --- a/configure.ac
> > +++ b/configure.ac
> > @@ -70,7 +70,16 @@ AC_CHECK_LIB(pthread, pthread_create, dummy=3Dyes,
> >  AC_CHECK_LIB(dl, dlopen, dummy=3Dyes,
> >                         AC_MSG_ERROR(dynamic linking loader is required=
))
> >
> > -AC_CHECK_HEADERS(linux/types.h linux/if_alg.h linux/uinput.h linux/uhi=
d.h sys/random.h)
> > +AC_CHECK_HEADERS(string.h linux/types.h linux/if_alg.h linux/uinput.h =
linux/uhid.h sys/random.h)
> > +
> > +# basename may be only available in libgen.h with the POSIX behavior,
> > +# not desired here
> > +AC_CHECK_DECLS([basename], [],
> > +                               AC_MSG_WARN([GNU basename extension not=
 found]),
> > +                               [#define _GNU_SOURCE 1
> > +                                #include <string.h>
> > +                                ])
> > +
> >
> >  PKG_CHECK_MODULES(GLIB, glib-2.0 >=3D 2.28)
> >
> > diff --git a/mesh/mesh-config-json.c b/mesh/mesh-config-json.c
> > index c198627c6..e3b0a1809 100644
> > --- a/mesh/mesh-config-json.c
> > +++ b/mesh/mesh-config-json.c
> > @@ -28,6 +28,7 @@
> >  #include <ell/ell.h>
> >  #include <json-c/json.h>
> >
> > +#include "mesh/missing.h"
> >  #include "mesh/mesh-defs.h"
> >  #include "mesh/util.h"
> >  #include "mesh/mesh-config.h"
> > @@ -2694,7 +2695,8 @@ bool mesh_config_load_nodes(const char *cfgdir_na=
me, mesh_config_node_func_t cb,
> >
> >  void mesh_config_destroy_nvm(struct mesh_config *cfg)
> >  {
> > -       char *node_dir, *node_name;
> > +       char *node_dir;
> > +       const char* node_name;
> >         char uuid[33];
> >
> >         if (!cfg)
> > diff --git a/mesh/missing.h b/mesh/missing.h
> > new file mode 100644
> > index 000000000..eaf32815e
> > --- /dev/null
> > +++ b/mesh/missing.h
> > @@ -0,0 +1,21 @@
> > +// SPDX-License-Identifier: LGPL-2.1-or-later
> > +/*
> > + *
> > + *  BlueZ - Bluetooth protocol stack for Linux
> > + *
> > + *  Copyright (C) 2024  Khem Raj <raj.khem@gmail.com>
> > + *
> > + */
> > +
> > +#ifdef HAVE_CONFIG_H
> > +#include <config.h>
> > +#endif
> > +#if !HAVE_DECL_BASENAME
> > +#include <string.h>
> > +static inline const char *basename(const char *path)
> > +{
> > +  const char *base =3D strrchr(path, '/');
> > +
> > +  return base ? base + 1 : path;
> > +}
> > +#endif
> > diff --git a/mesh/rpl.c b/mesh/rpl.c
> > index fb225dddd..2fa17d72f 100644
> > --- a/mesh/rpl.c
> > +++ b/mesh/rpl.c
> > @@ -24,6 +24,7 @@
> >
> >  #include <ell/ell.h>
> >
> > +#include "mesh/missing.h"
> >  #include "mesh/mesh-defs.h"
> >
> >  #include "mesh/node.h"
> > diff --git a/tools/hex2hcd.c b/tools/hex2hcd.c
> > index e6dca5a81..452ab2beb 100644
> > --- a/tools/hex2hcd.c
> > +++ b/tools/hex2hcd.c
> > @@ -24,6 +24,7 @@
> >  #include <stdlib.h>
> >  #include <stdbool.h>
> >  #include <sys/stat.h>
> > +#include "tools/missing.h"
> >
> >  static ssize_t process_record(int fd, const char *line, uint16_t *uppe=
r_addr)
> >  {
> > diff --git a/tools/missing.h b/tools/missing.h
> > new file mode 100644
> > index 000000000..eaf32815e
> > --- /dev/null
> > +++ b/tools/missing.h
> > @@ -0,0 +1,21 @@
> > +// SPDX-License-Identifier: LGPL-2.1-or-later
> > +/*
> > + *
> > + *  BlueZ - Bluetooth protocol stack for Linux
> > + *
> > + *  Copyright (C) 2024  Khem Raj <raj.khem@gmail.com>
> > + *
> > + */
> > +
> > +#ifdef HAVE_CONFIG_H
> > +#include <config.h>
> > +#endif
> > +#if !HAVE_DECL_BASENAME
> > +#include <string.h>
> > +static inline const char *basename(const char *path)
> > +{
> > +  const char *base =3D strrchr(path, '/');
> > +
> > +  return base ? base + 1 : path;
> > +}
> > +#endif
> >
>
>
> --
> Luiz Augusto von Dentz
