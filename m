Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4C1922F388
	for <linux-bluetooth@vger.kernel.org>; Fri, 12 Dec 2025 21:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765573683; cv=none; b=HD2N5xhgZauNtMnULgioDVKImrhEKLeyOYFZ13OLwqqRZY43EWtwVItdwhZMvNQgRikxbDfVv6K8IXUAwJwy2fydIZFrX2zwk1moyRhpDvM07rjJCIFIdCLE1Dfqu2JXTnwsih8u811H60H6QucvHq0Uxi0AHpYGu4/CSQEsUow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765573683; c=relaxed/simple;
	bh=acKEaQhkC/NTU/UlC5pkskFKenMrJYKGKI9MHBM35+0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nyGxg2uNH2XepRHwbf/HNCkHGh9xAof0j7EOp9/RaQVal3d7fCFNuUNJPTApC/XUz8nQxzu9O5qhHqp4ttK0sn5oTMjmfiwSvYcQdiznZ5PJY/vos9ya2V6ZpAZyey5HC4HrcgSQv2v2X6h4NTGqBgzrmlUPidZDNx89EM0KSgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V5HcHuGi; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V5HcHuGi"
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-37b983fbd45so12764201fa.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 12 Dec 2025 13:07:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765573678; x=1766178478; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zFNXvCa4ywoAPAOSZjr80hACLlB5r4DYWssCbce1gLU=;
        b=V5HcHuGiFCAJWbqZ75CQqrCsWqc9xq5yQdRzYI2XihIakiiyK7husHXmGfParG1M31
         GWTT6onk8vqSR6Q72BZvlSq9cI4BE7fBXWqEMYzkGHpYuUN7lfcPBo26cWQb+igmID+N
         EKKt19YFI/NGupuNQb8JV5PE9ZKL3NG/Rr955rOyMp2/eFK8GnoUNzcD3k/mwgxFnBF7
         W2m2hpogLN4qTz5YPU+iOJgLX0VB6GwoQXMJ3uEicImTuaif47s5y4he+BNRwDIhzXOt
         Bss7sV5mendQouMybN619ErneWGLjdxRdQuf9hp/7voG7Wkq1CguolXpukShR3Z0+NE5
         G5sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765573678; x=1766178478;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zFNXvCa4ywoAPAOSZjr80hACLlB5r4DYWssCbce1gLU=;
        b=X480BoyfDdVJT8gaW8ReeyqRkcjqeFml6cDdD1Oj7UmhzznYBsMrCZ2L/+HpW+hlDQ
         cC6M65mB48qZI71MLCIsN0Wo9zMN3HezpnpEY/TKaB8XIYkT5cf7m8oa0jd7ab0/+JaX
         rWKpVx68Ebhx4Xxop41oeYIWAyLSqWGCwpaTNAr3c5S2NDG9dQHqHJzIx1g95EE2150V
         vpwEOfkdF4bExkgC3iHOR88PLQI7+9wSTFkOH3ZWf3bgkneCCZk59jilu8M3b41Wk7UC
         ev6R4Ck9OpCLM5+3J3AcCRY+36Ytll9hivtDLPWvah3O1qFoVFajXkpRhDpgcney2N/o
         Vezg==
X-Gm-Message-State: AOJu0YyaftemU4F7gGddb00VWYxq+7yNDOcwL+8q4otB1heYcnBwKgZB
	fMRFmkHZmewy3fwmPxab2evzotSZXVrp8Apc3FvBQmartVR5iiQ8MiCf2rAfe3pmKque0OXD/sR
	R1NLI3FmNuoJyzBxli1caYOQp++crBwTSegE9
X-Gm-Gg: AY/fxX5PZu95Q8U1irI+88VGRevKd/zU/JG4tzYE1bp/GvKZB8gH1M5CaBgzJkHQliG
	Vhddv+JYoz4Rm06M6rjPUT9kS4GvPKhOyQOpegOYrqm8xnlJFda1uDIMt6KmXxnlf8S8/IWYgbE
	Rn0HXMsGUuiIVVJpZuaj9hHxHnz5VBr8FyrOknUHOE8fo9QaQiGHhDUQOYwJVVUbju+Qg3hlgOF
	HTPPMBn/cmMdBxMETVQhWUmT5G+o01wPlVxknJxxmdaHZkZYAOu1mDDGxGNOJnQt4VYuXqogJgP
	1TgW
X-Google-Smtp-Source: AGHT+IHroZw+3HCn76cHhM3nl2ZBJY8IR9z0vMAZgy0PGZBdy8gUj5paXSkJelhGfgZVIDRBf+t/BG1yH+QLxwxD0D8=
X-Received: by 2002:a05:651c:4ca:b0:34c:e79:7827 with SMTP id
 38308e7fff4ca-37fd087df7amr9507521fa.21.1765573677371; Fri, 12 Dec 2025
 13:07:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251212202240.4057163-1-mafm@igalia.com> <20251212202240.4057163-2-mafm@igalia.com>
In-Reply-To: <20251212202240.4057163-2-mafm@igalia.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Fri, 12 Dec 2025 16:07:43 -0500
X-Gm-Features: AQt7F2pmEkhv3R8I0gVAMB-0hUAAm0pFLQEp-iNcgS0bdgmVbn1w1aj8ftLS7I0
Message-ID: <CABBYNZ+NDSvSHO9Q9jfavE0e+895-oNFs-5Y6P0=h2XX_+oq=w@mail.gmail.com>
Subject: Re: [PATCH BlueZ v2 1/1] Support for config fragments (conf.d style dirs)
To: "Manuel A. Fernandez Montecelo" <mafm@igalia.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Manuel,

On Fri, Dec 12, 2025 at 3:23=E2=80=AFPM Manuel A. Fernandez Montecelo
<mafm@igalia.com> wrote:
>
> Support config fragments, to read config from conf.d directories.
> Those dirs will be main.conf.d for main.conf, analog for input.conf
> and network.conf.
>
> This is commonly supported by other tools, as an extension of the main
> config file(s).  It is useful and convenient in several situations,
> for example:
>
> * distributions can set different values from the defaults shipped
>   upstream, without having to modify the config file
>
> * different packages or config-management tools can change config just
>   by adding, removing or modifying files in that directory; instead of
>   editing the main config files
>
> The main or base config files will be processed first, and then files
> in the conf.d dirs, if existing.
>
> When reading these config files in conf.d dirs, they override values
> for keys in the base config files (or default config set in code).
> For example, for "main.conf" the directory to be processed will be
> "main.conf.d", in the same basedir as the config file
> (e.g. /etc/main.conf, /etc/main.conf.d/).  The same for input.conf and
> network.conf.
>
> Within the conf.d directory, the format of the filename should be
> '^([0-9][0-9])-([a-zA-Z0-9-_])*\.conf$', that is, starting with "00-"
> to "99-", ending in ".conf", and with a mix of alphanumeric characters
> with dashes and underscores in between.  For example:
> '01-override-general-secureconnections.conf'.
>
> Files named differently will not be considered, and accepting groups
> or keys not present in the base config depends on the code, currently
> set to "NOT accept new groups" but "YES to accept new keys".  This is
> because the base config files contain all the groups, but most keys
> are commented-out, with the values set in code.
>
> The candidate files within the given directory are sorted (with
> g_strcmp0(), so the ordering will be as with strcmp()).  The
> configuration in the files being processed later will override
> previous config, in particular the main/base config files, but also
> the one from previous files processed, if the Group and Key coincide.
>
> For example, consider 'main.conf' that contains the defaults:
>
>   [General]
>   DiscoverableTimeout=3D0
>   PairableTimeout=3D0
>
> and there is a file 'main.conf.d/70-default-timeouts-vendor.conf'
> containing settings for these keys:
>
>   [General]
>   DiscoverableTimeout=3D30
>   PairableTimeout=3D30
>
> and another 'main.conf.d/99-default-timeouts-local.conf'
> containing settings only for 'PairableTimeout':
>
>   [General]
>   PairableTimeout=3D15
>
> What happens is:
> 1) First, the 'main.conf' is processed as usual;
> 2) then 'main.conf.d/70-default-timeouts-vendor.conf' is processed,
>    overriding the two values from the main config file with the given
>    values;
> 3) and finally 'main.conf.d/99-default-timeouts-local.conf' is
>    processed, overriding once again only 'PairableTimeout'.
>
> The final, effective values are:
>
>   DiscoverableTimeout=3D30
>   PairableTimeout=3D15
> ---
>  Makefile.am                |   1 +
>  profiles/input/hog.c       |   3 +
>  profiles/input/manager.c   |   3 +
>  profiles/network/manager.c |   3 +
>  src/conf_d.c               | 202 +++++++++++++++++++++++++++++++++++++
>  src/conf_d.h               |  76 ++++++++++++++
>  src/main.c                 |   3 +
>  7 files changed, 291 insertions(+)
>  create mode 100644 src/conf_d.c
>  create mode 100644 src/conf_d.h
>
> diff --git a/Makefile.am b/Makefile.am
> index e152ae648..f8516bacd 100644
> --- a/Makefile.am
> +++ b/Makefile.am
> @@ -307,6 +307,7 @@ pkglibexec_PROGRAMS +=3D src/bluetoothd
>  bluetoothd_internal_sources =3D \
>                         $(attrib_sources) $(btio_sources) \
>                         src/log.h src/log.c \
> +                       src/conf_d.h src/conf_d.c \
>                         src/backtrace.h src/backtrace.c \
>                         src/rfkill.c src/btd.h src/sdpd.h \
>                         src/sdpd-server.c src/sdpd-request.c \
> diff --git a/profiles/input/hog.c b/profiles/input/hog.c
> index f50a0f217..6d2348c26 100644
> --- a/profiles/input/hog.c
> +++ b/profiles/input/hog.c
> @@ -39,6 +39,7 @@
>  #include "src/shared/att.h"
>  #include "src/shared/gatt-client.h"
>  #include "src/plugin.h"
> +#include "src/conf_d.h"
>
>  #include "suspend.h"
>  #include "attrib/att.h"
> @@ -246,6 +247,8 @@ static void hog_read_config(void)
>                 return;
>         }
>
> +       confd_process_config(config, filename, FALSE, TRUE);
> +
>         config_auto_sec =3D g_key_file_get_boolean(config, "General",
>                                         "LEAutoSecurity", &err);
>         if (!err) {
> diff --git a/profiles/input/manager.c b/profiles/input/manager.c
> index 0fcd6728c..68691ec52 100644
> --- a/profiles/input/manager.c
> +++ b/profiles/input/manager.c
> @@ -27,6 +27,7 @@
>  #include "src/device.h"
>  #include "src/profile.h"
>  #include "src/service.h"
> +#include "src/conf_d.h"
>
>  #include "device.h"
>  #include "server.h"
> @@ -75,6 +76,8 @@ static GKeyFile *load_config_file(const char *file)
>                 return NULL;
>         }
>
> +       confd_process_config(keyfile, file, FALSE, TRUE);
> +
>         return keyfile;
>  }
>
> diff --git a/profiles/network/manager.c b/profiles/network/manager.c
> index 693547d45..e9b620b0f 100644
> --- a/profiles/network/manager.c
> +++ b/profiles/network/manager.c
> @@ -28,6 +28,7 @@
>  #include "src/device.h"
>  #include "src/profile.h"
>  #include "src/service.h"
> +#include "src/conf_d.h"
>
>  #include "bnep.h"
>  #include "connection.h"
> @@ -47,6 +48,8 @@ static void read_config(const char *file)
>                 goto done;
>         }
>
> +       confd_process_config(keyfile, file, FALSE, TRUE);
> +
>         conf_security =3D !g_key_file_get_boolean(keyfile, "General",
>                                                 "DisableSecurity", &err);
>         if (err) {
> diff --git a/src/conf_d.c b/src/conf_d.c
> new file mode 100644
> index 000000000..878fb9157
> --- /dev/null
> +++ b/src/conf_d.c
> @@ -0,0 +1,202 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +/*
> + *
> + *  BlueZ - Bluetooth protocol stack for Linux
> + *
> + *  Copyright (C) 2025  Valve Corporation
> + *
> + */
> +
> +#include "conf_d.h"
> +
> +#include "src/log.h"
> +
> +static gint confd_compare_filenames(gconstpointer a, gconstpointer b)
> +{
> +       return g_strcmp0(*(const gchar **)(a), *(const gchar **)(b));
> +}
> +
> +static GPtrArray *confd_get_valid_files_sorted(const gchar *confd_path)
> +{
> +       const char *regex_pattern =3D "^([0-9][0-9])-([a-zA-Z0-9-_])*\\.c=
onf$";
> +       g_autoptr(GRegex) regex =3D NULL;
> +       g_autoptr(GPtrArray) ret_confd_files =3D NULL;
> +       GDir *dir =3D NULL;
> +       GError *error =3D NULL;
> +       const gchar *filename =3D NULL;
> +
> +       regex =3D g_regex_new(regex_pattern, 0, 0, &error);
> +       if (!regex) {
> +               DBG("Invalid regex: %s", error->message);
> +               g_clear_error(&error);
> +               return NULL;
> +       }
> +
> +       dir =3D g_dir_open(confd_path, 0, &error);
> +       if (!dir) {
> +               DBG("%s", error->message);
> +               g_clear_error(&error);
> +               return NULL;
> +       }
> +
> +       ret_confd_files =3D g_ptr_array_new_full(0, g_free);
> +
> +       while ((filename =3D g_dir_read_name(dir)) !=3D NULL) {
> +               g_autofree gchar *file_path =3D NULL;
> +
> +               if (!g_regex_match(regex, filename, 0, NULL)) {
> +                       DBG("Ignoring file in conf.d dir: '%s'", filename=
);
> +                       continue;
> +               }
> +
> +               file_path =3D g_build_filename(confd_path, filename, NULL=
);
> +               if (file_path)
> +                       g_ptr_array_add(ret_confd_files, g_strdup(file_pa=
th));
> +       }
> +
> +       g_dir_close(dir);
> +
> +       if (ret_confd_files && ret_confd_files->len > 0) {
> +               g_ptr_array_sort(ret_confd_files, confd_compare_filenames=
);
> +
> +               DBG("Will consider additional config files (in order):");
> +               for (guint i =3D 0; i < ret_confd_files->len; i++) {
> +                       DBG(" - %s",
> +                           (const gchar *)(g_ptr_array_index(ret_confd_f=
iles,
> +                                                             i)));
> +               }
> +
> +               return g_ptr_array_ref(ret_confd_files);
> +       } else {
> +               g_ptr_array_free(ret_confd_files, TRUE);
> +               ret_confd_files =3D NULL;
> +               return NULL;
> +       }
> +}
> +
> +static void confd_override_config(GKeyFile *keyfile,
> +                                 const gchar *new_conf_file_path,
> +                                 gboolean accept_new_groups,
> +                                 gboolean accept_new_keys)
> +{
> +       g_autoptr(GKeyFile) new_keyfile =3D NULL;
> +       gchar **existing_groups =3D NULL;
> +       gchar **groups =3D NULL;
> +       gchar **keys =3D NULL;
> +       gsize existing_groups_size =3D 0;
> +       gsize groups_size =3D 0;
> +       gsize keys_size =3D 0;
> +       g_autoptr(GError) error =3D NULL;
> +
> +       new_keyfile =3D g_key_file_new();
> +       if (!g_key_file_load_from_file(new_keyfile, new_conf_file_path,
> +                                      G_KEY_FILE_NONE, &error)) {
> +               if (error) {
> +                       warn("%s", error->message);
> +                       g_clear_error(&error);
> +               }
> +               return;
> +       }
> +
> +       existing_groups =3D g_key_file_get_groups(keyfile, &existing_grou=
ps_size);
> +
> +       groups =3D g_key_file_get_groups(new_keyfile, &groups_size);
> +       for (gsize gi =3D 0; gi < groups_size; gi++) {
> +               bool match =3D false;
> +               const gchar *group =3D groups[gi];
> +
> +               for (gsize egi =3D 0; egi < existing_groups_size; egi++) =
{
> +                       if (g_str_equal(group, existing_groups[egi])) {
> +                               match =3D true;
> +                               break;
> +                       }
> +               }
> +
> +               if (!match) {
> +                       if (accept_new_groups =3D=3D FALSE) {
> +                               warn("Skipping group '%s' in '%s' "
> +                                    "not known in previous config",
> +                                    group, new_conf_file_path);
> +                               continue;
> +                       } else {
> +                               DBG("Accepting group '%s' in '%s' "
> +                                   "not known in previous config",
> +                                   group, new_conf_file_path);
> +                       }
> +               }
> +
> +               keys =3D g_key_file_get_keys(new_keyfile, group, &keys_si=
ze,
> +                                          NULL);
> +               if (keys =3D=3D NULL) {
> +                       DBG("No keys found in '%s' for group '%s'",
> +                           new_conf_file_path, group);
> +                       continue;
> +               }
> +
> +               for (gsize ki =3D 0; ki < keys_size; ki++) {
> +                       const gchar *key =3D keys[ki];
> +                       g_autofree gchar *value =3D NULL;
> +                       g_autofree gchar *old_value =3D NULL;
> +
> +                       value =3D g_key_file_get_value(new_keyfile, group=
, key,
> +                                                    NULL);
> +                       if (!value)
> +                               continue;
> +
> +                       old_value =3D
> +                               g_key_file_get_value(keyfile, group, key,=
 NULL);
> +                       if (old_value !=3D NULL) {
> +                               DBG("Overriding config value from "
> +                                   "conf.d file: [%s] %s: '%s'->'%s'",
> +                                   group, key, old_value, value);
> +                               g_key_file_set_value(keyfile, group, key,
> +                                                    value);
> +                       } else {
> +                               if (accept_new_keys =3D=3D TRUE) {
> +                                       DBG("Adding new config value from=
 "
> +                                           "conf.d file: [%s] %s: '%s'",
> +                                           group, key, value);
> +                                       g_key_file_set_value(keyfile, gro=
up,
> +                                                            key, value);
> +                               } else {
> +                                       DBG("Ignoring config value from "
> +                                           "conf.d, unknown keys not all=
owed: "
> +                                           "[%s] %s: '%s'",
> +                                           group, key, value);
> +                               }
> +                       }
> +               }
> +               g_strfreev(keys);
> +       }
> +       g_strfreev(groups);
> +       g_strfreev(existing_groups);
> +}
> +
> +void confd_process_config(GKeyFile *keyfile, const gchar *base_conf_file=
_path,
> +                         gboolean accept_new_groups, gboolean accept_new=
_keys)
> +{
> +       g_autofree gchar *confd_path =3D NULL;
> +       g_autoptr(GPtrArray) confd_files =3D NULL;
> +
> +       confd_path =3D g_strconcat(base_conf_file_path, ".d", NULL);
> +
> +       if (!g_file_test(confd_path,
> +                        (G_FILE_TEST_EXISTS | G_FILE_TEST_IS_DIR))) {
> +               DBG("'%s' does not exist or not a directory", confd_path)=
;
> +               return;
> +       }
> +
> +       confd_files =3D confd_get_valid_files_sorted(confd_path);
> +
> +       if (confd_files && confd_files->len > 0) {
> +               for (guint i =3D 0; i < confd_files->len; i++) {
> +                       const gchar *confd_file =3D
> +                               (const gchar *)(g_ptr_array_index(confd_f=
iles,
> +                                                                 i));
> +                       DBG("Processing config file: '%s'", confd_file);
> +                       confd_override_config(keyfile, confd_file,
> +                                             accept_new_groups,
> +                                             accept_new_keys);
> +               }
> +       }
> +}
> diff --git a/src/conf_d.h b/src/conf_d.h
> new file mode 100644
> index 000000000..812966740
> --- /dev/null
> +++ b/src/conf_d.h
> @@ -0,0 +1,76 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +/*
> + *
> + *  BlueZ - Bluetooth protocol stack for Linux
> + *
> + *  Copyright (C) 2025  Valve Corporation
> + *
> + */
> +
> +#include <glib.h>
> +
> +/**
> + * confd_process_config:
> + *
> + * @keyfile: keyfile already initialized and parsed
> + *
> + * @base_conf_file_path: base config file (e.g. /etc/bluetooth/main.conf=
,
> + * input.conf, network.conf).  The directory to be processed will be sam=
e path
> + * with ".d" appended.
> + *
> + * @accept_new_groups: whether to accept groups not appearing in the bas=
e config
> + * file
> + *
> + * @accept_new_keys: whether to accept keys not appearing in the base co=
nfig
> + * file
> + *
> + * Helper function to process config files in conf.d style dirs (config
> + * fragments), overriding values for keys in the base config files (or d=
efault
> + * config set in code).  For example, for "main.conf" the directory to b=
e
> + * processed will be "main.conf.d", in the same basedir as the config fi=
le.
> + *
> + * Within the .d directory, the format of the filename should be
> + * '^([0-9][0-9])-([a-zA-Z0-9-_])*\.conf$', that is, starting with "00-"=
 to
> + * "99-", ending in ".conf", and with a mix of alphanumeric characters w=
ith
> + * dashes and underscores in between.  For example:
> + * '01-override-general-secureconnections.conf'.
> + *
> + * Files named differently will not be considered, and accepting groups =
or keys
> + * not present in the base config depends on the function arguments.
> + *
> + * The candidate files within the given directory are sorted (with g_str=
cmp0(),
> + * so the ordering will be as with strcmp()).  The configuration in the =
files
> + * being processed later will override previous config, in particular th=
e main
> + * config, but also the one from previous files processed, if the Group =
and Key
> + * coincide.
> + *
> + * For example, consider 'main.conf' that contains the defaults:
> + *   [General]
> + *   DiscoverableTimeout=3D0
> + *   PairableTimeout=3D0
> + *
> + * and there is a file 'main.conf.d/70-default-timeouts-vendor.conf'
> + * containing settings for these keys:
> + *   [General]
> + *   DiscoverableTimeout=3D30
> + *   PairableTimeout=3D30
> + *
> + * and another 'main.conf.d/99-default-timeouts-local.conf'
> + * containing settings only for 'PairableTimeout':
> + *   [General]
> + *   PairableTimeout=3D15
> + *
> + * What happens is:
> + * 1) First, the 'main.conf' is processed as usual;
> + * 2) then 'main.conf.d/70-default-timeouts-vendor.conf' is processed,
> + *    overriding the two values from the main config file with the given=
 values;
> + * 3) and finally 'main.conf.d/99-default-timeouts-local.conf' is proces=
sed,
> + *    overriding once again only 'PairableTimeout'.
> + *
> + * The final, effective values are:
> + *
> + *   DiscoverableTimeout=3D30

And PairableTimeout=3D15, right?

> + *
> + **/
> +void confd_process_config(GKeyFile *keyfile, const gchar *base_conf_file=
_path,
> +                         gboolean accept_new_groups, gboolean accept_new=
_keys);
> diff --git a/src/main.c b/src/main.c
> index 61e5ef983..79866616e 100644
> --- a/src/main.c
> +++ b/src/main.c
> @@ -54,6 +54,7 @@
>  #include "dbus-common.h"
>  #include "agent.h"
>  #include "profile.h"
> +#include "conf_d.h"
>
>  #define BLUEZ_NAME "org.bluez"
>
> @@ -284,6 +285,8 @@ static GKeyFile *load_config(const char *name)
>                 return NULL;
>         }
>
> +       confd_process_config(keyfile, main_conf_file_path, FALSE, TRUE);

After a second look this does seem to completely ignore the formatting
of logging when parsing main.conf, also I do wonder why you didn't
just reuse load_config to parse the files in conf.d, we will need to
adjust the use of main_conf_file_path perhaps to just conf_file_path,
or better yet add a second argument for the path represented by the
GKeyFile, but I believe this is a lot more straightforward overwriting
the same GKeyFile with all the values from conf.d, actually I don't
think this really checks the existing groups and keys because it will
initially be based on the existing main.conf which can be wrong
already, but you will only be able to detect that while in
parse_config.

So except if I miss something above, I think we should really parse
each config separately, and not just load and overwrite.

>         return keyfile;
>  }
>
> --
> 2.51.0
>
>


--=20
Luiz Augusto von Dentz
