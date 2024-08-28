Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7EBF188CB8
	for <linux-bluetooth@vger.kernel.org>; Wed, 28 Aug 2024 14:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724854042; cv=none; b=fNf6lWI/agx4P3+2+h/kBkYf/RXdqII07mf8FRfa+ZWSC2zfbLnyLUiX06Xd+uUdTIFSgx4MLch908S8/DkwpeMEEpd2ExnFF/r1obozwx2D4WrztYAIr5QK93jU4fXXrg1CEW8fh+C1J8h1ootsd4KVcKJy7StsPWZ3UBYfATw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724854042; c=relaxed/simple;
	bh=zM6iJSOUGJiYhDTC47xjI9HOBpNXa1M5lQh+rrMyzac=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UarbyHsGaV+ZnENZ5AgmU/q5pod96LmczqxRiO4L+FPGfGgLCjhIveQsGMyEs0t3sA7Di98HeF9o0OuKaID3rpc4DyUGPcpjMPwrMXEjLD2oAx8LjBDM1xifM9AvbPpvMGhgv/UoYmQwxewjLuX9wtKyNaqxI98Bmlax30h4R6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HZXdemRj; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HZXdemRj"
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2f51b67e16dso20962231fa.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 28 Aug 2024 07:07:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724854039; x=1725458839; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=54VyEeiMNoEhZMtZlTUiKnu7ABNTmseUw/SE5rOP3dQ=;
        b=HZXdemRjN8IJkpdRHa4qOKiAThyaOOIMmBC0NgkNfeSw78lZfzAvlydJl5wmtwzHx6
         QZJRgvLZWNkk+RU8nhvyVCsWFsFhV0fWVNOK1rhRURC1LDraB/R74IU02RnraeIglPP5
         atBlZOou/X5/wb5ohPedNOW5aX2Q9gC9snAndCQ9R3mCr0ox/DGja/YIrDrL7uYojfhM
         FBXVd32NaIpNUD2l30sxaa+OKZ1o08y4TAaGU3/AGxLtK5iuIGagnT7TXy37gojWrsIO
         vE2m5xutcxGxyJ41JodouJO+MGgiEpS5iJZz3oEx454w5wz8eG5W6ZKECbsw6zYPMOJb
         tBGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724854039; x=1725458839;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=54VyEeiMNoEhZMtZlTUiKnu7ABNTmseUw/SE5rOP3dQ=;
        b=u0ssRR5dXJ0sn4Crh2RMRYGOsSxL0Nw3g+Pn8upMjv/jerdRSC4LmC2RnG2fzyNVSs
         VSoX6iQt6Yx9gp+iH2sFzYyMZVMeT0DzsDspdu5cj64eps9vuXcEuQxMZIGSEoNzi6Pm
         O4GBb8O293Y9z4HMXfBnUwwmf4nQQJ/LkeLgDj8nIIeW6rMvbK28qYb2yZl14zBhFfIz
         XE7PMSZw+433DLymFD8NHmnMmv2B/GqL4X4eG1DESBWUL+/sNANzQZYUbL7HIOnGEKZ+
         Tha3K2p9wRtMjLLi0lorjf4e6bAzdtiFbrSN/l89sf8iF0ekjwV5rZWg1hzGPST11VFj
         CZIQ==
X-Gm-Message-State: AOJu0Ywtqpbyu6xUmcj++zbi8pUO8IUzR2mQb/UMuOkSlUhmxGZbJvIp
	nNrFJgSpw0W9GvwJIzT7JFhoiC5PZDn1I6K6nAApu4+8wEW09OTbrh/0RdXjQBRXY3l+Z2YfuTn
	DCeP3LNcOQL0bzyRaiogyxOUFTtU=
X-Google-Smtp-Source: AGHT+IEK5A+OkplFeSn69v1Cl9WA+4CDhUj+o/wfMxtnP3Buc8b2lVtOT+5IoxMaEQMCvbm30Ji8koomvrEMRHeidyE=
X-Received: by 2002:a2e:95d9:0:b0:2f3:f8d7:d556 with SMTP id
 38308e7fff4ca-2f55b67c04amr12884101fa.18.1724854038031; Wed, 28 Aug 2024
 07:07:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240828041644.3331363-1-raj.khem@gmail.com>
In-Reply-To: <20240828041644.3331363-1-raj.khem@gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 28 Aug 2024 10:07:05 -0400
Message-ID: <CABBYNZ+vFe+TnsnwL01aRdkLswdYAg2H44VqSXpkC-G-pdJ3gw@mail.gmail.com>
Subject: Re: [PATCH v5 BlueZ] Provide GNU basename compatible implementation
To: Khem Raj <raj.khem@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Khem,

On Wed, Aug 28, 2024 at 12:17=E2=80=AFAM Khem Raj <raj.khem@gmail.com> wrot=
e:
>
> Call to basename() relies on a GNU extension
> to take a const char * vs a char *. Let's define
> a trivial helper function to ensure compatibility
> with musl.
>
> Fixes Issue: https://github.com/bluez/bluez/issues/843
> ---
> v2: Fix code formatter reported errors
> v3: Make just node_name as const and keep node_dir as such
> v4: Fix code formatting errors
> v5: Redo the patch to address textrels seen on ppc32/arm

Not really sure why you went with something completely different then
the util helper?

>  configure.ac            | 11 ++++++++++-
>  mesh/mesh-config-json.c |  4 +++-
>  mesh/missing.h          | 21 +++++++++++++++++++++
>  mesh/rpl.c              |  1 +
>  tools/hex2hcd.c         |  1 +
>  tools/missing.h         | 21 +++++++++++++++++++++
>  6 files changed, 57 insertions(+), 2 deletions(-)
>  create mode 100644 mesh/missing.h
>  create mode 100644 tools/missing.h
>
> diff --git a/configure.ac b/configure.ac
> index d31eb1656..f0f1ec100 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -70,7 +70,16 @@ AC_CHECK_LIB(pthread, pthread_create, dummy=3Dyes,
>  AC_CHECK_LIB(dl, dlopen, dummy=3Dyes,
>                         AC_MSG_ERROR(dynamic linking loader is required))
>
> -AC_CHECK_HEADERS(linux/types.h linux/if_alg.h linux/uinput.h linux/uhid.=
h sys/random.h)
> +AC_CHECK_HEADERS(string.h linux/types.h linux/if_alg.h linux/uinput.h li=
nux/uhid.h sys/random.h)
> +
> +# basename may be only available in libgen.h with the POSIX behavior,
> +# not desired here
> +AC_CHECK_DECLS([basename], [],
> +                               AC_MSG_WARN([GNU basename extension not f=
ound]),
> +                               [#define _GNU_SOURCE 1
> +                                #include <string.h>
> +                                ])
> +
>
>  PKG_CHECK_MODULES(GLIB, glib-2.0 >=3D 2.28)
>
> diff --git a/mesh/mesh-config-json.c b/mesh/mesh-config-json.c
> index c198627c6..e3b0a1809 100644
> --- a/mesh/mesh-config-json.c
> +++ b/mesh/mesh-config-json.c
> @@ -28,6 +28,7 @@
>  #include <ell/ell.h>
>  #include <json-c/json.h>
>
> +#include "mesh/missing.h"
>  #include "mesh/mesh-defs.h"
>  #include "mesh/util.h"
>  #include "mesh/mesh-config.h"
> @@ -2694,7 +2695,8 @@ bool mesh_config_load_nodes(const char *cfgdir_name=
, mesh_config_node_func_t cb,
>
>  void mesh_config_destroy_nvm(struct mesh_config *cfg)
>  {
> -       char *node_dir, *node_name;
> +       char *node_dir;
> +       const char* node_name;
>         char uuid[33];
>
>         if (!cfg)
> diff --git a/mesh/missing.h b/mesh/missing.h
> new file mode 100644
> index 000000000..eaf32815e
> --- /dev/null
> +++ b/mesh/missing.h
> @@ -0,0 +1,21 @@
> +// SPDX-License-Identifier: LGPL-2.1-or-later
> +/*
> + *
> + *  BlueZ - Bluetooth protocol stack for Linux
> + *
> + *  Copyright (C) 2024  Khem Raj <raj.khem@gmail.com>
> + *
> + */
> +
> +#ifdef HAVE_CONFIG_H
> +#include <config.h>
> +#endif
> +#if !HAVE_DECL_BASENAME
> +#include <string.h>
> +static inline const char *basename(const char *path)
> +{
> +  const char *base =3D strrchr(path, '/');
> +
> +  return base ? base + 1 : path;
> +}
> +#endif
> diff --git a/mesh/rpl.c b/mesh/rpl.c
> index fb225dddd..2fa17d72f 100644
> --- a/mesh/rpl.c
> +++ b/mesh/rpl.c
> @@ -24,6 +24,7 @@
>
>  #include <ell/ell.h>
>
> +#include "mesh/missing.h"
>  #include "mesh/mesh-defs.h"
>
>  #include "mesh/node.h"
> diff --git a/tools/hex2hcd.c b/tools/hex2hcd.c
> index e6dca5a81..452ab2beb 100644
> --- a/tools/hex2hcd.c
> +++ b/tools/hex2hcd.c
> @@ -24,6 +24,7 @@
>  #include <stdlib.h>
>  #include <stdbool.h>
>  #include <sys/stat.h>
> +#include "tools/missing.h"
>
>  static ssize_t process_record(int fd, const char *line, uint16_t *upper_=
addr)
>  {
> diff --git a/tools/missing.h b/tools/missing.h
> new file mode 100644
> index 000000000..eaf32815e
> --- /dev/null
> +++ b/tools/missing.h
> @@ -0,0 +1,21 @@
> +// SPDX-License-Identifier: LGPL-2.1-or-later
> +/*
> + *
> + *  BlueZ - Bluetooth protocol stack for Linux
> + *
> + *  Copyright (C) 2024  Khem Raj <raj.khem@gmail.com>
> + *
> + */
> +
> +#ifdef HAVE_CONFIG_H
> +#include <config.h>
> +#endif
> +#if !HAVE_DECL_BASENAME
> +#include <string.h>
> +static inline const char *basename(const char *path)
> +{
> +  const char *base =3D strrchr(path, '/');
> +
> +  return base ? base + 1 : path;
> +}
> +#endif
>


--=20
Luiz Augusto von Dentz
