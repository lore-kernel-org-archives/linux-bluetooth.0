Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 265E730CD95
	for <linux-bluetooth@vger.kernel.org>; Fri, 12 Dec 2025 20:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765570996; cv=none; b=VYSxTM7CNjpgkbLFANrklW6I5ae9iKuG65dzPv1Vtwo3ero86Qlf42j0k7O2ZkRKSf3BOqCNbAviyzT0gv8w5xiFle0YD+Sb6dl8YXUdf0mF2OrJIMFYGtlJoCnrvkiUu3XICKE13beI/oFZesgfzRTdA08CEeiM42iU41Eb6Bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765570996; c=relaxed/simple;
	bh=V6wtGlHbvun81bIBIYT8xjFBvpA/LyFbeYQTV6NNlzo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XyAMGlKs9smZqqbAWQ3MTYnsDYAm75IEJ0NjRjRJEy3CgtNyUQ0RYALUh4u8dgATPuHDg+TzNmsDyOEFlO8jNuGozwGCdbu2ABeqjQ4359R4bIJ4Qqv5Sj9MOhiJEkvnqiNoUy4DHcJSjQQ22hCAKm8ejrDKEHFXG/RvgArnSQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=qWFdD/XZ; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="qWFdD/XZ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=92Y66l2RhWrZSJaLBLWg5YiPFA0rzU2WTNgjRrSu2D0=; b=qWFdD/XZAvrSjnNvhW+w4CqmYC
	FDRmJvOqk0gC9P6zPE+f3NaQdyFvU2Gdsveen9ze42uYqsMfRF1uSHxcT7uouez9VNbp+k3NjgTv3
	7dHvLbM0NwWEPguasNRsQ16CTBdkRGZKXAJ8pFMb+zV52pQW1/Qgb5C9bV9MGGtqsU+fxyAK9+fNE
	VWndrX5v2pkjg7fu0rPB2TiqDjg0z69nlXldtvE1ydTDxr9pRsU412ziYWsAuJkXFpDjWbiy2CJDx
	jZbCjmykpsDlSp9hNBnW4wHzMUk3HfCkWAY7AF+PkDuoyG077zkFDGrM1oTP6UbGLRlSa3l536hkq
	7tJJdiZA==;
Received: from 241.red-83-35-220.dynamicip.rima-tde.net ([83.35.220.241] helo=breogan.igalia.local)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1vU9fS-00C9aJ-Vz; Fri, 12 Dec 2025 21:23:11 +0100
From: "Manuel A. Fernandez Montecelo" <mafm@igalia.com>
To: linux-bluetooth@vger.kernel.org
Cc: "Manuel A. Fernandez Montecelo" <mafm@igalia.com>
Subject: [PATCH BlueZ v2 1/1] Support for config fragments (conf.d style dirs)
Date: Fri, 12 Dec 2025 21:22:40 +0100
Message-ID: <20251212202240.4057163-2-mafm@igalia.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251212202240.4057163-1-mafm@igalia.com>
References: <20251212202240.4057163-1-mafm@igalia.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Support config fragments, to read config from conf.d directories.
Those dirs will be main.conf.d for main.conf, analog for input.conf
and network.conf.

This is commonly supported by other tools, as an extension of the main
config file(s).  It is useful and convenient in several situations,
for example:

* distributions can set different values from the defaults shipped
  upstream, without having to modify the config file

* different packages or config-management tools can change config just
  by adding, removing or modifying files in that directory; instead of
  editing the main config files

The main or base config files will be processed first, and then files
in the conf.d dirs, if existing.

When reading these config files in conf.d dirs, they override values
for keys in the base config files (or default config set in code).
For example, for "main.conf" the directory to be processed will be
"main.conf.d", in the same basedir as the config file
(e.g. /etc/main.conf, /etc/main.conf.d/).  The same for input.conf and
network.conf.

Within the conf.d directory, the format of the filename should be
'^([0-9][0-9])-([a-zA-Z0-9-_])*\.conf$', that is, starting with "00-"
to "99-", ending in ".conf", and with a mix of alphanumeric characters
with dashes and underscores in between.  For example:
'01-override-general-secureconnections.conf'.

Files named differently will not be considered, and accepting groups
or keys not present in the base config depends on the code, currently
set to "NOT accept new groups" but "YES to accept new keys".  This is
because the base config files contain all the groups, but most keys
are commented-out, with the values set in code.

The candidate files within the given directory are sorted (with
g_strcmp0(), so the ordering will be as with strcmp()).  The
configuration in the files being processed later will override
previous config, in particular the main/base config files, but also
the one from previous files processed, if the Group and Key coincide.

For example, consider 'main.conf' that contains the defaults:

  [General]
  DiscoverableTimeout=0
  PairableTimeout=0

and there is a file 'main.conf.d/70-default-timeouts-vendor.conf'
containing settings for these keys:

  [General]
  DiscoverableTimeout=30
  PairableTimeout=30

and another 'main.conf.d/99-default-timeouts-local.conf'
containing settings only for 'PairableTimeout':

  [General]
  PairableTimeout=15

What happens is:
1) First, the 'main.conf' is processed as usual;
2) then 'main.conf.d/70-default-timeouts-vendor.conf' is processed,
   overriding the two values from the main config file with the given
   values;
3) and finally 'main.conf.d/99-default-timeouts-local.conf' is
   processed, overriding once again only 'PairableTimeout'.

The final, effective values are:

  DiscoverableTimeout=30
  PairableTimeout=15
---
 Makefile.am                |   1 +
 profiles/input/hog.c       |   3 +
 profiles/input/manager.c   |   3 +
 profiles/network/manager.c |   3 +
 src/conf_d.c               | 202 +++++++++++++++++++++++++++++++++++++
 src/conf_d.h               |  76 ++++++++++++++
 src/main.c                 |   3 +
 7 files changed, 291 insertions(+)
 create mode 100644 src/conf_d.c
 create mode 100644 src/conf_d.h

diff --git a/Makefile.am b/Makefile.am
index e152ae648..f8516bacd 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -307,6 +307,7 @@ pkglibexec_PROGRAMS += src/bluetoothd
 bluetoothd_internal_sources = \
 			$(attrib_sources) $(btio_sources) \
 			src/log.h src/log.c \
+			src/conf_d.h src/conf_d.c \
 			src/backtrace.h src/backtrace.c \
 			src/rfkill.c src/btd.h src/sdpd.h \
 			src/sdpd-server.c src/sdpd-request.c \
diff --git a/profiles/input/hog.c b/profiles/input/hog.c
index f50a0f217..6d2348c26 100644
--- a/profiles/input/hog.c
+++ b/profiles/input/hog.c
@@ -39,6 +39,7 @@
 #include "src/shared/att.h"
 #include "src/shared/gatt-client.h"
 #include "src/plugin.h"
+#include "src/conf_d.h"
 
 #include "suspend.h"
 #include "attrib/att.h"
@@ -246,6 +247,8 @@ static void hog_read_config(void)
 		return;
 	}
 
+	confd_process_config(config, filename, FALSE, TRUE);
+
 	config_auto_sec = g_key_file_get_boolean(config, "General",
 					"LEAutoSecurity", &err);
 	if (!err) {
diff --git a/profiles/input/manager.c b/profiles/input/manager.c
index 0fcd6728c..68691ec52 100644
--- a/profiles/input/manager.c
+++ b/profiles/input/manager.c
@@ -27,6 +27,7 @@
 #include "src/device.h"
 #include "src/profile.h"
 #include "src/service.h"
+#include "src/conf_d.h"
 
 #include "device.h"
 #include "server.h"
@@ -75,6 +76,8 @@ static GKeyFile *load_config_file(const char *file)
 		return NULL;
 	}
 
+	confd_process_config(keyfile, file, FALSE, TRUE);
+
 	return keyfile;
 }
 
diff --git a/profiles/network/manager.c b/profiles/network/manager.c
index 693547d45..e9b620b0f 100644
--- a/profiles/network/manager.c
+++ b/profiles/network/manager.c
@@ -28,6 +28,7 @@
 #include "src/device.h"
 #include "src/profile.h"
 #include "src/service.h"
+#include "src/conf_d.h"
 
 #include "bnep.h"
 #include "connection.h"
@@ -47,6 +48,8 @@ static void read_config(const char *file)
 		goto done;
 	}
 
+	confd_process_config(keyfile, file, FALSE, TRUE);
+
 	conf_security = !g_key_file_get_boolean(keyfile, "General",
 						"DisableSecurity", &err);
 	if (err) {
diff --git a/src/conf_d.c b/src/conf_d.c
new file mode 100644
index 000000000..878fb9157
--- /dev/null
+++ b/src/conf_d.c
@@ -0,0 +1,202 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2025  Valve Corporation
+ *
+ */
+
+#include "conf_d.h"
+
+#include "src/log.h"
+
+static gint confd_compare_filenames(gconstpointer a, gconstpointer b)
+{
+	return g_strcmp0(*(const gchar **)(a), *(const gchar **)(b));
+}
+
+static GPtrArray *confd_get_valid_files_sorted(const gchar *confd_path)
+{
+	const char *regex_pattern = "^([0-9][0-9])-([a-zA-Z0-9-_])*\\.conf$";
+	g_autoptr(GRegex) regex = NULL;
+	g_autoptr(GPtrArray) ret_confd_files = NULL;
+	GDir *dir = NULL;
+	GError *error = NULL;
+	const gchar *filename = NULL;
+
+	regex = g_regex_new(regex_pattern, 0, 0, &error);
+	if (!regex) {
+		DBG("Invalid regex: %s", error->message);
+		g_clear_error(&error);
+		return NULL;
+	}
+
+	dir = g_dir_open(confd_path, 0, &error);
+	if (!dir) {
+		DBG("%s", error->message);
+		g_clear_error(&error);
+		return NULL;
+	}
+
+	ret_confd_files = g_ptr_array_new_full(0, g_free);
+
+	while ((filename = g_dir_read_name(dir)) != NULL) {
+		g_autofree gchar *file_path = NULL;
+
+		if (!g_regex_match(regex, filename, 0, NULL)) {
+			DBG("Ignoring file in conf.d dir: '%s'", filename);
+			continue;
+		}
+
+		file_path = g_build_filename(confd_path, filename, NULL);
+		if (file_path)
+			g_ptr_array_add(ret_confd_files, g_strdup(file_path));
+	}
+
+	g_dir_close(dir);
+
+	if (ret_confd_files && ret_confd_files->len > 0) {
+		g_ptr_array_sort(ret_confd_files, confd_compare_filenames);
+
+		DBG("Will consider additional config files (in order):");
+		for (guint i = 0; i < ret_confd_files->len; i++) {
+			DBG(" - %s",
+			    (const gchar *)(g_ptr_array_index(ret_confd_files,
+							      i)));
+		}
+
+		return g_ptr_array_ref(ret_confd_files);
+	} else {
+		g_ptr_array_free(ret_confd_files, TRUE);
+		ret_confd_files = NULL;
+		return NULL;
+	}
+}
+
+static void confd_override_config(GKeyFile *keyfile,
+				  const gchar *new_conf_file_path,
+				  gboolean accept_new_groups,
+				  gboolean accept_new_keys)
+{
+	g_autoptr(GKeyFile) new_keyfile = NULL;
+	gchar **existing_groups = NULL;
+	gchar **groups = NULL;
+	gchar **keys = NULL;
+	gsize existing_groups_size = 0;
+	gsize groups_size = 0;
+	gsize keys_size = 0;
+	g_autoptr(GError) error = NULL;
+
+	new_keyfile = g_key_file_new();
+	if (!g_key_file_load_from_file(new_keyfile, new_conf_file_path,
+				       G_KEY_FILE_NONE, &error)) {
+		if (error) {
+			warn("%s", error->message);
+			g_clear_error(&error);
+		}
+		return;
+	}
+
+	existing_groups = g_key_file_get_groups(keyfile, &existing_groups_size);
+
+	groups = g_key_file_get_groups(new_keyfile, &groups_size);
+	for (gsize gi = 0; gi < groups_size; gi++) {
+		bool match = false;
+		const gchar *group = groups[gi];
+
+		for (gsize egi = 0; egi < existing_groups_size; egi++) {
+			if (g_str_equal(group, existing_groups[egi])) {
+				match = true;
+				break;
+			}
+		}
+
+		if (!match) {
+			if (accept_new_groups == FALSE) {
+				warn("Skipping group '%s' in '%s' "
+				     "not known in previous config",
+				     group, new_conf_file_path);
+				continue;
+			} else {
+				DBG("Accepting group '%s' in '%s' "
+				    "not known in previous config",
+				    group, new_conf_file_path);
+			}
+		}
+
+		keys = g_key_file_get_keys(new_keyfile, group, &keys_size,
+					   NULL);
+		if (keys == NULL) {
+			DBG("No keys found in '%s' for group '%s'",
+			    new_conf_file_path, group);
+			continue;
+		}
+
+		for (gsize ki = 0; ki < keys_size; ki++) {
+			const gchar *key = keys[ki];
+			g_autofree gchar *value = NULL;
+			g_autofree gchar *old_value = NULL;
+
+			value = g_key_file_get_value(new_keyfile, group, key,
+						     NULL);
+			if (!value)
+				continue;
+
+			old_value =
+				g_key_file_get_value(keyfile, group, key, NULL);
+			if (old_value != NULL) {
+				DBG("Overriding config value from "
+				    "conf.d file: [%s] %s: '%s'->'%s'",
+				    group, key, old_value, value);
+				g_key_file_set_value(keyfile, group, key,
+						     value);
+			} else {
+				if (accept_new_keys == TRUE) {
+					DBG("Adding new config value from "
+					    "conf.d file: [%s] %s: '%s'",
+					    group, key, value);
+					g_key_file_set_value(keyfile, group,
+							     key, value);
+				} else {
+					DBG("Ignoring config value from "
+					    "conf.d, unknown keys not allowed: "
+					    "[%s] %s: '%s'",
+					    group, key, value);
+				}
+			}
+		}
+		g_strfreev(keys);
+	}
+	g_strfreev(groups);
+	g_strfreev(existing_groups);
+}
+
+void confd_process_config(GKeyFile *keyfile, const gchar *base_conf_file_path,
+			  gboolean accept_new_groups, gboolean accept_new_keys)
+{
+	g_autofree gchar *confd_path = NULL;
+	g_autoptr(GPtrArray) confd_files = NULL;
+
+	confd_path = g_strconcat(base_conf_file_path, ".d", NULL);
+
+	if (!g_file_test(confd_path,
+			 (G_FILE_TEST_EXISTS | G_FILE_TEST_IS_DIR))) {
+		DBG("'%s' does not exist or not a directory", confd_path);
+		return;
+	}
+
+	confd_files = confd_get_valid_files_sorted(confd_path);
+
+	if (confd_files && confd_files->len > 0) {
+		for (guint i = 0; i < confd_files->len; i++) {
+			const gchar *confd_file =
+				(const gchar *)(g_ptr_array_index(confd_files,
+								  i));
+			DBG("Processing config file: '%s'", confd_file);
+			confd_override_config(keyfile, confd_file,
+					      accept_new_groups,
+					      accept_new_keys);
+		}
+	}
+}
diff --git a/src/conf_d.h b/src/conf_d.h
new file mode 100644
index 000000000..812966740
--- /dev/null
+++ b/src/conf_d.h
@@ -0,0 +1,76 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2025  Valve Corporation
+ *
+ */
+
+#include <glib.h>
+
+/**
+ * confd_process_config:
+ *
+ * @keyfile: keyfile already initialized and parsed
+ *
+ * @base_conf_file_path: base config file (e.g. /etc/bluetooth/main.conf,
+ * input.conf, network.conf).  The directory to be processed will be same path
+ * with ".d" appended.
+ *
+ * @accept_new_groups: whether to accept groups not appearing in the base config
+ * file
+ *
+ * @accept_new_keys: whether to accept keys not appearing in the base config
+ * file
+ *
+ * Helper function to process config files in conf.d style dirs (config
+ * fragments), overriding values for keys in the base config files (or default
+ * config set in code).  For example, for "main.conf" the directory to be
+ * processed will be "main.conf.d", in the same basedir as the config file.
+ *
+ * Within the .d directory, the format of the filename should be
+ * '^([0-9][0-9])-([a-zA-Z0-9-_])*\.conf$', that is, starting with "00-" to
+ * "99-", ending in ".conf", and with a mix of alphanumeric characters with
+ * dashes and underscores in between.  For example:
+ * '01-override-general-secureconnections.conf'.
+ *
+ * Files named differently will not be considered, and accepting groups or keys
+ * not present in the base config depends on the function arguments.
+ *
+ * The candidate files within the given directory are sorted (with g_strcmp0(),
+ * so the ordering will be as with strcmp()).  The configuration in the files
+ * being processed later will override previous config, in particular the main
+ * config, but also the one from previous files processed, if the Group and Key
+ * coincide.
+ *
+ * For example, consider 'main.conf' that contains the defaults:
+ *   [General]
+ *   DiscoverableTimeout=0
+ *   PairableTimeout=0
+ *
+ * and there is a file 'main.conf.d/70-default-timeouts-vendor.conf'
+ * containing settings for these keys:
+ *   [General]
+ *   DiscoverableTimeout=30
+ *   PairableTimeout=30
+ *
+ * and another 'main.conf.d/99-default-timeouts-local.conf'
+ * containing settings only for 'PairableTimeout':
+ *   [General]
+ *   PairableTimeout=15
+ *
+ * What happens is:
+ * 1) First, the 'main.conf' is processed as usual;
+ * 2) then 'main.conf.d/70-default-timeouts-vendor.conf' is processed,
+ *    overriding the two values from the main config file with the given values;
+ * 3) and finally 'main.conf.d/99-default-timeouts-local.conf' is processed,
+ *    overriding once again only 'PairableTimeout'.
+ *
+ * The final, effective values are:
+ *
+ *   DiscoverableTimeout=30
+ *
+ **/
+void confd_process_config(GKeyFile *keyfile, const gchar *base_conf_file_path,
+			  gboolean accept_new_groups, gboolean accept_new_keys);
diff --git a/src/main.c b/src/main.c
index 61e5ef983..79866616e 100644
--- a/src/main.c
+++ b/src/main.c
@@ -54,6 +54,7 @@
 #include "dbus-common.h"
 #include "agent.h"
 #include "profile.h"
+#include "conf_d.h"
 
 #define BLUEZ_NAME "org.bluez"
 
@@ -284,6 +285,8 @@ static GKeyFile *load_config(const char *name)
 		return NULL;
 	}
 
+	confd_process_config(keyfile, main_conf_file_path, FALSE, TRUE);
+
 	return keyfile;
 }
 
-- 
2.51.0

