Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 438622BD11
	for <linux-bluetooth@vger.kernel.org>; Thu, 11 Dec 2025 22:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765491353; cv=none; b=makQqObq9C3oeCWdlZ3w8s3PSTpQnrH8Wnt5IpmVnvUtTwe4lWr1ETggqwz48iTOr9sWaFW52TcKYV4wubNpR/xl7Yzm9NEYWZXxEHvoTPDW0zLSWyCpP2phPUmMRqCvSbLn2vaUfp0NvSVIWzD+fZATR0Nj41BowkF6xJs8Sk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765491353; c=relaxed/simple;
	bh=AG+k+khoX9c7BebE4eLPVkSRvSFH1IrTJwSk7r5F5XQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ma2qvwmUmQE+G9YBBQB0Zg876sH2k5rjgUz4I3hZS3U1C75QVr/ved8rgTN3wf+jPZ1vf9cn6+Io695feR0cttVZTfn2nepuqcCXmda8ismRCKXriIiV7NZJBh7xkFEAzRTIUQH5FROK+a7Gb7t5306zelmLLFd+SqtCWCaQrXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YOfTSrXY; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YOfTSrXY"
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-59577c4c7c1so516889e87.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 11 Dec 2025 14:15:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765491349; x=1766096149; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R2JfyNWO3N2gnlOG/IBM6cBXs0yadIDDnjRFhFJ+cV4=;
        b=YOfTSrXYu9TkulQXK71YwhnrWvh5w3wjz5oFZs79CY1XISuNk7n6NsGBkQf7RpY0P4
         s3zI4+6yxvLBX7da9mLdUerx0daGENgX9OLGUYeaA6c/dCRw6eGzvYNSnyTkQCbd4Cd+
         4F0SmzlWuehwNkHIarL5hFvy2gIerzhctZyxXmdwl5LxFCIVj77KkzrDXzd7OuinNytx
         eGWQ/x3oCd7tV9aj4l5/3mKcBEjh4tQBoq0PC6V8jhL2TjaMUl6BcyFnKwrxi2Wj8TNf
         Wg5/tFWsWpcLtZjWDxVpXOdwCOVvvqilUOPVzhjVDGIRDDxGM1tiPbrBAcIshg1GPlqZ
         5jrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765491349; x=1766096149;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=R2JfyNWO3N2gnlOG/IBM6cBXs0yadIDDnjRFhFJ+cV4=;
        b=FNcDq68bYQtYlo9PsZo0dSNgBIPoQnKi5Pa0z4i8ymqAEq7OHJ+IWdmWCYBlyzHwbs
         XeXs7veV9R4SSoGXzCXHbEwN4gnARmnHaEEzFxJD02yL7BgkyNGLbdqhNVWRig3QLFeo
         2OR3Lo3oR8OJQZKSI/IZ9h0tplzBoiya+Ul+IVg67CoFwaC7tzhq/IhDFG4OBhOhs1po
         ZbgKgW9bw3MjNqRHxEHr2ADrsAtaUGB++Fxnk/oV55pwRTgDqe+TqEPAVKHFVAltabC5
         uQymHc0NfsA9Qlst+XkxyAzFpVLDikcYqwhGCNrxDDHloxB5ZWv0NcSaLyKYK42/6rMP
         cv2g==
X-Gm-Message-State: AOJu0YyDZ+dZuOJ0IRGuQrDlvFwpsoRJpf+pXO55l3X3zYczaN2SnA2F
	Sch64WZ86TJboip1QKy4CS/Cdlwe61daBt9kMV4PvJuSWyEEVeDZgyPqsKfIQwrx/mrb1t54xxK
	kqo4YfYF/p29ZiAE4KpeGfmCog95+jNS/HNHp
X-Gm-Gg: AY/fxX4QswpgW4MCLYwPevv8WBZuextZDjf0ns5vFLopf9O3wxDcYELFcZgr538yzt5
	ega2eTqkSjLi81+By9tD8PZWNbwOxkbZddUZPLcT8I0RSSxoqQ5M4vXn3CvQHkJvbzOcRyFqO4r
	YNr+UxpkrdRj3izXrTUwbffl1Od8+bOFAHlEDNznaOhdvvD4FvtN7NGs1zoxWDK27oObnSnz4WN
	MKWDsfLMOusio61gz/CzTvSBuOaKbzLoNUnhhgIisdPljuhq75J/x0yjo3t9TUSvfPm/A==
X-Google-Smtp-Source: AGHT+IE0op/+qDPY4tbj5Lf09yA7NLZ03S6F8nCuvmgZpgc/tm/UI9AX3qMv0mucVSmCwSxRFF+hOAbwngbcV5JB0do=
X-Received: by 2002:a05:6512:3d1d:b0:598:e9f1:3883 with SMTP id
 2adb3069b0e04-598f3bc30c7mr1335559e87.11.1765491348830; Thu, 11 Dec 2025
 14:15:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251211211356.3842264-1-mafm@igalia.com> <20251211211356.3842264-2-mafm@igalia.com>
In-Reply-To: <20251211211356.3842264-2-mafm@igalia.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 11 Dec 2025 17:15:34 -0500
X-Gm-Features: AQt7F2qIiwk0TupcjvNq3xvrJRAtEVW0_uBsIxE9qP0hYqzoLZHkENmVRcwdYWE
Message-ID: <CABBYNZKPn27zfKdRDSD2uChTB7eVaWiCKMdvbvvPGDwfBZmADg@mail.gmail.com>
Subject: Re: [PATCH BlueZ 1/1] Support for config fragments (conf.d style dirs)
To: "Manuel A. Fernandez Montecelo" <mafm@igalia.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Manuel,

On Thu, Dec 11, 2025 at 4:14=E2=80=AFPM Manuel A. Fernandez Montecelo
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
> - distributions can set different values from the defaults shipped
>   upstream, without having to modify the config file
>
> - different packages or config-management tools can change config just
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

Great work on the commit message, really helpful.

> ---
>  Makefile.am                |   1 +
>  acinclude.m4               |   4 +-
>  profiles/input/hog.c       |   3 +
>  profiles/input/manager.c   |   3 +
>  profiles/network/manager.c |   3 +
>  src/conf_d.c               | 177 +++++++++++++++++++++++++++++++++++++
>  src/conf_d.h               |  77 ++++++++++++++++
>  src/main.c                 |   3 +
>  8 files changed, 269 insertions(+), 2 deletions(-)
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
> diff --git a/acinclude.m4 b/acinclude.m4
> index 8046c9a7d..560a5d44b 100644
> --- a/acinclude.m4
> +++ b/acinclude.m4
> @@ -63,8 +63,8 @@ AC_DEFUN([COMPILER_FLAGS], [
>                 with_cflags=3D"$with_cflags -Wformat -Wformat-security"
>                 with_cflags=3D"$with_cflags -Wstringop-overflow"
>                 with_cflags=3D"$with_cflags -DG_DISABLE_DEPRECATED"
> -               with_cflags=3D"$with_cflags -DGLIB_VERSION_MIN_REQUIRED=
=3DGLIB_VERSION_2_36"
> -               with_cflags=3D"$with_cflags -DGLIB_VERSION_MAX_ALLOWED=3D=
GLIB_VERSION_2_36"
> +               with_cflags=3D"$with_cflags -DGLIB_VERSION_MIN_REQUIRED=
=3DGLIB_VERSION_2_76"
> +               with_cflags=3D"$with_cflags -DGLIB_VERSION_MAX_ALLOWED=3D=
GLIB_VERSION_2_76"

Hmm, I'd like to avoid upping the dependency if possible, what is the
new function(s) that required such update?

>         fi
>         AC_SUBST([WARNING_CFLAGS], $with_cflags)
>  ])
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
> index 000000000..0ce06ee83
> --- /dev/null
> +++ b/src/conf_d.c
> @@ -0,0 +1,177 @@
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
> +
> +static gint confd_compare_filenames(gconstpointer a, gconstpointer b)
> +{
> +       return g_strcmp0((const gchar*)a, (const gchar*)b);
> +}
> +
> +static GPtrArray *confd_get_valid_files_sorted(const gchar *confd_path)
> +{
> +       const char *regex_pattern =3D "^([0-9][0-9])-([a-zA-Z0-9-_])*\\.c=
onf$";
> +       g_autoptr (GRegex) regex =3D NULL;
> +       g_autoptr (GPtrArray) ret_confd_files =3D NULL;
> +       GDir *dir =3D NULL;
> +       GError *error =3D NULL;
> +       const gchar *filename =3D NULL;
> +
> +       regex =3D g_regex_new(regex_pattern, G_REGEX_DEFAULT, G_REGEX_MAT=
CH_DEFAULT, &error);
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
> +               if (!g_regex_match(regex, filename, G_REGEX_MATCH_DEFAULT=
, NULL)) {
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
> +               g_ptr_array_sort_values(ret_confd_files, confd_compare_fi=
lenames);
> +
> +               DBG("Will consider additional config files (in order):");
> +               for (guint i =3D 0; i < ret_confd_files->len; i++) {
> +                       DBG(" - %s", (const gchar*)(g_ptr_array_index(ret=
_confd_files, i)));
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
> +static void confd_override_config(GKeyFile *keyfile, const gchar *new_co=
nf_file_path, gboolean accept_new_groups, gboolean accept_new_keys)

Pretty sure the above is over 80 columns.

> +{
> +       g_autoptr (GKeyFile) new_keyfile =3D NULL;
> +       gchar **existing_groups =3D NULL;
> +       gchar **groups =3D NULL;
> +       gchar **keys =3D NULL;
> +       gsize existing_groups_size =3D 0;
> +       gsize groups_size =3D 0;
> +       gsize keys_size =3D 0;
> +       g_autoptr (GError) error =3D NULL;
> +
> +       new_keyfile =3D g_key_file_new();
> +       if (!g_key_file_load_from_file(new_keyfile, new_conf_file_path, G=
_KEY_FILE_NONE, &error)) {
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
> +                               warn("Skipping group '%s' in '%s' not kno=
wn in previous config", group, new_conf_file_path);
> +                               continue;
> +                       } else {
> +                               DBG("Accepting group '%s' in '%s' not kno=
wn in previous config", group, new_conf_file_path);
> +                       }
> +               }
> +
> +               keys =3D g_key_file_get_keys(new_keyfile, group, &keys_si=
ze, NULL);
> +               if (keys =3D=3D NULL) {
> +                       DBG("No keys found in '%s' for group '%s'", new_c=
onf_file_path, group);
> +                       continue;
> +               }
> +
> +               for (gsize ki =3D 0; ki < keys_size; ki++) {
> +                       const gchar *key =3D keys[ki];
> +                       g_autofree gchar *value =3D NULL;
> +                       g_autofree gchar *old_value =3D NULL;
> +
> +                       value =3D g_key_file_get_value(new_keyfile, group=
, key, NULL);
> +                       if (!value)
> +                               continue;
> +
> +                       old_value =3D g_key_file_get_value(keyfile, group=
, key, NULL);
> +                       if (old_value !=3D NULL) {
> +                               DBG("Overriding config value from conf.d =
file: [%s] %s: '%s'->'%s'",
> +                                   group, key, old_value, value);
> +                               g_key_file_set_value(keyfile, group, key,=
 value);
> +                       } else {
> +                               if (accept_new_keys =3D=3D TRUE) {
> +                                       DBG("Adding new config value from=
 conf.d file: [%s] %s: '%s'",
> +                                           group, key, value);
> +                                       g_key_file_set_value(keyfile, gro=
up, key, value);
> +                               } else {
> +                                       DBG("Ignoring config value from c=
onf.d, unknown keys not allowed: [%s] %s: '%s'",
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
_path, gboolean accept_new_groups, gboolean accept_new_keys)
> +{
> +       g_autofree gchar *confd_path =3D NULL;
> +       g_autoptr (GPtrArray) confd_files =3D NULL;
> +
> +       confd_path =3D g_strconcat(base_conf_file_path, ".d", NULL);
> +
> +       if (!g_file_test(confd_path, (G_FILE_TEST_EXISTS | G_FILE_TEST_IS=
_DIR))) {
> +               DBG("'%s' does not exist or not a directory", confd_path)=
;
> +               return;
> +       }
> +
> +       confd_files =3D confd_get_valid_files_sorted(confd_path);
> +
> +       if (confd_files && confd_files->len > 0) {
> +               for (guint i =3D 0; i < confd_files->len; i++) {
> +                       const gchar* confd_file =3D (const gchar*)(g_ptr_=
array_index(confd_files, i));
> +                       DBG("Processing config file: '%s'", confd_file);
> +                       confd_override_config(keyfile, confd_file, accept=
_new_groups, accept_new_keys);
> +               }
> +       }
> +}
> diff --git a/src/conf_d.h b/src/conf_d.h
> new file mode 100644
> index 000000000..563d303d8
> --- /dev/null
> +++ b/src/conf_d.h
> @@ -0,0 +1,77 @@
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
e
> + * config file
> + *
> + * @accept_new_keys: whether to accept keys not appearing in the base
> + * config file
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
> + *    overriding the two values from the main config file with the given
> + *    values;
> + * 3) and finally 'main.conf.d/99-default-timeouts-local.conf' is
> + *    processed, overriding once again only 'PairableTimeout'.
> + *
> + * The final, effective values are:
> + *
> + *   DiscoverableTimeout=3D30
> + *
> + **/
> +void confd_process_config(GKeyFile *keyfile, const gchar *base_conf_file=
_path, gboolean accept_new_groups, gboolean accept_new_keys);
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
> +
>         return keyfile;
>  }
>
> --
> 2.51.0
>
>


--=20
Luiz Augusto von Dentz
