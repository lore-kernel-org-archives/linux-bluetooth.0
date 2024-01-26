Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF8A81DFF9
	for <linux-bluetooth@vger.kernel.org>; Fri, 26 Jan 2024 18:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706295025; cv=none; b=Yllow2BJvNKik0t4T96knYTxBNVS6nvrEe7HqHFTZ/U45l7xulHebp67MI3JeD7xx7OBXiBFcfcKd0/mTB8M9i5ScNL5/fQbIhqok796u0LhW2RW1ELSn+rQaCx26OxeXEiUtmi04VfG5THRaR1rMjCkgecgnqUWEdXSYs6bwgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706295025; c=relaxed/simple;
	bh=Rzeki7Pq8UsUZZ7ZHdtygdqBkyKIomoQVPamcq4xviI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gYYkzt/xd52mdIXhNQatXkPloLEZA79+igKE84n/GZYltaUJYgO3eM9+ziTTFpuqLX51udKJkT4U6e313GYcrp4DSf1sIaMpGz9BDaxthcquIJzN90gNibCVmR6KBgEhi5gSJQGB+VzjA3qhoIzwPr/4mpIHjokaVhsaa3L1BVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FfRODCJM; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FfRODCJM"
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2cf4696b90fso6901391fa.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 26 Jan 2024 10:50:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706295022; x=1706899822; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7f0TZI1bnhvGPt5FmyNmDOJ+gyLsazsxmetAf8DGpzQ=;
        b=FfRODCJMMXiszwuyY5POlChEFoio1MrFeQp6GtzQC4xywKNoKms4IDsToeWr7xH3Xb
         NWj+r9feVeRV5skSB77kmC1UA2qeZUupFpjArh2TXd/dM7dQS9CX7F6L8YPhlsyAEuqz
         h+fSEM/+VO4Yp6tKAlNwv5IKOI7vGKE6hA0jNHNeIMdX1Pqojp6xK5gTNtQ4hfmvqrqK
         u1hC2BMyPTBucOOKDn49hZTDY/VsvnTeJN2BSKVz7zwbqz2BGZyvNGF1nu6gQ6tXKJG1
         SmgNpypiMu9YQDrkMSK5N4t0PTJT6Pbu+hY38yWhB8xHfzS4RjGghcUVFsAPEa46Eo3J
         275A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706295022; x=1706899822;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7f0TZI1bnhvGPt5FmyNmDOJ+gyLsazsxmetAf8DGpzQ=;
        b=m652JW4hE9kmTSBLHlkgz386tI5uVEkdu+FP/t5dBVydmcRYHzcgOHv//rsvtmwAlf
         L4d2r0nBV8cTkR/BsnXr4ecf2pGpNU9SheddTFgLSQEKehKT8m7WUmeRD9XAkmi5yDhf
         qJnhCF0ECkc+h3EZMUw4XuojJTep/E4Cq/sNsYrHUir85dDii94ZACJHCQRagBJetEgj
         l2u13PduEyxAXBJkqBqacQyoRr2Qmhk0dHAKQLV32OFh48MMw+yTG3BOH3ZtduUHQgPu
         eq2fsFqp8JMLGs4glbJSqA70sw/VH8Kx5wkWgcPPvHVW5F/d9vy90+Ne21qVUxbc9ouC
         1OPQ==
X-Gm-Message-State: AOJu0YyJocMqxFR08RShzfeZfee4ZiE1C1DXxtBwF9+YvMN5jeoBqXs5
	K04pYg+gv8z1uOpWhq7JMZKa+lkApgM8upo4nLm6lwJCFobSp/lkP6UKEqgYnDCXr5WW05H5lnq
	5J5hSnC5ED4agqy2b5gE+UiU3BWo=
X-Google-Smtp-Source: AGHT+IEfq4DOBS1kDziQ8wnBvZg1RZEUsK53UtovCvOzDTxs8yvTXMtxl0L4EsTTu5UiSQ8ILr/u6cYOoSxFxh2E3Gw=
X-Received: by 2002:a2e:3305:0:b0:2cf:121:3ccb with SMTP id
 d5-20020a2e3305000000b002cf01213ccbmr143472ljc.55.1706295021628; Fri, 26 Jan
 2024 10:50:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240125-rm-ext-plugins-v3-0-d141f7870bb6@gmail.com> <20240125-rm-ext-plugins-v3-2-d141f7870bb6@gmail.com>
In-Reply-To: <20240125-rm-ext-plugins-v3-2-d141f7870bb6@gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Fri, 26 Jan 2024 13:50:08 -0500
Message-ID: <CABBYNZKafK6LRauk4RMVeE8PpsazFd75nxSA+a0-v2iHqsYQcQ@mail.gmail.com>
Subject: Re: [PATCH BlueZ v3 2/8] obexd: factor out external plugin support
To: emil.l.velikov@gmail.com
Cc: linux-bluetooth@vger.kernel.org, Emil Velikov <emil.velikov@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Emil,

On Wed, Jan 24, 2024 at 7:08=E2=80=AFPM Emil Velikov via B4 Relay
<devnull+emil.l.velikov.gmail.com@kernel.org> wrote:
>
> From: Emil Velikov <emil.velikov@collabora.com>
>
> As a whole all plugins should be built-in, otherwise they would be using
> internal, undocumented, unversioned, unstable API.
>
> Flesh out the external plugin support into a few pre-processor blocks
> and simplify the normal path.
>
> Hide the internal API (omit export-dynamic) when built without external
> plugins.
> ---
>  Makefile.obexd     |  2 ++
>  obexd/src/obexd.h  |  2 +-
>  obexd/src/plugin.c | 93 ++++++++++++++++++++++++++++++++++++------------=
------
>  obexd/src/plugin.h |  4 +++
>  4 files changed, 70 insertions(+), 31 deletions(-)
>
> diff --git a/Makefile.obexd b/Makefile.obexd
> index 5d1a4ff65..9175de2a4 100644
> --- a/Makefile.obexd
> +++ b/Makefile.obexd
> @@ -86,7 +86,9 @@ obexd_src_obexd_LDADD =3D lib/libbluetooth-internal.la =
\
>                         $(ICAL_LIBS) $(DBUS_LIBS) $(LIBEBOOK_LIBS) \
>                         $(LIBEDATASERVER_LIBS) $(GLIB_LIBS) -ldl
>
> +if EXTERNAL_PLUGINS
>  obexd_src_obexd_LDFLAGS =3D $(AM_LDFLAGS) -Wl,--export-dynamic
> +endif
>
>  obexd_src_obexd_CPPFLAGS =3D $(AM_CPPFLAGS) $(GLIB_CFLAGS) $(DBUS_CFLAGS=
) \
>                                 $(ICAL_CFLAGS) -DOBEX_PLUGIN_BUILTIN \
> diff --git a/obexd/src/obexd.h b/obexd/src/obexd.h
> index fe312a65b..af5265da5 100644
> --- a/obexd/src/obexd.h
> +++ b/obexd/src/obexd.h
> @@ -18,7 +18,7 @@
>  #define OBEX_MAS       (1 << 8)
>  #define OBEX_MNS       (1 << 9)
>
> -gboolean plugin_init(const char *pattern, const char *exclude);
> +void plugin_init(const char *pattern, const char *exclude);
>  void plugin_cleanup(void);
>
>  gboolean manager_init(void);
> diff --git a/obexd/src/plugin.c b/obexd/src/plugin.c
> index a3eb24753..212299fa5 100644
> --- a/obexd/src/plugin.c
> +++ b/obexd/src/plugin.c
> @@ -37,11 +37,14 @@
>  static GSList *plugins =3D NULL;
>
>  struct obex_plugin {
> +#if EXTERNAL_PLUGINS
>         void *handle;
> +#endif
>         const struct obex_plugin_desc *desc;
>  };
>
> -static gboolean add_plugin(void *handle, const struct obex_plugin_desc *=
desc)
> +#if EXTERNAL_PLUGINS
> +static gboolean add_external_plugin(void *handle, const struct obex_plug=
in_desc *desc)
>  {
>         struct obex_plugin *plugin;
>
> @@ -65,6 +68,26 @@ static gboolean add_plugin(void *handle, const struct =
obex_plugin_desc *desc)
>
>         return TRUE;
>  }
> +#endif
> +
> +static void add_plugin(const struct obex_plugin_desc *desc)
> +{
> +       struct obex_plugin *plugin;
> +
> +       plugin =3D g_try_new0(struct obex_plugin, 1);
> +       if (plugin =3D=3D NULL)
> +               return;
> +
> +       plugin->desc =3D desc;
> +
> +       if (desc->init() < 0) {
> +               g_free(plugin);
> +               return;
> +       }
> +
> +       plugins =3D g_slist_append(plugins, plugin);
> +       DBG("Plugin %s loaded", desc->name);
> +}
>
>  static gboolean check_plugin(const struct obex_plugin_desc *desc,
>                                 char **patterns, char **excludes)
> @@ -93,42 +116,23 @@ static gboolean check_plugin(const struct obex_plugi=
n_desc *desc,
>  }
>
>
> -#include "builtin.h"
> -
> -gboolean plugin_init(const char *pattern, const char *exclude)
> +static void external_plugin_init(char **patterns, char **excludes)
>  {
> -       char **patterns =3D NULL;
> -       char **excludes =3D NULL;
> +#if EXTERNAL_PLUGINS
>         GDir *dir;
>         const char *file;
> -       unsigned int i;
>
> -       if (strlen(PLUGINDIR) =3D=3D 0)
> -               return FALSE;
> -
> -       if (pattern)
> -               patterns =3D g_strsplit_set(pattern, ":, ", -1);
> -
> -       if (exclude)
> -               excludes =3D g_strsplit_set(exclude, ":, ", -1);
> -
> -       DBG("Loading builtin plugins");
> -
> -       for (i =3D 0; __obex_builtin[i]; i++) {
> -               if (check_plugin(__obex_builtin[i],
> -                                       patterns, excludes) =3D=3D FALSE)
> -                       continue;
> +       warn("Using external plugins is not officially supported.\n");
> +       warn("Consider upstreaming your plugins into the BlueZ project.")=
;
>
> -               add_plugin(NULL,  __obex_builtin[i]);
> -       }
> +       if (strlen(PLUGINDIR) =3D=3D 0)
> +               return;
>
>         DBG("Loading plugins %s", PLUGINDIR);
>
>         dir =3D g_dir_open(PLUGINDIR, 0, NULL);
>         if (!dir) {
> -               g_strfreev(patterns);
> -               g_strfreev(excludes);
> -               return FALSE;
> +               return;
>         }
>
>         while ((file =3D g_dir_read_name(dir)) !=3D NULL) {
> @@ -164,15 +168,42 @@ gboolean plugin_init(const char *pattern, const cha=
r *exclude)
>                         continue;
>                 }
>
> -               if (add_plugin(handle, desc) =3D=3D FALSE)
> +               if (add_external_plugin(handle, desc) =3D=3D FALSE)
>                         dlclose(handle);
>         }
>
>         g_dir_close(dir);
> +#endif
> +}
> +
> +#include "builtin.h"
> +
> +void plugin_init(const char *pattern, const char *exclude)
> +{
> +       char **patterns =3D NULL;
> +       char **excludes =3D NULL;
> +       unsigned int i;
> +
> +       if (pattern)
> +               patterns =3D g_strsplit_set(pattern, ":, ", -1);
> +
> +       if (exclude)
> +               excludes =3D g_strsplit_set(exclude, ":, ", -1);
> +
> +       DBG("Loading builtin plugins");
> +
> +       for (i =3D 0; __obex_builtin[i]; i++) {
> +               if (check_plugin(__obex_builtin[i],
> +                                       patterns, excludes) =3D=3D FALSE)
> +                       continue;
> +
> +               add_plugin(__obex_builtin[i]);
> +       }
> +
> +       external_plugin_init(patterns, excludes);
> +
>         g_strfreev(patterns);
>         g_strfreev(excludes);
> -
> -       return TRUE;
>  }
>
>  void plugin_cleanup(void)
> @@ -187,8 +218,10 @@ void plugin_cleanup(void)
>                 if (plugin->desc->exit)
>                         plugin->desc->exit();
>
> +#if EXTERNAL_PLUGINS
>                 if (plugin->handle !=3D NULL)
>                         dlclose(plugin->handle);
> +#endif
>
>                 g_free(plugin);
>         }
> diff --git a/obexd/src/plugin.h b/obexd/src/plugin.h
> index a91746cbc..e1756b9bf 100644
> --- a/obexd/src/plugin.h
> +++ b/obexd/src/plugin.h
> @@ -20,10 +20,14 @@ struct obex_plugin_desc {
>                         #name, init, exit \
>                 };
>  #else
> +#if EXTERNAL_PLUGINS
>  #define OBEX_PLUGIN_DEFINE(name,init,exit) \
>                 extern struct obex_plugin_desc obex_plugin_desc \
>                                 __attribute__ ((visibility("default"))); =
\
>                 const struct obex_plugin_desc obex_plugin_desc =3D { \
>                         #name, init, exit \
>                 };
> +#else
> +#error "Requested non built-in plugin, while external plugins is disable=
d"
> +#endif
>  #endif
>
> --
> 2.43.0

How about we do something like:

https://gist.github.com/Vudentz/0b8bcb78a8898614fc4848cbf44a0a9f

That way we leave it to the compiler to remove the dead code when
linking but it still build checks which catches errors such as:

make --no-print-directory all-am
  CC       obexd/src/obexd-plugin.o
obexd/src/plugin.c: In function =E2=80=98external_plugin_init=E2=80=99:
obexd/src/plugin.c:123:9: error: implicit declaration of function
=E2=80=98warn=E2=80=99 [-Werror=3Dimplicit-function-declaration]
  123 |         warn("Using external plugins is not officially supported.\n=
");
      |         ^~~~

>


--=20
Luiz Augusto von Dentz
