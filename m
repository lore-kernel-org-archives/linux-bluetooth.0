Return-Path: <SRS0=3wSE=QD=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E24EC282C0
	for <linux-bluetooth@archiver.kernel.org>; Sun, 27 Jan 2019 11:57:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19CC82148D
	for <linux-bluetooth@archiver.kernel.org>; Sun, 27 Jan 2019 11:57:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EebWHzqs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726535AbfA0L5T (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 27 Jan 2019 06:57:19 -0500
Received: from mail-wr1-f53.google.com ([209.85.221.53]:36167 "EHLO
        mail-wr1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726443AbfA0L5T (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 27 Jan 2019 06:57:19 -0500
Received: by mail-wr1-f53.google.com with SMTP id u4so14856117wrp.3
        for <linux-bluetooth@vger.kernel.org>; Sun, 27 Jan 2019 03:57:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=tKg9G98BXPVnvNcyHD6xS49LgdcHNva2eJ7kAtkinXI=;
        b=EebWHzqsEl/+Som6ZNPDptobi0423Df7y6CfAPwRuayB1MfajyblPfzTvT+0HFnmDZ
         E3Du27cvrD7VWWch3IEk80vUD2hNu5zzB3J9aMELCZxGu7H6g2U7C//4y/y/71Q21iko
         xlo2AYQd5RvLdFySP76Uw3vghHDgh7m74bo5nesFn9wHJhH2/1BwALhsWS/6E0pmVoVm
         he2/gyYtdTgQVadqPmVmxDzqRPdqFb+sA74clt4Z4YRLBf2O0uPcvEwVZvUx+dQQrC4j
         T2HQDaiuUdvt3tMTsCZr7v1Gf1dotDPHRu+KtK47j2ZU9ahbXs7Jkim3HmuWBtGF5qM/
         DRyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=tKg9G98BXPVnvNcyHD6xS49LgdcHNva2eJ7kAtkinXI=;
        b=QVnYvn3NOWgVP1T19j3pweylFlhkYYG7i4NqvlazIEzN1Yxv1Frp3CirHirgUnMPLU
         sEsH3ylScV0bZj7T1UBh738C0sDGEkyTYSjo2z4RHPQoCAuAw1xQUUGqlHhN0PP6KG99
         /XsyO1CTn5GCaYBftXr5WdkMziisFCLSVCWVPIzyPA/RwUpnVbEewl7A1TFzzJlTP7XC
         mTROYTcjCzlb/lzlcpRLUU+IgPpjAy19ArBbDyC7U3yeXMEqylT7sGMJaNh6eTClEh6/
         ui0765a/pmPimbBsD4901zGhdQWoeFzmKdRcAFSRY/oy525n9i7ZpNxfKRrjFu9uHYql
         b7GA==
X-Gm-Message-State: AJcUukeNlIbjziNCz+l1n5VyYGCOqe65MeYte8pCin+PmmOoupGlfUC2
        vWU5F/LAgjLuMfrezVSWvC3WGp0d
X-Google-Smtp-Source: ALg8bN7c1mNmim/ac/VMztrXL4gTAjI8SQGrkqBGwtHlyRRVc2zgYZdn+IvBCANdBeT4QXD3cA5XJg==
X-Received: by 2002:adf:f1cb:: with SMTP id z11mr17870854wro.35.1548590235665;
        Sun, 27 Jan 2019 03:57:15 -0800 (PST)
Received: from Buero.fritz.box ([2001:a62:158e:8d01:357b:74c0:62f9:a1b8])
        by smtp.gmail.com with ESMTPSA id 67sm178999281wra.37.2019.01.27.03.57.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 27 Jan 2019 03:57:15 -0800 (PST)
From:   Christian Zimmermann <zimmermach@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Christian Zimmermann <zimmermach@gmail.com>
Subject: [PATCH BlueZ 2/2] Added config converter for Bluez4 config conversion
Date:   Sun, 27 Jan 2019 12:56:46 +0100
Message-Id: <20190127115646.5814-3-zimmermach@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190127115646.5814-1-zimmermach@gmail.com>
References: <20190127115646.5814-1-zimmermach@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

---
 .gitignore                |   2 +
 Makefile.am               |  12 ++++
 Makefile.tools            |   9 +++
 tools/config-conversion.c | 129 +++++++++++++++++++++++++++++++++++++
 tools/config-conversion.h |  23 +++++++
 tools/config-converter.c  |  69 ++++++++++++++++++++
 unit/test-conversions.c   | 158 ++++++++++++++++++++++++++++++++++++++++++++++
 7 files changed, 402 insertions(+)
 create mode 100644 tools/config-conversion.c
 create mode 100644 tools/config-conversion.h
 create mode 100644 tools/config-converter.c
 create mode 100644 unit/test-conversions.c

diff --git a/.gitignore b/.gitignore
index d145ccdcd..b75e49bd6 100644
--- a/.gitignore
+++ b/.gitignore
@@ -122,6 +122,7 @@ tools/btsnoop
 tools/btpclient
 tools/btmon-logger
 tools/bluetooth-logger.service
+tools/config-converter
 peripheral/btsensor
 monitor/btmon
 emulator/btvirt
@@ -150,6 +151,7 @@ unit/test-avrcp
 unit/test-gatt
 unit/test-midi
 unit/test-gattrib
+unit/test-conversions
 unit/test-*.log
 unit/test-*.trs
 
diff --git a/Makefile.am b/Makefile.am
index f84a1faba..4a157d714 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -499,6 +499,15 @@ unit_test_gattrib_LDADD = lib/libbluetooth-internal.la \
 			src/libshared-glib.la \
 			$(GLIB_LIBS) $(DBUS_LIBS) -ldl -lrt
 
+unit_tests += unit/test-conversions
+unit_test_conversions_SOURCES = unit/test-conversions.c \
+			tools/config-conversion.h tools/config-conversion.c \
+			src/storage.h src/storage.c \
+			src/textfile.h src/textfile.c \
+			src/uuid-helper.h src/uuid-helper.c
+unit_test_conversions_LDADD = src/libshared-glib.la \
+				lib/libbluetooth-internal.la $(GLIB_LIBS)
+
 if MIDI
 unit_tests += unit/test-midi
 unit_test_midi_CPPFLAGS = $(AM_CPPFLAGS) $(ALSA_CFLAGS) -DMIDI_TEST
@@ -617,3 +626,6 @@ clean-local:
 	-find $(top_builddir) -name "*.gcda" -delete
 	$(RM) -r lib/bluetooth
 endif
+
+install-exec-hook:
+	tools/config-converter
diff --git a/Makefile.tools b/Makefile.tools
index 1f8271542..3221e2634 100644
--- a/Makefile.tools
+++ b/Makefile.tools
@@ -473,3 +473,12 @@ tools_btpclient_LDADD = lib/libbluetooth-internal.la \
 				src/libshared-ell.la $(ell_ldadd)
 tools_btpclient_DEPENDENCIES = $(ell_dependencies)
 endif
+
+noinst_PROGRAMS += tools/config-converter
+tools_config_converter_SOURCES = tools/config-converter.c \
+			tools/config-conversion.h tools/config-conversion.c \
+			src/storage.h src/storage.c \
+			src/textfile.h src/textfile.c \
+			src/uuid-helper.h src/uuid-helper.c
+tools_config_converter_LDADD = src/libshared-glib.la lib/libbluetooth-internal.la \
+				$(GLIB_LIBS)
\ No newline at end of file
diff --git a/tools/config-conversion.c b/tools/config-conversion.c
new file mode 100644
index 000000000..2f4f79708
--- /dev/null
+++ b/tools/config-conversion.c
@@ -0,0 +1,129 @@
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2019  Christian Zimmermann <zimmermach@gmail.com>
+ *
+ *
+ *  This library is free software; you can redistribute it and/or
+ *  modify it under the terms of the GNU Lesser General Public
+ *  License as published by the Free Software Foundation; either
+ *  version 2.1 of the License, or (at your option) any later version.
+ *
+ *  This library is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ *  Lesser General Public License for more details.
+ *
+ */
+
+#ifdef HAVE_CONFIG_H
+#include <config.h>
+#endif
+
+#define _GNU_SOURCE
+
+#include <sys/stat.h>
+#include <dirent.h>
+#include <stdbool.h>
+#include <stdlib.h>
+
+#include "lib/bluetooth.h"
+#include "src/storage.h"
+#include "src/textfile.h"
+#include "tools/config-conversion.h"
+
+#define MAX_NAME_LENGTH		248
+
+#define MODE_OFF		0x00
+#define MODE_CONNECTABLE	0x01
+#define MODE_DISCOVERABLE	0x02
+#define MODE_UNKNOWN		0xff
+
+static uint8_t str_to_mode(const char *mode)
+{
+	if (strcasecmp("off", mode) == 0)
+		return MODE_OFF;
+	else if (strcasecmp("connectable", mode) == 0)
+		return MODE_CONNECTABLE;
+	else if (strcasecmp("discoverable", mode) == 0)
+		return MODE_DISCOVERABLE;
+	else
+		return MODE_UNKNOWN;
+}
+
+static uint8_t has_file(const char *path, const char *file)
+{
+	struct stat st;
+	char filename[PATH_MAX];
+
+	snprintf(filename, PATH_MAX, "%s/%s", path, file);
+	if (stat(filename, &st) == 0)
+		return true;
+	else
+		return false;
+}
+
+static uint8_t has_bluez4_config(const char *adapter_cfg_path)
+{
+	return has_file(adapter_cfg_path, "config");
+}
+
+static uint8_t has_bluez5_config(const char *adapter_cfg_path)
+{
+	return has_file(adapter_cfg_path, "settings");
+}
+
+void convert_bluez4_config(const char *cfg_path)
+{
+	char filename[PATH_MAX];
+	char str[MAX_NAME_LENGTH + 1];
+	char *key_file_data;
+	int timeout;
+	uint8_t mode;
+	GKeyFile *key_file;
+	gsize length = 0;
+
+	key_file = g_key_file_new();
+
+	//Create config file string(old config)
+	snprintf(filename, PATH_MAX, "%s/config", cfg_path);
+
+	//Convert old config values
+	if (bluez4_read_pairable_timeout(filename, &timeout) == 0)
+		g_key_file_set_integer(key_file, "General",
+					"PairableTimeout", timeout);
+
+	if (bluez4_read_discoverable_timeout(filename, &timeout) == 0)
+		g_key_file_set_integer(key_file, "General",
+					"DiscoverableTimeout", timeout);
+
+	if (bluez4_read_on_mode(filename, str, sizeof(str)) == 0) {
+		mode = str_to_mode(str);
+		g_key_file_set_boolean(key_file, "General", "Discoverable",
+					mode == MODE_DISCOVERABLE);
+	}
+
+	if (bluez4_read_local_name(filename, str) == 0)
+		g_key_file_set_string(key_file, "General", "Alias", str);
+
+	//Create settings file string(new config)
+	snprintf(filename, PATH_MAX, "%s/settings", cfg_path);
+
+	create_file(filename, 0600);
+
+	key_file_data = g_key_file_to_data(key_file, &length, NULL);
+	g_file_set_contents(filename, key_file_data, length, NULL);
+	g_free(key_file_data);
+	g_key_file_free(key_file);
+}
+
+void convert_config(const char *adapter_cfg_path, gboolean force)
+{
+	if ((has_bluez4_config(adapter_cfg_path) &&
+			!has_bluez5_config(adapter_cfg_path)) || force) {
+		convert_bluez4_config(adapter_cfg_path);
+		//TODO will be done in 2nd step
+		//convert_bluez4_device_storage(cfg_path);
+	}
+}
diff --git a/tools/config-conversion.h b/tools/config-conversion.h
new file mode 100644
index 000000000..eac789cec
--- /dev/null
+++ b/tools/config-conversion.h
@@ -0,0 +1,23 @@
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2019  Christian Zimmermann <zimmermach@gmail.com>
+ *
+ *
+ *  This library is free software; you can redistribute it and/or
+ *  modify it under the terms of the GNU Lesser General Public
+ *  License as published by the Free Software Foundation; either
+ *  version 2.1 of the License, or (at your option) any later version.
+ *
+ *  This library is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ *  Lesser General Public License for more details.
+ *
+ */
+
+#include <glib.h>
+
+void convert_bluez4_config(const char *cfg_path);
+void convert_config(const char *adapter_cfg_path, gboolean force);
diff --git a/tools/config-converter.c b/tools/config-converter.c
new file mode 100644
index 000000000..ab9cab9a0
--- /dev/null
+++ b/tools/config-converter.c
@@ -0,0 +1,69 @@
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2019  Christian Zimmermann <zimmermach@gmail.com>
+ *
+ *
+ *  This program is free software; you can redistribute it and/or
+ *  modify it under the terms of the GNU Lesser General Public
+ *  License as published by the Free Software Foundation; either
+ *  version 2.1 of the License, or (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ *  Lesser General Public License for more details.
+ *
+ */
+
+#ifdef HAVE_CONFIG_H
+#include <config.h>
+#endif
+
+#define _GNU_SOURCE
+
+#include <stdbool.h>
+#include <stdlib.h>
+#include <sys/stat.h>
+#include <dirent.h>
+#include <unistd.h>
+
+#include "tools/config-conversion.h"
+#include "lib/bluetooth.h"
+
+int main(int argc, char *argv[])
+{
+	int user;
+
+	user = getuid();
+	if (user == 0) {
+		char adapter_cfg_path[PATH_MAX];
+		char *adapter_address;
+		struct dirent *dir_entry;
+		DIR *cfg_dir;
+
+		cfg_dir = opendir(STORAGEDIR);
+		if (cfg_dir) {
+			dir_entry = readdir(cfg_dir);
+			while (dir_entry != NULL) {
+				adapter_address = dir_entry->d_name;
+				if (bachk(adapter_address)) {
+					dir_entry = readdir(cfg_dir);
+					continue;
+				}
+				snprintf(adapter_cfg_path, PATH_MAX,
+					STORAGEDIR "/%s", adapter_address);
+				convert_config(adapter_cfg_path, FALSE);
+
+				dir_entry = readdir(cfg_dir);
+			};
+		} else {
+			printf("Storage Dir: %s was not found\n"
+				, STORAGEDIR);
+		}
+	} else {
+		printf("Root privileges needed for conversion, since it touches %s directory\n"
+			, STORAGEDIR);
+	}
+}
diff --git a/unit/test-conversions.c b/unit/test-conversions.c
new file mode 100644
index 000000000..542a5d15c
--- /dev/null
+++ b/unit/test-conversions.c
@@ -0,0 +1,158 @@
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2019  Christian Zimmermann <zimmermach@gmail.com>
+ *
+ *
+ *  This library is free software; you can redistribute it and/or
+ *  modify it under the terms of the GNU Lesser General Public
+ *  License as published by the Free Software Foundation; either
+ *  version 2.1 of the License, or (at your option) any later version.
+ *
+ *  This library is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ *  Lesser General Public License for more details.
+ *
+ */
+
+#ifdef HAVE_CONFIG_H
+#include <config.h>
+#endif
+
+#include <sys/stat.h>
+#include <stdlib.h>
+#include <stdio.h>
+#include <fcntl.h>
+#include <unistd.h>
+#include <errno.h>
+#include <string.h>
+
+#include "src/shared/tester.h"
+#include "src/textfile.h"
+#include "tools/config-conversion.h"
+
+#define MAX_NAME_LENGTH		248
+#define TEST_CONFIG_DIR "/tmp/bluez/"
+#define TEST_CONTROLLER_MAC "00:11:22:33:44:55"
+
+const char bluez4_cfg_file[] =
+"name unit_test\n"
+"pairto 234\n"
+"discovto 123\n"
+"onmode discoverable\n"
+"pairable yes\n";
+
+static void setup_bluez4_cfg_conversion_test(const void *test_data)
+{
+	int fd;
+	ssize_t bytes_written;
+	char filename[PATH_MAX];
+
+	snprintf(filename, PATH_MAX, "%s/config", TEST_CONFIG_DIR);
+	create_file(filename, 0600);
+	fd = open(filename, O_WRONLY);
+	if (fd < 0) {
+		tester_debug("Couldn't open file: %s\n", strerror(errno));
+		tester_setup_failed();
+		return;
+	}
+	bytes_written = write(fd, bluez4_cfg_file, sizeof(bluez4_cfg_file));
+	if (bytes_written < (ssize_t) sizeof(bluez4_cfg_file)) {
+		if (bytes_written == -1)
+			tester_debug("Couldn't write all Bytes to Bluez4 config file, error: %s\n"
+				, strerror(errno));
+		else
+			tester_debug("Couldn't write all Bytes to Bluez4 config file, not enough disk space\n");
+		close(fd);
+		tester_setup_failed();
+		return;
+	}
+	close(fd);
+	tester_setup_complete();
+}
+
+static void teardown_bluez4_cfg_conversion_test(const void *test_data)
+{
+	char filename[PATH_MAX];
+
+	snprintf(filename, PATH_MAX, "%s/config", TEST_CONFIG_DIR);
+	remove(filename);
+	snprintf(filename, PATH_MAX, "%s/settings", TEST_CONFIG_DIR);
+	remove(filename);
+	snprintf(filename, PATH_MAX, "%s", TEST_CONFIG_DIR);
+	remove(filename);
+	tester_teardown_complete();
+}
+
+static void run_bluez4_cfg_conversion_test(const void *test_data)
+{
+	struct stat st;
+	char filename[PATH_MAX];
+	int timeout;
+	gchar *alias;
+	gboolean discoverable;
+	GKeyFile *key_file;
+
+	convert_bluez4_config(TEST_CONFIG_DIR);
+	snprintf(filename, PATH_MAX, "%s/settings", TEST_CONFIG_DIR);
+	if (stat(filename, &st) != 0) {
+		tester_debug("No new settings file created!\n");
+		goto failed;
+	}
+	key_file = g_key_file_new();
+	g_key_file_load_from_file(key_file, filename, 0, NULL);
+	timeout = g_key_file_get_integer(key_file,
+				"General", "DiscoverableTimeout", NULL);
+	if (timeout != 123) {
+		tester_debug("Conversion failed, Discoverable Timeout not correct: %d, should be 123\n"
+			, timeout);
+		g_key_file_free(key_file);
+		goto failed;
+	}
+	timeout = g_key_file_get_integer(key_file,
+				"General", "PairableTimeout", NULL);
+	if (timeout != 234) {
+		tester_debug("Conversion failed, Pairable Timeout not correct: %d, should be 234\n"
+			, timeout);
+		g_key_file_free(key_file);
+		goto failed;
+	}
+	alias = g_key_file_get_string(key_file,
+				"General", "Alias", NULL);
+	if (strncmp(alias, "unit_test", 9) != 0) {
+		tester_debug("Conversion failed, Alias not correct: %s, should be unit_test\n"
+			, alias);
+		g_key_file_free(key_file);
+		g_free(alias);
+		goto failed;
+	}
+	discoverable = g_key_file_get_boolean(key_file,
+					"General", "Discoverable", NULL);
+	if (!discoverable) {
+		tester_debug("Conversion failed, Discoverable not correct:	 %d, should be true\n"
+			, discoverable);
+		g_key_file_free(key_file);
+		g_free(alias);
+		goto failed;
+	}
+	g_key_file_free(key_file);
+	g_free(alias);
+	tester_test_passed();
+	return;
+
+failed:
+	tester_test_failed();
+}
+
+int main(int argc, char *argv[])
+{
+	tester_init(&argc, &argv);
+	tester_add("bluez4_config_conversion", NULL,
+		setup_bluez4_cfg_conversion_test,
+		run_bluez4_cfg_conversion_test,
+		teardown_bluez4_cfg_conversion_test);
+
+	return tester_run();
+}
-- 
2.11.0

