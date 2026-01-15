Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B90FF221DAE
	for <linux-bluetooth@vger.kernel.org>; Thu, 15 Jan 2026 10:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768472520; cv=none; b=TS0T78EPic48ol0kI8stJXYaJCHWektfBGvbOYHgGtWiS0FFIb/Ylq1w82royA/EhVSgoOI5iNrThATx7w1oz0j3D2vrOBQ/2iMp9eG4RcB5GWo/bX8rxjgKMoA8cZ/xZfuihKgoQaevdGMIbJytZo5HhmAei/7NyQQVvh2VWHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768472520; c=relaxed/simple;
	bh=nCDswTcg9qWt164HNgWyb+xcIFd7mfGAbLsf8VAyE+c=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kuwDlLl4rcvCKvbvR4vGeHhmeLtweykWXeBZ8yYKbZPOmELEJzN5Kc5ajNM+rxErpk7qmDFXz8DDIyDiR1c5Q07hT7uYkbf5c4WQU/CfYZ5vqp9RoK9kN3/4uVHAzxKkntC3TUA6KbN37gF087Gan29OOm5tWvaACgTNPVRu9Qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id 1B6674333B;
	Thu, 15 Jan 2026 10:21:49 +0000 (UTC)
Message-ID: <8b6eda3466156d30824be3e1fce3a1c9cba1141b.camel@hadess.net>
Subject: Re: [PATCH BlueZ v3 1/1] Support for config fragments (conf.d style
 dirs)
From: Bastien Nocera <hadess@hadess.net>
To: "Manuel A. Fernandez Montecelo" <mafm@igalia.com>, 
	linux-bluetooth@vger.kernel.org
Date: Thu, 15 Jan 2026 11:21:49 +0100
In-Reply-To: <20260115022852.2841362-2-mafm@igalia.com>
References: <20260115022852.2841362-1-mafm@igalia.com>
	 <20260115022852.2841362-2-mafm@igalia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-GND-Sasl: hadess@hadess.net
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduvdehkeduucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecunecujfgurhepkffuhffvffgjfhgtgfgfggesthhqredttderjeenucfhrhhomhepuegrshhtihgvnhcupfhotggvrhgruceohhgruggvshhssehhrgguvghsshdrnhgvtheqnecuggftrfgrthhtvghrnhepvdduheehleehgffgleekhffhueegleejueeigfeggeelheekffekfeeiveehffdunecuffhomhgrihhnpehfrhgvvgguvghskhhtohhprdhorhhgnecukfhppedvrgdtudemvgefgeemvggtjeefmegtfhdvtdemsggrgeefmegrieejieemtgdvugefmeejrgehfeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemvgefgeemvggtjeefmegtfhdvtdemsggrgeefmegrieejieemtgdvugefmeejrgehfedphhgvlhhopeglkffrvheimedvrgdtudemvgefgeemvggtjeefmegtfhdvtdemsggrgeefmegrieejieemtgdvugefmeejrgehfegnpdhmrghilhhfrhhomhephhgruggvshhssehhrgguvghsshdrnhgvthdpqhhiugepudeuieeijeegfeeffeeupdhmohguvgepshhmthhpohhuthdpnhgspghrtghpthhtohepvddprhgtphhtthhopehmrghfmhesihhgrghlihgrrdgtohhmpdhrtghpthhtoheplhhinhhugidqsghluhgvthhoohhthhesv
 hhgvghrrdhkvghrnhgvlhdrohhrgh
X-GND-State: clean
X-GND-Score: 0

Hey,

I've not completely read-through the patch (and I'm going to hazard a
guess that the new GLib usage isn't going to go down well) but I would
highly recommend removing all the explanations of configuration
precedence to instead refer to:
https://www.freedesktop.org/software/systemd/man/latest/system.conf.d.html#=
Configuration%20Directories%20and%20Precedence
and make sure that your implementation respects it (or mentions what
the differences are to it).

You might also want to move the majority of the new code to src/shared
so it can be reused, most notably by the mesh daemon, and a unit test
that verifies that configuration precedence works as expected.

Cheers

On Thu, 2026-01-15 at 03:28 +0100, Manuel A. Fernandez Montecelo wrote:
> Support config fragments, to read config from conf.d directories.
> Those dirs will be main.conf.d for main.conf, analog for input.conf
> and network.conf.
>=20
> This is commonly supported by other tools, as an extension of the
> main
> config file(s).=C2=A0 It is useful and convenient in several situations,
> for example:
>=20
> * distributions can set different values from the defaults shipped
> =C2=A0 upstream, without having to modify the config file
>=20
> * different packages or config-management tools can change config
> just
> =C2=A0 by adding, removing or modifying files in that directory; instead
> of
> =C2=A0 editing the main config files
>=20
> The main or base config files will be processed first, and then files
> in the corresponding conf.d dirs, if existing.
>=20
> When reading these config files in conf.d dirs, they override values
> for keys in the base config files (or default config set in code).
> For example, for "main.conf" the directory to be processed will be
> "main.conf.d", in the same basedir as the config file
> (e.g. /etc/bluetooth/main.conf, /etc/bluetooth/main.conf.d/).=C2=A0 The
> same for input.conf and network.conf.
>=20
> Within the conf.d directory, the format of the filename should be
> '^([0-9][0-9])-([a-zA-Z0-9-_])*\.conf$', that is, starting with "00-"
> to "99-", ending in ".conf", and with a mix of alphanumeric
> characters
> with dashes and underscores in between.=C2=A0 For example:
> '01-override-general-secureconnections.conf'.
>=20
> Files with a different name scheme will not be considered.=C2=A0 Acceptin=
g
> groups or keys not present in the base config depends on the code,
> currently set to "NOT accept new groups" but "YES to accept new
> keys".
> This is because the base config files as shipped contain all the
> groups, but most keys are commented-out, with the default values set
> in code.
>=20
> The candidate files within the given directory are sorted (with
> g_strcmp0(), so the ordering will be as with strcmp()).=C2=A0 The
> configuration in the files being processed later will override
> previous config, in particular the main/base config files, but also
> the one from previous files processed, if the Group and Key coincide.
>=20
> For example, consider 'main.conf' that contains the defaults:
>=20
> =C2=A0 [General]
> =C2=A0 DiscoverableTimeout=3D0
> =C2=A0 PairableTimeout=3D0
>=20
> and there is a file 'main.conf.d/70-default-timeouts-vendor.conf'
> containing settings for these keys:
>=20
> =C2=A0 [General]
> =C2=A0 DiscoverableTimeout=3D30
> =C2=A0 PairableTimeout=3D30
>=20
> and another 'main.conf.d/99-default-timeouts-local.conf'
> containing settings only for 'PairableTimeout':
>=20
> =C2=A0 [General]
> =C2=A0 PairableTimeout=3D15
>=20
> What happens is:
> 1) First, the 'main.conf' is processed as usual;
> 2) then 'main.conf.d/70-default-timeouts-vendor.conf' is processed,
> =C2=A0=C2=A0 overriding the two values from the main config file with the=
 given
> =C2=A0=C2=A0 values;
> 3) and finally 'main.conf.d/99-default-timeouts-local.conf' is
> =C2=A0=C2=A0 processed, overriding once again only 'PairableTimeout'.
>=20
> The final, effective values are:
>=20
> =C2=A0 DiscoverableTimeout=3D30
> =C2=A0 PairableTimeout=3D15
> ---
> =C2=A0Makefile.am=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 1 +
> =C2=A0profiles/input/hog.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=
=A0 9 ++
> =C2=A0profiles/input/manager.c=C2=A0=C2=A0 |=C2=A0=C2=A0 9 ++
> =C2=A0profiles/network/manager.c |=C2=A0=C2=A0 9 ++
> =C2=A0src/conf_d.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 208
> +++++++++++++++++++++++++++++++++++++
> =C2=A0src/conf_d.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 83 +++++++++++++++
> =C2=A0src/main.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 9 ++
> =C2=A07 files changed, 328 insertions(+)
> =C2=A0create mode 100644 src/conf_d.c
> =C2=A0create mode 100644 src/conf_d.h
>=20
> diff --git a/Makefile.am b/Makefile.am
> index 3adfa6cd5..dbd937268 100644
> --- a/Makefile.am
> +++ b/Makefile.am
> @@ -308,6 +308,7 @@ pkglibexec_PROGRAMS +=3D src/bluetoothd
> =C2=A0bluetoothd_internal_sources =3D \
> =C2=A0			$(attrib_sources) $(btio_sources) \
> =C2=A0			src/log.h src/log.c \
> +			src/conf_d.h src/conf_d.c \
> =C2=A0			src/backtrace.h src/backtrace.c \
> =C2=A0			src/rfkill.c src/btd.h src/sdpd.h \
> =C2=A0			src/sdpd-server.c src/sdpd-request.c \
> diff --git a/profiles/input/hog.c b/profiles/input/hog.c
> index f50a0f217..9a23a10ff 100644
> --- a/profiles/input/hog.c
> +++ b/profiles/input/hog.c
> @@ -39,6 +39,7 @@
> =C2=A0#include "src/shared/att.h"
> =C2=A0#include "src/shared/gatt-client.h"
> =C2=A0#include "src/plugin.h"
> +#include "src/conf_d.h"
> =C2=A0
> =C2=A0#include "suspend.h"
> =C2=A0#include "attrib/att.h"
> @@ -246,6 +247,14 @@ static void hog_read_config(void)
> =C2=A0		return;
> =C2=A0	}
> =C2=A0
> +	confd_process_config(config, filename, FALSE, TRUE, &err);
> +	if (err) {
> +		error("Parsing conf.d file failed: %s", err-
> >message);
> +		g_error_free(err);
> +		g_key_file_free(config);
> +		return;
> +	}
> +
> =C2=A0	config_auto_sec =3D g_key_file_get_boolean(config, "General",
> =C2=A0					"LEAutoSecurity", &err);
> =C2=A0	if (!err) {
> diff --git a/profiles/input/manager.c b/profiles/input/manager.c
> index 0fcd6728c..36b78c3f5 100644
> --- a/profiles/input/manager.c
> +++ b/profiles/input/manager.c
> @@ -27,6 +27,7 @@
> =C2=A0#include "src/device.h"
> =C2=A0#include "src/profile.h"
> =C2=A0#include "src/service.h"
> +#include "src/conf_d.h"
> =C2=A0
> =C2=A0#include "device.h"
> =C2=A0#include "server.h"
> @@ -75,6 +76,14 @@ static GKeyFile *load_config_file(const char
> *file)
> =C2=A0		return NULL;
> =C2=A0	}
> =C2=A0
> +	confd_process_config(keyfile, file, FALSE, TRUE, &err);
> +	if (err) {
> +		error("Parsing conf.d failed: %s", err->message);
> +		g_error_free(err);
> +		g_key_file_free(keyfile);
> +		return NULL;
> +	}
> +
> =C2=A0	return keyfile;
> =C2=A0}
> =C2=A0
> diff --git a/profiles/network/manager.c b/profiles/network/manager.c
> index 693547d45..7f180ed0b 100644
> --- a/profiles/network/manager.c
> +++ b/profiles/network/manager.c
> @@ -28,6 +28,7 @@
> =C2=A0#include "src/device.h"
> =C2=A0#include "src/profile.h"
> =C2=A0#include "src/service.h"
> +#include "src/conf_d.h"
> =C2=A0
> =C2=A0#include "bnep.h"
> =C2=A0#include "connection.h"
> @@ -43,6 +44,14 @@ static void read_config(const char *file)
> =C2=A0	keyfile =3D g_key_file_new();
> =C2=A0
> =C2=A0	if (!g_key_file_load_from_file(keyfile, file, 0, &err)) {
> +		DBG("Parsing file %s failed: %s", file, err-
> >message);
> +		g_clear_error(&err);
> +		goto done;
> +	}
> +
> +	confd_process_config(keyfile, file, FALSE, TRUE, &err);
> +	if (err) {
> +		DBG("Parsing conf.d file failed: %s", err->message);
> =C2=A0		g_clear_error(&err);
> =C2=A0		goto done;
> =C2=A0	}
> diff --git a/src/conf_d.c b/src/conf_d.c
> new file mode 100644
> index 000000000..b60303661
> --- /dev/null
> +++ b/src/conf_d.c
> @@ -0,0 +1,208 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +/*
> + *
> + *=C2=A0 BlueZ - Bluetooth protocol stack for Linux
> + *
> + *=C2=A0 Copyright (C) 2025-2026=C2=A0 Valve Corporation
> + *
> + */
> +
> +#include "conf_d.h"
> +
> +#include "src/log.h"
> +
> +static gint confd_compare_filenames(gconstpointer a, gconstpointer
> b)
> +{
> +	return g_strcmp0(*(const gchar**)(a), *(const gchar**)(b));
> +}
> +
> +static GPtrArray *confd_get_valid_files_sorted(const gchar
> *confd_path)
> +{
> +	const char *regex_pattern =3D "^([0-9][0-9])-([a-zA-Z0-9-
> _])*\\.conf$";
> +	g_autoptr(GRegex) regex =3D NULL;
> +	g_autoptr(GPtrArray) ret_confd_files =3D NULL;
> +	GDir *dir =3D NULL;
> +	GError *error =3D NULL;
> +	const gchar *filename =3D NULL;
> +
> +	/* the 2nd and 3rd arguments (0, 0), are equivalent to
> (G_REGEX_DEFAULT,
> +	 * G_REGEX_MATCH_DEFAULT) in newer versions of glib */
> +	regex =3D g_regex_new(regex_pattern, 0, 0, &error);
> +	if (!regex) {
> +		DBG("Invalid regex: %s", error->message);
> +		g_clear_error(&error);
> +		return NULL;
> +	}
> +
> +	dir =3D g_dir_open(confd_path, 0, &error);
> +	if (!dir) {
> +		DBG("%s", error->message);
> +		g_clear_error(&error);
> +		return NULL;
> +	}
> +
> +	ret_confd_files =3D g_ptr_array_new_full(0, g_free);
> +
> +	while ((filename =3D g_dir_read_name(dir)) !=3D NULL) {
> +		g_autofree gchar *file_path =3D NULL;
> +
> +		if (!g_regex_match(regex, filename, 0, NULL)) {
> +			DBG("Ignoring file in conf.d dir: '%s'",
> filename);
> +			continue;
> +		}
> +
> +		file_path =3D g_build_filename(confd_path, filename,
> NULL);
> +		if (file_path)
> +			g_ptr_array_add(ret_confd_files,
> g_strdup(file_path));
> +	}
> +
> +	g_dir_close(dir);
> +
> +	if (ret_confd_files && ret_confd_files->len > 0) {
> +		g_ptr_array_sort(ret_confd_files,
> confd_compare_filenames);
> +
> +		DBG("Will consider additional config files (in
> order):");
> +		for (guint i =3D 0; i < ret_confd_files->len; i++) {
> +			DBG(" - %s",
> +			=C2=A0=C2=A0=C2=A0 (const gchar
> *)(g_ptr_array_index(ret_confd_files,
> +							=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 i)));
> +		}
> +
> +		return g_ptr_array_ref(ret_confd_files);
> +	} else {
> +		g_ptr_array_free(ret_confd_files, TRUE);
> +		ret_confd_files =3D NULL;
> +		return NULL;
> +	}
> +}
> +
> +static void confd_override_config(GKeyFile *keyfile,
> +				=C2=A0 const gchar *new_conf_file_path,
> +				=C2=A0 gboolean accept_new_groups,
> +				=C2=A0 gboolean accept_new_keys,
> +				=C2=A0 GError **err)
> +{
> +	g_autoptr(GKeyFile) new_keyfile =3D NULL;
> +	gchar **existing_groups =3D NULL;
> +	gchar **groups =3D NULL;
> +	gchar **keys =3D NULL;
> +	gsize existing_groups_size =3D 0;
> +	gsize groups_size =3D 0;
> +	gsize keys_size =3D 0;
> +
> +	new_keyfile =3D g_key_file_new();
> +	if (!g_key_file_load_from_file(new_keyfile,
> new_conf_file_path,
> +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 G_KEY_FILE_NONE, err)) {
> +		/* the caller can further process 'err' */
> +		gchar *new_message =3D g_strdup_printf("%s: %s",
> +						=C2=A0=C2=A0=C2=A0=C2=A0
> new_conf_file_path,
> +						=C2=A0=C2=A0=C2=A0=C2=A0 (*err)-
> >message);
> +		g_free((*err)->message);
> +		(*err)->message =3D new_message;
> +		return;
> +	}
> +
> +	existing_groups =3D g_key_file_get_groups(keyfile,
> &existing_groups_size);
> +
> +	groups =3D g_key_file_get_groups(new_keyfile, &groups_size);
> +	for (gsize gi =3D 0; gi < groups_size; gi++) {
> +		bool match =3D false;
> +		const gchar *group =3D groups[gi];
> +
> +		for (gsize egi =3D 0; egi < existing_groups_size;
> egi++) {
> +			if (g_str_equal(group,
> existing_groups[egi])) {
> +				match =3D true;
> +				break;
> +			}
> +		}
> +
> +		if (!match) {
> +			if (accept_new_groups =3D=3D FALSE) {
> +				warn("Skipping group '%s' in '%s' "
> +				=C2=A0=C2=A0=C2=A0=C2=A0 "not known in previous config",
> +				=C2=A0=C2=A0=C2=A0=C2=A0 group, new_conf_file_path);
> +				continue;
> +			} else {
> +				DBG("Accepting group '%s' in '%s' "
> +				=C2=A0=C2=A0=C2=A0 "not known in previous config",
> +				=C2=A0=C2=A0=C2=A0 group, new_conf_file_path);
> +			}
> +		}
> +
> +		keys =3D g_key_file_get_keys(new_keyfile, group,
> &keys_size,
> +					=C2=A0=C2=A0 NULL);
> +		if (keys =3D=3D NULL) {
> +			DBG("No keys found in '%s' for group '%s'",
> +			=C2=A0=C2=A0=C2=A0 new_conf_file_path, group);
> +			continue;
> +		}
> +
> +		for (gsize ki =3D 0; ki < keys_size; ki++) {
> +			const gchar *key =3D keys[ki];
> +			g_autofree gchar *value =3D NULL;
> +			g_autofree gchar *old_value =3D NULL;
> +
> +			value =3D g_key_file_get_value(new_keyfile,
> group, key,
> +						=C2=A0=C2=A0=C2=A0=C2=A0 NULL);
> +			if (!value)
> +				continue;
> +
> +			old_value =3D
> +				g_key_file_get_value(keyfile, group,
> key, NULL);
> +			if (old_value !=3D NULL) {
> +				DBG("Overriding config value from "
> +				=C2=A0=C2=A0=C2=A0 "conf.d file: [%s] %s: '%s'-
> >'%s'",
> +				=C2=A0=C2=A0=C2=A0 group, key, old_value, value);
> +				g_key_file_set_value(keyfile, group,
> key,
> +						=C2=A0=C2=A0=C2=A0=C2=A0 value);
> +			} else {
> +				if (accept_new_keys =3D=3D TRUE) {
> +					DBG("Adding new config value
> from "
> +					=C2=A0=C2=A0=C2=A0 "conf.d file: [%s] %s:
> '%s'",
> +					=C2=A0=C2=A0=C2=A0 group, key, value);
> +					g_key_file_set_value(keyfile
> , group,
> +							=C2=A0=C2=A0=C2=A0=C2=A0 key,
> value);
> +				} else {
> +					DBG("Ignoring config value
> from "
> +					=C2=A0=C2=A0=C2=A0 "conf.d, unknown keys
> not allowed: "
> +					=C2=A0=C2=A0=C2=A0 "[%s] %s: '%s'",
> +					=C2=A0=C2=A0=C2=A0 group, key, value);
> +				}
> +			}
> +		}
> +		g_strfreev(keys);
> +	}
> +	g_strfreev(groups);
> +	g_strfreev(existing_groups);
> +}
> +
> +void confd_process_config(GKeyFile *keyfile, const gchar
> *base_conf_file_path,
> +			=C2=A0 gboolean accept_new_groups, gboolean
> accept_new_keys,
> +			=C2=A0 GError **err)
> +{
> +	g_autofree gchar *confd_path =3D NULL;
> +	g_autoptr(GPtrArray) confd_files =3D NULL;
> +
> +	confd_path =3D g_strconcat(base_conf_file_path, ".d", NULL);
> +
> +	if (!g_file_test(confd_path,
> +			 (G_FILE_TEST_EXISTS | G_FILE_TEST_IS_DIR)))
> {
> +		DBG("'%s' does not exist or not a directory",
> confd_path);
> +		return;
> +	}
> +
> +	confd_files =3D confd_get_valid_files_sorted(confd_path);
> +
> +	if (confd_files && confd_files->len > 0) {
> +		for (guint i =3D 0; i < confd_files->len; i++) {
> +			const gchar *confd_file =3D
> +				(const gchar
> *)(g_ptr_array_index(confd_files,
> +								=C2=A0
> i));
> +			DBG("Processing config file: '%s'",
> confd_file);
> +			confd_override_config(keyfile, confd_file,
> +					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 accept_new_groups,
> +					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 accept_new_keys,
> +					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 err);
> +		}
> +	}
> +}
> diff --git a/src/conf_d.h b/src/conf_d.h
> new file mode 100644
> index 000000000..e5cb4ae16
> --- /dev/null
> +++ b/src/conf_d.h
> @@ -0,0 +1,83 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +/*
> + *
> + *=C2=A0 BlueZ - Bluetooth protocol stack for Linux
> + *
> + *=C2=A0 Copyright (C) 2025-2026=C2=A0 Valve Corporation
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
> + * @base_conf_file_path: base config file (e.g.
> /etc/bluetooth/main.conf,
> + * input.conf, network.conf).=C2=A0 The directory to be processed will b=
e
> same path
> + * with ".d" appended.
> + *
> + * @accept_new_groups: whether to accept groups not appearing in the
> base config
> + * file
> + *
> + * @accept_new_keys: whether to accept keys not appearing in the
> base config
> + * file
> + *
> + * @err: error, taken as input to pass back to caller, if any
> + *
> + * Helper function to process config files in conf.d style dirs
> (config
> + * fragments), overriding values for keys in the base config files
> (or default
> + * config set in code).=C2=A0 For example, for "main.conf" the directory
> to be
> + * processed will be "main.conf.d", in the same basedir as the
> config file.
> + *
> + * Within the .d directory, the format of the filename should be
> + * '^([0-9][0-9])-([a-zA-Z0-9-_])*\.conf$', that is, starting with
> "00-" to
> + * "99-", ending in ".conf", and with a mix of alphanumeric
> characters with
> + * dashes and underscores in between.=C2=A0 For example:
> + * '01-override-general-secureconnections.conf'.
> + *
> + * Files with a different name scheme will not be considered.=C2=A0
> Accepting groups
> + * or keys not present in the base config depends on the function
> arguments.
> + * Currently, the callers set it to "NOT accept new groups" but "YES
> to accept
> + * new keys".=C2=A0 This is because the base config files as shipped
> contain all the
> + * groups, but most keys are commented-out, with the default values
> set in code.
> + *
> + * The candidate files within the given directory are sorted (with
> g_strcmp0(),
> + * so the ordering will be as with strcmp()).=C2=A0 The configuration in
> the files
> + * being processed later will override previous config, in
> particular the main
> + * config, but also the one from previous files processed, if the
> Group and Key
> + * coincide.
> + *
> + * For example, consider 'main.conf' that contains the defaults:
> + *=C2=A0=C2=A0 [General]
> + *=C2=A0=C2=A0 DiscoverableTimeout=3D0
> + *=C2=A0=C2=A0 PairableTimeout=3D0
> + *
> + * and there is a file 'main.conf.d/70-default-timeouts-vendor.conf'
> + * containing settings for these keys:
> + *=C2=A0=C2=A0 [General]
> + *=C2=A0=C2=A0 DiscoverableTimeout=3D30
> + *=C2=A0=C2=A0 PairableTimeout=3D30
> + *
> + * and another 'main.conf.d/99-default-timeouts-local.conf'
> + * containing settings only for 'PairableTimeout':
> + *=C2=A0=C2=A0 [General]
> + *=C2=A0=C2=A0 PairableTimeout=3D15
> + *
> + * What happens is:
> + * 1) First, the 'main.conf' is processed as usual;
> + * 2) then 'main.conf.d/70-default-timeouts-vendor.conf' is
> processed,
> + *=C2=A0=C2=A0=C2=A0 overriding the two values from the main config file=
 with the
> given values;
> + * 3) and finally 'main.conf.d/99-default-timeouts-local.conf' is
> processed,
> + *=C2=A0=C2=A0=C2=A0 overriding once again only 'PairableTimeout'.
> + *
> + * The final, effective values are:
> + *
> + *=C2=A0=C2=A0 DiscoverableTimeout=3D30
> + *=C2=A0=C2=A0 PairableTimeout=3D15
> + *
> + **/
> +void confd_process_config(GKeyFile *keyfile, const gchar
> *base_conf_file_path,
> +			=C2=A0 gboolean accept_new_groups, gboolean
> accept_new_keys,
> +			=C2=A0 GError **err);
> diff --git a/src/main.c b/src/main.c
> index 59df0ad4c..1a4610188 100644
> --- a/src/main.c
> +++ b/src/main.c
> @@ -54,6 +54,7 @@
> =C2=A0#include "dbus-common.h"
> =C2=A0#include "agent.h"
> =C2=A0#include "profile.h"
> +#include "conf_d.h"
> =C2=A0
> =C2=A0#define BLUEZ_NAME "org.bluez"
> =C2=A0
> @@ -285,6 +286,14 @@ static GKeyFile *load_config(const char *name)
> =C2=A0		return NULL;
> =C2=A0	}
> =C2=A0
> +	confd_process_config(keyfile, main_conf_file_path, FALSE,
> TRUE, &err);
> +	if (err) {
> +		error("Parsing conf.d file failed: %s", err-
> >message);
> +		g_error_free(err);
> +		g_key_file_free(keyfile);
> +		return NULL;
> +	}
> +
> =C2=A0	return keyfile;
> =C2=A0}
> =C2=A0
